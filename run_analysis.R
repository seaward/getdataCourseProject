### Get tidy data of all sd and mean variables of accelerometer dataset,
### also generate a dataset of mean of each variable by each subject and each activity.
### Download accelerometer dataset zip file, unzip to
### current directory, then run this script to generate
### tidy data.
run_analysis <- function() {
  
  library(dplyr)
  
  actLabels = read.table("UCI HAR Dataset/activity_labels.txt", sep = " ")

  features = read.table("UCI HAR Dataset/features.txt", sep = " ")
  ## features with "mean() / std()", read data; other columns are skipped.
  cols = grep("-(mean)|(std)\\(\\)", features$V2)
  f = rep("X16", length(features[[1]]))
  f[cols] = "F16"

  ## Update features into accessible strings
  actNames = features[cols, 2]
  actNames = gsub("-", ".", actNames)
  actNames = sub("\\(\\)", "", actNames)
  
  type = "train"
  activity = actLabeledDataset(actLabels, type)
  subject = read.table(sprintf("UCI HAR Dataset/%s/subject_%s.txt", type, type))
  names(subject) = "subject"
  dsTrain = featuredDataset(actNames, f, type)
  dsTrain = cbind(subject, activity, dsTrain)
  
  type = "test"
  activity = actLabeledDataset(actLabels, type)
  subject = read.table(sprintf("UCI HAR Dataset/%s/subject_%s.txt", type, type))
  names(subject) = "subject"
  dsTest = featuredDataset(actNames, f, type)
  dsTest = cbind(subject, activity, dsTest)
  
  ds = rbind(dsTrain, dsTest)
  dsLen = length(ds)
  
  ds = group_by(ds, subject, activity)
  ## below function calling is awkard :(
  dsMean = mutate(ds, mean(tBodyAcc.mean.X)
                  ,mean(tBodyAcc.mean.Y)
                  ,mean(tBodyAcc.mean.Z)
                  ,mean(tBodyAcc.std.X)
                  ,mean(tBodyAcc.std.Y)
                  ,mean(tBodyAcc.std.Z)
                  ,mean(tGravityAcc.mean.X)
                  ,mean(tGravityAcc.mean.Y)
                  ,mean(tGravityAcc.mean.Z)
                  ,mean(tGravityAcc.std.X)
                  ,mean(tGravityAcc.std.Y)
                  ,mean(tGravityAcc.std.Z)
                  ,mean(tBodyAccJerk.mean.X)
                  ,mean(tBodyAccJerk.mean.Y)
                  ,mean(tBodyAccJerk.mean.Z)
                  ,mean(tBodyAccJerk.std.X)
                  ,mean(tBodyAccJerk.std.Y)
                  ,mean(tBodyAccJerk.std.Z)
                  ,mean(tBodyGyro.mean.X)
                  ,mean(tBodyGyro.mean.Y)
                  ,mean(tBodyGyro.mean.Z)
                  ,mean(tBodyGyro.std.X)
                  ,mean(tBodyGyro.std.Y)
                  ,mean(tBodyGyro.std.Z)
                  ,mean(tBodyGyroJerk.mean.X)
                  ,mean(tBodyGyroJerk.mean.Y)
                  ,mean(tBodyGyroJerk.mean.Z)
                  ,mean(tBodyGyroJerk.std.X)
                  ,mean(tBodyGyroJerk.std.Y)
                  ,mean(tBodyGyroJerk.std.Z)
                  ,mean(tBodyAccMag.mean)
                  ,mean(tBodyAccMag.std)
                  ,mean(tGravityAccMag.mean)
                  ,mean(tGravityAccMag.std)
                  ,mean(tBodyAccJerkMag.mean)
                  ,mean(tBodyAccJerkMag.std)
                  ,mean(tBodyGyroMag.mean)
                  ,mean(tBodyGyroMag.std)
                  ,mean(tBodyGyroJerkMag.mean)
                  ,mean(tBodyGyroJerkMag.std)
                  ,mean(fBodyAcc.mean.X)
                  ,mean(fBodyAcc.mean.Y)
                  ,mean(fBodyAcc.mean.Z)
                  ,mean(fBodyAcc.std.X)
                  ,mean(fBodyAcc.std.Y)
                  ,mean(fBodyAcc.std.Z)
                  ,mean(fBodyAcc.meanFreq.X)
                  ,mean(fBodyAcc.meanFreq.Y)
                  ,mean(fBodyAcc.meanFreq.Z)
                  ,mean(fBodyAccJerk.mean.X)
                  ,mean(fBodyAccJerk.mean.Y)
                  ,mean(fBodyAccJerk.mean.Z)
                  ,mean(fBodyAccJerk.std.X)
                  ,mean(fBodyAccJerk.std.Y)
                  ,mean(fBodyAccJerk.std.Z)
                  ,mean(fBodyAccJerk.meanFreq.X)
                  ,mean(fBodyAccJerk.meanFreq.Y)
                  ,mean(fBodyAccJerk.meanFreq.Z)
                  ,mean(fBodyGyro.mean.X)
                  ,mean(fBodyGyro.mean.Y)
                  ,mean(fBodyGyro.mean.Z)
                  ,mean(fBodyGyro.std.X)
                  ,mean(fBodyGyro.std.Y)
                  ,mean(fBodyGyro.std.Z)
                  ,mean(fBodyGyro.meanFreq.X)
                  ,mean(fBodyGyro.meanFreq.Y)
                  ,mean(fBodyGyro.meanFreq.Z)
                  ,mean(fBodyAccMag.mean)
                  ,mean(fBodyAccMag.std)
                  ,mean(fBodyAccMag.meanFreq)
                  ,mean(fBodyBodyAccJerkMag.mean)
                  ,mean(fBodyBodyAccJerkMag.std)
                  ,mean(fBodyBodyAccJerkMag.meanFreq)
                  ,mean(fBodyBodyGyroMag.mean)
                  ,mean(fBodyBodyGyroMag.std)
                  ,mean(fBodyBodyGyroMag.meanFreq)
                  ,mean(fBodyBodyGyroJerkMag.mean)
                  ,mean(fBodyBodyGyroJerkMag.std)
                  ,mean(fBodyBodyGyroJerkMag.meanFreq))
  dsMeanLen = length(dsMean)
  dsMean = dsMean[,c(1,2, (dsLen+1) : dsMeanLen)]
  
  unique(dsMean)
}

## Get list of activity names
## param actLabels - activity labels
## param type - train / test
actLabeledDataset <- function (actLabels, type = "train") {
  ## Activity column
  act = read.table(sprintf("UCI HAR Dataset/%s/y_%s.txt", type, type))
  rows <- length(act[[1]])
  actStr  = rep("", rows)
  for(i in 1:rows) {
    actStr[i] = as.character(actLabels[act[[1]][i],2])
  }
  
  actStr
}

## The activities dataset with column names
## param features - feature names
## param cols - the selected columns number
## param f - Format list for reading from fixed-format data file
## param type - train / test data type.
featuredDataset <- function (actNames, f, type = "train") {
  ds = read.fortran(sprintf("UCI HAR Dataset/%s/X_%s.txt", type, type), f)
  ## Set column names on dataset
  names(ds) = actNames
  
  ds
}
