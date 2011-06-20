/*
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * Written (W) 2011 Heiko Strathmann
 * Copyright (C) 2011 Berlin Institute of Technology and Max-Planck-Society
 */

#include "features/Subset.h"
#include "lib/io.h"
#include "base/Parameter.h"
#include <string>

using namespace shogun;

CSubset::CSubset()
{
	m_subset.vector=NULL;
	m_subset.length=0;

	m_parameters->add(&m_subset, "subset", "Vector of subset indices");
}

CSubset::~CSubset()
{
	delete[] m_subset.vector;
}

void CSubset::set_subset(SGVector<index_t> subset)
{
	remove_subset();

	m_subset.vector=subset.vector;
	m_subset.length=subset.length;
}

void CSubset::remove_subset()
{
	delete[] m_subset.vector;
	m_subset.vector=NULL;
	m_subset.length=0;
}

SGVector<index_t>* CSubset::get_subset_copy()
{
	SGVector<index_t>* copy=new SGVector<index_t> (
			(index_t*) SG_MALLOC(m_subset.length*sizeof(index_t)),
			m_subset.length);

	memcpy(copy->vector, m_subset.vector, m_subset.length*sizeof(index_t));

	return copy;
}
