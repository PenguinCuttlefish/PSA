#ifndef SEARCH_H
#define SEARCH_H

#include <iostream>

namespace YODA_PSA
{

/**
 * @brief Naive pattern search algorithm (Brute force)
 * 
 * O(n*m) 
 * n is the length of the array to search from and 
 * m is the size of the pattern
 * 
 * @param charArray array of data to seach from
 * @param pattern pattern to find
 * @param mainArraySize size of main array
 * @param patternLength length of pattern
 * @param startIndex #index to start searching from
 * @param locationIndex indexing to use
 * @return int* 
 */
int *naivePatternSearch(const char *charArray, const char *pattern, int mainArraySize, int patternLength, int startIndex, int *locationIndex);


} // namespace YODA_PSA

#endif