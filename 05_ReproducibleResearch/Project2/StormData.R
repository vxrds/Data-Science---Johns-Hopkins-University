## My working folder. Your's might vary.
setwd("Z:\\Z\\Coursera Data Science\\RStudioWork\\C05\\W4\\Course Project 2")

#Filenames
sURL <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
sZipFile <- "StormData.csv.bz2"
sCSVFile <- "StormData.csv"

# Download, if not exists
if(!file.exists(sZipFile))
{
    download.file(sURL, sZipFile, mode = "wb")
}

# Check for csv file
if (file.exists(sCSVFile) == FALSE)
{
    library(R.utils)
    bunzip2(sZipFile, sCSVFile)
}

#Read data
data <- read.csv(sCSVFile, header = TRUE)
tidy <- data[, c("EVTYPE","FATALITIES","INJURIES","PROPDMG","PROPDMGEXP","CROPDMG","CROPDMGEXP")]

#Units
K <- 10^3
M <- 10^6
B <- 10^9

#Caluclate property damages
tidy$PropertyDamages <- 0
tidy[tidy$PROPDMGEXP=="K",]$PropertyDamages = tidy[tidy$PROPDMGEXP=="K",]$PROPDMG * K
tidy[tidy$PROPDMGEXP=="M",]$PropertyDamages = tidy[tidy$PROPDMGEXP=="M",]$PROPDMG * M
tidy[tidy$PROPDMGEXP=="B",]$PropertyDamages = tidy[tidy$PROPDMGEXP=="B",]$PROPDMG * B

#Caluclate crop damages
tidy$CropDamages <- 0
tidy[tidy$CROPDMGEXP=="K",]$CropDamages = tidy[tidy$CROPDMGEXP=="K",]$CROPDMG * K
tidy[tidy$CROPDMGEXP=="M",]$CropDamages = tidy[tidy$CROPDMGEXP=="M",]$CROPDMG * M
tidy[tidy$CROPDMGEXP=="B",]$CropDamages = tidy[tidy$CROPDMGEXP=="B",]$CROPDMG * B

#Cleaned-up data
tidy<-tidy[tidy$FATALITIES+tidy$INJURIES+tidy$PropertyDamages+tidy$CropDamages>0,c("EVTYPE","FATALITIES","INJURIES","PropertyDamages","CropDamages")]
tidy$EVTYPE <- toupper(tidy$EVTYPE)


#Convert property damages to billions
tidy$PropertyDamages <- tidy$PropertyDamages/B

#Convert crop damages to billions
tidy$CropDamages <- tidy$CropDamages/B

#Final set for plotting
plotdata <- aggregate(cbind(FATALITIES, INJURIES, PropertyDamages, CropDamages)~EVTYPE, data=tidy, sum)


#Plotting - import ggplot2 library
library(ggplot2)

# plot fatalities by top 10 event types
fatalities <- aggregate(FATALITIES ~ EVTYPE, data=plotdata, sum)
fatalities <- fatalities[order(-fatalities$FATALITIES), ][1:10, ]
fatalities$EVTYPE <- factor(fatalities$EVTYPE, levels = fatalities$EVTYPE)

ggplot(fatalities, aes(x = EVTYPE, y = FATALITIES)) + 
    geom_bar(stat = "identity", fill = "red") + 
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
    ggtitle("Fatalities by top 10 Weather Events") + 
    xlab("Event") + ylab("Fatalities")


# plot injuries by top 10 event types
injuries <- aggregate(INJURIES ~ EVTYPE, data=plotdata, sum)
injuries <- injuries[order(-injuries$INJURIES), ][1:10, ]
injuries$EVTYPE <- factor(injuries$EVTYPE, levels = injuries$EVTYPE)

ggplot(injuries, aes(x = EVTYPE, y = INJURIES)) + 
    geom_bar(stat = "identity", fill = "red") + 
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
    ggtitle("Injuries by top 10 Weather Events") + 
    xlab("Event") + ylab("Injuries")


# plot top 10 greatest economic consequences by event types
damages <- aggregate(PropertyDamages+CropDamages ~ EVTYPE, data=plotdata, sum)
names(damages) <- c("EVTYPE","TotalDamages")
damages <- damages[order(-damages$TotalDamages), ][1:10, ]
damages$EVTYPE <- factor(damages$EVTYPE, levels = damages$EVTYPE)

ggplot(damages, aes(x = EVTYPE, y = TotalDamages)) + 
    geom_bar(stat = "identity", fill = "red") + 
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
    ggtitle("Total Damages by top 10 Weather Events") + 
    xlab("Event") + ylab("Damages (billions of $)")
