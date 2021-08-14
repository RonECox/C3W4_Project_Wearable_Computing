
# Github URL: https://github.com/RonECox/C3W4_Project_Wearable_Computing
# Project Data: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

# You should create one R script called run_analysis.R that does the following. 
# 
# 1 (Done) - Merges the training and the test sets to create one data set.
# 2 (Done) - Extracts only the measurements on the mean and standard deviation for each 
#     measurement. 
# 3 (Done) - Uses descriptive activity names to name the activities in the data set
# 4 (Done) - Appropriately labels the data set with descriptive variable names. 
# 5 - From the data set in step 4, creates a second, independent tidy data set 
#     with the average of each variable for each activity and each subject.

# Load necessary libraries
library(dplyr)
library(dataMaid)

# Create a temporary file to store the downloaded zip file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
temp <- tempfile()
download.file(fileUrl, temp)

# Get a list of the files in the zip file
zipFiles <- unzip(zipfile = temp, list = TRUE)

## The following files will be loaded into the project using the corresponding index
## of zipFiles:
##              1 = activity_labels.txt
##              2 = features.txt
##              16 = subject_test.txt
##              17 = X_test.txt
##              18 = y_test.txt
##              30 = subject_train.txt
##              31 = X_train.txt
##              32 = y_train.txt


# Read in activity_labels.txt
activityLabels <- read.csv(unz(temp, zipFiles$Name[1]), 
                           header = FALSE, sep = "", 
                           col.names = c("ActivityCode", "Activity"))
# Read in features.txt
features <- read.csv(unz(temp, zipFiles$Name[2]),
                     header = FALSE, sep = "", 
                     col.names = c("FeatureCode", "Feature"))

# Read each of the three data sets related to testing: subject_test.txt, X_test.txt,
# and y_test.txt
testSubjects <- read.csv(unz(temp, zipFiles$Name[16]), 
                         header = FALSE, col.names = "Subjects")

testSet <- read.csv(unz(temp, zipFiles$Name[17]), 
                    header = FALSE, sep = "") #Use "features" for column names

activityLabels_test <- read.csv(unz(temp, zipFiles$Name[18]), 
                                header = FALSE, col.names = "Activity")

# Read each of the three data sets related to training: subject_train.txt, X_train.txt,
# and y_train.txt
trainSubjects <- read.csv(unz(temp, zipFiles$Name[30]),
                          header = FALSE, col.names = "Subjects")

trainSet <- read.csv(unz(temp, zipFiles$Name[31]),
                     header = FALSE, sep = "") #Use "features" for column names

activityLabels_train <- read.csv(unz(temp, zipFiles$Name[32]),
                                 header = FALSE, col.names = "Activity")

# Close the connection to the temporary file
unlink(temp)

# Use the values from the features data set to establish column names for testSet and trainSet
names(testSet) <- features$Feature
names(trainSet) <- features$Feature

# Identify all values in features data set that contains the string 'mean' or 'std'
targetedFeatures <- features %>% filter(grepl("mean|std", Feature))

# Filter out all columns in testSet and trainSet where the variable name does not include
# the string 'mean' or 'std'
testSet <- testSet[,targetedFeatures$FeatureCode]
trainSet <- trainSet[,targetedFeatures$FeatureCode]

# Add activity labels to the test and train data sets
testActivities <- merge(activityLabels, activityLabels_test, by.x = "ActivityCode", 
                        by.y = "Activity", all.y = TRUE)
trainActivities <- merge(activityLabels, activityLabels_train, by.x = "ActivityCode", 
                        by.y = "Activity", all.y = TRUE)

# Add new variable, dataType, to test and train data sets
testActivities <- mutate(testActivities, DataType = "Test")
trainActivities <- mutate(trainActivities, DataType = "Train")

# Combine the training related data sets into a unified data frame
trainingData <- cbind(trainSubjects, trainActivities, trainSet)

# Combine the test related data sets into a unified data frame
testData <- cbind(testSubjects, testActivities, testSet)

# Combine the training and test data sets into a single data frame
combinedData <- rbind(trainingData, testData)

# Remove the ActivityCode variable
combinedData <- select(combinedData, -ActivityCode)

# Calculate the mean of all measurement rows by subject and activity
tidyData <- combinedData %>%
        select(-DataType) %>%
        group_by(Subjects,Activity) %>% 
        summarise(
                across(.cols = everything(), mean, .names = "mean_{.col}"),
                .groups = "keep")

# Write out tidyData data set to TidyData.csv
write.table(tidyData, file = "./TidyData_v1.csv", sep = ",", row.names = FALSE)

print(tidyData)