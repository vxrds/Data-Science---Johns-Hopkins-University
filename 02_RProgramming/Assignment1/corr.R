corr <- function(directory, threshold = 0) {
    df = complete(directory)
    ids = df[df["nobs"] > threshold, ]$id
    c1 = numeric()
    for (i in ids)
    {
        csvdata = read.csv(paste(directory, "/", formatC(i, width = 3, flag = "0"), ".csv", sep = ""))
        df2 = csvdata[complete.cases(csvdata), ]
        c1 = c(c1, cor(df2$sulfate, df2$nitrate))
    }
    return(c1)
}