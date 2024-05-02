# 02_mapped_reads

## 02052024

all rnaseq reads mapped to reference genome with hisat2. mapped reads extracted and sorted in bam file.

e.g. 
```
hisat2-build LW_SCC_SI.fasta genome
```
and 
```
../rlb_light/scripts/hisat2.sh genome AN.T.W_dark_R1_fastp_1.fastq AN.T.W_dark_R2_fastp_2.fastq AN.T.W_dark
../rlb_light/scripts/hisat2.sh genome AN.T.W_light_R1_fastp_1.fastq AN.T.W_light_R2_fastp_2.fastq AN.T.W_light
```
