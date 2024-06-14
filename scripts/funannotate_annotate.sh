#!/bin/bash

fasta=$1
gff=$2
antismash_gbk=$3


export AUGUSTUS_CONFIG_PATH=/project/fdwsru_fungal/Nick/software/augustus_config


module load funannotate/1.8.16

funannotate annotate \
    --fasta $fasta \
    --gff $gff \
    --species C_glycines_LW_SCC_SI \
    --force \
    --out funannotate_out \
    --antismash $antismash_gbk
