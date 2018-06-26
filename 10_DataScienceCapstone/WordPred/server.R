library(shiny)
library(tm)
library(qdap)
library(data.table)

sGramRDS <- c("./data/unigram.RDS", "./data/bigram.RDS", "./data/trigram.RDS", "./data/quadrigram.RDS", "./data/fivegram.RDS")
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


shinyServer(function(input, output, session) {
    observe({
        sInput <- reactive({input$txtInput})
        predictions <- predictNext(sInput())

        output$placeHolder1 <- renderUI({
            actionButton("btn1", label = predictions[1], style = "width:125px; height:35px")
        })

        output$placeHolder2 <- renderUI({
            actionButton("btn2", label = predictions[2], style = "width:125px; height:35px")
        })

        output$placeHolder3 <- renderUI({
            actionButton("btn3", label = predictions[3], style = "width:125px; height:35px")
        })
    })

})
