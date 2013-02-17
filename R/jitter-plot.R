#get sample data
site <- "https://spark-public.s3.amazonaws.com/dataanalysis/movies.txt"
download.file(site, destfile="movies.txt", method="curl")
MovieData <- read.delim("movies.txt")

with(MovieData, plot(jitter(as.numeric(rating)), score, pch=19, col=rating, xaxt="n"))
axis(side=1, at=1:4, labels=levels(MovieData$rating))

#calculate means
means <- tapply(MovieData$score,MovieData$rating, mean)
#add axis means
scaling = length(levels(MovieData$rating))
scaling.values <- seq(1, scaling, by=1)
scaling.values.upper <- scaling.values+1/scaling
scaling.values.lower <- scaling.values-1/scaling
for (i in scaling.values) segments(scaling.values.lower[i], means[i], scaling.values.upper[i], means[i], col=palette()[i])
