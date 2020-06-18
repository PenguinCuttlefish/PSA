#include "Search.h"
#include <time.h>
#include <string.h>
#include <iostream>
#include <sstream>
#include <fstream>

char *readfile(const std::string filename, const int numOfChar)
{

   unsigned char *inputstream;
   //input stream
   std::ifstream inFile;
   std::string line;

   inFile.open(filename, std::ifstream::binary);

   if (!inFile)
   {
      std::cerr << "Unable to open file" << filename << std::endl;
      inFile.close();
      return 0;
   }
   else
   {

      inputstream = new unsigned char[numOfChar];
      //add characters to the array
      inFile.read((char *)inputstream, numOfChar);
   }
   inFile.close();

   return (char *)inputstream;
}

int main(int argc, char *argv[])
{
   if (argc < 3)
   {
      std::cout << "Missing inputs" << std::endl;
      return 0;
   }

   const std::string inputFile = argv[1];

   const std::string sizeOfFile = argv[2];

   char* pattern = argv[3];

   char* mainString = readfile(inputFile,std::stoi(sizeOfFile));

   int index = -1;
   clock_t time = clock();

   std::cout << strlen(mainString) << " " << strlen(pattern) << std::endl;

   int *locArray = YODA_PSA::naivePatternSearch(mainString, pattern, strlen(mainString), strlen(pattern), 0, &index);
   
   time = clock() - time;
   for (int i = 0; i <= index; i++)
   {
      std::cout << "Pattern found at position: " << locArray[i] << std::endl;
   }

   std::cout << "search took " << ((float)time) / CLOCKS_PER_SEC << " seconds" << std::endl;

   return 0;
}