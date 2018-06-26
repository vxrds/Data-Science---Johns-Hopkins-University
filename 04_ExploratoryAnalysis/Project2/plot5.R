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
    ccSCC<-SCC[grep(("vehicle"), SCC$EI.Sector, ignore.case=TRUE),c(1,4)]
    pData <- NEI[NEI$SCC %in% ccSCC$SCC,]
    pData <- pData[pData$fips=="24510",]
    pData <- tapply(pData$Emissions, pData$year, FUN = sum)
    
    ## Plot data
    barplot(
        pData
        , col = "magenta"
        , main = "PM2.5 motor vehicle emissions in Baltimore City (1999-2008)"
        , xlab = "Year"
        , ylab = "PM2.5 Emission (in tons)"
        , ylim = c(0,350)
    )
    
    # Write to png
    dev.copy(png, file="plot5.png", width=480, height=480, units="px")
    
    # Close the device
    dev.off()
}