#!/bin/sh
#before starting symlink to the appropriate annotation index genes.gtf and symlink mm9 or hg19 to the bowtie index
#sample commands:
#ln -s /database/reference-annotations/Mus_musculus/UCSC/mm10/genes.gtf mm10_genes.gtf
#ln -s /database/reference-annotations/Mus_musculus/UCSC/mm10/mm10_th2.* .
#once fastq files are extracted into folders, adjust the numbering and the grouping (in cuffdiff) accordingly
tophat -p 3 -G mm10_genes.gtf -o tophat2/Sample10829th2out mm10_th2 Sample10829/sample10829.fastq
tophat -p 3 -G mm10_genes.gtf -o tophat2/Sample10830th2out mm10_th2 Sample10830/Sample10830.fastq
tophat -p 3 -G mm10_genes.gtf -o tophat2/Sample10831th2out mm10_th2 Sample10831/Sample10831.fastq
tophat -p 3 -G mm10_genes.gtf -o tophat2/Sample10832th2out mm10_th2 Sample10832/Sample10832.fastq
tophat -p 3 -G mm10_genes.gtf -o tophat2/Sample10833th2out mm10_th2 Sample10833/Sample10833.fastq
tophat -p 3 -G mm10_genes.gtf -o tophat2/Sample10834th2out mm10_th2 Sample10834/Sample10834.fastq
tophat -p 3 -G mm10_genes.gtf -o tophat2/Sample10835th2out mm10_th2 Sample10835/Sample10835.fastq
tophat -p 3 -G mm10_genes.gtf -o tophat2/Sample10836th2out mm10_th2 Sample10836/Sample10836.fastq
tophat -p 3 -G mm10_genes.gtf -o tophat2/Sample10837th2out mm10_th2 Sample10837/Sample10837.fastq
tophat -p 3 -G mm10_genes.gtf -o tophat2/Sample10838th2out mm10_th2 Sample10838/Sample10838.fastq
tophat -p 3 -G mm10_genes.gtf -o tophat2/Sample10839th2out mm10_th2 Sample10839/Sample10839.fastq
tophat -p 3 -G mm10_genes.gtf -o tophat2/Sample10840th2out mm10_th2 Sample10840/Sample10840.fastq
cufflinks -p 3 -o tophat2/Sample10829clout tophat2/Sample10829th2out/accepted_hits.bam
cufflinks -p 3 -o tophat2/Sample10830clout tophat2/Sample10830th2out/accepted_hits.bam
cufflinks -p 3 -o tophat2/Sample10831clout tophat2/Sample10831th2out/accepted_hits.bam
cufflinks -p 3 -o tophat2/Sample10832clout tophat2/Sample10832th2out/accepted_hits.bam
cufflinks -p 3 -o tophat2/Sample10833clout tophat2/Sample10833th2out/accepted_hits.bam
cufflinks -p 3 -o tophat2/Sample10834clout tophat2/Sample10834th2out/accepted_hits.bam
cufflinks -p 3 -o tophat2/Sample10835clout tophat2/Sample10835th2out/accepted_hits.bam
cufflinks -p 3 -o tophat2/Sample10836clout tophat2/Sample10836th2out/accepted_hits.bam
cufflinks -p 3 -o tophat2/Sample10837clout tophat2/Sample10837th2out/accepted_hits.bam
cufflinks -p 3 -o tophat2/Sample10838clout tophat2/Sample10838th2out/accepted_hits.bam
cufflinks -p 3 -o tophat2/Sample10839clout tophat2/Sample10839th2out/accepted_hits.bam
cufflinks -p 3 -o tophat2/Sample10840clout tophat2/Sample10840th2out/accepted_hits.bam
cuffmerge -g genes.gtf -s mm9.fa -p 3 assemblies_tophat2.txt
cuffdiff -o diff_out -b mm9.fa -p 3 -L Sample1/Sample2 -u merged_asm/merged.gtf ./tophat2/Sample10829th2out/accepted_hits.bam,./tophat2/Sample10830th2out/accepted_hits.bam,./tophat2/Sample10831th2out/accepted_hits.bam,./tophat2/Sample10832th2out/accepted_hits.bam,./tophat2Sample10833th2out/accepted_hits.bam,./tophat2/Sample10834th2out/accepted_hits.bam ./tophat2/Sample10835th2out/accepted_hits.bam,./tophat2/Sample10836th2out/accepted_hits.bam,./tophat2/Sample10837th2out/accepted_hits.bam,./tophat2/Sample10838th2out/accepted_hits.bam,./tophat2/Sample10839th2out/accepted_hits.bam,./tophat2/Sample10840th2out/accepted_hits.bam
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
