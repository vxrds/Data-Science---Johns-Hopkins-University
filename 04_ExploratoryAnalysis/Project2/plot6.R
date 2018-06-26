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
    library(plyr)
    ccSCC<-SCC[grep(("mobile"), SCC$EI.Sector, ignore.case=TRUE),c(1,4)]

    #Baltimore
    pDataBaltimore <- NEI[NEI$SCC %in% ccSCC$SCC,]
    pDataBaltimore <- pDataBaltimore[pDataBaltimore$fips=="24510",c("Emissions","year")]
    pDataBaltimore$year <- as.character(pDataBaltimore$year)
    pDataBaltimore <- ddply(pDataBaltimore, .(year), summarise, Emissions = sum(Emissions))
    pDataBaltimore$City <- "Baltimore City"
    
    #LACounty
    pDataLACounty <- NEI[NEI$SCC %in% ccSCC$SCC,]
    pDataLACounty <- pDataLACounty[pDataLACounty$fips=="06037",c("Emissions","year")]
    pDataLACounty$year <- as.character(pDataLACounty$year)
    pDataLACounty <- ddply(pDataLACounty, .(year), summarise, Emissions = sum(Emissions))
    pDataLACounty$City <- "Los Angeles County"
    
    pData <- rbind(pDataBaltimore,pDataLACounty)
    
    ## Plot data
    options(warn=-1)
    g<-ggplot(
        pData
        , aes(
            x=factor(year)
            , y=Emissions
            , color=City
        )
    ) + geom_point() + geom_smooth(aes(group=City), method="loess", se=FALSE)
    
    g <- g + ggtitle("Total emissions from motor vehicles - Baltimore v Los Angeles (1999-2008)")
    g <- g + xlab("Year") + ylab("PM2.5 Emission (in tons)") + labs(color = "City")
    
    print(g)

    ## Write to png
    dev.copy(png, file="plot6.png", width=480, height=480, units="px")
    
    ## Close the device
    dev.off()
}