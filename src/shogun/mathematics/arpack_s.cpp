/*
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * Written (W) 2011 Sergey Lisitsyn
 * Copyright (C) 2011 Berlin Institute of Technology and Max-Planck-Society
 */

#include <shogun/mathematics/arpack_s.h>
#ifdef HAVE_ARPACK
#ifdef HAVE_LAPACK
#include <shogun/io/SGIO.h>
#include <string.h>
#include <shogun/mathematics/lapack.h>

#ifdef HAVE_SUPERLU
#include <superlu/slu_sdefs.h>
#endif

using namespace shogun;

/** external ARPACK routine DSAUPD */
extern "C" void ssaupd_(int *ido, char *bmat, int *n, char *which,
			int *nev, float *tol, float *resid, int *ncv,
			float *v, int *ldv, int *iparam, int *ipntr,
			float *workd, float *workl, int *lworkl,
			int *info);

/** external ARPACK routine DSEUPD */
extern "C" void sseupd_(int *rvec, char *All, int *select, float *d,
			float *v, int *ldv, float *sigma, 
			char *bmat, int *n, char *which, int *nev,
			float *tol, float *resid, int *ncv, float *tv,
			int *tldv, int *iparam, int *ipntr, float *workd,
			float *workl, int *lworkl, int *ierr);

