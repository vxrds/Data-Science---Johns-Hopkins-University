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
    ## Plot data
    NEI <- NEI[NEI$fips=="24510",]
    pData <- tapply((NEI$Emissions/1000), NEI$year, FUN = sum)

    barplot(
        pData
        , col = "red"
        , main = "Total PM2.5 emission in Baltimore City, Maryland"
        , xlab = "Year"
        , ylab = "PM2.5 Emission (in thousands of tons)"
    )

    # Write to png
    dev.copy(png, file="plot2.png", width=480, height=480, units="px")
    
    # Close the device
    dev.off()
}
