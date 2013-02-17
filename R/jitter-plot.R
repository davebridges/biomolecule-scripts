#get sample data
site <- "https://spark-public.s3.amazonaws.com/dataanalysis/movies.txt"
download.file(site, destfile="movies.txt", method="curl")
MovieData <- read.delim("movies.txt")

jitter.plot <- function(x,y,xlab=names(x)){
plot(jitter(as.numeric(x)), y, pch=19, col=x, xaxt="n",xlab=xlab)
axis(side=1, at=1:length(levels(x)), labels=levels(x))

#calculate means
means <- tapply(y,x, mean)
#add axis means
scaling = length(levels(x))
scaling.values <- seq(1, scaling, by=1)
scaling.values.upper <- scaling.values+1/scaling
scaling.values.lower <- scaling.values-1/scaling
for (i in scaling.values) segments(scaling.values.lower[i], means[i], scaling.values.upper[i], means[i], col=palette()[i])
}

#usage
with(MovieData, jitter.plot(rating,score))