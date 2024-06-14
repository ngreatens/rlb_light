#!/bin/bash

assembly=$1
gff3=$2

module load antismash/7.0.0

antismash \
    --taxon fungi \
    --clusterhmmer \
    --tigrfam \
    --asf \
    --cc-mibig \
    --cb-general \
    --cb-subclusters \
    --cb-knownclusters \
    --pfam2go \
    --rre \
    --smcog-trees \
    --tfbs \
    --genefinding-gff3 $gff3 \
    $assembly

# takes much longer--cassis
