=========================================================================================================
##Getting and Cleaning Data > Course Project > run_analysis.R
##The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.
=========================================================================================================

The R script performs the following steps:
1. Packages Used *** install following packages if not already in use ***
2. Set directory
3. Uses descriptive activity names to name the activities in the data set
4. Extracts only the measurements on the mean and standard deviation for each measurement
5. Loads and combines the datasets
6. Merges the training and the test sets to create one data set call merge_data
7. Turn activities & subjects into factors
8. Appropriately labels the data set with descriptive variable names
9. Creates a second, independent tidy data set (tidy_data.txt) with the average of each variable for each activity and each subject