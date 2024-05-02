# 00_data

## RNAseq data

## Genomes

Genomes generated from rlb phylogenomics projects. Spades assemblies following cleanup. Scaffold names simplified and scafflds < 1000 bp removed. Names slightly different from RNAseq data. 

* Rename RNAseq data for consistency
* Rename genomes for ease of use

genome names original :
```
AN.T.W_scaffolds_renamed.fasta
CHI.P77_scaffolds_renamed.fasta
Emett64_S6_L001_scaffolds_filtered.fasta
Emett97_S7_L001_scaffolds_filtered.fasta
KAB.10_scaffolds_renamed.fasta
LW_SCC_SI_scaffolds_filtered.fasta
MT.M.P17_scaffolds_renamed.fasta
NAM.2_scaffolds_renamed.fasta
```

genome names updated:
```
AN.T.W.fasta
CHI.P77.fasta
Emett64.fasta
Emett97.fasta
KAB.10.fasta
LW_SCC_SI.fasta
MT.M.P17.fasta
NAM.2.fasta
```

RNAseq data for each of these isolates, but names are slightly different. Rename with rename.txt
```
AN.T.W  AHTK
CHI.P77 CHIP77
Emett64 Emett64
Emett97 Emett97
KAB.10  KAB10
LW_SCC_SI       LWSEESI
MT.M.P17        MTMP17
NAM.2   NAM5
```
```
while read line; do 
    old_name=$(echo $line | awk '{print $2}')
    new_name=$(echo $line | awk '{print $1}')
    for file in "$old_name"*; do
        mv $file $(echo $file | sed "s/$old_name/$new_name/1")
    done
done < rename
```



