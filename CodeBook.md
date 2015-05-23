# Code Book for `new_dataset.txt`


## Reading the data
The cleaned dataset which can be read into R, and viewed as follows.

```R
data <- read.table("new_dataset.txt", header=T)
View(data)
```


## About the data
The cleaned data is based off of the UC Irvine Human Activity Recognition Using
Smartphones Data Set. To create the data we follow the following steps

1. Merge the training and test data into one data frame.
2. Drop all the columns that do not involve the mean or std.
3. Add in label and subject columns.
4. Create the cleaned data set by getting the column means, grouped by unique
   subject and activity.

The cleaned dataset thus contains 180 observations (6 activities * 30
subjects/participants), each with 68 variables.

- The first 66 variables are the averages of such values observed for that
  variable for a particular activity/subject pair. These are all numerics.
- The 67th variable is a factor indicating the activity.
- The 68th variable is the interger which indicates the participant.

This is to say that the data present is mostly the mean of means and standard
deviations. I have no understanding of the features beyond this. For a more
detailed review of what these features exactly are, consult the UCI HAR Dataset
`features_info.txt`.
