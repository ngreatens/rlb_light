#!/bin/bash

assembly=$1
forward_reads=$2
reverse_reads=$3
outname=$4

module load \
	hisat2/2.2.1 \
	samtools/1.16.1

#hisat2-build $assembly genome
hisat2 -x genome -1 $forward_reads -2 $reverse_reads -S ${outname}.sam
cat ${outname}.sam | samtools view --bam -F 4 - | samtools sort --write-index -o ${outname}_mapped.bam -
