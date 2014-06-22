This project is cleaning up data from UCI's machine learning Repository,
Data files were downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
on 17/06/2014

Permission to use this dataset obtained from the Author: 
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

Description
--------------------------------
This program cleans the dataset to only display columns containing the mean and standard deviation information for the data for patients 1-30.

The original dataset was derived from a series of experiments carried out with 30 patients (volunteers) aged 19-48 years. Each person preformed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a Samsung Galaxy S II smartphone on their waist. Using its embeded accelerometer and gyroscope were used to measure each subject’s  
3-axial linear acceleration,3-axial angular velocity from which the original dataset describing the motion was derived . The patients were divided into two sets, 70% of the volunteers was selected for generating the training data and 30% the test data. 

This data was obtained online at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The downloaded files correspond to features describing measurements of patient’s motion. The data has been normalized and ranges from (-1 to 1) Therefore no units are included with the measurements.

Please refer to the original data's readMe.txt for more information regarding the experiment. The original data includes:
- features.txt, a text document containing a description of all the features in this database
- feature_info.txt, describes the features of this database and lists the variables estimated from the measured signal

The Dataset includes the following files:
---------------------------------
- readMe.txt
- Codebook.md
- run_analysis.R, file to run to clean and print out data of interest
- cleanDF.txt
- activity_labels.txt
- subject_test.txt,
- x_text.txt
- y_text.txt 
- suject_train.txt
- x_train.txt
- y_train.txt  


the x_test.txt and y_train.txt contain the measurements corresponding to 30 test subjects in both test and train conditions.

The activity_labels.txt, contains the legend for the labels (1-5) that correspond to different activity preformed in y_train.txt and y_test.txt to describe activity corresponding to x_test.txt and ytrain.txt


Data processing:
--------------------------------

The data was read in R using read.tale(). 
The x_test.txt, y_test.txt, subject_test and column with label "test" were joined using cbind()
The y_train.txt, y_train.txt, subject_test and a column with label "train" were joined using cbind()
Both datasets above were combined into a single dataset using rbind()

the relevant columns from the resulting data set were extracting (containing mean() and std() variables
note that mean frequency and angel data omitted)
colnames() was used to appropriately label the corresponding variables
gsub() used to replace activity labels in with descriptive names (following activity_lables.txt)
melt() was used to convert the data set into a long dataset, note that only selected variables from above were used
(variables with X,Y,Z components were omitted at this stage, I chose not to include them)
dcast() is used to converted the dataframe into a wide dataset, where the average of the mean and st data for each activity  was preformed.

A summary describing the resulting matrix was included at the bottom, describing the average for all 30 patients
using matrix(), a column was created to describe "Average for all patients IDs, 1-30"

ddply() was used the determine the mean for the above dataframe
the resulting dataset was combined with the one above using cbind()
write.table() was used to create a text file with the resulting clean dataset, cleanDF.txt


Assumptions:
---------------------------------------------------------------------
The Intertial signal values were ignored from the original dataset as they were not values of interest
The meanSdData dataframe object in run_analysis.R includes all the features of the dataset that contain mean() or std() information,  however the mean frequency and angle data was omitted.

A final cleaned up datafame object, called final_df, displays the mean of the mean() and std() information, averaging determining an averages for each patient (one average per activity). The last 6 columns of this data frame includes overall means for all patients. 

Since the meanSdData dataframe was a large file, for the final cleaned dataframe I omitted mean and standard deviation data containing X,Y,Z components.
Should the user be interested in additional variables they may consult themeanSdData frame and modify the meanSdDataMelt dataset and corresponding code as required to include additional measurements.
