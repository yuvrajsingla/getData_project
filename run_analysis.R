## run_analysis.R 
## The goal is to fetch data and process it to prepare tidy data that can be used for later analysis

## Data https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Descriptive variable names means names based on the action the variable is recording, for example the Jerk of the body on the z axis of the phone

## 1
testSet <- read.table("test/X_test.txt")
trainSet <- read.table("train/X_train.txt")
labely <- read.table("test/y_test.txt")
labelx <- read.table("train/y_train.txt")

trainSubjects <- read.table("train/subject_train.txt") 
testSubjects <- read.table("test/subject_test.txt") 

allSet <- rbind(cbind(trainSet,trainSubjects,labelx),cbind(testSet,testSubjects,labely))

#Rename columns
features <- read.table("features.txt")
featureNames <- as.character(features[,2])
featureNames[562] <- "subject"
featureNames[563] <- "activity"
colnames(allSet) <- featureNames

validFeatures <- grep('.*((mean[^F])|(std)).*', featureNames)
validFeatures <- c(validFeatures,562,563)
slicedSet <- allSet[,validFeatures]

activityLabels <- read.table("activity_labels.txt")
slicedSet[["activity"]] <- activityLabels[ match(slicedSet[["activity"]], activityLabels[["V1"]]),'V2']

finalSet <- melt(slicedSet,id=c("subject","activity"))
finalSet2 <- dcast(finalSet,subject+activity ~ variable, mean)

for(i in 3:ncol(finalSet2))
{
  cname <- colnames(finalSet2)[i]
  splits = unlist(strsplit(cname,"-"))
  
  ifelse(splits[2]=="mean()",newName <- "mean of the",
         ifelse(splits[2]=="std()",newName <- "standart deviation of the",newName <- "SPLIT 2 ERROR"))
  
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
  
  if(is.na(splits[3]))
    newName <- paste(newName,"on",splits[3],"axis")
    
  colnames(finalSet2)[i] <- newName
}


##  if(splits[2]=="mean()")
##  newName <- "mean of the "
##else if(splits[2]=="std()")
##    newName <- "standart deviation of the "
##else
##    newName <- "SPLIT 2 ERROR"



##if(substr(splits[1],1,1)=="t")
##  newName <- paste(newName,"time signals ")
##else if(substr(splits[1],1,1)=="f")
##  newName <- paste(newName,"frequency signals ")
##else
##  newName <- paste(newName,"FIRST LETTER PROB")

##if(grepl('.*Gyro.*', splits[1])==1)
##  newName <- paste(newName,"based on the gyrometer reading ")
##else if(grepl('.*Body.*', splits[1])==1)
##  newName <- paste(newName,"based on the body acceleration ")
##else if(grepl('.*Gravity.*', splits[1])==1)
##  newName <- paste(newName,"based on the gravity acceleration ")
