#ifndef _CFEATURES__H__
#define _CFEATURES__H__

#include "preproc/PreProc.h"

class CFeatures
{

	/** Features can be DOUBLEs and STRINGs
	*/
	enum EType
	{
		DOUBLE,
		STRING
	};

	CFeatures();
	virtual ~CFeatures();

	/** return feature type with which objects derived 
	    from CFeatures can deal
	*/
	virtual EType get_feature_type()=0;

	/** get feature vector for sample num
		from the matrix as it is if matrix is
		initialized, else return
		preprocessed compute_feature_vector.
		One HAS TO call free_feature_vector
		when done.
		@param num index of feature vector
		@param len length is returned by reference
		@param free parameter needed for free_feature_vector
	*/
	REAL* get_feature_vector(int num, int& len, bool& free);
	/** free features possibly allocated in get_feature_vector
		@param free parameter that was returned by get_feature_vector
	 */
	bool free_feature_vector(void* feat_vec, bool free);
	
	/// get the pointer to the feature matrix
	/// num_feat,num_vectors are returned by reference
	REAL* get_feature_matrix(int &num_feat, int &num_vec);

	/** set feature matrix
		necessary to set feature_matrix, num_features, num_vectors, where
		num_features is the column offset, and columns are linear in memory
		see below for definition of feature_matrix
	*/
	virtual REAL* set_feature_matrix()=0;

	/// compute feature vector for sample num
	/// len is returned by reference
	virtual REAL* compute_feature_vector(int num, int& len)=0;
	
	/// set preprocessor
	void set_preproc(CPreProc* p);

	/// set current preprocessor
	CPreProc* get_preproc();

	/// Preprocess the feature feature_matrix
	bool preproc_feature_matrix();
	
protected:
	/// Preprocessor
	CPreProc* preproc;

	/** chunk of memory for all the feature_vectors	
	  it is aligned like 0...num_features-1 for vec0
	  0...num_features-1 for vec1 and so on up to vecnum_vectors-1
	  */
	REAL* feature_matrix;

	/// number of features in cache
	int num_features;

	/// number of vectors in cache
	int num_vectors;
};
#endif