void arpack_ssxupd(float* matrix, float* rhs_diag, int n, int nev, const char* which, 
                   int mode, bool pos, float shift, float tolerance, 
                   float* eigenvalues, float* eigenvectors, int& status)
{
	// loop vars
	int i,j;

	// check if nev is greater than n
	if (nev>n)
		SG_SERROR("Number of required eigenpairs is greater than order of the matrix");

	// check specified mode
	if (mode!=1 && mode!=3)
		SG_SERROR("Mode not supported yet");

	// init ARPACK's reverse communication parameter 
 	// (should be zero initially)
	int ido = 0;

	// specify general or non-general eigenproblem will be solved
 	// w.r.t. to given rhs_diag
	char bmat[2] = "I";
	if (rhs_diag)
		bmat[0] = 'G';

	// init tolerance (zero means machine precision)
	float tol = tolerance;

	// allocate array to hold residuals
	float* resid = SG_MALLOC(float, n);
	// fill residual vector with ones
	for (i=0; i<n; i++)
		resid[i] = 1.0;

	// set number of Lanczos basis vectors to be used
	// (with max(4*nev,n) sufficient for most tasks)
	int ncv = nev*4>n ? n : nev*4;

	// allocate array 'v' for dsaupd routine usage
	int ldv = n;
	float* v = SG_MALLOC(float, ldv*ncv);

	// init array for i/o params for routine
	int* iparam = SG_MALLOC(int, 11);
	// specify method for selecting implicit shifts (1 - exact shifts) 
	iparam[0] = 1;
	// specify max number of iterations
	iparam[2] = 3*n;
	// set the computation mode (1 for regular or 3 for shift-inverse)
	iparam[6] = mode;

	// init array indicating locations of vectors for routine callback
	int* ipntr = SG_CALLOC(int, 11);

	// allocate workaround arrays
	float* workd = SG_MALLOC(float, 3*n);
	int lworkl = ncv*(ncv+8);
	float* workl = SG_MALLOC(float, lworkl);

	// init info holding status (1 means that residual vector is provided initially)
	int info = 1;

	// which eigenpairs to find
	char* which_ = strdup(which);
	// All
	char* all_ = strdup("A");

	// ipiv for LUP factorization
	int* ipiv = NULL;

	#ifdef HAVE_SUPERLU
	char equed[1];
	void* work = NULL;
	int lwork = 0;
	SuperMatrix slu_A, slu_L, slu_U, slu_B, slu_X;
	superlu_options_t options;
	SuperLUStat_t stat;
	mem_usage_t mem_usage;
	int *perm_c=NULL, *perm_r=NULL, *etree=NULL;
	float *R=NULL, *C=NULL;
	if (mode==3)
	{
		perm_c = intMalloc(n);
		perm_r = intMalloc(n);
		etree = intMalloc(n);
		R = floatMalloc(n);
		C = floatMalloc(n);
	}
	float ferr;
	float berr;
	float rcond;
	float rpg;
	int slu_info;
	float* slu_Bv = NULL;
	float* slu_Xv = NULL;
	#endif

	// shift-invert mode init
	if (mode==3)
	{
		// subtract shift from main diagonal if necessary
		if (shift!=0.0)
		{
			SG_SDEBUG("ARPACK: Subtracting shift\n");
			// if right hand side diagonal matrix is provided
			if (rhs_diag)
				// subtract I*diag(rhs_diag)
				for (i=0; i<n; i++)
					matrix[i*n+i] -= shift*rhs_diag[i];
			else
				// subtract I
				for (i=0; i<n; i++)
					matrix[i*n+i] -= shift;
		}
		
	#ifdef HAVE_SUPERLU
		SG_SDEBUG("SUPERLU: Constructing sparse matrix.\n");
		int nnz = 0;
		// get number of non-zero elements
		for (i=0; i<n*n; i++)
		{
			if (matrix[i]!=0.0)
				nnz++;
		}
		// allocate arrays to store sparse matrix
		float* val = floatMalloc(nnz);
		int* rowind = intMalloc(nnz);
		int* colptr = intMalloc(n+1);
		nnz = 0;
		// construct sparse matrix
		for (i=0; i<n; i++)
		{
			colptr[i] = nnz;
			for (j=0; j<n; j++)
			{
				if (matrix[i*n+j]!=0.0)
				{
					val[nnz] = matrix[i*n+j];
					rowind[nnz] = j;
					nnz++;
				}
			}
		}
		colptr[i] = nnz;
		// create CCS matrix 
		sCreate_CompCol_Matrix(&slu_A,n,n,nnz,val,rowind,colptr,SLU_NC,SLU_S,SLU_GE);

		// initialize options
		set_default_options(&options);
		options.Equil = YES;
		options.SymmetricMode = YES;
		StatInit(&stat);

		// factorize
		slu_info = 0;
		slu_Bv = floatMalloc(n);
		slu_Xv = floatMalloc(n);
		sCreate_Dense_Matrix(&slu_B,n,1,slu_Bv,n,SLU_DN,SLU_S,SLU_GE);
		sCreate_Dense_Matrix(&slu_X,n,1,slu_Xv,n,SLU_DN,SLU_S,SLU_GE);
		slu_B.ncol = 0;
		SG_SDEBUG("SUPERLU: Factorizing\n");
		sgssvx(&options, &slu_A, perm_c, perm_r, etree, equed, R, C,
		       &slu_L, &slu_U, work, lwork, &slu_B, &slu_X, &rpg, &rcond, &ferr, &berr,
		       &mem_usage,&stat,&slu_info);
		slu_B.ncol = 1;
		if (slu_info)
		{
			SG_SERROR("SUPERLU: Failed to factorize matrix, got %d code\n", slu_info);
		}
		options.Fact = FACTORED;
	#else
		// compute factorization according to pos value
		if (pos)
		{
			// with Cholesky
			SG_SDEBUG("ARPACK: Using Cholesky factorization.\n");
			clapack_spotrf(CblasColMajor,CblasUpper,n,matrix,n);
		}
		else
		{
			// with LUP
			SG_SDEBUG("ARPACK: Using LUP factorization.\n");
			ipiv = SG_CALLOC(int, n);
			clapack_sgetrf(CblasColMajor,n,n,matrix,n,ipiv);
		}
	#endif
	}
	// main computation loop
	SG_SDEBUG("ARPACK: Starting main computation DSAUPD loop.\n");
	do	 
	{
		ssaupd_(&ido, bmat, &n, which_, &nev, &tol, resid,
	        	&ncv, v, &ldv, iparam, ipntr, workd, workl,
	        	&lworkl, &info);

		if ((ido==1)||(ido==-1)||(ido==2))
		{
			if (mode==1)
			{
				// compute (workd+ipntr[1]-1) = A*(workd+ipntr[0]-1)
				cblas_ssymv(CblasColMajor,CblasUpper,
				            n,1.0,matrix,n,
				            (workd+ipntr[0]-1),1,
				            0.0,(workd+ipntr[1]-1),1);
			}
			if (mode==3)
			{
				if (!rhs_diag)
				{
			#ifdef HAVE_SUPERLU
					// treat workd+ipntr(0) as B 
					for (i=0; i<n; i++)
						slu_Bv[i] = (workd+ipntr[0]-1)[i];
					slu_info = 0;
					// solve
					sgssvx(&options, &slu_A, perm_c, perm_r, etree, equed, R, C,
					       &slu_L, &slu_U, work, lwork, &slu_B, &slu_X, &rpg, &rcond, 
					       &ferr, &berr, &mem_usage, &stat, &slu_info);
					if (slu_info)
						SG_SERROR("SUPERLU: GOT %d\n", slu_info);
					// move elements from resulting X to workd+ipntr(1) 
					for (i=0; i<n; i++)
						(workd+ipntr[1]-1)[i] = slu_Xv[i];
			#else
					for (i=0; i<n; i++)
						(workd+ipntr[1]-1)[i] = (workd+ipntr[0]-1)[i];

						if (pos)
						clapack_spotrs(CblasColMajor,CblasUpper,n,1,matrix,n,(workd+ipntr[1]-1),n);
					else 
						clapack_sgetrs(CblasColMajor,CblasNoTrans,n,1,matrix,n,ipiv,(workd+ipntr[1]-1),n);
			#endif
				}
				else
				{
					if (ido==-1)
					{
			#ifdef HAVE_SUPERLU
						for (i=0; i<n; i++)
							slu_Bv[i] = (workd+ipntr[0]-1)[i];
						slu_info = 0;
						sgssvx(&options, &slu_A, perm_c, perm_r, etree, equed, R, C,
						       &slu_L, &slu_U, work, lwork, &slu_B, &slu_X, &rpg, &rcond, 
						       &ferr, &berr, &mem_usage, &stat, &slu_info);
						if (slu_info)
							SG_SERROR("SUPERLU: GOT %d\n", slu_info);
						for (i=0; i<n; i++)
							(workd+ipntr[1]-1)[i] = slu_Xv[i];
			#else
						for (i=0; i<n; i++)
							(workd+ipntr[1]-1)[i] = rhs_diag[i]*(workd+ipntr[0]-1)[i];
						
						if (pos)
							clapack_spotrs(CblasColMajor,CblasUpper,n,1,matrix,n,(workd+ipntr[1]-1),n);
						else 
							clapack_sgetrs(CblasColMajor,CblasNoTrans,n,1,matrix,n,ipiv,(workd+ipntr[1]-1),n);
			#endif
					}
					if (ido==1)
					{
			#ifdef HAVE_SUPERLU
						for (i=0; i<n; i++)
							slu_Bv[i] = (workd+ipntr[2]-1)[i];
						slu_info = 0;
						sgssvx(&options, &slu_A, perm_c, perm_r, etree, equed, R, C,
						       &slu_L, &slu_U, work, lwork, &slu_B, &slu_X, &rpg, &rcond, 
						       &ferr, &berr, &mem_usage, &stat, &slu_info);
						if (slu_info)
							SG_SERROR("SUPERLU: GOT %d\n", slu_info);
						for (i=0; i<n; i++)
							(workd+ipntr[1]-1)[i] = slu_Xv[i];
			#else
						for (i=0; i<n; i++)
							(workd+ipntr[1]-1)[i] = (workd+ipntr[2]-1)[i];

						if (pos)
							clapack_spotrs(CblasColMajor,CblasUpper,n,1,matrix,n,(workd+ipntr[1]-1),n);
						else 
							clapack_sgetrs(CblasColMajor,CblasNoTrans,n,1,matrix,n,ipiv,(workd+ipntr[1]-1),n);
			#endif
					}
					if (ido==2)
					{
						for (i=0; i<n; i++)
							(workd+ipntr[1]-1)[i] = rhs_diag[i]*(workd+ipntr[0]-1)[i]; 
					}
				}
			}
		}
	} while ((ido==1)||(ido==-1)||(ido==2));
	
	if (!pos && mode==3) SG_FREE(ipiv);
	
	#ifdef HAVE_SUPERLU
	if (mode==3)
	{
		SUPERLU_FREE(slu_Bv);
		SUPERLU_FREE(slu_Xv);
		SUPERLU_FREE(perm_r);
		SUPERLU_FREE(perm_c);
		SUPERLU_FREE(R);
		SUPERLU_FREE(C);
		SUPERLU_FREE(etree);
		if (lwork!=0) SUPERLU_FREE(work);
		Destroy_CompCol_Matrix(&slu_A);
		StatFree(&stat);
		Destroy_SuperMatrix_Store(&slu_B);
		Destroy_SuperMatrix_Store(&slu_X);
		Destroy_SuperNode_Matrix(&slu_L);
		Destroy_CompCol_Matrix(&slu_U);
	}
	#endif 
	
	// check if DSAUPD failed
	if (info<0) 
	{
		if ((info<=-1)&&(info>=-6))
			SG_SWARNING("ARPACK: DSAUPD failed. Wrong parameter passed.\n");
		else if (info==-7)
			SG_SWARNING("ARPACK: DSAUPD failed. Workaround array size is not sufficient.\n");
		else 
			SG_SWARNING("ARPACK: DSAUPD failed. Error code: %d.\n", info);

		status = -1;
	}
	else 
	{
		if (info==1)
			SG_SWARNING("ARPACK: Maximum number of iterations reached.\n");
			
		// allocate select for dseupd
		int* select = SG_MALLOC(int, ncv);
		// allocate d to hold eigenvalues
		float* d = SG_MALLOC(float, 2*ncv);
		// sigma for dseupd
		float sigma = shift;
		
		// init ierr indicating dseupd possible errors
		int ierr = 0;

		// specify that eigenvectors are going to be computed too		
		int rvec = 1;

		SG_SDEBUG("APRACK: Starting DSEUPD.\n");

		// call dseupd_ routine
		sseupd_(&rvec, all_, select, d, v, &ldv, &sigma, bmat,
		        &n, which_, &nev, &tol, resid, &ncv, v, &ldv,
		        iparam, ipntr, workd, workl, &lworkl, &ierr);

		// check for errors
		if (ierr!=0)
		{
			SG_SWARNING("ARPACK: DSEUPD failed with status %d.\n", ierr);
			status = -1;
		}
		else
		{
			SG_SDEBUG("ARPACK: Storing eigenpairs.\n");

			// store eigenpairs to specified arrays
			for (i=0; i<nev; i++)
			{	
				eigenvalues[i] = d[i];
			
				for (j=0; j<n; j++)
					eigenvectors[j*nev+i] = v[i*n+j];
			}
		}
		
		// cleanup
		SG_FREE(select);
		SG_FREE(d);
	}

	// cleanup
	SG_FREE(all_);
	SG_FREE(which_);
	SG_FREE(resid);
	SG_FREE(v);
	SG_FREE(iparam);
	SG_FREE(ipntr);
	SG_FREE(workd);
	SG_FREE(workl);
};
#endif /* HAVE_LAPACK */
#endif /* HAVE_ARPACK */
