Code Book
==========

## Pre Analysis
This script will check if the data file is present in your working directory. (If not, will download and unzip the file)

## 1. Read data and Merge
* x_test : values of variables of test data
* x_train : values of variables of train data
* x : bind of x_train and x_test
* y_test : activity ID of test data
* y_train : activity ID of train data
* y : bind of y_train and y_test
* sub_test : subject IDs for test
* sub_train  : subject IDs for train
* sub : bind of sub_train and sub_test

* dataSet : bind of X_train and X_test

## 2. Extract only mean() and std()
Create a vector of only mean and std labels, then use the vector to subset x.
* features : table of features
* mean_std_set : a vector of only mean and std 
* x_mean_std : values of variables of only mean and std

## 3. Activity names
Merge activity name and table y into new table y
* act_label : Description of activity IDs in y_test and y_train
* y : table y changed after merging

## 4. Appropriately labels the data set with descriptive variable names.
* dataset : combined data of sub, y, x_mean_std

## 5. Create tidy table
* baseData : melted tall and skinny dataSet
* secondDataset : casete baseData which has means of each variables