#!/bin/bash

### RSEM: gene quantification based on BAMs aligned to the transcriptome ###

# Confirming that we are in the correct directory to run
cd /PROJECT_DIR/

# Defining input and output folders
INPUT_FOLDER=/PROJECT_DIR/STAR_align
OUTPUT_FOLDER=/PROJECT_DIR/RSEM_quant

## Running RSEM

echo "Starting RSEM quantification!"

for i in $(cat rsem_input.list); do

echo "RSEM started for sample ${i}"

rsem-calculate-expression -p 20 --paired-end --bam --estimate-rspd --append-names \
	--output-genome-bam ${INPUT_FOLDER}/${i}_STAR_GRCh38Aligned.toTranscriptome.out.bam \
	/HUMAN_REF/ \
	${OUTPUT_FOLDER}/${i}_STARaligned_RSEMquantified

done
