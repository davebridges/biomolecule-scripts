#get sample data
site <- "https://spark-public.s3.amazonaws.com/dataanalysis/movies.txt"
download.file(site, destfile="movies.txt", method="curl")
MovieData <- read.delim("movies.txt")

with(MovieData, plot(jitter(as.numeric(rating)), score, pch=19, col=rating, xaxt="n"))
axis(side=1, at=1:4, labels=levels(MovieData$rating))

#calculate means
means <- tapply(MovieData$score,MovieData$rating, mean)
#add axis means
segments(0.75, means[1], 1.25, means[1], col=palette()[1])
segments(1.75, means[2], 2.25, means[2], col=palette()[2])
segments(2.75, means[3], 3.25, means[3], col=palette()[3])
segments(3.75, means[4], 4.25, means[4], col=palette()[4])
