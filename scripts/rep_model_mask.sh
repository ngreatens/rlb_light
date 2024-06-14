#!/bin/bash

threads=16
fasta=$1
dbname=$(basename $fasta .fasta)

module load repeatmodeler/2.0.4

mkdir $dbname; cd $dbname 

BuildDatabase \
    -name $dbname \
    $fasta

RepeatModeler \
    -threads $threads \
    -LTRStruct \
    -database $dbname

consensi_file=RM*/consensi.fa.classified

module purge
module load repeatmasker/4.1.5

RepeatMasker \
        -pa 16 `#parallel`\
        -e ncbi `#engine`\
        -lib $consensi_file `#library- output from RepeatModeler`\
        -xsmall `#soft mask repeats`\
        $fasta

cd ..
