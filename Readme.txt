This project is cleaning up data from UCI's machine learning Repository,
Data files were downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
on 17/06/2014

Permission to use this dataset obtained from the Author: 
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

Description
--------------------------------
a series of expriments carried out with 30 patients (volunteers) aged 19-48 years.
each person preformed six activities(WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
wearing a Samsung Galaxy S II smartphone on their waist. Using its embeded accelorometer and gyroscope, the  
3-axial linear acceleration and 3-axial angular velocity were captured. The patients were divided into two sets, 
70% of the volunteers was selected for generating the training data 
and 30% the test data. 

the data was obtained online at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The downloaded files correspond to features describing measuremens of patients motion. the data has been normalized
and so it has a mean of 0 and ranges from (-1 to 1) Therefore no units are included.


please refer to the original data's readMe.txt for more information on this experiment. The original data includes:
- features.txt, a text document containing a description of all the features in this database
- feature_info.txt, describes the features of this database and lists the variables estimated from the measured signal

The Dataset includes the following files:
---------------------------------
- readMe.txt
- Codebook.md
- run_analysis.R, file to run 
- cleanDF.txt
- activity_labels.txt, contains the legend for the lables (1-5) that correspond to different activity preformed in y_train.txt and y_test.txt to describe activity corresponding to x_test.txt and ytrain.txt

- subject_test.txt, 
- x_text.txt
- y_text.txt 

- suject_train.txt
- x_train.txt
- y_train.txt  

the x_test.txt and y_train.txt contain the measurements coreesponding to 30 test subjects in both test and 
training conditions.

Data processing:
--------------------------------

The data was read in R using read.tale(). 
The x_test.txt, y_test.txt, subject_test and column with label "test" were joined using cbind()
The y_train.txt, y_train.txt, subject_test and a column with label "train" were joined using cbind()
Both datasets above were combined into a single dataset using rbind()

the relevant columns from the resulting data set were extracting (containing mean() and std() variables
note that mean frequency and angel data ommitted)
colnames() was used to appropriately lable the coressponding variables
gsub() used to replace activity lables in with describtive names (following activity_lables.txt)
melt() was used to convert the data set into a long dataset, note that only selected varables from above were used
(variables with X,Y,Z components were ommitted at this stage, I chose not to include them)
dcast() is used to converte the dataframe into a wide dataset

A summary describing the resulting matrix was included at the bottom, describing the average for all 30  patients
using matrix(), a column was created to describle "Average for all patients IDs, 1-30"

ddply() was used the determine the mean for the above dataframe
the resulting dataset was combined with the one above using cbind()
write.table() was used to create a text file with the resulting clean dataset, cleanDF.txt







         - how I processed the data
        - what assumptions I made
        - why I did things a certain way
        - who and where did I obtain original data
