##Introduction

The script run_analysis.R performs the 5 steps described in the course assignment.

Data from teh UCI HAR data set was cleaned up by applying several methods of merging different data sets in to a tidy set.  This includes merging data to one table, determining the means, and applying column names.

##Variables

* x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from UCI HAR Dataset.
* merged_data merge the previous datasets, data_train and data_test for further analysis.
* features contains the correct names for the x_data dataset, which are applied to the column names stored in mean_and_std_features, a numeric vector used to extract the desired data.
* A similar approach is taken with activity names through the activities variable.
* tidy.dataset contains the relevant averages which will be later stored in a .txt file. ddply() from the plyr package is used to apply colMeans() and ease the development.
