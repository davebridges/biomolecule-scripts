#!/bin/sh
#before starting symlink to the appropriate annotation index genes.gtf and symlink mm9 or hg19 to the bowtie index
#once fastq files are extracted into folders, adjust the numbering and the grouping (in cuffdiff) accordingly
tophat -p 3 -G genes.gtf -o Sample10829out mm9 Sample10829/sample10829.fastq
tophat -p 3 -G genes.gtf -o Sample10830out mm9 Sample10830/Sample10830.fastq
tophat -p 3 -G genes.gtf -o Sample10831out mm9 Sample10831/Sample10831.fastq
tophat -p 3 -G genes.gtf -o Sample10832out mm9 Sample10832/Sample10832.fastq
tophat -p 3 -G genes.gtf -o Sample10833out mm9 Sample10833/Sample10833.fastq
tophat -p 3 -G genes.gtf -o Sample10834out mm9 Sample10834/Sample10834.fastq
tophat -p 3 -G genes.gtf -o Sample10835out mm9 Sample10835/Sample10835.fastq
tophat -p 3 -G genes.gtf -o Sample10836out mm9 Sample10836/Sample10836.fastq
tophat -p 3 -G genes.gtf -o Sample10837out mm9 Sample10837/Sample10837.fastq
tophat -p 3 -G genes.gtf -o Sample10838out mm9 Sample10838/Sample10838.fastq
tophat -p 3 -G genes.gtf -o Sample10839out mm9 Sample10839/Sample10839.fastq
tophat -p 3 -G genes.gtf -o Sample10840out mm9 Sample10840/Sample10840.fastq
cufflinks -p 3 -o Sample10829clout Sample10829out/accepted_hits.bam
cufflinks -p 3 -o Sample10830clout Sample10830out/accepted_hits.bam
cufflinks -p 3 -o Sample10831clout Sample10831out/accepted_hits.bam
cufflinks -p 3 -o Sample10832clout Sample10832out/accepted_hits.bam
cufflinks -p 3 -o Sample10833clout Sample10833out/accepted_hits.bam
cufflinks -p 3 -o Sample10834clout Sample10834out/accepted_hits.bam
cufflinks -p 3 -o Sample10835clout Sample10835out/accepted_hits.bam
cufflinks -p 3 -o Sample10836clout Sample10836out/accepted_hits.bam
cufflinks -p 3 -o Sample10837clout Sample10837out/accepted_hits.bam
cufflinks -p 3 -o Sample10838clout Sample10838out/accepted_hits.bam
cufflinks -p 3 -o Sample10839clout Sample10839out/accepted_hits.bam
cufflinks -p 3 -o Sample10840clout Sample10840out/accepted_hits.bam
cuffmerge -g genes.gtf -s mm9.fa -p 3 assemblies.txt
cuffdiff -o diff_out -b mm9.fa -p 3 -L GroupName1,GroupName2 -u merged_asm/merged.gtf ./Sample10829out/accepted_hits.bam,./Sample10830out/accepted_hits.bam,./Sample10831out/accepted_hits.bam,./Sample10832out/accepted_hits.bam,./Sample10833out/accepted_hits.bam,./Sample10834out/accepted_hits.bam ./Sample10835out/accepted_hits.bam,./Sample10836out/accepted_hits.bam,./Sample10837out/accepted_hits.bam,./Sample10838out/accepted_hits.bam,./Sample10839out/accepted_hits.bam,./Sample10840out/accepted_hits.bam
#merge all accepted_hits.bam into one large bam file
samtools merge all_accepted_hits.bam *out/accepted_hits.bam
#index each of the accepted_hits.bam files (including the new large one)
for i in *out/accepted_hits.bam; do echo $i; samtools index $i; done;
#counts the number of hits per chromosome for each sample and exports this as chromosome_counts.txt
for i in *out/accepted_hits.bam; do echo $i; samtools idxstats $i ; done > chromosome_counts.txt;
#list of all the gtf files in the working directory (and subdirectories)
find . -name transcripts.gtf > gtf_out_list.txt
#compares each assembly gtf  to the reference annotation
cuffcompare -i gtf_out_list.txt -r genes.gtf
#outputs a table for each assembly listing matches to reference genome... not working
#for i in 'find . -name *.tmap'; do echo $i; awk 'NR > 1 { s[$3]++ } END { \
  for (j in s) {print j, s[j] }} ' $i; done;
