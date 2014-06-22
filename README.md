#README.md
Notes on converting flat text files provided from download into the tidy data set contained in uci_har_data.txt

###Data sources and background
Data sources are explained in the [Course Project Instructions](https://class.coursera.org/getdata-004/human_grading/view/courses/972137/assessments/3/submissions)

[Background information](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones )

###To duplicate this work...
1. [Original study's data should be downloaded manually](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
2. If a ./data directory exists, delete it to make sure to have a clean starting point
2. Unzip manually using file system resources into ./data
3. Use R to run the script run_analysis.R

###Understanding run_analysis.R
####Main action in run_analysis.R
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

####Merge the training and the test sets to create one data set (requirement #1)

This is the most complex step.

1. source required functions from ./CommonFunctions.R
2. load the required library (reshape2)
3. build training and test data sets separately, using nearly idential code. See data/train and data/test. [See naming conventions for R code later in this document.] There are 3 componets to both datasets which can be unified using cbind():
    * Measurements in either ./data/test/X_test.txt or ./data/train/X_train.txt
    * Subjects in either ./data/test/X_test.txt or ./data/train/subject_train.txt
    * Activity codes in either ./data/test/y_test.txt or ./data/train/y_train.txt

4. merge the training and test datasets. They have identical column names so rbind() works well.

####Use descriptive activity names to name the activities in the data set (requirement #3)
1. Get the raw feature names from ./data/features.txt. Remove legacy leading integers from column names. Remove embdded "()" from column names to facilite use in R code.
2. Get the map of activity codes to human readable names from ./data/activity_labels.txt

####Extract only the measurements on the mean and standard deviation(requirement #2)
1. Define two new column names: 'subject' & 'activity and append the modified feaure names forming a vector containing all column names for the merged, tidy data set.
4. Filter out all the column names which don't reflect either calculaiton of a mean or calculation of a standard deviation. 
5. Use the reduced vector of column names to  subset the merged data. Use the name uci_har_reduced for the data set to indicate:
    * uci_har data is foundation 
    * original data has been recuced
    
####Appropriately labels the data set with descriptive variable names (requirement #4)
1. Use the cleaned up column names to rename columns in the merged data set.
    
####Do a data size sanity check
1. Use the environment pane of R Studio to examine the dimensions and sizes of the components of uci_har_reduced. 
    * Note that the total number of rows in the separate test and training datasets are equal to the number of rows in uci_har_reduced (10299).
    * The number of columns in test, training and merged datasets (uci_har) are equal.
    * The number of columns in the reduced data set (uci_har_reduced) is only 50 reflecting a column for subject and one for activity + 48 observations that passed the filter of mean and standard deviation columns.

####Compute averages of the reduced and (slightly) renamed origianl data 
1. Carve out only the measurements in uci_har_reduced. (That is omit subject and activity columns)
2. Use melt() to create a very tall melted data set in uci_har_melt. We can predict its size. We know we have 48 variables and we know we have 10299 observations. When we melt() using subject and activity as ids, and the measuremnt column names we should get 48 * 10299 == 494352 rows. 
    *Use R Studio's environmental pane to verify uci_har_reduced has 494352 rows.
3. Use dcast to rebuild a new data set with
    * 30 rows -- one for each subject
    * 289 columns -- 1 for subject and 288 for variables. Note that 288 is the prodcut of number of activites (6) and number of observations (48).
    * the column names for variables are composed of the activty name pretended to the original, cleaned up, variable name.
    
4. Use write.table to export the new data set to uci_har_data.txt for use by others.   
