# these command line scripts are for analysing the output of a cuffdiff run.  This has been tested using cufflinks version 1.10 and GNU Awk 3.1.5

# for promoter.diff; see http://cufflinks.cbcb.umd.edu/manual.html#cuffdiff_output for more details 
#column id's are shown here
# 1 test_id 
# 2 gene_id 
# 3 gene    
# 4 locus   
# 5 sample_1        
# 6 sample_2        
# 7 status  
# 8 value_1 
# 9 value_2 
# 10 sqrt(JS)        
# 11 test_stat       
# 12 p_value      
# 13 q_value 
# 14 significant


#output gene list (column 3) of significantly changed items (column 14) into a file named promoters-gene-list.txt
awk '$14 == "yes"{ print $3 }' promoters.diff > promoters-gene-list.txt

#output results for a particular gene.  This also works for the other diff files in the output
awk '$3 == "PIKFYVE"{ print  }' promoters.diff

#output for fpkm tracking a particular gene
awk '$5 == "PIKFYVE"{ print  }' isoforms.fpkm_tracking
