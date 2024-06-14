#!/bin/bash

input_fasta=$1


module load \
	interproscan/5.64-96.0 \
	java/11.0.2

#configure analyses with licensed components https://interproscan-docs.readthedocs.io/en/latest/ActivatingLicensedAnalyses.html
#phobius.signature.library.release=1.01
#binary.phobius.pl.path=/project/fdwsru_fungal/Nick/software/phobius/phobius.pl

interproscan.sh \
		-cpu 40 \
		-i $input_fasta `#unaligned fasta of predicted proteins: e.g. braker.codingseq` \
		-f XML,GFF3 \
		--goterms





