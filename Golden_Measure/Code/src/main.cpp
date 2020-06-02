#include "Search.h"
#include <time.h>

int main() {
   std::string mainString = "ABAAABCDBBABCDDEBCABC";
   std::string pattern = "ABC";
   int index = -1;
   clock_t time = clock();
   int * locArray =  YODA_PSA::naivePatternSearch(mainString.c_str(), pattern.c_str(), mainString.size(),pattern.size(),0, &index);
   time = clock() - time;
   for(int i = 0; i <= index; i++) {
      std::cout << "Pattern found at position: " << locArray[i]<<std::endl;
   }

   std::cout << "search took " << ((float)time)/CLOCKS_PER_SEC << " seconds" << std::endl;

    return 0;
}