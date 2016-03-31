## Getting and Cleaning Data Week 4 Assignment:
## Making a "tidy" data set from multiple sets of data from UCI HAR Dataset

library(plyr)
# assuming that you have set your working directory to the directory that contains the file 'UCI HAR Dataset'#


## 1)Merges the training and the test sets to create one data set. 

## Train data set
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
data_train <- data.frame(x_train, y_train, subject_train)

## Test data set 
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
data_test <- data.frame(x_test, y_test, subject_test)

merged_data <-rbind(data_train, data_test)
print("Data is merged!")

#data is now merged by rows into merged_data

## 2)Extracting the measurements on the mean and standard deviation for each measurement.

features <- read.table("UCI HAR Dataset/features.txt")

mean_id <- grep("mean()",features$V2, ignore.case = F) 
std_id <- grep("std()",features$V2, ignore.case = F) 
ids <- c(mean_id, std_id) 
data_meanStd <- cbind(merged_data$V1.1, merged_data$V1.2, merged_data[, ids])

names(data_meanStd) <- c("activity", "subjId", as.character(droplevels(features$V2[ids])))



## 3)Use descriptive activity names to name the activities in the data set.

activity_names <- read.table("UCI HAR Dataset/activity_labels.txt")
data_meanStd$activity <- tolower(activity_names$V2[data_meanStd$activity])

## 4)Appropriately label the data set with descriptive variable names.

clean_features <- names(data_meanStd) 
clean_features <- gsub("-", "", clean_features)
clean_features <- gsub("\\(\\)", "", clean_features)
names(data_meanStd) <- c(clean_features)

## 5)From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

tidy_dataset <- ddply(data_meanStd, c("activity","subjId"), numcolwise(mean))

## 6)Output the "tidy data" to a text file-

write.table(file = "TidyData.txt",x = tidy_dataset, row.names = FALSE)
print("File is created!")

#file TidyData.txt genereated. 

