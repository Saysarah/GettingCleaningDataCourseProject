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
                          "tBodyAc.mean.X1", "tBodyAc.mean.Y2","tBodyAc.mean.Z3",
                          "tBodyAc.std.X4", "tBodyAc.std.Y5", "tBodyAc.std.Z6", 
                          "tGravAc.mean.X41", "tGravAc.mean.Y42","tGravAc.mean.Z43",
                          "tGravAc.std.X44","tGravAc.std.Y45","tGravAc.std.Z46",
                          "tBodyAcJerk.mean.X81","tBodyAcJerk.mean.Y82","tBodyAcJerk.mean.Z83",
                          "tBodyAcJerk.std.X84", "tBodyAcJerk.std.Y85","tBodyAcJerk.std.Z86",
                          "tBodyGyro.mean.X121","tBodyGyro.mean.Y122", "tBodyGyro.mean.Z123",
                          "tBodyGyro.std.X124","tBody.std.Y125","tBodyGyro.std.Z126",
                          "tBodyGyroJerk.mean.X161", "tBodyGyroJerk.mean.Y162","tBodyGyroJerk.mean.Z163",
                          "tBodyGyroJerk.std.X164","tBodyGyroJerk.std.Y165","tBodyGyroJerk.std.Z166",
                          "tBodyAcMag.mean201", "tBodyAcMag.std202", 
                          "tGravAcMag.mean214", "tGravAcMag.std215",
                          "tBodyAcJerkMag.mean227", "tBodyAcJerkMag.std228",
                          "tBodyGyroMag.mean240", "tBodyGyroMag.std241", 
                          "tBodyGyroJerkMag.mean253","tBodyGyroJerkMag.std254",
                          "fBodyAc.mean.X266","fBodyAc.mean.Y267","fBodyAc.mean.Z268",
                          "fBodyAc.std.X269","fBodyAc.std.Y270","fBodyAc.std.Z271", 
                          "fBodyAcJerk.mean.X345","fBodyAcJerk.mean.Y346","fBodyAcJerk.mean.Z347",
                          "fBodyAcJerk.std.Y348","fBodyAcJerk.std.Y349", "fBodyAcJerk.std.Z350",
                          "fBodyGyro.mean.X424","fBodyGyro.mean.Y425","fBodyGyro.mean.Z426",
                          "fBodyGyro.std.X427","fBodyGyro.std.Y428", "fBodyGyro.std.Z429",
                          "fBodyAcMag.mean503","fBodyAcMag.std504",
                          "fBodyAcJerkMag.mean516","fBodyAcJerkMag.std517",
                          "fBodyGyroMag.mean529","fBodyGyroMag.std530",
                          "fBodyGyroJerkMag.mean542","fBodyGyroJerkMag.std543")

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
                       measure.vars=c("tBodyAcMag.mean201", "tBodyAcMag.std202", 
                                      "tGravAcMag.mean214", "tGravAcMag.std215",
                                      "tBodyAcJerkMag.mean227", "tBodyAcJerkMag.std228",
                                      "tBodyGyroMag.mean240", "tBodyGyroMag.std241", 
                                      "tBodyGyroJerkMag.mean253","tBodyGyroJerkMag.std254",
                                      "fBodyAcMag.mean503","fBodyAcMag.std504",
                                      "fBodyAcJerkMag.mean516","fBodyAcJerkMag.std517",
                                      "fBodyGyroMag.mean529","fBodyGyroMag.std530",
                                      "fBodyGyroJerkMag.mean542","fBodyGyroJerkMag.std543"),
                       na.rm = TRUE) ## Tall/Long Dataset with 185382 rows

# cast the dataset to dermine average of mean and std measurements, one value per Activity
meanSdDat <- dcast(meanSdDataMelt, patientId + activity ~ variable, mean) 

## Create a column with to replace "Patient ID" value 
patientId <- matrix(patientId <- "Average for all Patient IDs (1-30)", 6)

## dply to find the overall mean for each measurements for all patients per activty
final <- ddply(meanSdDat,.(activity), summarize, tBodyAcMag.mean201 = mean(tBodyAcMag.mean201), 
                                                tBodyAcMag.std202 = mean(tBodyAcMag.std202), 
                                                tGravAcMag.mean214 = mean(tGravAcMag.mean214), 
                                                tGravAcMag.std215 = mean(tGravAcMag.std215),
                                                tBodyAcJerkMag.mean227 = mean(tBodyAcJerkMag.mean227), 
                                                tBodyAcJerkMag.std228 = mean(tBodyAcJerkMag.std228),
                                                tBodyGyroMag.mean240 = mean(tBodyGyroMag.mean240),
                                                tBodyGyroMag.std241 = mean(tBodyGyroMag.std241), 
                                                tBodyGyroJerkMag.mean253 = mean(tBodyGyroJerkMag.mean253),
                                                tBodyGyroJerkMag.std254 = mean(tBodyGyroJerkMag.std254),
                                                fBodyAcMag.mean503 = mean(fBodyAcMag.mean503),
                                                fBodyAcMag.std504 = mean(fBodyAcMag.std504),
                                                fBodyAcJerkMag.mean516 = mean(fBodyAcJerkMag.mean516),
                                                fBodyAcJerkMag.std517 = mean(fBodyAcJerkMag.std517),
                                                fBodyGyroMag.mean529 = mean(fBodyGyroMag.mean529),
                                                fBodyGyroMag.std530 = mean(fBodyGyroMag.std530),
                                                fBodyGyroJerkMag.mean542 = mean(fBodyGyroJerkMag.mean542),
                                                fBodyGyroJerkMag.std543 =mean(fBodyGyroJerkMag.std543))

## Affix the Average for all patients column to the data set to match the previous meanSdDat set
finalDataAssembled  <-cbind(patientId,final)

## Add the final summary for all patients at the bottom of the dataset.
finalData <- rbind(meanSdDat,finalDataAssembled)

## Create a text file with the cleaned up dataset for step 5
final_df <- finalData
file <- "~/CleanData/UCI HAR Dataset/cleanDf.txt"
write.table(final_df, file = file, row.names=FALSE, col.names=TRUE, sep="\t", quote=FALSE)
                
## Create a text file with the data from step 1-4 with all mean and std variables included
step4_df <- meanSdData
file <- "~/CleanData/UCI HAR Dataset/step4_df.txt"
write.table(step4_df, file = file, row.names=FALSE, col.names=TRUE, sep="\t", quote=FALSE)

## please note that both txt files open with improper formatting when opened with Notepad 
## or wordpad, files must be opened using excel to properly display columns and formatting