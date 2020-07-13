#!/bin/bash

## activate msa
conda activate msa


## get input data (uniprot ids)
VAR=$(cat uniprot_ids.txt)

URL="http:/www.uniprot.org/uniprot/"

## loop for downloading data
for i in ${VAR}
do 

echo "(o) Downloading Uniprot entry: ${i}"
wget ${URL}${i}.fasta
echo "(o) Done downloading ${i}"

## construct muscle input
cat ${i}.fasta >> muscle_input.fasta
rm ${i}.fasta

done

