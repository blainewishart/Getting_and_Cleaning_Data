#Getting and Cleaning Data -- Course Project -- Code Book

###Column names in uci_har_data.txt
A tidy data set named "uci_har_data.txt" has been uploaded and contains:

30 rows of data representing observations of 30 subjects in the original experment. Subjects are represented by integers 1:30 and have not been modified from the original data.

562 columns, each representing a single type of data composed of the  of types of actvities (6) and 48 types of observations in the original experment. The data are not the original statistics generated, but averages of that data. The notion of averages of averages is not natural to everyone, but it is what the assignment requested and it is a count statistical concept.

The term 'tidy' is used as presented in [The tidy data lecture](http://jtleek.com/modules/03_GettingData/01_03_componentsOfTidyData/#4)

1. 562 variables are each presented in their own column.
2. Each of the 30 rows represents observations of a single subject in the original experment.
3. The variables are all of the same type: an average of some data in the original experment so they are presented in one table.
4. Since only one table is used, there is no provision for linking to other tables.

Many of the variable names are human readable to the authors of the original study, however, they can be a little cryptic to anyone not aleady familiar with various measurements made possible by the Samsung Galaxys used in the experment. The origial have only been modified slightly to preserve traceability from the original data to the averages of that data contained in this assignment. Those familiar with the concpts of 'aceleration' and 'jerk' will understand their meaning. For those who don't, longer column names are won't be of much help.

####column 1 is named "subject"
It represents one of 30 subjects in the original study.
####columns 2:253...

An example column name, "walking_upstairs_tBodyGyro-mean-Y" is used for reference.

Each column name begins with the name of one of six activites defined in the distribution file "activity_labels.txt", which is reproduced below for reference. In the example column name, the activity is "walking_upstairs". The name of the activity and the name of the underlying measurement are separated by an underscore character. The activities are:

    1 WALKING
    2 WALKING_UPSTAIRS
    3 WALKING_DOWNSTAIRS
    4 SITTING
    5 STANDING
    6 LAYING

The first character following the underscore is a lower case 'f' or 't'. This is carried over from the original study. An 'f' indicates the expermental data was passed through a FFT filter to enhance the signal. A 't' indicates the expermental data is a time series. In the example column name, the 't' indicates the meaurements are time series measurements. 

The next section of a column name is based on the signals in the original data. In the compressed list presented here, a trailing "-XYZ" indicates there are really three meauremnts one each for x,y, and z dimentions of a 3D space. In the eaxample name BodyGyro is the name of the signal and the traling Y is the dimension. 

    tBodyAcc-XYZ
    tGravityAcc-XYZ
    tBodyAccJerk-XYZ
    tBodyGyro-XYZ
    tBodyGyroJerk-XYZ
    tBodyAccMag
    tGravityAccMag
    tBodyAccJerkMag
    tBodyGyroMag
    tBodyGyroJerkMag
    fBodyAcc-XYZ
    fBodyAccJerk-XYZ
    fBodyGyro-XYZ
    fBodyAccMag
    fBodyAccJerkMag
    fBodyGyroMag
    fBodyGyroJerkMag

The original data contained many statistics generated from the raw data. For the uci_har_data.txt dataset, which is the tidy data set required for this assignment, all except the mean and standard deviation of a raw signal were dropped. These are indicated by the string "mean" or "std" at the name's end or just before a terminating "X", "Y", or "Z". In the sample name above the string "-mean-" indicates a mean of the meaurement (BodyGyro) rather than the standard deviation of the measurement. 

For more details on the original data see data/For details see "data/features_info.txt" in the GitHub repository. For a complete enumeration of the measurement names see data/features.txt.

Five vectors inclded in the original data include the term 'mean', but their character is different -- they don't represent the mean of a set of measurements, they constute a measurement based on averaging signals in a sample. Therefore they are more like raw data than a statistic based on raw dats so they have not been included. 

####Example: "walking_upstairs_tBodyGyro-mean-Y" is the name of a column based on

1. measurements of BodyGyro in the Samsung Galaxy
2. on the Y axis
3. based on a time series
4. is the mean of those measurements
5. take while the subject was walking upstairs.

