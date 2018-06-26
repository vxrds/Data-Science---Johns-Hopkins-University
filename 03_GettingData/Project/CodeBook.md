# Code Book

This code book summarizes all the variables (columns) in `tidy_data_set.txt`.
<br>
<br>

## Identifiers

    * subject_id - The ID of the test subject
    * activity_type - The type of activity performed by the subject for the corresponding measurements
<br>
<br>

## Measurements

	* tBodyAcc-mean()-X
	* tBodyAcc-mean()-Y
	* tBodyAcc-mean()-Z
	* tBodyAcc-std()-X
	* tBodyAcc-std()-Y
	* tBodyAcc-std()-Z
	* tGravityAcc-mean()-X
	* tGravityAcc-mean()-Y
	* tGravityAcc-mean()-Z
	* tGravityAcc-std()-X
	* tGravityAcc-std()-Y
	* tGravityAcc-std()-Z
	* tBodyAccJerk-mean()-X
	* tBodyAccJerk-mean()-Y
	* tBodyAccJerk-mean()-Z
	* tBodyAccJerk-std()-X
	* tBodyAccJerk-std()-Y
	* tBodyAccJerk-std()-Z
	* tBodyGyro-mean()-X
	* tBodyGyro-mean()-Y
	* tBodyGyro-mean()-Z
	* tBodyGyro-std()-X
	* tBodyGyro-std()-Y
	* tBodyGyro-std()-Z
	* tBodyGyroJerk-mean()-X
	* tBodyGyroJerk-mean()-Y
	* tBodyGyroJerk-mean()-Z
	* tBodyGyroJerk-std()-X
	* tBodyGyroJerk-std()-Y
	* tBodyGyroJerk-std()-Z
	* tBodyAccMag-mean()
	* tBodyAccMag-std()
	* tGravityAccMag-mean()
	* tGravityAccMag-std()
	* tBodyAccJerkMag-mean()
	* tBodyAccJerkMag-std()
	* tBodyGyroMag-mean()
	* tBodyGyroMag-std()
	* tBodyGyroJerkMag-mean()
	* tBodyGyroJerkMag-std()
	* fBodyAcc-mean()-X
	* fBodyAcc-mean()-Y
	* fBodyAcc-mean()-Z
	* fBodyAcc-std()-X
	* fBodyAcc-std()-Y
	* fBodyAcc-std()-Z
	* fBodyAccJerk-mean()-X
	* fBodyAccJerk-mean()-Y
	* fBodyAccJerk-mean()-Z
	* fBodyAccJerk-std()-X
	* fBodyAccJerk-std()-Y
	* fBodyAccJerk-std()-Z
	* fBodyGyro-mean()-X
	* fBodyGyro-mean()-Y
	* fBodyGyro-mean()-Z
	* fBodyGyro-std()-X
	* fBodyGyro-std()-Y
	* fBodyGyro-std()-Z
	* fBodyAccMag-mean()
	* fBodyAccMag-std()
	* fBodyBodyAccJerkMag-mean()
	* fBodyBodyAccJerkMag-std()
	* fBodyBodyGyroMag-mean()
	* fBodyBodyGyroMag-std()
	* fBodyBodyGyroJerkMag-mean()
	* fBodyBodyGyroJerkMag-std()
<br>

####     Prefix 't' denotes time domain signals
####     Prefix 'f' indicates frequency domain signals

####     Abbreviations 'Acc' and 'Gyro' represents 'accelerometer' and 'gyroscope'

####     Jerk - Jerk signals are the body linear acceleration and angular velocity  derived in time
####     Mag - Magnitude of 3-dimensional signals calculated using the Euclidean norm

####     X,Y,Z indicates 3-axial raw signals in the X, Y and Z directions

####     mean() - Mean values
####     std() -  Standard deviation
<br>
<br>

## Activity Labels

    * WALKING (value 1) - Volunteer was walking during the experiment
    * WALKING_UPSTAIRS (value 2) - Volunteer was walking up a staircase during the experiment
    * WALKING_DOWNSTAIRS (value 3) - Volunteer was walking down a staircase during the experiment
    * SITTING (value 4) - Volunteer was sitting during the experiment
    * STANDING (value 5) - Volunteer was standing during the experiment
    * LAYING (value 6) - Volunteer was laying down during the experiment

