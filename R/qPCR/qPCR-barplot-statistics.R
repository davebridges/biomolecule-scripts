#This is a simple script for qPCR data
#This requires a csv file with the headings where value is the normalized ddCt:
#gene
#sample
#treatment
#value

setwd('C:/Documents and Settings/davebrid/My Documents/Research/') #set to where you want the data saved
filename <- data.csv #adjust to whatever your input file is called
data <- read.csv(filename)
library(plyr) #loads the plyr package
superpose.eb <- function (x, y, ebl, ebu = ebl, length = 0.08, ...)
  arrows(x, y + ebu, x, y - ebl, angle = 90, code = 3,
         length = length, ...) #creates the error bar function
#this command creates a summary table with means and standard errors.  Each row is a gene:treatment pair
summary <- ddply(data,~gene*treatment,summarise,
               mean=mean(value, na.rm=TRUE),
               se=sd(value, na.rm=TRUE)/sqrt(length(value)))
                 
#sample data                 
#gene <- c(rep("Gene1",6), rep("Gene2",6))
#sample <- seq(1:12) 
#treatment <- c(rep("Treatment1",3), rep("Treatment2",3),rep("Treatment1",3), rep("Treatment2",3)) 
#value <- sample(12) #randomly generated sample
#data <- data.frame(gene,sample,treatment,value)    


#filter data frame to show genes per treatment
gene1 <- subset(summary, gene=="Gene1") #replace all instances with gene name
pdf("Gene1.pdf")
plot <- barplot(gene1$mean, names.arg=(gene1$treatment),  
                ylab="Relative Expression",
                ylim=c(0,max(gene1$mean+gene1$se))) #this sets the y-axis maximum to the highest value/error combination
superpose.eb(plot, gene1$mean, gene1$se)
dev.off()

pdf("Gene2.pdf")
gene2 <- subset(summary, gene=="Gene2")
plot <- barplot(gene2$mean, names.arg=(gene2$treatment),  
                ylab="Relative Expression",
                ylim=c(0,max(gene2$mean+gene2$se))) #this sets the y-axis maximum to the highest value/error combination
superpose.eb(plot, gene2$mean, gene2$se)
dev.off()

#statistics
gene1.t.test <- with(subset(data, gene== "Gene1"), 
                     pairwise.t.test(value,treatment, p.adjust.method="none"))
gene2.t.test <- with(subset(data, gene== "Gene2"), 
                     pairwise.t.test(value,treatment, p.adjust.method="none"))

print(gene1.t.test)
print(gene2.t.test)