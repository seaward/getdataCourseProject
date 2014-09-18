run_analysis <- function() {
  
  actLabels = read.table("UCI HAR Dataset/activity_labels.txt", sep = " ")

  features = read.table("UCI HAR Dataset/features.txt", sep = " ")
  ## features with "mean() / std()", read data; other columns are skipped.
  cols = grep("-(mean)|(std)\\(\\)", features$V2)
  f = rep("X16", length(features[[1]]))
  f[cols] = "F16"
  
  type = "train"
  activity = actLabeledDataset(actLabels, type)
  subject = read.table(sprintf("UCI HAR Dataset/%s/subject_%s.txt", type, type))
  names(subject) = "subject"
  dsTrain = featuredDataset(features, cols, f, type)
  dsTrain = cbind(subject, activity, dsTrain)
  
  type = "test"
  activity = actLabeledDataset(actLabels, type)
  subject = read.table(sprintf("UCI HAR Dataset/%s/subject_%s.txt", type, type))
  names(subject) = "subject"
  dsTest = featuredDataset(features, cols, f, type)
  dsTest = cbind(subject, activity, dsTest)
  
  ds = rbind(dsTrain, dsTest)
  
  ds
}

featuredDataset <- function (features, cols, f, type = "train") {
  ## Column names on dataset
  ds = read.fortran(sprintf("UCI HAR Dataset/%s/X_%s.txt", type, type), f)
  names(ds) = features[cols, 2]
  
  ds
}

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
