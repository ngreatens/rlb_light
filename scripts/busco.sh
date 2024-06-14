#!/bin/bash

input_fasta=$1
outname=$2

module load apptainer


apptainer exec /project/fdwsru_fungal/Nick/sifs/busco_v5.7.0_cv1.sif \
	\
	busco \
	--download_path /project/fdwsru_fungal/Nick/databases/ \
	--mode genome \
	--lineage_dataset dothideomycetes_odb10 \
	--in $input_fasta \
	--out $outname 
