# For my local machine only. Set working folder
# setwd("Z:/F/Coursera Data Science/RStudioWork/C04/W1/Course Project 1/ExData_Plotting1")

# Download zip file
sURL = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
sZipfile = "exdata_data_household_power_consumption.zip"
if (!file.exists(sZipfile))
{
    # Download zip file
    download.file(sURL,sZipfile,mode = "wb")
}

# Unzip file
sDatafile = "household_power_consumption.txt"
if (!file.exists(sDatafile))
{
    unzip(sZipfile, exdir = ".")
}


# Read file
df <- read.table(sDatafile, header = TRUE, sep = ";", na.strings = "?")

# Filter data by date
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")
df <- df[df$Date >= as.Date("2007-02-01") & df$Date <= as.Date("2007-02-02"),]

# Convert data type
df$Global_active_power <- as.numeric(df$Global_active_power)

# Generate date & time
df$DateTime <- as.POSIXct(strptime(paste(df$Date, df$Time, sep = " "), format = "%Y-%m-%d %H:%M:%S"))

# Plot 2
with(df, plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

# Write to png
dev.copy(png, file="plot2.png", width=480, height=480, units="px")

# Close the device
dev.off()
