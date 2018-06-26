## Declarations
#setwd("/mnt/hgfs/Z/Data Science/Coursera/JHU/10. Data Science Capstone/Capstone")
setwd("Z:/F/Data Science/Coursera/JHU/10. Data Science Capstone/Capstone")
sGramRDS <- c("./data/unigram.RDS", "./data/bigram.RDS", "./data/trigram.RDS", "./data/quadrigram.RDS", "./data/fivegram.RDS")
sBadWordsTXT <- "./input/badwords.txt"

library(qdap)
library(tm)
library(data.table)
source("./R/Clean.R")

oBadWords <- tolower(stripWhitespace(readLines(sBadWordsTXT)))
oG1 <- readRDS(sGramRDS[1])
oG2 <- readRDS(sGramRDS[2])
oG3 <- readRDS(sGramRDS[3])
oG4 <- readRDS(sGramRDS[4])
oG5 <- readRDS(sGramRDS[5])
oGrams <- list(oG1, oG2, oG3, oG4, oG5)
remove(oG1, oG2, oG3, oG4, oG5)

getLastNWords <- function(oLine, nWords){
    sRet <- NULL
    iWords <- length(oLine[[1]])

    for (i in (nWords:1)){
        sRet <- paste(sRet, oLine[[1]][iWords - (i - 1)], sep = " ")
    }

    return(trimws(sRet))
}

predictNext <- function(sText){
    #sText <- "Our first African American president Barack "
    iMaxMatches <- 10
    oMatch <- data.frame(matrix(nrow = 0, ncol = 3))
    colNames <- c("Term", "Freq", "Prob")
    colnames(oMatch) <- colNames

    iLength <- nchar(sText)
    cLast <- substr(sText, iLength, iLength)

    sLine <- removeWords(sText, oBadWords)
    oLine <- getCleanText(sLine, 0, 0)
    sLine <- oLine$content

    oLine <- strsplit(sLine, " ")
    iWords <- length(oLine[[1]])
    oMatch <- NULL
    oPred <- NULL

    if (cLast == " "){
        iWords <- iWords + 1
    }

    #Fivegram to bigram match
    for (iMinWords in (4:1)){
        if (iWords > iMinWords){
            sMatch <- getLastNWords(oLine, iMinWords)
            if (cLast == " "){
                sMatch <- paste(sMatch, cLast, sep = "")
            }

            oG <- oGrams[(iMinWords + 1)][[1]]
            oTemp <- oG[startsWith(oG$Term, sMatch), ]
            if (length(oTemp$Term) > 0){
                oTemp <- cbind(oTemp, c(0))
                colnames(oTemp) <- colNames
                oTemp$Prob <- round(((oTemp$Freq * 100) / (sum(oTemp$Freq))), digits = 2)
                oMatch <- rbind(oMatch, oTemp)
            }
        }
    }

    #Top unigrams
    if (length(oMatch$Term) < iMaxMatches){
        oTemp <- oGrams[1][[1]]
        oTemp <- cbind(oTemp, c(0))
        colnames(oTemp) <- colNames
        oTemp$Prob <- round(((oTemp$Freq * 100) / (sum(oTemp$Freq))), digits = 2)
        oMatch <- rbind(oMatch, oTemp)
    }

    oMatch <- oMatch[order(oMatch$Prob, decreasing = TRUE), ]
    oMatch <- oMatch[1:iMaxMatches, ]

    for (i in (1:length(oMatch$Term))){
        oTemp <- strsplit(oMatch[[1]][i], " ")
        oPred[i] <- oTemp[[1]][length(oTemp[[1]])]
    }
    oMatch <- cbind(oMatch, oPred)
    colnames(oMatch) <- c("Term", "Freq", "Prob", "Pred")
    
    return(unique(oMatch$Pred))
}

#Test cases
predictNext("United States of ")
predictNext("Our first African American president Barack ")
predictNext("I'm too tired to watch a movie now. I might fall ")
predictNext("When you were in Holland you were like 1 inch away from me but you hadn't time to take a ")
predictNext("Who else is attending Washington real estate summit ")
predictNext("Ohhhhh #PointBreak is on tomorrow. Love that lm and haven't seen it in quite some ")
predictNext("Employees will begin to pay more for their health insurance when ")
predictNext("The court noted that we do not need to start over from ")
predictNext("Well I'm pretty sure my granny has some old bagpipes in her garage I'll dust them off and be on my ")
predictNext("ND winter is too harsh during ")
predictNext("Nobody carries cash anymore, so limiting sales to those who have cash may eat away at your ")
predictNext("Every inch of you is perfect from the bottom to the ")
predictNext("You're the reason why I smile everyday. Can you follow me please? It would mean the ")
