# getting-cleaning-data-project-1

## Project Prompt
The purpose of this project is to demonstrate your ability to collect, work
with, and clean a data set. The goal is to prepare tidy data that can be used
for later analysis. You will be graded by your peers on a series of yes/no
questions related to the project.

You will be required to submit:

1. A tidy data set as described below.
2. A link to a Github repository with your script for performing the analysis.
3. A code book that describes the variables, the data, and any transformations
   or work that you performed to clean up the data called CodeBook.md.

You should also include a README.md in the repo with your scripts. This repo
explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable
computing - see for example [this article][1].
[1]: http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/

Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most
advanced algorithms to attract new users. The data linked to from the course
website represent data collected from the accelerometers from the Samsung
Galaxy S smartphone. A full description is available at the site where the data
was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each
   measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set
   with the average of each variable for each activity and each subject.

Good luck!

## Explanations
There is only one script, `run_analysis.R`, which does the following:

1. Downloads and extracts the data to `./data/` if it is not already there.
2. Reads in the relevant files from the UCI data directory.
3. Follows the steps outlined above for `run_analysis.R`.
4. Writes the resultant dataset to the current working directory as
   `new_dataset.txt`.

There is a codebook, `CodeBook.md`, describing the variables, the data, and the
transformations in `run_analysis.R` used to create the cleaned up dataset,
`new_dataset.txt`.

There is a cleaned dataset, `new_dataset.txt`, which is described in detail in
the codebook, `CodeBook.md`.
