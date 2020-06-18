#!/bin/bash

echo > output.txt

EXE_NAME=PSA

make

echo Golden measure with data of size 250 >> output.txt

#non existing
./bin/$EXE_NAME ../../Data/ascii/250_Gene.txt 250  ATAAGAA >> output.txt

#short in middle
./bin/$EXE_NAME ../../Data/ascii/250_Gene.txt 250 GAAATTACTTCCGCTA >> output.txt

./bin/$EXE_NAME ../../Data/ascii/250_Gene.txt 250 TCACTCCTGACGTGCG >> output.txt

#long closer to end
./bin/$EXE_NAME ../../Data/ascii/250_Gene.txt 250 TCACTCCTGACGTGCGTCAACCAGATAAAGCA >> output.txt

echo >> output.txt

echo Golden measure with data of size 500 >> output.txt

./bin/$EXE_NAME ../../Data/ascii/500_Gene.txt 500 ATAAGAA >> output.txt

./bin/$EXE_NAME ../../Data/ascii/500_Gene.txt 500 AGTCTGTCTTTGCCAT >> output.txt

./bin/$EXE_NAME ../../Data/ascii/500_Gene.txt 500 ACCGTGAACCCACCAG >> output.txt

./bin/$EXE_NAME ../../Data/ascii/500_Gene.txt 500 ACCGTGAACCCACCAGGATTAAGAGAAAGCAT >> output.txt

echo >> output.txt

echo Golden measure with data of size 1000 >> output.txt

./bin/$EXE_NAME ../../Data/ascii/1000_Gene.txt 1000 ATTAGAA >> output.txt

./bin/$EXE_NAME ../../Data/ascii/1000_Gene.txt 1000 CACCTCCCGCGGTCGA >> output.txt

./bin/$EXE_NAME ../../Data/ascii/1000_Gene.txt 1000 GTCAGAACCTTGGCGG >> output.txt

./bin/$EXE_NAME ../../Data/ascii/1000_Gene.txt 1000 GTCAGAACCTTGGCGGCCAGGTACGGCCTCGG >> output.txt

echo >> output.txt

echo Golden measure with data of size 2000 >> output.txt

./bin/$EXE_NAME ../../Data/ascii/2000_Gene.txt 2000 ATAGGGT >> output.txt

./bin/$EXE_NAME ../../Data/ascii/2000_Gene.txt 2000 CTAATCCTGTCCTTAG >> output.txt

./bin/$EXE_NAME ../../Data/ascii/2000_Gene.txt 2000 CGCAGCAGTTACGGCC >> output.txt

./bin/$EXE_NAME ../../Data/ascii/2000_Gene.txt 2000 CGCAGCAGTTACGGCCGGTCTCTTGATGAAGT >> output.txt

echo >> output.txt

echo Golden measure with data of size 4000 >> output.txt

./bin/$EXE_NAME ../../Data/ascii/4000_Gene.txt 4000 ATAGGGT >> output.txt

./bin/$EXE_NAME ../../Data/ascii/4000_Gene.txt 4000 AACAATATATGCGCTC >> output.txt

./bin/$EXE_NAME ../../Data/ascii/4000_Gene.txt 4000 CGACTGCTCGTCCTTA >> output.txt

./bin/$EXE_NAME ../../Data/ascii/4000_Gene.txt 4000 CGACTGCTCGTCCTTAGAACACCAAACTAACA >> output.txt

make clean