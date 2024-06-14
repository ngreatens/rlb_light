#!/bin/bash

gff=$1
input_folder=$2


declare -a bams=()
for file in $input_folder/*; do bams+=($file); done

module load subread/2.0.4 

featureCounts \
    -a $gff `#annotation` \
    -T 16 `#threads` \
    -t gene \
    -g ID \
    -o counts.txt \
    -p `#paired end` \
    "${bams[@]}"
