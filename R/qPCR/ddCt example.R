#see http://www.bioconductor.org/packages/2.8/bioc/vignettes/ddCt/inst/doc/rtPCR-usage.pdf

#for installation
#source("http://www.bioconductor.org/biocLite.R")
#    biocLite("ddCt")
 
source(system.file("scripts", "ddCt.R", package="ddCt"))

#Set analysis parameterse (see comments)
params <- list(loadPath = system.file("extdata", package="ddCt"),savePath = getwd())
 
params$confFile <- system.file("scripts", "ddCt.conf", package="ddCt")
params$inputFile <- c("Experiment1.txt")
params$sampleAnnotationFile = NULL
params$columnForGrouping = NULL
params$onlyFromAnnotation = FALSE
params$referenceGene <- c("Gene1", "Gene2")
params$referenceSample <- c("Sample1")
params$threshold <- 40
params$mode = "mean"
#params$efficiencies = c("Gene A"=1.9,"Gene B"=1.8,"HK1"=2,"Gene C"=2,"HK2"=2)
#params$efficienciesError = c("Gene A"=0.01,"Gene B"=0.1,"HK1"=0.05,"Gene C"=0.01,"HK2"=0.2
params$plotMode = c("level","Ct")
#REMAIN
params$genesRemainInOutput = NULL
params$samplesRemainInOutput = NULL
#NOT
params$genesNotInOutput = NULL
params$samplesNotInOutput = NULL 
params$groupingBySamples = FALSE
params$plotPerObject = TRUE
#params$groupingForPlot = NULL
#params$groupingColor = c("#E41A1C","#377EB8","#4DAF4A","#984EA3","#FF7F00") 
#params$cutoff = NULL
#params$brewerColor = c("Set3","Set1","Accent","Dark2","Spectral","PuOr","BrBG")
params$legende = TRUE
params$ttestPerform = FALSE
#params$ttestCol = NULL