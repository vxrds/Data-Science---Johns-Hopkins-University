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
    library(ggplot2)
    library(plyr)
    
    pData <- NEI[NEI$fips=="24510", c("Emissions", "type", "year")]
    pData$year <- as.character(pData$year)
    pData <- ddply(pData, .(type,year), summarise, Emissions = sum(Emissions))

    ## Plot data
    options(warn=-1)
    g<-ggplot(
        pData
        , aes(
            x=factor(year)
            , y=Emissions
            , color=type
        )
    ) + geom_point() + geom_smooth(aes(group=type), method="loess", se=FALSE)

    g <- g + ggtitle("Total PM2.5 emissions from 1999-2008 for Baltimore City")
    g <- g + xlab("Year") + ylab("PM2.5 Emission (in tons)") + labs(color = "Type")

    print(g)

    # Write to png
    dev.copy(png, file="plot3.png", width=480, height=480, units="px")
    
    # Close the device
    dev.off()
}
