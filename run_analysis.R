# Data download and read
# string variables for file download
fileName <- "UCIdata.zip"
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dir <- "UCI HAR Dataset"

# File download verification. If file does not exist, download to working directory.
if(!file.exists(fileName)){
  download.file(url,fileName, mode = "wb") 
}

# File unzip verification. If the directory does not exist, unzip the downloaded file.
if(!file.exists(dir)){
  unzip("UCIdata.zip", files = NULL, exdir=".")
}


# Merges the training and the test sets to create one data set.
x_test <- read.table("UCI HAR Dataset\\test\\X_test.txt")
x_train <- read.table("UCI HAR Dataset\\train\\X_train.txt")
x <- rbind(x_train, x_test)

y_test <- read.table("UCI HAR Dataset\\test\\y_test.txt")
y_train <- read.table("UCI HAR Dataset\\train\\y_train.txt")
y <- rbind(y_train, y_test)

sub_test <- read.table("UCI HAR Dataset\\test\\subject_test.txt")
sub_train <- read.table("UCI HAR Dataset\\train\\subject_train.txt")
sub <- rbind(sub_train, sub_test)

# Extracts only the measurements on the mean and standard deviation for each measurement.
features <- read.table("UCI HAR Dataset\\features.txt")
mean_std_set <- grep("mean|std", features[,2])
x_mean_std <- x[,mean_std_set]

# Uses descriptive activity names to name the activities in the data set
act_label <- read.table("UCI HAR Dataset\\activity_labels.txt")
act_label[,2] <- gsub("_"," ",act_label[,2])
y[,1] <- merge(y, act_label, by = "V1")[,2]


# Appropriately labels the data set with descriptive variable names.
names(x_mean_std) <- gsub("\\(|\\)","",features[mean_std_set, 2])
names(y) <- "activity"
names(sub) <- "subject"
dataset <- cbind(sub, y, x_mean_std)

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# check if reshape2 package is installed
if (!"reshape2" %in% installed.packages()) {
  install.packages("reshape2")
}
library("reshape2")
baseData <- melt(dataset,(id.vars=c("subject","activity")))
secondDataset <- dcast(baseData, subject + activity ~ variable, mean)
names(secondDataset)[-c(1:2)] <- paste("[Mean]" , names(secondDataset)[-c(1:2)] )
write.table(secondDataset, "tidy_data.txt", sep = ",")