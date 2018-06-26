## Peer-graded Assignment: Getting and Cleaning Data Course Project

# Start - My working folder setup. You may not need this.
#sWD <- "Z:/F/Coursera Data Science/RStudioWork/C03/W4"
#setwd(sWD)
# End - My working folder setup. You may not need this.


# Project folder
sProjectFolder <- "Project"

# Project folder validation
if (!dir.exists(sProjectFolder))
{
    dir.create(sProjectFolder)
}
setwd(sProjectFolder)


# URL and filename variables
sURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
sFileName <- "Dataset.zip"

# Download, if not exists
if(!file.exists(sFileName))
{
    download.file(sURL, sFileName, mode = "wb")
}

# Check for unzipped files and delete them
sUnzipFolder <- "UCI HAR Dataset"
if (!dir.exists(sUnzipFolder))
{
    # Create directory
    dir.create(sUnzipFolder)

    # Unzip file
    unzip(sFileName, files = NULL, exdir = ".")
}


# 1. Merge the training and the test sets to create one data set
    sDataFolder <- paste("./", sUnzipFolder, "/", sep = "")
    
    # a) Read training files
    x_train <- read.table(paste(sDataFolder, "train/X_train.txt", sep=""))
    y_train <- read.table(paste(sDataFolder, "train/y_train.txt", sep=""))
    subject_train <- read.table(paste(sDataFolder, "train/subject_train.txt", sep=""))
    
    # b) Read test files
    x_test <- read.table(paste(sDataFolder, "test/X_test.txt", sep=""))
    y_test <- read.table(paste(sDataFolder, "test/y_test.txt", sep=""))
    subject_test <- read.table(paste(sDataFolder, "test/subject_test.txt", sep=""))
    
    # c) Read features file
    features <- read.table(paste(sDataFolder, "features.txt", sep=""))
    
    # d) Reading activity labels:
    activity_labels = read.table(paste(sDataFolder, "activity_labels.txt", sep=""))

    # e) Assign column names
    colnames(x_train) <- features[, 2] 
    colnames(y_train) <- "activity_id"
    colnames(subject_train) <- "subject_id"
    
    colnames(x_test) <- features[, 2] 
    colnames(y_test) <- "activity_id"
    colnames(subject_test) <- "subject_id"
    
    colnames(activity_labels) <- c("activity_id", "activity_type")
    
    # f) Merge data
    merged_train <- cbind(y_train, subject_train, x_train)
    merged_test <- cbind(y_test, subject_test, x_test)
    merged_data <- rbind(merged_train, merged_test)
    
    
# 2. Extract only the measurements on the mean and standard deviation for each measurement
    # a) Get column names of merged dataset
    column_names <- colnames(merged_data)

    # b) Filter columns containing mean and standard deviation data
    ## mean_sd_cols <- (grepl("activity_id" , column_names) | grepl("subject_id" , column_names) | grepl("mean.." , column_names) | grepl("std.." , column_names))
    mean_sd_cols <- grepl("activity_id|subject_id|mean\\(\\)|std\\(\\)", column_names)

    # c) Extract columns identified above
    mean_sd_data <- merged_data[ , mean_sd_cols == TRUE]
    

# 3. Uses descriptive activity names to name the activities in the data set
    mean_sd_data <- merge(mean_sd_data, activity_labels, by='activity_id', all.x = TRUE)
    

# 4. Appropriately label the data set with descriptive variable names
    # Please see #1(e) above. I did it for ease of bedugging
    

# 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject
    # Re-arrange columns to remove activity id and get activity type to column 1 and keep the rest of the columns as such
    mean_sd_data <- mean_sd_data[, c(2, ncol(mean_sd_data), 4:ncol(mean_sd_data)-1)]
    
    # Create tidy data set
    tidy_data_set <- aggregate(. ~ subject_id + activity_type, data=mean_sd_data, FUN=mean)
    tidy_data_set <- tidy_data_set[order(tidy_data_set$subject_id, tidy_data_set$activity_type), ]
    
    
# Write tidy data set to a file
    sFileName = "tidy_data_set.txt"
    write.table(tidy_data_set, sFileName, row.name=FALSE)
    
