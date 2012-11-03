#Before running this script, the following links need to be established:
#reference-annotations folder is symlinked

#this is the GTF file for the assembly
GTF="reference-annotations/Homo_sapiens.GRCh37.69.gtf"
#this is the name (without the .fa) of the index built with bowtie2-build
REFERENCE="reference-annotations/Homo_sapiens.GRCh37.69"

echo "This alignment is using bowtie with the $REFERENCE genome"
echo "The alignments and assemblies are made using $GTF"

#remove existing alignments and assemblies
rm -r tophat_out
rm -r cufflinks_out

mkdir tophat_out
mkdir cufflinks_out

for sample in Sample_12100 Sample_12101 Sample_12102 Sample_12103 Sample_12104 Sample_12105 Sample_12106 Sample_12107 Sample_12108 Sample_12109 Sample_12$

do
  #run tophat alignment
  echo "tophat2 -p 11 -G $GTF -o tophat_out/$sample reference-annotations/Homo_sapiens.GRCh37.69 $sample.fa" > $sample.sh
  echo "cufflinks -p 11 -o -g reference-annotations/Homo_sapiens.GRCh37.69.gtf -u cufflinks_out/$sample tophat_out/$sample/accepted_hits.bam" >> $sample.$
  echo "cufflinks_out/$sample/transcripts.gtf" >> assemblies.txt
  qsub -cwd $sample.sh
  rm $sample.sh
done

