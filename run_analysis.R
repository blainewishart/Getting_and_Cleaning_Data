#script: run_analysis.R
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## Misc. Notes:
### style for names. exising R code and data uses several conflicting nameing conventions. 
###    Here we use all lower case, separated on occasion with undeerscores for readability
###          Example: in stead of measurementnames, we use measurement_names
###    Where possible, we use the names inspired by the file name of the input file
###          Example: subjects is built from data/test|train/subject_train.txt
## download, and unzip data to known directory
setwd("/Users/dev/Coursera/Getting_Cleaning_Data/submission/Getting_and_Cleaning_Data")  # make sure we are in the right directory

#### do by hand because unzip is not working under OSX
            #if (file.exists("data")) unlink("data", recursive=TRUE)  #delete any exising data directory so we have clean slate
            #dir.create("data")                         #create a clean data directory
            # the url has been copied from the course project description at 
            #   https://class.coursera.org/getdata-004/human_grading/view/courses/972137/assessments/3/submissions
            #url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
            #download.file(url, destfile = "./data/uci_har_dataset.zip", method = "curl")
            #### end of do by hand
            
            # download data set from https://class.coursera.org/getdata-004/human_grading/view/courses/972137/assessments/3/submissions to working directory
            # use file system to unzip
            # rename resulting top level directory from "UCI HAR Dataset" to "data"

#load functions developed for and used in this analysis
source("common_functions.R")
#load required libraries
library(reshape2)

###############
# 1.   Merge the training and the test sets to create one data set.
################
#build the training dataset
measurements_train<- read.table("data/train/X_train.txt")
subjects_train<- read.table("data/train/subject_train.txt")
activities_train<- read.table("data/train/y_train.txt")
train_uci_har<- cbind(subjects_train, activities_train, measurements_train)

#build test dataset the same way, but get data from slightly different location
measurements_test<- read.table("data/test/X_test.txt")
subjects_test<- read.table("data/test/subject_test.txt")
activities_test<- read.table("data/test/y_test.txt")
test_uci_har<- cbind(subjects_test, activities_test, measurements_test)

#form the merged dataset
uci_har<- rbind(train_uci_har, test_uci_har)  #column names are identical so combining test and training datasets is straightforward

##########
# 2.  Extract only the measurements on the mean and standard deviation for each measurement. 
# 3   Use descriptive activity names to name the activities in the data set
#     It was more straight forward to combine these actvites as then we could deal with meaningful names for subsetting 
#########
# mean and standard deviation include either "-mean()-" or "-std()-"
# therefore replace default names with names from data/features.txt & give meaningful names to subject and activity columns
#build names for both datasets
# create the vector we will use for featues i.e. names of measurements. Names are itentical in both training and test data sets
features <- readLines("data/features.txt")  
features <- gsub("^[0-9]+ ", "", features)   #cleanup leanding legacy column numbers []
subject_activity_labels<-c("subject", "activity")
all_labels<-c(subject_activity_labels, features)
clean_labels<- gsub("\\(\\)", "",all_labels)
colnames(uci_har)<- clean_labels
mean_and_std_cols<- grep("-mean-|-std-", clean_labels)  # we only want mean and std
# use the col numbers of columns containing mean and std data to subset uci_har. be sure to include the first two columns with subjexts and activities
uci_har_reduced <- uci_har[,c(1,2,mean_and_std_cols)]

#take some simple measurements as sanity check
activities_size<- nrow(activities_test) + nrow(activities_train)
measurements_size<- nrow(measurements_test) + nrow(measurements_train)

## while we pulled in data from various sources, the sizes of the pieces and the 
##      end result make sense. 
##      We have a total of 10299 measurents i.e. rows
##      The original data had 563 columns -- 561 measurements and 2 indetifiers (subjecct and activity) 
##      We found 48 colums matching the pattern mean() or std(). We kept our two identifer columns.
##      Now we have a 50 x 10299 data frame

#########
# 4.  Appropriately labels the data set with descriptive variable names. 
######### 
named_activites <- sapply(uci_har_reduced$activity, name_activities)
uci_har_reduced$activity<-named_activites

#########
# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
######### 
all_names<-  names(uci_har_reduced)
measurement_names<-all_names[3:50]
uci_har_melt<-melt(uci_har_reduced, id=c("subject", "activity"), measure.vars=c(measurement_names))

#cylData <- dcast(carMelt, cyl ~ variable,mean)
uci_har_data<- dcast(uci_har_melt, subject ~ activity + variable, mean)
write.table(uci_har_data,file="uci_har_data.txt")
