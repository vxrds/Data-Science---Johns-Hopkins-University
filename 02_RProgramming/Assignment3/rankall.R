rankall <- function(outcome, num = "best")
{
    ## Set wroking directory
    setwd("Z:\\F\\Coursera Data Science\\RStudioWork\\C02\\W4")
    
    ## Read outcome data
    outcomedata <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    ## Check that outcome is valid
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

    ##Filter by outcome
    states <- sort(unique(outcomedata[,7]))
    outcomedata <- na.omit(outcomedata[,c(2,7,outcol)])
    outcomedata <- outcomedata[outcomedata[3]!="Not Available",]
    outcomedata[,3] <- as.numeric(outcomedata[,3])

    ##Collect state abbreviations and loop through
    hnames <- c()
    for (state in states)
    {
        state <- as.character(state)
        statedata <- outcomedata[outcomedata[2] == state,]
        statedata <- statedata[order(statedata[,3], statedata[,1]),]

        if (num == "best")
        {
            rownum <- 1
        }
        else if (num == "worst")
        {
            rownum <- length(statedata[,1])
        }
        else if (as.integer(num))
        {
            if (as.integer(num) <= length(statedata[,1]))
            {
                rownum <- as.integer(num)
            }
            else
            {
                rownum <- NA
            }
        }
        else
        {
            rownum <- NA
        }

        if (!is.na(rownum))
        {
            hnames <- c(hnames, statedata[rownum, 1])
        }
        else
        {
            hnames <- c(hnames, "<NA>")
        }
    }

    outdata <- data.frame(states, hnames, states)
    colnames(outdata) <- c("", "hospital", "state")
    outdata
}