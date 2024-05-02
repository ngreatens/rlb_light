#!/bin/bash

assembly=$1

module load antismash/7.0.0

antismash \
    --taxon fungi \
    --genefinding-tool glimmerhmm \
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
    $assembly

# takes much longer--cassis
