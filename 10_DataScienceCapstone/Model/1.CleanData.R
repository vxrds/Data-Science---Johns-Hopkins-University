library(qdap)
library(tm)
library(ngram)

## Declarations
#setwd("/mnt/hgfs/Z/Data Science/Coursera/JHU/10. Data Science Capstone/Capstone")
setwd("Z:/F/Data Science/Coursera/JHU/10. Data Science Capstone/Capstone")
sZip <- "./SwiftKey/Coursera-SwiftKey.zip"
sSwiftKeyZip <- paste("https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/", sZip, sep = "")
sSwiftKeyFiles <- c("./SwiftKey/final/en_US/en_US.twitter.txt",
                    "./SwiftKey/final/en_US/en_US.news.txt",
                    "./SwiftKey/final/en_US/en_US.blogs.txt")

sSampleFilesRDS <- c("./data/twitter.sample.RDS", "./data/news.sample.RDS", "./data/blogs.sample.RDS")
sSampleFilesTXT <- c("./data/twitter.sample.txt", "./data/news.sample.txt", "./data/blogs.sample.txt")
sCleanFilesRDS <- c("./data/twitter.cleaned.RDS", "./data/news.cleaned.RDS", "./data/blogs.cleaned.RDS")
sCleanFilesTXT <- c("./data/twitter.cleaned.txt", "./data/news.cleaned.txt", "./data/blogs.cleaned.txt")

sFileNames <- c("Twitter", "News", "Blogs")
sSummaryRDS <- c("./data/summary.RDS", "./data/summary.txt")
sCorpusRDS <- c("./data/corpus.RDS", "./data/corpus.txt")

source("./R/File.R")
source("./R/Clean.R")

set.seed(25477)
nSampleSize <- 0.01
iMB <- 1024 ^ 2
oLine_Count <- c()
oWord_Count <- c()


## Download and unzip
if (!file.exists(sZip))
{
    download.file(fsURL, method = "curl")
    unlink(sURL)
    unzip(sZip, files = sFiles)
}

oSize_in_MB <- c(round(file.info(sSwiftKeyFiles[1])$size/iMB, 1),
                 round(file.info(sSwiftKeyFiles[2])$size/iMB, 1),
                 round(file.info(sSwiftKeyFiles[3])$size/iMB, 1))

#Clean twitter sample
oRet <- createCleanedSample(1)
oLine_Count <<- append(oLine_Count, oRet[1])
oWord_Count <<- append(oWord_Count, oRet[2])

#Clean news sample
oRet <- createCleanedSample(2)
oLine_Count <<- append(oLine_Count, oRet[1])
oWord_Count <<- append(oWord_Count, oRet[2])

#Clean blogs sample
oRet <- createCleanedSample(3)
oLine_Count <<- append(oLine_Count, oRet[1])
oWord_Count <<- append(oWord_Count, oRet[2])

# Write corpus sample
oTwitterCleaned <- readRDS(sCleanFilesRDS[1])
oNewsCleaned <- readRDS(sCleanFilesRDS[2])
oBlogsCleaned <- readRDS(sCleanFilesRDS[3])

sCorpus <- paste(as.character(oTwitterCleaned$content), 
                 as.character(oNewsCleaned$content), 
                 as.character(oBlogsCleaned$content), sep = " ")
saveRDS(sCorpus, sCorpusRDS[1])
writeLines(sCorpus[1], sCorpusRDS[2])

## Write summary
dfSummary <- data.frame(sFileNames, oSize_in_MB, oLine_Count, oWord_Count)
colnames(dfSummary) <- c("File", "Size_in_MB", "Lines", "Words")
saveRDS(dfSummary, file = sSummaryRDS[1])
write.table(dfSummary, sSummaryRDS[2], sep = "\t")


## Cleanup
rm(list = ls())
invisible(gc())
