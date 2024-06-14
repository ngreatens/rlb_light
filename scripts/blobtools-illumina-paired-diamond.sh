#!/bin/bash

input_fasta=$1
forward_reads=$2
reverse_reads=$3

diamond_db=/project/fdwsru_fungal/Nick/databases/uniprot/reference_proteomes

#get coverage

module load  \
	bwa_mem2/2.2.1 \
	samtools/1.16.1

bwa-mem2 index -p ${input_fasta%.fasta} $input_fasta
bwa-mem2 mem \
    -t 40 \
    ${input_fasta%.fasta} \
    $forward_reads \
    $reverse_reads |
samtools sort -@40 -O BAM -o ${input_fasta%.*}_mapped.bam -
samtools index -c ${input_fasta%.*}_mapped.bam


#get diamond hits

module purge
module load diamond/2.1.8 
diamond blastx \
        --query $input_fasta \
        --db $diamond_db \
        --outfmt 6 qseqid staxids bitscore qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore \
        --sensitive \
        --max-target-seqs 1 \
        --evalue 1e-25 \
        --threads 40 \
        > ${input_fasta%.fasta}.diamond.blastx.out

module purge


FASTA=$input_fasta
BAM=${input_fasta%.*}_mapped.bam ### with csi index in same location. .e.g samtools index -c $BAM
DIAMOND_HITS=${input_fasta%.fasta}.diamond.blastx.out
TAXDUMP_DB=/project/fdwsru_fungal/Nick/databases/taxdump
PREFIX=${input_fasta%.fasta}

eval "$(conda shell.bash hook)" #intialize shell for conda environments
conda activate /project/fdwsru_fungal/Nick/conda/envs/blobtoolkit

blobtools add --create $PREFIX
blobtools add \
    --fasta $FASTA \
    --cov $BAM \
    --hits $DIAMOND_HITS \
    --taxdump $TAXDUMP_DB \
    --taxrule bestsum \
    $PREFIX
blobtools view --plot $PREFIX
blobtools filter --table ${PREFIX}_.tsv $PREFIX
cat ${PREFIX}_table.tsv | sed 's/,//g' | sed 's/\t/,/g' > ${PREFIX}_table.csv


# get table for top hits Ascomycota

blobtools filter --table ${PREFIX}_ascomycota.tsv --param bestsum_phylum--Inv=Ascomycota $PREFIX
cat ${PREFIX}_ascomycota.tsv  | sed -n '2,11p' > ${PREFIX}_ascomycota_head.tsv

#get average coverage for top 10 largest scaffolds with hits to Ascomycota

sum=0
while read line; do cov=$(echo $line | awk '{print $5}'); sum=`echo $sum + $cov | bc`; done < ${PREFIX}_ascomycota_head.tsv
cov_avg=`echo $sum / 10| bc`
min_cov=`echo $cov_avg / 2 | bc`
max_cov=`echo ${cov_avg}*1.5 | bc`

#filter scaffolds for top hit Ascomycota and coverage between .5x Avg and 1.5x Avg.

blobtools filter \
    --param bestsum_phylum--Inv=Ascomycota \
    --fasta $FASTA \
    --param ${BAM%.bam}_cov--Min=$min_cov \
    --param ${BAM%.bam}_cov--Max=$max_cov \
    $PREFIX

conda deactivate
