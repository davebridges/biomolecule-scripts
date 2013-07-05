#!/usr/bin/python
'''This package will take an input query and generate  list of blast hits.

The input query must be a refseq protein gi number.
The default cutoff is a Blast score of 100

This script can be invoked as::

    python blast_search.py 6319393
    
where 6319393 is the gi_number being queried.

The output of this script is a csv file named results.csv and a folder containing the fulll blast results located at blast_results/ with a separate XML file for each species.

The species tested by this script are mouse, yeast, drosophila and worms.
'''

import csv
import re
import os
import argparse
import sys

from Bio import Entrez, SeqIO
from Bio.Blast import NCBIWWW, NCBIXML

#set up argparse
#parser = argparse.ArgumentParser(description='Perform blast searches on a given gi number')
#parser.add_argument('gi', metavar='N', type=int, nargs='+',help='a gi number')
#args = parser.parse_args()

Entrez.email = "dave.bridges@gmail.com"

SCORE_CUTOFF = 100

SPECIES = (('mouse','10090'),
	('yeast','7227'),
	('drosophila','4932'),
	('worms','6239'))
	
#with open('results.csv','w') as csvfile:
#    dw = csv.writer(csvfile)
#    dw.writeheader('Species','Score','Expected','GI')

#creates the directory for blast_results if it dosent already exist
if not os.path.exists('blast_results'):
    os.makedirs('blast_results')


#this regex extracts the gi number (between the two | symbols)
r = re.compile('gi\|(.*?)\|')


for x in range(0, 4):
    result_handle = NCBIWWW.qblast("blastp", "refseq_protein", sys.argv[1], entrez_query='txid%s[orgn]' %SPECIES[x][1])
    print 'Performing blast search in %s for %s' %(SPECIES[x][0], sys.argv[1])
    save_file = open('blast_results/%s_blast_result.xml' %SPECIES[x][0], "w+")
    save_file.write(result_handle.read())
    save_file.close()
    result_handle.close()
    result_handle = open('blast_results/%s_blast_result.xml' %SPECIES[x][0])
    blast_record = NCBIXML.read(result_handle)
    for alignment in blast_record.alignments:
        for hsp in alignment.hsps:
            if hsp.score > SCORE_CUTOFF:
                with open('results.csv', 'a') as csvfile:
                        writer = csv.writer(csvfile)
                        writer.writerow([SPECIES[x][0],
                        hsp.score,
                        hsp.expect,
                        r.search(alignment.title).group(1)])