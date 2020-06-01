#include "Search.h"

int * YODA_PSA::naivePatternSearch(const char *charArray, const char *pattern, int mainArraySize, int patternLength, int startIndex, int *index)
{
    int * location = new int[mainArraySize];
    (*index) = -1;
    for (int i = startIndex ; i <= (mainArraySize - patternLength); ++i)
    {
        int j;

        for (j = 0; j < patternLength; ++j)
        {
            if (charArray[i + j] != pattern[j])
                break;
        }

        if(j== patternLength){
            (*index)++;
            location[*index] = i;
        }
    }

    return location;
}