rankhospital <- function(state, outcome, num = "best")
{
    ## Set wroking directory
    setwd("Z:\\F\\Coursera Data Science\\RStudioWork\\C02\\W4")
    
    ## Read outcome data
    outcomedata <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Check that state and outcome are valid
    if (!state %in% outcomedata$State)
    {
        stop("invalid state")
    }    
    
    if (outcome == "heart attack")
    {
        outcol = 11
    }
    else if (outcome == "heart failure")
    {
        outcol = 17  
    }
    else if (outcome == "pneumonia")
    {
        outcol = 23
    }
    else
    {
        stop ("invalid outcome")
    }
    
    ## Filter by state
    outcomedata <- na.omit(outcomedata[outcomedata$State == state,][c(2,outcol)])
    outcomedata <- outcomedata[outcomedata[2]!="Not Available",]
    
    ## Return hospital name in that state with lowest 30-day death ## rate
    outcomedata[,2] <- as.numeric(outcomedata[,2])
    outcomedata <- outcomedata[order(outcomedata[,2], outcomedata[,1]),]

    if (num == "best")
    {
        rownum <- 1
    }
    else if (num == "worst")
    {
        rownum <- length(outcomedata[,1])
    }
    else if (as.integer(num))
    {
        rownum <- as.integer(num)
    }
    else
    {
        rownum <- NA
    }
    
    outcomedata[rownum,1]
}