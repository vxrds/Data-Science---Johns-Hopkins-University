## set working folder
#setwd("Z:\\Z\\Coursera Data Science\\RStudioWork\\C05\\W2")

## 1. Code for reading in the dataset and/or processing the data
data <- read.csv("./activity.csv")
data1 <- data[!is.na(data$steps), c("steps","date")]

## 2. Histogram of the total number of steps taken each day
data2 <- aggregate(steps~date, data=data1, FUN = sum)
hist(data2$steps, 20, main = "Total number of steps taken each day", xlab="Steps", ylab="", col="blue")

## 3. Mean and median number of steps taken each day
mean3 <- mean(data2$steps)
median3 <- median(data2$steps)
mean3
median3

## 4. Time series plot of the average number of steps taken
data4 <- aggregate(steps ~ interval, data, mean, rm.na = TRUE)
plot(data4$interval, data4$steps, type = "l", axes=F, xlab = "Time interval", ylab="Avg. Steps", main = "Average number of steps taken by 5-minute interval")
axis(1, labels = c('0:00', '5:00', '10:00', '15:00', '20:00', '23:55'), at = c(0, 500, 1000, 1500, 2000, 2355))
axis(2)

## 5. The 5-minute interval that, on average, contains the maximum number of steps
interval5 <- data4[which.max(data4$steps),"interval"]
interval5

## 6. Code to describe and show a strategy for imputing missing data
    # Missing values
    na6 <- sum(is.na(data$steps))
    na6

    # Fill the missing values with 5-minute interval mean
    data6 <- data
    for (i in 1:nrow(data6))
    {
        if (is.na(data6$steps[i]))
        {
            data6$steps[i] <- data4[(data4$interval==data6$interval[i]),2]
        }
    }
    
    # See the differences. Not much, except 3rd quartile
    summary(data)
    summary(data6)

## 7. Histogram of the total number of steps taken each day after missing values are imputed
data7 <- aggregate(steps~date, data=data6, FUN = sum)
hist(data7$steps, 20, main = "Total number of steps taken each day", xlab="Steps", ylab="", col="green")

## 8. Panel plot comparing the average number of steps taken per 5-minute interval across weekdays and weekends
data8 <- data6
# Get day names
data8$dayCategory <- weekdays(as.Date(data8$date))
# Identify weekdays/weekends
data8$dayCategory <- ifelse(data8$dayCategory %in% c("Saturday", "Sunday"), "Weekend", "Weekday")
# Calculate averages
data8 <- aggregate(steps ~ dayCategory + interval, data8, mean)
data8$dayCategory <- as.factor(data8$dayCategory)
# Plot the data
library(ggplot2)
plot <- ggplot(data8, aes(interval, steps, group = dayCategory))
plot + geom_line() + geom_line() + facet_grid(dayCategory ~ .) + 
    scale_x_discrete(limit = c(0, 500, 1000, 1500, 2000, 2355), labels = c('0:00', '5:00', '10:00', '15:00', '20:00', '23:55')) + 
    labs(x="Interval", y="Steps", title="Avg. steps taken per 5-minute interval across weekdays and weekends")
