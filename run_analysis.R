###############################################################################
### run_analysis.R
###
### For the Getting and Cleaning Data Coursera course project.
### See README.md for project details and requirements.
###############################################################################
library(plyr)
library(data.table)


###############################################################################
### Some preparation
###############################################################################
# Set up a data directory.
if (!file.exists("data")) {
    print("Creating data directory.")
    dir.create("data")
}

# From the UC Irvine Machine Learning group.
# "Human Activity Recognition Using Smartphones Data Set" [60MB]
dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipRL <- "./data/dataset.zip"
dataRL <-"./data/UCI HAR Dataset"

# Download if necessary.
if (!file.exists(zipRL)) {
    download.file(dataURL, destfile=zipRL, method="curl")
} else {
    cat("Data file:", zipRL, "exists\n")
}

# Unzip if necessary.
if (!file.exists(dataRL)) {
    unzip(zipRL, exdir="./data/.")
} else {
    print("Data already unzipped.")
}

# Read in activity labels.
activity_labels <- fread("./data/UCI HAR Dataset/activity_labels.txt")
setnames(activity_labels, 1:2, c("label", "activity"))
activity_labels$activity <- as.factor(activity_labels$activity)

# Read in feature labels.
feature_labels <- fread("./data/UCI HAR Dataset/features.txt")

# fread seems to break on the big ones...
# Read in the train data.
train_X <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
train_s <- fread("./data/UCI HAR Dataset/train/subject_train.txt")

# Read in the test data.
test_X <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
test_s <- fread("./data/UCI HAR Dataset/test/subject_test.txt")


###############################################################################
### 1. Merge the training and test sets to create one dataset.
###############################################################################
one_dataset <- rbind(train_X, test_X)


###############################################################################
### 2. Extracts only the measurements on the mean and std for each measurement.
###############################################################################
# We only care about the features with mean() and std().
means <- feature_labels[grepl("mean\\(\\)", feature_labels$V2),]
stdev <- feature_labels[grepl("std\\(\\)", feature_labels$V2),]

# Extract those indices and put them back in order.
care_f <- arrange(rbind(means, stdev), V1)

# Make the subset.
one_dataset <- one_dataset[, care_f$V1]


###############################################################################
### 3. Uses descriptive activity names to name the activites in the data set.
###############################################################################
# To get descriptive activity names, we first need to know the actual activity
# for the measurement, i.e. the label. Append the labels to the data set.
labels <- rbind(train_y, test_y)
one_dataset$label <- labels$V1

# Join our labels to their descriptive activity names.
one_dataset <- join(one_dataset, activity_labels)

# Now we don't need the label, since we have the descriptive activity names.
one_dataset$label <- NULL


###############################################################################
### 4. Appropriately labels the data set with descriptive variable names.
###############################################################################
setnames(one_dataset, 1:length(care_f$V1), care_f$V2)


###############################################################################
### 5. New dataset with average of each variable for each activity and subject.
###############################################################################
# Now we care about the subject, so add that in.
subjects <- rbind(train_s, test_s)
one_dataset$subject <- subjects$V1

# Helper function.
# Since activity and subject don't make sense to get the means for, do it for
# everything else and then append them back. This function encapsulates this
# logic so we can later apply it towards every group of subject by activity.
# We expect that the input data has already been split by subject and by
# activity. So, then for each subject/activity, get the average of the
# features (1:66), and re-append the activity and subject (67:68) back in.
do_means_append <- function (sub_act) {
    tmp <- sub_act[, 1:66]
    cbind(t(data.frame(colMeans(tmp))), sub_act[1, 67:68])
}

# Helper function.
# This takes the data for a particular subject and splits the data by activity,
# then calls the function above to get the means for that subject and activity,
# binding all the results back into one dataframe.
calc_all_sub_act_bind <- function (subject) {
    do.call(rbind,
            lapply(split(subject, subject$activity),
                   do_means_append))
}

# Actual work.
split_by_subject <- split(one_dataset, one_dataset$subject)
new_dataset <- do.call(rbind, lapply(split_by_subject, calc_all_sub_act_bind))

# Save it to a file.
write.table(new_dataset, file="./new_dataset.txt", row.name=FALSE)


zz <- function() {source("run_analysis.R")}
