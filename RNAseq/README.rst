These scripts are run on a series of FASTQ files, utilizing the Tuxedo suite of Tophat/Bowtie/Cufflinks.
They are intended to be run on a cluster via qsub.

Preparation
-----------

* Decide on a reference genome, I prefer using Ensembl.  Download the fasta file and the gtf file of the genome
* Generate the bowtie2 index files (use the script **bowtie_index.sh**).  This only needs to be done once.

Generation of Alignments
------------------------

* Ammend the SAMPLE_README file with the software versions and reference genomes and reference assembly files.  Save this in your working directory as  README
* To generate the alignments edit the script **tophat_cufflinks.sh** with the following information: 

    * In the for loop change the Sample_XXXX to the actual sample names for your FASTQ files
    * adjust the GTF and REFERENCE locations for your assembly and index files respectively

* This will generate two new directories, *tophat_out* and *cufflinks_out* as well as an *assembly.txt* file for use with cuffmerge
* Each alignment will be in the *accepted_hits.bam* file in the *tophat_out/Sample_XXXXX* directory.

Analysis of Aligned Data
------------------------

Generally we use three anlyses for RNAseq data, two at the gene level (DESeq and Cufflinks) and one at the exon level (DEXseq).
All of these analyses files are provided in RMarkdown format, which can be edited within RStudio and run to generate an html output.  They can also be run within R directly by pasting in the lines between the code blocks (denoted with ```).

Generation of a Counts Table
""""""""""""""""""""""""""""

For DESeq and DEXseq, a counts table needs to be generated.  To generate the counts table, using R run the Rmarkdown script *counts_table.Rmd*.  The script currently aligns reads to the latest ensemble assembly, downloaded from biomart and this should be set to whatever you used for your tophat alignment.  It is possible to use archived (older) alignments, see the biomaRt documentation.  This script will generate two counts tables:

 * transcript_counts_table.csv
 * exon_counts_table.csv

Running DEXseq
""""""""""""""

DEXseq analysis is done using the scrpipt *dexseq_analysis.Rmd*.  That script will run the statistics for all the exons in yoru dataset.  It is important that you generate your exon data frame using the same assembly used to generate your counts table, and to generate your alignments.

You will also need to modify the gene-specific analyses depending on what you want to look at.