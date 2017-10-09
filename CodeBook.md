# CodeBook

This code book describes the variables, the data, and any transformations or work that will be performed to clean up the Human Activity Recognition Using Smartphones Data Set.

## The Data Source

The data set and its description can be obtained from:

	* Original Data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
	* Original Description of the Dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Abstract

Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

Data Set Characteristics:	Multivariate, Time-Series

Attribute Characteristics:	N/A

Associated Tasks:			Classification, Clustering

Number of Instances:		10299

Number of Attributes:		561

Missing Values?				N/A

Area:						Computer

Date Donated:				2012-12-10

Number of Web Hits:			536507

 
## Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.


## The Data Set Parts

The data set includes the following parts:

- 'README.txt':					instructions on how to run the ```run_analysis.R``` script.

- 'features_info.txt': 			information about the variables used on the feature vector.

- 'features.txt': 				list of all the features.

- 'activity_labels.txt': 		establishes the link between the class labels and their corresponding activity name.

- 'train/X_train.txt': 			the training set.

- 'train/y_train.txt': 			the training labels.

- 'test/X_test.txt': 			the test set.

- 'test/y_test.txt': 			the test labels.

The following files are divided in the train and test data sets. Test and training data are in two separate folder, ```test``` and ```train```.

- 'subject_train.txt': 	a row for each subject who performed the activity for each window sample. Its range is from 1 to 30.

- 'Inertial Signals/total_acc_x_train.txt': the acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.

- 'Inertial Signals/body_acc_x_train.txt': the body acceleration signal obtained by subtracting the gravity from the total acceleration.

- 'Inertial Signals/body_gyro_x_train.txt': the angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.


## Transformation Details

There are 5 steps:

Step 1. Merges the training and the test sets to create one data set.
Step 2. Extracts only the measurements on the mean and standard deviation for each measurement.
Step 3. Uses descriptive activity names to name the activities in the data set
Step 4. Appropriately labels the data set with descriptive activity names.
Step 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Major Steps Implemented on ```run_analysis.R``` Script

* The script needs ```reshapre2``` and ```data.table``` libraries.
* The script load both test and train data sets
* The script load both the features and activity labels.
* The script extract the mean and standard deviation column names and data.
* The script process the data for the training and test parts.
* The script merge two training and test data sets into one final data set.
