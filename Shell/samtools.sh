#combine, sort and index a bam file
samtools merge -f combined.bam */accepted_hits.bam
samtools sort -f combined.bam combined.sorted
samtools index combined.sorted.bam

#filter a bam file for a particular chromosome set (see http://seqanswers.com/forums/showthread.php?t=6892)
samtools view -h *sorted.bam | awk '$3=="chr1" || $3=="chr3" || /^@/' | samtools view -Sb -> onlychr1_3.bam.sorted.bam
