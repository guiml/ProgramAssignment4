---
title: "Programming Assignment 4"
author: "Guilherme Mussoi Louzada"
date: "April 2nd 2016"
---

## Coursera Programming Assignment 4

This assignment consisted in download and apply the steps bellow to the data from an experiments that have been carried out by UCI with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. 

1) Merges the training and the test sets to create one data set.
2) Extracts only the measurements on the mean and standard deviation for each measurement.
3) Uses descriptive activity names to name the activities in the data set
4) Appropriately labels the data set with descriptive variable names.
5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

###Collection of the raw data
The data was dowonloaded from the following link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
... and then unziped to the UCI folder


###Cleaning of the data
The cleaning scripts agregates the different files that contains the separated information:
- 'activity_labels.txt' - Contains the names of each activity
- 'features.txt' - Contains the 561 feature's names described in the dataset files
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

After agregating the information, the script renames the column names to a tidy format, and then summarize and export the information to the file tidy.csv with the average of each variable for each activity and each subject.

##Description of the variables in the tiny_data.txt file
 - Dimensions of the dataset: 10299 records, split into 561 variables 
 
