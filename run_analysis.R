## run_analysis.R 
## The goal is to fetch data and process it to prepare tidy data that can be used for later analysis

## Data https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Merges the training and the test sets to create one data set.
testSet <- read.table("UCI HAR Dataset/test/X_test.txt")
trainSet <- read.table("UCI HAR Dataset/train/X_train.txt")
labely <- read.table("UCI HAR Dataset/test/y_test.txt")
labelx <- read.table("UCI HAR Dataset/train/y_train.txt")

trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt") 
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt") 

finalSet <- rbind(cbind(trainSet,trainSubjects,labelx),cbind(testSet,testSubjects,labely))

## Fetching the appropriate feature name 
featureNames <- read.table("UCI HAR Dataset/features.txt")
featureNames <- as.character(featureNames[,2])
featureNames[562] <- "subject"
featureNames[563] <- "activity"
colnames(finalSet) <- featureNames

##Slice DataFrame : Keep only measurements on mean and std
validFeatures <- grep('.*((mean[^F])|(std)).*', featureNames)
validFeatures <- c(validFeatures,562,563)
finalSet <- finalSet[,validFeatures]

## Replace activity ID with descriptive labels
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
finalSet[["activity"]] <- activityLabels[ match(finalSet[["activity"]], activityLabels[["V1"]]),'V2']

## As from answer by course TA on the course FAQ
## Descriptive variable names means names based on the action the variable is recording, for example the Jerk of the body on the z axis of the phone

for(i in 1:(ncol(finalSet)-2))
{
  cname <- colnames(finalSet)[i]
  splits = unlist(strsplit(cname,"-"))
  
  ifelse(splits[2]=="mean()",newName <- "mean of the",
         ifelse(splits[2]=="std()",newName <- "standard deviation of the",newName <- "SPLIT 2 ERROR"))
  
  if(grepl('.*Mag.*', splits[1])){
    newName <- paste(newName,"magnitde of the")
  }
  
  ifelse(substr(splits[1],1,1)=="t",newName <- paste(newName,"time signals"),
         ifelse(substr(splits[1],1,1)=="f",newName <- paste(newName,"frequency signals"),newName <- paste(newName,"FIRST LETTER PROB")))
  
  if(grepl('.*Jerk.*', splits[1])==1)
    newName <- paste(newName,"of the Jerk")
  
  ifelse(grepl('.*Gyro.*', splits[1]),newName <- paste(newName,"based on the gyrometer reading"),
         ifelse(grepl('.*Body.*', splits[1]),newName <- paste(newName,"based on the body acceleration"),
                ifelse(grepl('.*Gravity.*', splits[1]),newName <- paste(newName,"based on the gravity acceleration"), newName<-"No Acc")))
  
  if(!is.na(splits[3]))
    newName <- paste(newName,"on",splits[3],"axis")
  
  colnames(finalSet)[i] <- newName
}

## Creating independent tidy data with the average of each variable for each activity and each subject
tidySet <- melt(finalSet,id=c("subject","activity"))
tidySet <- dcast(tidySet,subject+activity ~ variable, mean)

write.table(tidySet,file="tidySet.txt",row.name=FALSE)
tidySet


## Help Code for Generating CodeBook
## data.frame(min=sapply(tidySet[,-c(1,2)],min),max=sapply(tidySet[,-c(1,2)],max))
## write.table(data.frame(min=sapply(tidySet[,-c(1,2)],min),max=sapply(tidySet[,-c(1,2)],max)),file="codebook.md",row.name=FALSE)
  
  