## Declarations
setwd("/mnt/hgfs/Z/Data Science/Coursera/JHU/10. Data Science Capstone/Capstone")
sCorpusSampleRDS <- "./data/corpus.RDS"
sCleanCorpusRDS <- "./data/clean.corpus.RDS"

library(qdap)
library(tm)
source("./R/Clean.R")

sCorpusSample <- readRDS(sCorpusSampleRDS)
system.time({
    oCorpus <- getCleanText(sCorpusSample, 1)
})
saveRDS(oCorpus, sCleanCorpusRDS)

rm(list = ls())
invisible(gc())



#Twitter sample
iFileIndex <- 1
if (file.exists(sSwiftKeyFiles[iFileIndex])){
    sFileSample <- readRDS(sSampleFiles[iFileIndex])
} else {
    sFileText <- getFileContents(sSwiftKeyFiles[iFileIndex])
    oLine_Count <<- append(oLine_Count, length(sFileText))
    oWord_Count <<- append(oWord_Count, sum(sapply(gregexpr("\\S+", sFileText), length)))
    sFileSample <- sample(sFileText, ceiling(oLine_Count[iFileIndex] * nSampleSize))
    saveRDS(sFileSample, sSampleFiles[iFileIndex])
}
system.time({
    oCorpus <- getCleanText(sFileSample, 1)
    saveRDS(oCorpus, sCleanFiles[iFileIndex])
})

## News sample
sFileText <- getFileContents(sSwiftKeyFiles[2])
oLine_Count <<- append(oLine_Count, length(sFileText))
oWord_Count <<- append(oWord_Count, sum(sapply(gregexpr("\\S+", sFileText), length)))
sNewsSample <- sample(sFileText, ceiling(oLine_Count[2] * nSampleSize))
saveRDS(sNewsSample, "./data/news.sample.RDS")
system.time({
    oNewsCleaned <- getCleanText(sNewsSample, 1)
    saveRDS(oNewsCleaned, "./data/news.cleaned.RDS")
})

## Blogs sample
sFileText <- getFileContents(sSwiftKeyFiles[3])
oLine_Count <<- append(oLine_Count, length(sFileText))
oWord_Count <<- append(oWord_Count, sum(sapply(gregexpr("\\S+", sFileText), length)))
sBlogsSample <- sample(sFileText, ceiling(oLine_Count[3] * nSampleSize))
saveRDS(sBlogsSample, "./data/blogs.sample.RDS")
system.time({
    oBlogsCleaned <- getCleanText(sBlogsSample, 1)
    saveRDS(oBlogsCleaned, "./data/blogs.cleaned.RDS")
})



getCleanText0 <- function(sText){
    #Remove non-English characters
    sCorpusText <- iconv(sText, "latin1", "ASCII", sub="")
    sCorpusText <- iconv(sCorpusText, "UTF-8", "ASCII", sub="")

    #Remove URLs
    sCorpusText <- gsub("http[[:alnum:]]*", "", sCorpusText)

    #Remove hashtags
    sCorpusText <- gsub("#\\S+", "", sCorpusText)

    #Remove twitter handles
    sCorpusText <- gsub("@\\S+", "", sCorpusText)

    #Remove words with less than 3 characters
    #sCorpusText <- gsub("\\b\\w{1,2}\\b", "", sCorpusText)

    #Remove words enclosed between (), [], and {}
    sCorpusText <- gsub("\\s*\\([^\\)]+\\)", "", sCorpusText)
    sCorpusText <- gsub("\\s*\\[[^\\)]+\\]", "", sCorpusText)
    sCorpusText <- gsub("\\s*\\{[^\\)]+\\}", "", sCorpusText)

    #Remove numbers
    sCorpusText <- gsub('[0-9]+', '', sCorpusText)

    #Remove punctuation
    sCorpusText <- gsub('[[:punct:]]', '', sCorpusText)


    #oCorpus <- Corpus(VectorSource(list(sCorpusText)))
    #rm(sCorpusText)
    
    #Remove numbers
    #oCorpus <- tm_map(oCorpus, removeNumbers)
    
    #Remove punctuation
    #oCorpus <- tm_map(oCorpus, removePunctuation)
    
    #Replace contractions with long form
    #oCorpus <- tm_map(oCorpus, content_transformer(replace_contraction))
    sCorpusText <- replace_contraction(sCorpusText)
    
    #Replace abbreviations with long form
    #oCorpus <- tm_map(oCorpus, content_transformer(replace_abbreviation))
    sCorpusText <- replace_abbreviation(sCorpusText)

    #Convert to lowercase
    #oCorpus <- tm_map(oCorpus, content_transformer(tolower))
    #Convert to lower case
    sCorpusText <- tolower(sCorpusText)
        
    #Remove swear words
    #oCorpus <- removeBadWords(oCorpus)
    sBadWords <- tolower(stripWhitespace(readLines("./data/SwearWords.txt")))
    sCorpusText <- removeWords(sCorpusText, sBadWords)

    #Remove whitespaces
    #oCorpus <- tm_map(oCorpus, stripWhitespace)
    sCorpusText <- gsub('\\s+', ' ', sCorpusText)
    sCorpusText <- trimws(sCorpusText, which = "both")
    
    #return(oCorpus)
    return(sCorpusText)
}



