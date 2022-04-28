# Load "dplyr" library
library(dplyr)

# Download Data Set
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "dataset.zip")
unzip(zipfile = "dataset.zip")

# Import Activity Labels
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", quote="\"", comment.char="")

# Import Features [names]
features <- read.table("UCI HAR Dataset/features.txt", row.names=1, quote="\"", comment.char="")
names(features)="V1"

# Import Train Data
# SubjectId
SubjectId_train <- read.table("UCI HAR Dataset/train/subject_train.txt", quote="\"", comment.char="")
# TestLabel
TestLabel_train <- read.table("UCI HAR Dataset/train/y_train.txt", quote="\"", comment.char="")
# X - Measurements
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="")

# Import Test Data
# SubjectId
SubjectId_test <- read.table("UCI HAR Dataset/test/subject_test.txt", quote="\"", comment.char="")
# TestLabel
TestLabel_test <- read.table("UCI HAR Dataset/test/y_test.txt", quote="\"", comment.char="")
# X - Measurements
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="")

###
# 1. Merges the training and the test sets to create one data set.
###
# "Merge" Train and Test Data
SubjectId<-rbind(SubjectId_train,SubjectId_test)
TestLabel<-rbind(TestLabel_train,TestLabel_test)
X<-rbind(X_train,X_test)
# Remove unnecessary imported Data
rm(TestLabel_test,SubjectId_test,X_test,TestLabel_train,SubjectId_train,X_train)

# "Merge" all data
data<-cbind(SubjectId,TestLabel,X)
# Remove unnecessary imported Data
rm(SubjectId,TestLabel,X)
# Naming of variables by column (usage of "features")
names(data)=c("SubjectId","TestLabel",features$V1)

###
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
###
meanstdindex <- grep(pattern = 'mean|std', x = names(data))
data<-data[,c(1,2,meanstdindex)]

###
# 3. Uses descriptive activity names to name the activities in the data set
###
# TestLabel -> Change numberic to string labels from "activity_labels"
for (i in activity_labels$V1){
  data$TestLabel <- replace(data$TestLabel, data$TestLabel==activity_labels$V1[i], activity_labels$V2[i])
}

###
# 4. Appropriately labels the data set with descriptive variable names
###
# Nicer variable names in "data" (remove "()" and "-")
names(data)[3:length(data)]<-gsub("[()]|[-]", "", names(data)[3:length(data)])

###
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
###

# Group data by SubjectId and TestLabel
groupdata<-group_by(data, SubjectId, TestLabel)
# Summarize data with the mean of each feature/measurement column
summgroupdata<-summarize(groupdata,across(everything(), list(mean)))
# Cleaning column names (remove "_1")
names(summgroupdata)[3:length(summgroupdata)]<-gsub("[_1]", "", names(summgroupdata)[3:length(summgroupdata)])

# Write result to .txt file
#write.table(summgroupdata,file ="summgroupdata.txt",row.name=FALSE)