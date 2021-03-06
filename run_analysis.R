library(reshape2) ## load reshaping package into R for melt and cast for step 5
library(plyr) ## load plyr package to find the average for all patients in step 5 

##1] Merges the training and the test sets into one data set

## Read the test & Traning Data files
testData <- read.table("~/CleanData/UCI HAR Dataset/test/X_test.txt", 
                       comment.char = "", colClasses="numeric") ## Read test.txt file 
testLables = read.table("~/CleanData/UCI HAR Dataset/test/y_test.txt", 
                        comment.char = "", colClasses="numeric") ## Read the activity lables (1-6) for test data
testSubject = read.table("~/CleanData/UCI HAR Dataset/test/subject_test.txt", 
                         comment.char = "", colClasses="numeric") ## Read subject ID number
dataSet <- matrix(dataSet <- "Test", nrow(testData)) ## create a column with just "test" label

## Add columns of Test Lables, Test Subject and dataSet to the Test data as additional columns
testwLables <- cbind(testData,testLables,testSubject,dataSet)

## read train.txt file
trainData = read.table("~/CleanData/UCI HAR Dataset/train/X_train.txt", 
                       comment.char = "", colClasses="numeric") 
trainLables = read.table("~/CleanData/UCI HAR Dataset/train/y_train.txt", 
                         comment.char = "", colClasses="numeric") ## Read the activity lables (1-6) for train data
trainSubject = read.table("~/CleanData/UCI HAR Dataset/train/subject_train.txt", 
                          comment.char = "", colClasses="numeric") ## Read the subject ID number
dataSet <- matrix(dataSet <-"Train", nrow(trainData)) ## create a column with only "train" label

## Add columns of Train Lables, Train Subject and dataSet noto the Train 
## data as additional columns
trainwLables <- cbind(trainData, trainLables, trainSubject, dataSet)

## Add the two data sets (Test and Train) together to form one data set.
fullDataset <- rbind(testwLables,trainwLables)


##2], Extracts only the measurements related to the mean and standard deviation 
## relevant columns only
meanSdData <-  fullDataset[,c(564,562,563, 1:6,41:46,81:86, 121:126,161:166,201,
                              202,214,215,227,228,240,241,253,254,266:271,345:350,
                              424:429,503,504,516,517,529,530,542,543)]   
## Step 4] Appropriately labels the data set with descriptive variable names. 
## This dataset contains all values with mean() or Std() data omitting frequency and angle
## data

colnames(meanSdData) <- c("dataSet","activity", "patientId",
                          "tBodyAc.mean.X", "tBodyAc.mean.Y","tBodyAc.mean.Z",
                          "tBodyAc.std.X", "tBodyAc.std.Y", "tBodyAc.std.Z", 
                          "tGravAc.mean.X", "tGravAc.mean.Y","tGravAc.mean.Z",
                          "tGravAc.std.X","tGravAc.std.Y","tGravAc.std.Z",
                          "tBodyAcJerk.mean.X","tBodyAcJerk.mean.Y","tBodyAcJerk.mean.Z",
                          "tBodyAcJerk.std.X", "tBodyAcJerk.std.Y","tBodyAcJerk.std.Z",
                          "tBodyGyro.mean.X","tBodyGyro.mean.Y", "tBodyGyro.mean.Z",
                          "tBodyGyro.std.X","tBody.std.Y","tBodyGyro.std.Z",
                          "tBodyGyroJerk.mean.X", "tBodyGyroJerk.mean.Y","tBodyGyroJerk.mean.Z",
                          "tBodyGyroJerk.std.X","tBodyGyroJerk.std.Y","tBodyGyroJerk.std.Z",
                          "tBodyAcMag.mean", "tBodyAcMag.std", 
                          "tGravAcMag.mean", "tGravAcMag.std",
                          "tBodyAcJerkMag.mean", "tBodyAcJerkMag.std",
                          "tBodyGyroMag.mean", "tBodyGyroMag.std", 
                          "tBodyGyroJerkMag.mean","tBodyGyroJerkMag.std",
                          "fBodyAc.mean.X","fBodyAc.mean.Y","fBodyAc.mean.Z",
                          "fBodyAc.std.X","fBodyAc.std.Y","fBodyAc.std.Z", 
                          "fBodyAcJerk.mean.X","fBodyAcJerk.mean.Y","fBodyAcJerk.mean.Z",
                          "fBodyAcJerk.std.Y","fBodyAcJerk.std.Y", "fBodyAcJerk.std.Z",
                          "fBodyGyro.mean.X","fBodyGyro.mean.Y","fBodyGyro.mean.Z",
                          "fBodyGyro.std.X","fBodyGyro.std.Y", "fBodyGyro.std.Z",
                          "fBodyAcMag.mean","fBodyAcMag.std",
                          "fBodyAcJerkMag.mean","fBodyAcJerkMag.std",
                          "fBodyGyroMag.mean","fBodyGyroMag.std",
                          "fBodyGyroJerkMag.mean","fBodyGyroJerkMag.std")

