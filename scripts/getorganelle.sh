#!/bin/bash

forward_reads=$1
reverse_reads=$2

eval "$(conda shell.bash hook)" #initiate shell for conda envs
conda activate /project/fdwsru_fungal/Nick/conda/envs/getorganelle

get_organelle_from_reads.py \
        -1 $forward_reads \
        -2 $reverse_reads \
        -k 21,45,65,85,105,125 \
        -F fungus_mt \
        --config-dir /project/fdwsru_fungal/Nick/databases/GetOrganelle \
        -o fungus_mt125_out