#predictNext("The guy in front of me just bought a pound of bacon, a bouquet, and a case of ")
#predictNext("You're the reason why I smile everyday. Can you follow me please? It would mean the ")
#predictNext("Hey sunshine, can you follow me and make me the ")
#predictNext("Very early observations on the Bills game: Offense still struggling but the ")
#predictNext("Go on a romantic date at the ")
#predictNext("Well I'm pretty sure my granny has some old bagpipes in her garage I'll dust them off and be on my ")
#predictNext("Ohhhhh #PointBreak is on tomorrow. Love that lm and haven't seen it in quite some ")
#predictNext("After the ice bucket challenge Louis will push his long wet hair out of his eyes with his little ")
#predictNext("Be grateful for the good times and keep the faith during the ")
#predictNext("If this isn't the cutest thing you've ever seen, then you must be ")

#predictNext("When you breathe, I want to be the air for you. I'll be there for you, I'd live and I'd ")
#predictNext("Guy at my table's wife got up to go to the bathroom and I asked about dessert and he started telling me about his ")
#predictNext("I'd give anything to see arctic monkeys this ")
#predictNext("Talking to your mom has the same effect as a hug and helps reduce your ")
#predictNext("When you were in Holland you were like 1 inch away from me but you hadn't time to take a ")
#predictNext("I'd just like all of these questions answered, a presentation of evidence, and a jury to settle the ")
#predictNext("I can't deal with unsymetrical things. I can't even hold an uneven number of bags of groceries in each ")
#predictNext("Every inch of you is perfect from the bottom to the ")
#predictNext("I’m thankful my childhood was filled with imagination and bruises from playing ")
#predictNext("I like how the same people are in almost all of Adam Sandler's ")


