#Codebook for Tidy Data

##Description
This project summarizes and averages the data from UCI's Human Activity Recognition Using Smartphones Data Set, found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. It presents the data by subject and by activity (e.g. Subject 4 Walking, or Subject 8 Sitting).

##Raw Data
The raw data was taken from http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip, and downloaded August 15 2017 at 7:49PM EST. The raw data for this project is the processed data from the source data set; elaboration on the collection and processing of this data can be found at UCI's website, and in the README.txt and features_info.txt files contained in the data set.

A summary of the collection process, taken from the data set's README.txt:
"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain."

Further informtion and descriptions of the variables in the raw data can be found in features_info.txt.

##Processing
###Source Files
From the source data, the following files were used.
*activity_labels.txt
*features.txt
*/test/subject_test.txt
*/test/X_test.txt
*/test/y_test.txt
*/train/subject_train.txt
*/train/X_train.txt
*/train/y_train.txt

###Creating the Tidy Data
The creation of the tidy data file "output.txt," a tab-separated data file, is entirely automated within the script run_analysis.r. Upon downloading and unzipping "UCI HAR Dataset," one must simply run run_analysis.r from the directory containing the UCI HAR Dataset folder.

A high-level summary of the tasks performed by run_analysis.r:

1. The source files are read in; the "test" data frame is assembled from /test/subject_test.txt, /test/X_test.txt, /test/y_test.txt and features.txt. Likewise the "train" data frame is assembled. They are combined into one data frame with rbind.

2. From the full data frame, the variables representing "mean()" or "std" information are extracted.

3. The resulting data frame is split by subject and activity, and each of these data frames is processed to create an observation of the tidy data representing the averages of all measurements for a specific subject and activity.

This process is explained in greater detail here: [link readme]

###Variables
The tidy data is a data frame of 180 observations and 68 variables.

The 180 observations come from an observation for each activity, for each subject (6 activities * 30 subjects). The 68 variables are as follows:

 [1] "Subject"                                  
 [2] "Activity"                                 
 [3] "timeBodyAcc.mean.X.average"               
 [4] "timeBodyAcc.mean.Y.average"               
 [5] "timeBodyAcc.mean.Z.average"               
 [6] "timeBodyAcc.std.X.average"                
 [7] "timeBodyAcc.std.Y.average"                
 [8] "timeBodyAcc.std.Z.average"                
 [9] "timeGravityAcc.mean.X.average"            
[10] "timeGravityAcc.mean.Y.average"            
[11] "timeGravityAcc.mean.Z.average"            
[12] "timeGravityAcc.std.X.average"             
[13] "timeGravityAcc.std.Y.average"             
[14] "timeGravityAcc.std.Z.average"             
[15] "timeBodyAccJerk.mean.X.average"           
[16] "timeBodyAccJerk.mean.Y.average"           
[17] "timeBodyAccJerk.mean.Z.average"           
[18] "timeBodyAccJerk.std.X.average"            
[19] "timeBodyAccJerk.std.Y.average"            
[20] "timeBodyAccJerk.std.Z.average"            
[21] "timeBodyGyro.mean.X.average"              
[22] "timeBodyGyro.mean.Y.average"              
[23] "timeBodyGyro.mean.Z.average"              
[24] "timeBodyGyro.std.X.average"               
[25] "timeBodyGyro.std.Y.average"               
[26] "timeBodyGyro.std.Z.average"               
[27] "timeBodyGyroJerk.mean.X.average"          
[28] "timeBodyGyroJerk.mean.Y.average"          
[29] "timeBodyGyroJerk.mean.Z.average"          
[30] "timeBodyGyroJerk.std.X.average"           
[31] "timeBodyGyroJerk.std.Y.average"           
[32] "timeBodyGyroJerk.std.Z.average"           
[33] "timeBodyAccMag.mean.average"              
[34] "timeBodyAccMag.std.average"               
[35] "timeGravityAccMag.mean.average"           
[36] "timeGravityAccMag.std.average"            
[37] "timeBodyAccJerkMag.mean.average"          
[38] "timeBodyAccJerkMag.std.average"           
[39] "timeBodyGyroMag.mean.average"             
[40] "timeBodyGyroMag.std.average"              
[41] "timeBodyGyroJerkMag.mean.average"         
[42] "timeBodyGyroJerkMag.std.average"          
[43] "frequencyBodyAcc.mean.X.average"          
[44] "frequencyBodyAcc.mean.Y.average"          
[45] "frequencyBodyAcc.mean.Z.average"          
[46] "frequencyBodyAcc.std.X.average"           
[47] "frequencyBodyAcc.std.Y.average"           
[48] "frequencyBodyAcc.std.Z.average"           
[49] "frequencyBodyAccJerk.mean.X.average"      
[50] "frequencyBodyAccJerk.mean.Y.average"      
[51] "frequencyBodyAccJerk.mean.Z.average"      
[52] "frequencyBodyAccJerk.std.X.average"       
[53] "frequencyBodyAccJerk.std.Y.average"       
[54] "frequencyBodyAccJerk.std.Z.average"       
[55] "frequencyBodyGyro.mean.X.average"         
[56] "frequencyBodyGyro.mean.Y.average"         
[57] "frequencyBodyGyro.mean.Z.average"         
[58] "frequencyBodyGyro.std.X.average"          
[59] "frequencyBodyGyro.std.Y.average"          
[60] "frequencyBodyGyro.std.Z.average"          
[61] "frequencyBodyAccMag.mean.average"         
[62] "frequencyBodyAccMag.std.average"          
[63] "frequencyBodyBodyAccJerkMag.mean.average" 
[64] "frequencyBodyBodyAccJerkMag.std.average"  
[65] "frequencyBodyBodyGyroMag.mean.average"    
[66] "frequencyBodyBodyGyroMag.std.average"     
[67] "frequencyBodyBodyGyroJerkMag.mean.average"
[68] "frequencyBodyBodyGyroJerkMag.std.average"

Subject
Numeric vector taking values 1 to 30, representing the 30 different subjects in the experiment.

Activity
Factor with six levels; "LAYING," "SITTING," "STANDING," "WALKING," "WALKING_DOWNSTAIRS," "WALKING_UPSTAIRS." Each level is a specific activity.

Each subsequent variable is a numeric vector representing the average values for the corresponding variable from the original data, with each entry corresponding to a specific subject-activity pair.