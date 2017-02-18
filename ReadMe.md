##Peer-graded Assignment: Getting and Cleaning Data Course Project

###Submitted by : Ashish Verma
###Description: This file consists of various dependencies and steps involved in cleaning the data.

###Dependencies and Assumptions

1) The assignment references "dplyr" package. Hence, "dplyr" should be installed before script execution.

2) The working directory has to be set as "~\getdata_projectfiles_UCI HAR Dataset\UCI HAR Dataset" ("~" should be replaced appropriately with the real path for one's machine).


###Steps

The entire data tidying activity has been split into 14 steps. They are:

1) Load the test data set i.e., "test\X_test.txt".

2) Load the activities for test data set i.e., "test\y_test.txt".

3) Load the corresponding subjects for test data set i.e., "test\subject_test.txt".
	3.a) Merge the data set from (1), (2) and (3) to match the corresponding activities and subjects.

4) Load the training data set i.e., "train\X_train.txt".

5) Load the activities for training data set i.e., "train\Y_train.txt".

6) Load the corresponding subjects for training data set i.e., "train\subject_train.txt".
	6.a) Merge the data set from (4), (5) and (6) to match the corresponding activities and subjects.

7) Merge the test and training data sets i.e., data from (3.a) and (6.a).

8) Load the features data for the list of columns i.e., "features.txt".

9) Cleanse and extract feature data from (8). This should be done in order to extract all the columns having name like "mean" or "std".

10) Fetch the relevant data from (7) based on the columns from (8). Relevant data includes only those column having name like "mean" or "std".

11) Renames column names in the data from (10).

12) Update the values of activity names related to 1,2,3,4,5 and 6 to WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING
, STANDING and LAYING
 respectively.
(This is the final cleaned data as requested in the step-4 in the assignment).

13) Create a secondary tidy data set by using data from (12). This will group by Subject and activity and calculate the mean of each of the column.
This will be the secondary cleaned and aggregated tidy dataset. (This is the final cleaned data as requested in the step-5 in the assignment).

14) Write the final data from step (13) to a txt file named "Tidy Data Set_Subset.txt". 
