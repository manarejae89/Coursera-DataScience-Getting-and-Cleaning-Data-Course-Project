==================================================================
Analysis of Human Activity Recognition Using Smartphones Data Set
==================================================================
Manuel J. Arenas
manarejae@gmail.com
https://sites.google.com/view/manueljarenas/
==================================================================

Data Set description:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data Set download link:
http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip

======================================
---------------------
run_analysis.R output:
---------------------
data: merge data from Train and Test experiments

groupdata: "data" grouped by Subject Id and Training Type

summgroupdata: summary of "groupdata" with the mean of each measurement

activity_labels: levels and labels for Training Type

features: labels for measurements

---------------------
run_analysis.R do as follows:
---------------------
# Load "dplyr" library

# Download Data Set

###
# Import the following data with the "read.table" command from the "UCI HAR Dataset" folder
###
# Import Activity Labels
# Import Features [names]
# Import Train Data [SubjectId, TestLabel, X-Measurements]
# Import Test Data  [SubjectId, TestLabel, X-Measurements]

###
# 1. Merges the training and the test sets to create one data set.
###
# "Merge" Train and Test Data with "rbind" command
# Remove unnecessary imported Data
# "Merge" all data with "cbind" command
# Remove unnecessary imported Data
# Renaming of variables by column (usage of "features")

###
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
###
# Using "grep" command

###
# 3. Uses descriptive activity names to name the activities in the data set
###
# TestLabel -> Change numberic to string labels from "activity_labels"

###
# 4. Appropriately labels the data set with descriptive variable names
###
# Nicer variable names in "data" (remove "()" and "-") with "gsub" command

###
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
###

# Group data by SubjectId and TestLabel with "group_by" command
# Summarize data with the mean of each feature/measurement column with "summarize" command
# Cleaning column names (remove "_1") with "gsub" command



