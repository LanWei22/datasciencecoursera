library(dplyr)
# open the zip files
folder <- "dataset/"
zipFile <- "dataset.zip"
if(!file.exists(folder)) {dir.create(folder)}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,dest=zipFile, mode="wb")
unzip(zipFile, exdir = folder)

# 1. Merges the training and the test sets to create one data set
if (file.exists("dataset/UCI HAR Dataset/")){
  feature_date <- read.table("dataset/UCI HAR Dataset/features.txt",
                             col.names = c("f_id","functions"))
  activity_date <- read.table("dataset/UCI HAR Dataset/activity_labels.txt",
                             col.names = c("a_id","activity"))
  
  subject_test <- read.table("dataset/UCI HAR Dataset/test/subject_test.txt",
                             col.names = "subject")
  subject_train <- read.table("dataset/UCI HAR Dataset/train/subject_train.txt",
                             col.names = "subject")
  subject_data <- rbind(subject_train, subject_test)
  
  X_test <- read.table("dataset/UCI HAR Dataset/test/X_test.txt",
                       col.names = feature_date$functions)
  X_train <- read.table("dataset/UCI HAR Dataset/train/X_train.txt",
                        col.names = feature_date$functions)
  X_data <- rbind(X_train, X_test)
  
  y_test <- read.table("dataset/UCI HAR Dataset/test/y_test.txt",
                             col.names = "a_id")
  y_train <- read.table("dataset/UCI HAR Dataset/train/y_train.txt",
                             col.names = "a_id")
  y_data <- rbind(y_train, y_test)
  
  all_Data <- cbind(subject_data, y_data, X_data)
  
  
  # 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  
  mean_std_data <- all_Data %>% select(subject, a_id, contains("mean"), contains("std"))
  
  # 3. Uses descriptive activity names to name the activities in the data set
  
  new_mean_std_data <- merge(mean_std_data, activity_date, all=TRUE)
  new_mean_std_data <- select(new_mean_std_data, -a_id)
  
  # 4. Appropriately labels the data set with descriptive variable names.
  
  names(new_mean_std_data) <- tolower(names(new_mean_std_data))
  names(new_mean_std_data) <- gsub("[.]", "", names(new_mean_std_data))
  names(new_mean_std_data) <- gsub("acc", "accelerometer", names(new_mean_std_data))
  names(new_mean_std_data) <- gsub("freq", "frequency", names(new_mean_std_data))
  names(new_mean_std_data) <- gsub("^t", "time", names(new_mean_std_data))
  names(new_mean_std_data) <- gsub("^f", "frequency", names(new_mean_std_data))
  names(new_mean_std_data) <- gsub("gyro", "gyroscope", names(new_mean_std_data))
  names(new_mean_std_data) <- gsub("mag", "magnitude", names(new_mean_std_data))
  
  # 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  second_data <- new_mean_std_data %>% group_by(activity, subject)
  second_data <- second_data %>% summarise_all(list(mean))

}

