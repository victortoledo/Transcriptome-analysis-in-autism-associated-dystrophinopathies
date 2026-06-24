#!/bin/bash

### STAR: read mapping to the reference genome ###

# Confirming that we are in the correct directory to run
cd /PROJECT_DIR/

# Creating the results folder
mkdir -p /PROJECT_DIR/STAR_align

# Defining input and output folders
INPUT_FOLDER=/PROJECT_DIR/merged_fastqs
OUTPUT_FOLDER=/PROJECT_DIR/STAR_align

## Running STAR

echo "Starting alignment with STAR!"

for i in $(cat star_input.list); do

echo "STAR started for sample ${i}"

/PATH/TO/STAR --genomeDir /PATH/TO/STAR_INDEX \
--runThreadN 12 \
--readFilesIn ${INPUT_FOLDER}/${i}_merged_R1_001.fastq.gz ${INPUT_FOLDER}/${i}_merged_R2_001.fastq.gz \
--readFilesCommand zcat --outFileNamePrefix ${OUTPUT_FOLDER}/${i}_STAR_GRCh38 \
--outSAMunmapped Within \
--outFilterType BySJout \
--outFilterMultimapNmax 20 \
--outFilterMismatchNmax 999 \
--outFilterMismatchNoverLmax 0.04 \
--alignIntronMin 20 \
--alignIntronMax 1000000 \
--alignMatesGapMax 1000000 \
--alignSJoverhangMin 8 \
--alignSJDBoverhangMin 1 \
--sjdbScore 1 \
--genomeLoad NoSharedMemory \
--outSAMtype BAM SortedByCoordinate \
--outSAMattributes Standard \
--quantMode TranscriptomeSAM

# MANUAL RSEM: /PATH/TO/STAR --genomeDir . --outSAMunmapped Within --outFilterType BySJout --outSAMattributes NH HI AS NM MD --outFilterMultimapNmax 20 --outFilterMismatchNmax 999 --outFilterMismatchNoverLmax 0.04 --alignIntronMin 20 --alignIntronMax 1000000 --alignMatesGapMax 1000000 --alignSJoverhangMin 8 --alignSJDBoverhangMin 1 --sjdbScore 1 --runThreadN 1 --genomeLoad NoSharedMemory --outSAMtype BAM Unsorted --quantMode TranscriptomeSAM --outSAMheaderHD @HD VN:1.4 SO:unsorted --outFileNamePrefix EVB-10_S10.RSEM.out.temp/EVB-10_S10.RSEM.out --readFilesIn /PATH/TO/READ1.fq.gz /PATH/TO/READ2.fq.gz

# STAR --genomeDir /PATH/TO/STAR_INDEX --readFilesIn $trim1 $trim2 --outFileNamePrefix $out --readFilesCommand zcat --runThreadN 6 \
# --genomeLoad NoSharedMemory --twopassMode Basic --sjdbGTFfile /PATH/TO/ANNOTATION.gtf --sjdbScore 2 --sjdbOverhang 150 \
# --limitSjdbInsertNsj 1000000 --outFilterMultimapNmax 20 --alignSJoverhangMin 8 --alignSJDBoverhangMin 1 --outFilterMismatchNmax 999 --outFilterMismatchNoverReadLmax 0.04 \
# --alignIntronMin 20 --alignIntronMax 1000000 --alignMatesGapMax 1000000 --outSAMunmapped Within --outFilterType BySJout --outSAMattributes NH HI AS NM MD --outSAMtype BAM SortedByCoordinate \
# --quantMode TranscriptomeSAM GeneCounts --quantTranscriptomeBan IndelSoftclipSingleend --limitBAMsortRAM 32000000000

done

#rm -R star/*_STARgenome star/*_STARpass1
