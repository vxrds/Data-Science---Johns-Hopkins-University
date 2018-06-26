pollutantmean <- function(directory, pollutant, id = 1:332)
{
    names <- list.files(directory)[id]
    df <- data.frame()

    for (i in 1:length(names))
    {
        df <- rbind(df, read.csv(paste(directory, names[i], sep="/")))
    }

    nmean <- mean(df[, pollutant], na.rm = TRUE)
    nmean
}