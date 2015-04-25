
setwd("C:/Coursera/Swiftkey")

rm(list=ls(all=TRUE))
gc(reset=TRUE)
par(mfrow=c(1,1))

require(tm)
require(SnowballC)

# Material is already downloaded, for performance reasons no need to do this
# again


if (!file.exists("data")) {
  dir.create("data")
 }

fileUrl <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"
#download.file(fileUrl, destfile = "./data/SwiftKey.zip")

dateDownloaded <- date()
dateDownloaded

## Unzip the and get the data to R
Swiftkey <- unzip("../data/SwiftKey.zip")

# calculate lengths 
length_twitter<-length(readLines(file("final/en_US/en_US.twitter.txt", "r")))
length_blog <- length(readLines(file("final/en_US/en_US.blogs.txt", "r") ))
length_news <- length(readLines(file("final/en_US/en_US.news.txt", "r")))

con_twitter <- file("final/en_US/en_US.twitter.txt", "r")

# initialize empty
sample_twitter <-c ()
n <- 1
for(i in 1:length_twitter){
  temp<-readLines(con_twitter,1)
  ###binomial distribution to get a 1% sample
  if(rbinom(1,1,0.02)){
    sample_twitter[n]<-temp
    n=n+1
  }
}
close(con_twitter)


con_news <- file("final/en_US/en_US.news.txt", "r") 

sample_news <-c ()
n <- 1
#for(i in 1:length_news){
for(i in 1:length_news){
  temp<-readLines(con_news,1)
  
  if(rbinom(1,1,0.2)){
    
    sample_news[n]<-temp
    n=n+1
  }
}
close(con_news)


con_blog <- file("final/en_US/en_US.blogs.txt", "r") 

sample_blog <-c ()
n <- 1
for(i in 1:length_blog){
  temp<-readLines(con_blog,1)
  if(rbinom(1,1,0.02)){
    sample_blog[n]<-temp
    n=n+1
  }
}


close(con_blog)



# combine these samples
sample_combination = c(sample_twitter, sample_news, sample_blog)




#en_US <- file.path('.','final','en_US')
#length(dir(en_US))
#en_US.document <- Corpus(sample_combination, 
#                         readerControl = list(reader = readPlain,language = "en_US",load = TRUE))

en_US.document <- Corpus(VectorSource(sample_combination))


#require(data.table)


# see a few samples
en_US.document[[1]]



en_US.document <- tm_map(en_US.document, removeNumbers)
en_US.document <- tm_map(en_US.document, removePunctuation)
en_US.document <- tm_map(en_US.document , stripWhitespace)
en_US.document <- tm_map(en_US.document, tolower)
en_US.document <- tm_map(en_US.document, stemDocument)
en_US.document <- tm_map(en_US.document, PlainTextDocument)


library("RWeka")

# construct bi-gram tokanizer and tri-gram tokanizer
BiGramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
TriGramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))
QuatroGramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 4, max = 4))
QuintoGramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 5, max = 5))



dtm5 = DocumentTermMatrix(en_US.document, control = list(tokenize = QuintoGramTokenizer))
dtm4 = DocumentTermMatrix(en_US.document, control = list(tokenize = QuatroGramTokenizer))
dtm3 = DocumentTermMatrix(en_US.document, control = list(tokenize = BiGramTokenizer))
dtm2 = DocumentTermMatrix(en_US.document, control = list(tokenize = TriGramTokenizer))


dtm2Sparse = removeSparseTerms(dtm2, 0.999)
dtm3Sparse = removeSparseTerms(dtm3, 0.9996)
dtm4Sparse = removeSparseTerms(dtm4, 0.99996)
dtm5Sparse = removeSparseTerms(dtm5, 0.99998)

dim(dtm2)
dim(dtm2Sparse)

dim(dtm3)
dim(dtm3Sparse)

dim(dtm4)
dim(dtm4Sparse)

dim(dtm5)
dim(dtm5Sparse)

dtmx2 = as.data.frame(as.matrix(dtm2Sparse))
dtmx2ColSums = colSums(dtmx2)

dtmx3 = as.data.frame(as.matrix(dtm3Sparse))
dtmx3ColSums = colSums(dtmx3)

dtmx4 = as.data.frame(as.matrix(dtm4Sparse))
dtmx4ColSums = colSums(dtmx4)

dtmx5 = as.data.frame(as.matrix(dtm5Sparse))
dtmx5ColSums = colSums(dtmx5)

#bigrams = as.data.frame(dtmx2ColSums)
bigrams = dtmx2ColSums
bigrams$word2 = names(dtmx2ColSums)
bigrams <- bigrams[order(-bigrams$dtmx2ColSums),]
save(bigrams, file="bigrams.Rda")

trigrams = as.data.frame(dtmx3ColSums)
trigrams$word3 = names(dtmx3ColSums)
trigrams <- trigrams[order(-trigrams$dtmx3ColSums),]
save(trigrams, file="trigrams.Rda")

quatrograms = as.data.frame(dtmx4ColSums)
quatrograms$word4 = names(dtmx4ColSums)
quatrograms <- quatrograms[order(-quatrograms$dtmx4ColSums),]
save(quatrograms, file="quatrograms.Rda")

quintograms = as.data.frame(dtmx5ColSums)
quintograms$word5 = names(dtmx5ColSums)
quintograms <- quintograms[order(-quintograms$dtmx5ColSums),]
save(quintograms, file="quintograms.Rda")









