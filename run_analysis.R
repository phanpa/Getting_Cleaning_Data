#Getting and Cleaning Data Course Project
#The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set

	#Packages Used *** install following packages if not already in use ***
	install.packages("dplyr")
	install.packages("reshape2")
	library(dplyr)
	library(reshape2)

	#Set directory
	setwd("~/Learning/Coursera/03 Getting and Cleaning Data/Course Project/")

	#Uses descriptive activity names to name the activities in the data set
	activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
	activity_labels[,2] <- as.character(activity_labels[,2])
	features <- read.table("UCI HAR Dataset/features.txt")
	features[,2] <- as.character(features[,2])

	#Extracts only the measurements on the mean and standard deviation for each measurement
	features_selected <- grep(".*mean.*|.*std.*", features[,2])
	features_selected.names <- features[features_selected,2]
	features_selected.names = gsub('-mean', 'Mean', features_selected.names)
	features_selected.names = gsub('-std', 'Std', features_selected.names)
	features_selected.names <- gsub('[-()]', '', features_selected.names)

	#Loads and combines the datasets
	train_x <- read.table("UCI HAR Dataset/train/X_train.txt")[features_selected]
	train_y <- read.table("UCI HAR Dataset/train/Y_train.txt")
	train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
	train_combine <- cbind(train_subject, train_y, train_x)

	test_x <- read.table("UCI HAR Dataset/test/X_test.txt")[features_selected]
	test_y <- read.table("UCI HAR Dataset/test/Y_test.txt")
	test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
	test_combine <- cbind(test_subject, test_y, test_x)

	#Merges the training and the test sets to create one data set called merge_data
	merge_data <- rbind(train_combine, test_combine)
	colnames(merge_data) <- c("subject", "activity", features_selected.names)

	#Turn activities & subjects into factors
	merge_data$activity <- factor(merge_data$activity, levels = activity_labels[,1], labels = activity_labels[,2])
	merge_data$subject <- as.factor(merge_data$subject)

	#Appropriately labels the data set with descriptive variable names
	merge_data.melted <- melt(merge_data, id = c("subject", "activity"))
	merge_data.mean <- dcast(merge_data.melted, subject + activity ~ variable, mean)

	#Creates a second, independent tidy data set with the average of each variable for each activity and each subject
	write.table(merge_data.mean, "tidy_data.txt", row.names = FALSE, quote = FALSE)