## 3] Uses descriptive activity names to name the activities in the data set 
## 1- Walking,2-WalkingUpstairs, 3-WalkingDownstairs,4-Sitting, 5-Standing, 6-Laying
meanSdData$activity <- gsub("1", "Walking", meanSdData$activity)
meanSdData$activity <- gsub("2", "Walking Upstairs", meanSdData$activity)
meanSdData$activity <- gsub("3", "Walking Downstairs", meanSdData$activity)
meanSdData$activity <- gsub("4", "Sitting", meanSdData$activity)
meanSdData$activity <- gsub("5", "Standing", meanSdData$activity)
meanSdData$activity <- gsub("6", "Laying", meanSdData$activity)


## Determine size of the created (meanSdData) dataset
object.size(meanSdData) ## 5653856 bytes
## print(object.size(meanSdData), units = "Mb") ##5.4 Mb

## 5] Creates a second, independent tidy data set with average of each variable 
## for each activity/subject. 

## melt the data frame to display the mean measurements for each patient ID 
## Here for the simplified data I chose to eliminate mean and std data with X,Y,Z 
## components, additional variables in step4] could be included should the user
## need additional information

meanSdDataMelt <- melt(meanSdData, id=c("dataSet", "activity","patientId"), 
                       measure.vars=c("tBodyAcMag.mean", "tBodyAcMag.std", 
                                      "tGravAcMag.mean", "tGravAcMag.std",
                                      "tBodyAcJerkMag.mean", "tBodyAcJerkMag.std",
                                      "tBodyGyroMag.mean", "tBodyGyroMag.std", 
                                      "tBodyGyroJerkMag.mean","tBodyGyroJerkMag.std",
                                      "fBodyAcMag.mean","fBodyAcMag.std",
                                      "fBodyAcJerkMag.mean","fBodyAcJerkMag.std",
                                      "fBodyGyroMag.mean","fBodyGyroMag.std",
                                      "fBodyGyroJerkMag.mean","fBodyGyroJerkMag.std"),
                       na.rm = TRUE) ## Tall/Long Dataset with 185382 rows

# cast the dataset to dermine average of mean and std measurements, one value per Activity
meanSdDat <- dcast(meanSdDataMelt, patientId + activity ~ variable, mean) 

## Create a column with to replace "Patient ID" value 
patientId <- matrix(patientId <- "Average for all Patient IDs (1-30)", 6)

## dply to find the overall mean for each measurements for all patients per activty
final <- ddply(meanSdDat,.(activity), summarize, tBodyAcMag.mean = mean(tBodyAcMag.mean), 
                                                tBodyAcMag.std = mean(tBodyAcMag.std), 
                                                tGravAcMag.mean = mean(tGravAcMag.mean), 
                                                tGravAcMag.std = mean(tGravAcMag.std),
                                                tBodyAcJerkMag.mean = mean(tBodyAcJerkMag.mean), 
                                                tBodyAcJerkMag.std = mean(tBodyAcJerkMag.std),
                                                tBodyGyroMag.mean = mean(tBodyGyroMag.mean),
                                                tBodyGyroMag.std = mean(tBodyGyroMag.std), 
                                                tBodyGyroJerkMag.mean = mean(tBodyGyroJerkMag.mean),
                                                tBodyGyroJerkMag.std = mean(tBodyGyroJerkMag.std),
                                                fBodyAcMag.mean = mean(fBodyAcMag.mean),
                                                fBodyAcMag.std = mean(fBodyAcMag.std),
                                                fBodyAcJerkMag.mean = mean(fBodyAcJerkMag.mean),
                                                fBodyAcJerkMag.std = mean(fBodyAcJerkMag.std),
                                                fBodyGyroMag.mean = mean(fBodyGyroMag.mean),
                                                fBodyGyroMag.std = mean(fBodyGyroMag.std),
                                                fBodyGyroJerkMag.mean = mean(fBodyGyroJerkMag.mean),
                                                fBodyGyroJerkMag.std = mean(fBodyGyroJerkMag.std))

## Affix the Average for all patients column to the data set to match the previous meanSdDat set
finalDataAssembled  <-cbind(patientId,final)

## Add the final summary for all patients at the bottom of the dataset.
finalData <- rbind(meanSdDat,finalDataAssembled)


## Create a text file with the cleaned up dataset for step 5
final_df <- finalData
file <- "~/CleanData/UCI HAR Dataset/cleanDf.txt"
write.table(final_df, file = file, row.names=FALSE, col.names=TRUE, sep="\t", quote = FALSE)
                
## Create a text file with the data from step 1-4 with all mean and std variables included for all values
step4_df <- meanSdData
file <- "~/CleanData/UCI HAR Dataset/step4_df.txt"
write.table(step4_df, file = file, row.names=FALSE, col.names=TRUE, sep="\t", quote=FALSE)


## please note that both txt files open with improper formatting when opened with Notepad 
## or wordpad, files must be opened using excel to properly display columns and formatting
