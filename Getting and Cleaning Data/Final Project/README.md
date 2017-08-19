#README.md

By running run\_analysis.r from the same directory which contains the UCI HAR Dataset folder, a "tidy" tab-separated data file is produced. run\_analysis.r processes the UCI HAR data in the following fashion:

1. features.txt and activity\_labels.txt are read in as character vectors with scan. features.txt will be used for the names of the variables; activity\_labels will serve as a lookup table for labeling the activity performed in each observation.

2. The test data is read in.
    * /test/subject\_test.txt and /test/y\_test.txt are read as numeric vectors, with scan. /test/subject\_test.txt will serve as the variable representing which subject performed the task in an observation. /test/y\_test.txt serves as the variable representing which activity was performed for each observation.
    * /test/X\_test.txt is read in as a data frame, with read.table. It represents the measurements collected and calculated for the test portion of the experiment.

3. The test data frame is assembled. Columns in /test/X\_test.txt are named according to features.txt. Two columns are appended at the beginning with cbind: column 1 of the assembled data frame is named "Subject" and comprises /test/subject\_test.txt. The second column describes the activity performed; it is named "Activity" and it comprises the result of using the numbers found in /test/y\_test.txt to perform lookups on activity\_labels.txt (i.e. the numerical value in y\_test is fed to activity\_labels as an index). The result is a data frame of 2,947 observations and 563 variables (the 561 variables of /test/X\_test.txt plus the "Subject" and "Activity" variables).

4. The train information is read in, and the train data frame assembled, in an analogous fashion. The result is a data frame of the same 563 variables, this with 7,352 observations.

5. The full collection of observations is restored by combining the test and train data frames with rbind: train is bound as rows to test.

6. The columns containing "mean()" or "std" are extracted. This is performed by applying grep to the names of the data frame, searching for a regular expression matching "mean()" literally (including parentheses), or "std." The resulting indices are used to build a filtered data frame consisting of the Subject and Activity columns of the original, followed by the extracted columns.

7. Variable names of this new data frame are clarified; prefix "t" is expanded to "time" and likewise prefix "f" is expanded to "frequency." Special characters such as parentheses are removed. Dashes are replaced with periods to serve as separators. This is all performed by applying gsub to the names of the data frame.

8. The data is sorted by subject, ascending, using order().

9. The data is split across two factors; first, subject. Each element of the resulting list of data frames is then split by activity, by means of lapply, creating a list of lists of data frames. So each element of the first list is a list of data frames, all representing the same subject. Each element of this subordinate list is a data frame representing that subject performing one activity. Index in first list indicates subject, index in second list indicates activity.

10. A placeholder data frame for the tidy output is created by means of taking the data frame created in step 6 and extracting the first 180 observations. This serves two purposes; first, memory is allocated in advance for the output data frame. Second, each variable in the resulting data frame is already of the proper class for the tidy data (Subject is numeric, Activity is a factor with the proper six levels, the remaining variables are all numeric).

11. For each data frame created at the end of step 9, the mean for each numeric column (that is, those other than "Subject" and "Activity") is calculated. This is done by means of a nested for loop; the outer loop iterates over the subjects and the inner loop iterates over the activities.  For the data frame representing a certain subject-activity pair, applying colMeans to the columns representing measurements (i.e. columns 3 to 68) yields the average of all measurements for that subject, that activity, and that measured quantity.

12. The tidy data - averages for each variable selected from the original data set, by subject and activity - is assembled. For each data frame in step 11, a row in the placeholder from step 10 is filled. The subject and activity for the data frame comprise the row's Subject and Activity values. The means calculated in step 11 fill the remaining values.

13. The resulting data set is written to a tab-separated text file.