predictNext <- function(sText){
    #sText <- "and a case of "
    iMaxMatches <- 10
    oMatch <- data.frame(matrix(nrow = 0, ncol = 2))
    colnames(oMatch) <- c("Term", "Freq")

    iLength <- nchar(sText)
    cLast <- substr(sText, iLength, iLength)

    sLine <- removeWords(sText, oBadWords)
    oLine <- getCleanText(sLine, 0, 0)
    sLine <- oLine$content
    
    oLine <- strsplit(sLine, " ")
    iWords <- length(oLine[[1]])

    #Fivegram match
    if (iWords > 4){
        if (cLast == " "){
            #sMatch <- paste(oLine[[1]][iWords - 3], oLine[[1]][iWords - 2], oLine[[1]][iWords - 1], oLine[[1]][iWords], "", sep = " ")
            sMatch <- getLastNWords(oLine, 3)
        } else {
            #sMatch <- paste(oLine[[1]][iWords - 4], oLine[[1]][iWords - 3], oLine[[1]][iWords - 2], oLine[[1]][iWords - 1], oLine[[1]][iWords], sep = " ")
            sMatch <- getLastNWords(oLine, 4)
        }
        
        oMatch <- oG5[startsWith(oG5$Term, sMatch), ]
        print(sMatch)
    }

    #Quadrigram match
    if ((iWords > 3) && (length(oMatch$Term) < iMaxMatches)){
        if (cLast == " "){
            sMatch <- paste(oLine[[1]][iWords - 2], oLine[[1]][iWords - 1], oLine[[1]][iWords], "", sep = " ")
        } else {
            sMatch <- paste(oLine[[1]][iWords - 3], oLine[[1]][iWords - 2], oLine[[1]][iWords - 1], oLine[[1]][iWords], sep = " ")
        }
        
        oTemp <- oG4[startsWith(oG4$Term, sMatch), ]
        oMatch <- rbind(oMatch, oTemp)
    }
    
    #Trigram match
    if ((iWords > 2) && (length(oMatch$Term) < iMaxMatches)){
        if (cLast == " "){
            sMatch <- paste(oLine[[1]][iWords - 1], oLine[[1]][iWords], "", sep = " ")
        } else {
            sMatch <- paste(oLine[[1]][iWords - 2], oLine[[1]][iWords - 1], oLine[[1]][iWords], sep = " ")
        }

        oTemp <- oG3[startsWith(oG3$Term, sMatch), ]
        oMatch <- rbind(oMatch, oTemp)
    }

    #Bigram match
    if ((iWords > 1) && (length(oMatch$Term) < iMaxMatches)){
        if (cLast == " "){
            sMatch <- paste(oLine[[1]][iWords], "", sep = " ")
        } else {
            sMatch <- paste(oLine[[1]][iWords - 1], oLine[[1]][iWords], sep = " ")
        }
        
        oTemp <- oG2[startsWith(oG2$Term, sMatch), ]
        oMatch <- rbind(oMatch, oTemp)
    }

    #Bigram/Unigram match
    if ((iWords > 0) && (length(oMatch$Term) < iMaxMatches)){
        if (cLast == " "){
            sMatch <- paste(oLine[[1]][iWords], "", sep = " ")
            oTemp <- oG2[startsWith(oG2$Term, sMatch), ]
        } else {
            sMatch <- oLine[[1]][iWords]
            oTemp <- oG1[startsWith(oG1$Term, sMatch), ]
        }
        
        oMatch <- rbind(oMatch, oTemp)
    }
    oMatch <- unique(oMatch)

    #Top unigrams
    if (length(oMatch$Term) < iMaxMatches){
        oMatch <- rbind(oMatch, oG1[1:iMaxMatches, ])
    }

    oMatch <- oMatch[1:iMaxMatches, ]
    return(oMatch)
}



#Fivegram match
iMinWords <- 4
if (iWords > iMinWords){
    if (cLast == " "){
        sMatch <- getLastNWords(sLine, (iMinWords - 1))
    } else {
        sMatch <- getLastNWords(sLine, iMinWords)
    }
    
    oMatch <- oG5[startsWith(oG5$Term, sMatch), ]
}

#Quadrigram match
iMinWords <- 3
if ((iWords > iMinWords) && (length(oMatch$Term) < iMaxMatches)){
    if (cLast == " "){
        sMatch <- getLastNWords(sLine, (iMinWords - 1))
    } else {
        sMatch <- getLastNWords(sLine, iMinWords)
    }
    
    oTemp <- oG4[startsWith(oG4$Term, sMatch), ]
    oMatch <- rbind(oMatch, oTemp)
}

#Trigram match
iMinWords <- 2
if ((iWords > iMinWords) && (length(oMatch$Term) < iMaxMatches)){
    if (cLast == " "){
        sMatch <- getLastNWords(sLine, (iMinWords - 1))
    } else {
        sMatch <- getLastNWords(sLine, iMinWords)
    }
    
    oTemp <- oG3[startsWith(oG3$Term, sMatch), ]
    oMatch <- rbind(oMatch, oTemp)
}

#Bigram match
iMinWords <- 1
if ((iWords > iMinWords) && (length(oMatch$Term) < iMaxMatches)){
    if (cLast == " "){
        sMatch <- getLastNWords(sLine, (iMinWords - 1))
    } else {
        sMatch <- getLastNWords(sLine, iMinWords)
    }
    
    oTemp <- oG2[startsWith(oG2$Term, sMatch), ]
    oMatch <- rbind(oMatch, oTemp)
}

#Bigram/Unigram match
iMinWords <- 0
if ((iWords > iMinWords) && (length(oMatch$Term) < iMaxMatches)){
    if (cLast == " "){
        sMatch <- paste(getLastNWords(sLine, iMinWords), "", sep = " ")
        oTemp <- oGrams[2][startsWith(oG2$Term, sMatch), ]
    } else {
        sMatch <- getLastNWords(sLine, iMinWords)
        oTemp <- oGrams[1][startsWith(oG1$Term, sMatch), ]
    }
    
    oMatch <- rbind(oMatch, oTemp)
}
oMatch <- unique(oMatch)
