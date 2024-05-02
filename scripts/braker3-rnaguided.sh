#!/bin/bash

masked_genome=$1
species=$2
bamfolder=$3
prot_db=/project/fdwsru_fungal/Nick/databases/odbFungiProteins.fa


#generate bamlist. Create array of bams, and then echo array and replace spaces with commas.
declare -a bams=()
for bam in ${bamfolder}/*; do bams+=($bam); done
bamlist=$(echo "${bams[@]}" | sed 's/ /,/g')


module load \
	braker/3.0.3 \
	perl/5.36.0 \
	diamond/2.1.2 \
	blast+/2.13.0 \
	augustus/3.5.0 \
	bamtools/2.5.2 \
	samtools/1.17 \
	bedtools/2.30.0 \
	java/1.8 \
	python_3/3.11.1 \
	sratoolkit/3.0.2 \
	hisat2/2.2.1

# configure paths
export AUGUSTUS_BIN_PATH=/software/el9/apps/augustus/3.5.0/bin
export AUGUSTUS_SCRIPTS_PATH=/software/el9/apps/augustus/3.5.0/scripts
export CDBTOOLS_PATH=/project/fdwsru_fungal/Nick/git_repos/cdbfasta
export DIAMOND_PATH=/software/el9/apps/diamond/2.1.2
export GENEMARK_PATH=/project/fdwsru_fungal/Nick/git_repos/GeneMark-ETP/tools
export PERL5LIB=/project/fdwsru_fungal/Nick/perl5/lib/perl5:$PERL5LIB
export PATH=$PATH:/project/fdwsru_fungal/Nick/git_repos/stringtie
export PATH=$PATH:/project/fdwsru_fungal/Nick/git_repos/gffread
export PATH=$PATH:/project/fdwsru_fungal/Nick/git_repos/GUSHR
#export PATH=$PATH:/project/fdwsru_fungal/Nick/software/UCSC-tools
#export MAKEHUB_PATH=/project/fdwsru_fungal/Nick/git_repos/MakeHub
#export PATH=$PATH:/project/fdwsru_fungal/Nick/software/compleasm_kit

cd $species

braker.pl \
	--threads=16 \
	--fungus `#GeneMark-ETP option: run algorithm with branch point model. Use this option if you genome is a fungus.` \
	--genome=$masked_genome `#hard path`\
	--species=$species \
	--prot_seq=$prot_db \
	--gff3 \
	--AUGUSTUS_CONFIG_PATH=/project/fdwsru_fungal/Nick/software/augustus_config \
	--bam $bamlist

#To run with RNA-Seq and protein sequences
#
#braker.pl [OPTIONS] --genome=genome.fa --species=speciesname \
#    --prot_seq=proteins.fa --rnaseq_sets_ids=id_rnaseq1,id_rnaseq2 \
#    --rnaseq_sets_dir=/path/to/local/rnaseq/files
#braker.pl [OPTIONS] --genome=genome.fa --species=speciesname \
#    --prot_seq=proteins.fa --bam=id_rnaseq1.bam,id_rnaseq2.bam
#

