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
