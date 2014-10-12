---
title: "Analyzed accelerometer data from Samsung Galaxy S"
author: "Seaward Chen"
date: "Tuesday, September 16, 2014"
output: html_document
---

The original data was obtained as below:
>The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

>Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

>Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

>These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

In `run_analysis.R', first we get `data.frame` `ds`, is the data selected from accelerometer dataset, which include all sd and mean variables; distilled from `ds`, `dsMean` has the mean of all sd and mean variables by subject and activity.

mean(tBodyAcc-XYZ)
mean(tGravityAcc-XYZ)
mean(tBodyAccJerk-XYZ)
mean(tBodyGyro-XYZ)
mean(tBodyGyroJerk-XYZ)
mean(tBodyAccMag)
mean(tGravityAccMag)
mean(tBodyAccJerkMag)
mean(tBodyGyroMag)
mean(tBodyGyroJerkMag)
mean(fBodyAcc-XYZ)
mean(fBodyAccJerk-XYZ)
mean(fBodyGyro-XYZ)
mean(fBodyAccMag)
mean(fBodyAccJerkMag)
mean(fBodyGyroMag)
mean(fBodyGyroJerkMag)
