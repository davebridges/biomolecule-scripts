#combine, sort and index a bam file
samtools merge -f combined.bam */accepted_hits.bam
samtools sort -f combined.bam combined.sorted
samtools index combined.sorted.bam

#filter a bam file for a particular region (look up region on Ensembl)
 samtools view combined.sorted.bam 2:209000000-210000000 > region_name.bam
