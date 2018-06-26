complete <- function(directory, id = 1:332) {
    names <- list.files(directory)[id]
    nobsdata <- numeric()
    
    for (i in 1:length(names))
    {
        csvdata <- read.csv(paste(directory, names[i], sep="/"))
        nobsdata[i] <- nrow(na.omit(csvdata))
    }

    df <- data.frame(id=c(id), nobs=nobsdata)    
    df
}