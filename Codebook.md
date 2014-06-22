INTRODUCTION
__________________
This program cleans the dataset to only display columns containing the mean and standard deviation information for 
the data for patients 1-30.

This data was obtained online at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The downloaded files correspond to features describing measurements of patient’s motion. The data has been normalized and ranges from (-1 to 1) Therefore no units are included with the measurements.


The meanSdData dataframe object in run_analysis.R includes all the features of the dataset that contain mean() or std() information,  however the mean frequency and angle data was omitted. ( shown below)

A final cleaned up datafame object, final_df, displays the mean of the mean() and std() information, averaging determining an averages for each patient (one average per activity). The last 6 columns of this data frame includes overall means for all patients. 

Since the meanSdData dataframe was a large file, for the final cleaned dataframe the mean and standard deviation data containing X,Y,Z components were ommitted.


Values for columns 3-20 display the mean of  all the measurements corresponding to patient ID for a given activity level
Note for colums 1-20 the following convention was used for the names:


CODEBOOK : refer to bottom for variable descriptions 
________________________


1.	patientId: a character value identifying the patient 1-30
        - rows(181-186) contain “Average for all Patient IDs (1-30)” to represent the mean for all patients
2. activity
 		    1. Walking
        2. Walking Upstairs
        3. Walking Downstairs
        4. Sitting
        5. Standing
        6. Laying		

3.	tBodyAcMag.mean : numeric value
4.	tBodyAcMag.std : numeric value
5.	tGravAcMag.mean : numeric value
6.	tGravAcMag.st : numeric value
7.	tBodyAcJerkMag.mean : numeric value
8.	tBodyAcJerkMag.std: numeric value,
9.	tBodyGyroMag.mean : numeric value
10.	tBodyGyroMag.std : numeric value
11.	tBodyGyroJerkMag.mean : numeric value
12.	tBodyGyroJerkMag.std : numeric value
13.	fBodyAcMag.mean : numeric value
14.	fBodyAcMag.std : numeric value
15.	fBodyAcJerkMag.mean : numeric value
16.	fBodyAcJerkMag.std : numeric value
17.	fBodyGyroMag.mean : numeric value
18.	fBodyGyroMag.std : numeric value
19.	fBodyGyroJerkMag.mean : numeric value
20.	fBodyGyroJerkMag.std : numeric value


the step4_df.txt data frame (meanSdData dataframe in run_analysis.R) is a larger dataframe, contains all the relevant mean and  standard deviation variables, the corresponding rows are listed below. Note that mean frequency and angular data were omitted from the original dataset during this analysis.

columns 4 - 69 are numerical values, note that the 3-axial signals in the X, Y and Z directions are included in this dataset


1.	dataset : a factor object designated if the measurement is of the test or train dataset 
          -	test
          -	train
2.	activity : a character object corresponding to the activiy
          1. Walking
          2. Walking Upstairs
          3. Walking Downstairs
          4. Sitting
          5. Standing
          6. Laying
3.	patientId :  a numeric value identifying the patient (1-30)
4.	tBodyAc.mean.X
5.	tBodyAc.mean.Y
6.	tBodyAc.mean.Z
7.	tBodyAc.std.X
8.	tBodyAc.std.Y
9.	tBodyAc.std.Z
10.	tGravAc.mean.X
11.	tGravAc.mean.Y
12.	tGravAc.mean.Z
13.	tGravAc.std.X
14.	tGravAc.std.Y
15.	tGravAc.std.Z
16.	tBodyAcJerk.mean.X
17.	tBodyAcJerk.mean.Y
18.	tBodyAcJerk.mean.Z
19.	tBodyAcJerk.std.X
20.	tBodyAcJerk.std.Y
21.	tBodyAcJerk.std.Z
22.	tBodyGyro.mean.X
23.	tBodyGyro.mean.Y
24.	tBodyGyro.mean.Z
25.	tBodyGyro.std.X
26.	tBody.std.Y
27.	tBodyGyro.std.Z
28.	tBodyGyroJerk.mean.X
29.	tBodyGyroJerk.mean.Y
30.	tBodyGyroJerk.mean.Z
31.	tBodyGyroJerk.std.X 
32.	tBodyGyroJerk.std.Y
33.	tBodyGyroJerk.std.Z
34.	tBodyAcMag.mean
35.	tBodyAcMag.std
36.	tGravAcMag.mean
37.	tGravAcMag.std
38.	tBodyAcJerkMag.mean227
39.	tBodyAcJerkMag.std
40.	tBodyGyroMag.mean
41.	tBodyGyroMag.std
42.	tBodyGyroJerkMag.mean
43.	tBodyGyroJerkMag.std
44.	fBodyAc.mean.X
45.	fBodyAc.mean.Y
46.	fBodyAc.mean.Z
47.	fBodyAc.std.X
48.	fBodyAc.std.Y
49.	fBodyAc.std.Z
50.	fBodyAcJerk.mean.X
51.	fBodyAcJerk.mean.Y
52.	fBodyAcJerk.mean.Z
53.	fBodyAcJerk.std.Y
54.	fBodyAcJerk.std.Y
55.	fBodyAcJerk.std.Z
56.	fBodyGyro.mean.X
57.	fBodyGyro.mean.Y
58.	fBodyGyro.mean.Z
59.	fBodyGyro.std.X
60.	fBodyGyro.std.Y
61.	fBodyGyro.std.Z
62.	fBodyAcMag.mean
63.	fBodyAcMag.std
64.	fBodyAcJerkMag.mean
65.	fBodyAcJerkMag.std
66.	fBodyGyroMag.mean
67.	fBodyGyroMag.std
68.	fBodyGyroJerkMag.mean
69.	fBodyGyroJerkMag.std

The name is prefixed with either a  t or f:
t - refers to time domain signals to obtain jerk signals, taken at a constant rate of 50 Hz  and adjusted 
f – frequency time domain sigals, Refers to values obtained from a fourier transform

The middle of the name consists of the following abbreviations:

GravAcMag – refers the eculeadian norm used to determine magnitude of the gravity acceleration signals
BodyAcMag – refers to eculeadian norm used to calculate magnitude of the body acceleration signals 
BodyGyroMag – refers to the magnitude of the body jerk signals measured from the gyroscope 
BodyAcJerkMag – refers to eucleadian norm used to calculate magnitude of the body acceleration jerk signals 
BodyGyroJerkMag – refers to the magnitude of the body jerk signals measured from the gyroscope 

These signals were used to estimate variables of the feature vector for each pattern
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

The end of the name
. mean – indicates a mean value
. std – indicates standard deviation values

