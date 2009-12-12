"""This is a module to retrieve and parse pubmed articles which match a keyword"""

from Bio import Entrez
Entrez.email = "davebrid@umich.edu"

def get_article_abstract(article_id):
    """Takes an article_id and prints out the abstract of that article 
    
    >>>article_id = 18434594
    >>>get_article_abstract(18434594)
    1: Mol Biol Cell. 2008 Jul;19(7):2718-28. Epub 2008 Apr 23. 

    Insulin stimulates phosphatidylinositol 3-phosphate production via the activation of Rab5.

    Lodhi IJ, Bridges D, Chiang SH, Zhang Y, Cheng A, Geletka LM, Weisman LS, Saltiel AR.

    Life Sciences Institute, University of Michigan, Ann Arbor, MI 48109, USA.

    Phosphatidylinositol 3-phosphate (PI(3)P) plays an important role in insulin-stimulated glucose uptake. Insulin promotes the production of PI(3)P at the plasma membrane by a process dependent on TC10 activation. Here, we report that insulin-stimulated PI(3)P production requires the activation of Rab5, a small GTPase that plays a critical role in phosphoinositide synthesis and turnover. This activation occurs at the plasma membrane and is downstream of TC10. TC10 stimulates Rab5 activity via the recruitment of GAPEX-5, a VPS9 domain-containing guanyl nucleotide exchange factor that forms a complex with TC10. Although overexpression of plasma membrane-localized GAPEX-5 or constitutively active Rab5 promotes PI(3)P formation, knockdown of GAPEX-5 or overexpression of a dominant negative Rab5 mutant blocks the effects of insulin or TC10 on this process. Concomitant with its effect on PI(3)P levels, the knockdown of GAPEX-5 blocks insulin-stimulated Glut4 translocation and glucose uptake. Together, these studies suggest that the TC10/GAPEX-5/Rab5 axis mediates insulin-stimulated production of PI(3)P, which regulates trafficking of Glut4 vesicles.

    Publication Types:
        Research Support, N.I.H., Extramural
        Research Support, Non-U.S. Gov't

    PMID: 18434594 [PubMed - indexed for MEDLINE]


    """
    article_handle = Entrez.efetch(db="pubmed", id=article_id, rettype="abstract", retmode="text")
    article = article_handle.read()
    print article


handle = Entrez.einfo(db="pubmed") # gets information about the Entrez pubmed database
record = Entrez.read(handle) #parses pubmed information

total_records = record["DbInfo"]["Count"] #obtains a count of total records in the PubMed database
last_updated = record["DbInfo"]["LastUpdate"] #obtains the most recent update to the PubMed database

query = "Bridges D[AUTH] AND Saltiel AR[AUTH]" #sets the query; should make this an input field

"""Takes an author's name and performs a pubmed search for articles by that author

>>>query = "Saltiel AR"
>>>handle = Entrez.esearch(db="pubmed", term=query)
>>>record = Entrez.read(handle)
>>>record["RetMax"]
'20'


"""
handle = Entrez.esearch(db="pubmed", term=query) #searches PubMed for the specified query
record = Entrez.read(handle) #parses the entrez search results
article = record["IdList"][0] #gets the first article in the list
article_handle = Entrez.efetch(db="pubmed", id=article, rettype="medline", retmode="xml") #retrieves the first article as xml
filename = "%s.xml" % article #sets filename for output file to be the gi number.xml
outhandle = open(filename, "w") #generates and opens the output file
outhandle.write(article_handle.read()) #writes article to output file 
outhandle.close()
article_handle.close()
print "Saved as %s" % filename  #prints a completion output

cited_articles = Entrez.read(Entrez.elink(dbfrom="pubmed", db="pmc", LinkName="pubmed_pmc_refs", from_uid=article)) #gets pubmed central articles which cite the article
cited_article_ids = [link["Id"] for link in cited_articles[0]["LinkSetDb"][0]["Link"]]
cited_pmid = Entrez.read(Entrez.elink(dbfrom="pmc", db="pubmed", LinkName="pmc_pubmed", from_uid=",".join(cited_article_ids)))
if cited_pmid:
    print "This article was cited by:\n %s" % get_article_abstract(cited_pmid[0]["IdList"][0])
else:
    print "This article has not been cited in PubMed Central"
