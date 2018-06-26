## My working folder. Your's might vary.
# setwd("Z:\\Z\\Coursera Data Science\\RStudioWork\\C04\\W4\\Course Project 2")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# head(NEI)
# head(SCC)

## Check for files
bFilesExists <- 1
if ((file.exists("summarySCC_PM25.rds") == FALSE) || (file.exists("Source_Classification_Code.rds") == FALSE))
{
    bFilesExists <- 0
    stop("Data file(s) missing.")
}

if (bFilesExists == 1)
{
    ## Filter data
    ccSCC<-SCC[grep(("comb"), SCC$EI.Sector, ignore.case=TRUE),c(1,4)]
    ccSCC<-ccSCC[grep(("coal"), ccSCC$EI.Sector, ignore.case=TRUE),]
    pData <- NEI[NEI$SCC %in% ccSCC$SCC,]
    pData <- tapply((pData$Emissions/1000), pData$year, FUN = sum)
    
    ## Plot data
    barplot(
        pData
        , col = "brown"
        , main = "PM2.5 coal combustion emissions in the US (1999-2008)"
        , xlab = "Year"
        , ylab = "PM2.5 Emission (in thousands of tons)"
    )
    
    # Write to png
    dev.copy(png, file="plot4.png", width=480, height=480, units="px")
    
    # Close the device
    dev.off()
}