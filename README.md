==================================================================
Getting and Cleaning Data Course Project
Student: Ron Cox
==================================================================

The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. I will be graded by my peers on a series of yes/no questions related to the project. I will be required to submit:

1) a tidy data set as described below
2) a link to a Github repository with my script for performing the analysis
3) a code book that describes the variables, the data, and any transformations or work that I performed to clean up the data called CodeBook.md.

I created one R script called run_analysis.R that does the following. 

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement. 

3. Uses descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive variable names. 

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
==================================================================
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project:

 https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

The getdata_projectfiles_UCI HAR Dataset.zip file has the following structure:

                                                           Name   Length                Date
1                           UCI HAR Dataset/activity_labels.txt       80 2012-10-10 15:55:00
2                                  UCI HAR Dataset/features.txt    15785 2012-10-11 13:41:00
3                             UCI HAR Dataset/features_info.txt     2809 2012-10-15 15:44:00
4                                    UCI HAR Dataset/README.txt     4453 2012-12-10 10:38:00
5                                         UCI HAR Dataset/test/        0 2012-11-29 17:01:00
6                        UCI HAR Dataset/test/Inertial Signals/        0 2012-11-29 17:01:00
7     UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt  6041350 2012-11-29 15:08:00
8     UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt  6041350 2012-11-29 15:08:00
9     UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt  6041350 2012-11-29 15:08:00
10   UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt  6041350 2012-11-29 15:09:00
11   UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt  6041350 2012-11-29 15:09:00
12   UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt  6041350 2012-11-29 15:09:00
13   UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt  6041350 2012-11-29 15:08:00
14   UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt  6041350 2012-11-29 15:09:00
15   UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt  6041350 2012-11-29 15:09:00
16                        UCI HAR Dataset/test/subject_test.txt     7934 2012-11-29 15:09:00
17                              UCI HAR Dataset/test/X_test.txt 26458166 2012-11-29 15:25:00
18                              UCI HAR Dataset/test/y_test.txt     5894 2012-11-29 15:09:00
19                                       UCI HAR Dataset/train/        0 2012-11-29 17:01:00
20                      UCI HAR Dataset/train/Inertial Signals/        0 2012-11-29 17:01:00
21  UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt 15071600 2012-11-29 15:08:00
22  UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt 15071600 2012-11-29 15:08:00
23  UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt 15071600 2012-11-29 15:08:00
24 UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt 15071600 2012-11-29 15:09:00
25 UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt 15071600 2012-11-29 15:09:00
26 UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt 15071600 2012-11-29 15:09:00
27 UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt 15071600 2012-11-29 15:08:00
28 UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt 15071600 2012-11-29 15:08:00
29 UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt 15071600 2012-11-29 15:08:00
30                      UCI HAR Dataset/train/subject_train.txt    20152 2012-11-29 15:09:00
31                            UCI HAR Dataset/train/X_train.txt 66006256 2012-11-29 15:25:00
32                            UCI HAR Dataset/train/y_train.txt    14704 2012-11-29 15:09:00

The following files will be extracted from the zip file and loaded into the project using the
corresponding index illustrated above:

             1 = activity_labels.txt
             2 = features.txt
             16 = subject_test.txt
             17 = X_test.txt
             18 = y_test.txt
             30 = subject_train.txt
             31 = X_train.txt
             32 = y_train.txt
==================================================================
File Descriptions

- activity_labels.txt: Links the class labels with their activity name.
- features.txt: List of all features.
- subject_test.txt: Subjects in the test set.
- X_test.txt: Test set.
- y_test.txt: Test labels.
- subject_train.txt: Subjects in the train set.
- X_train.txt: Training set.
- y_train.txt: Training labels.

NOTE: None of the files above contained column headers (i.e., variable names), but the values
of some files were used as variable names for corresponding files (e.g., 'features.txt' is used as the column header for 'X_test.txt' and 'X_train.txt'). Additional details are available in the code book.
==================================================================

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013. 

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Other Related Publications:
===========================
[2] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra, Jorge L. Reyes-Ortiz.  Energy Efficient Smartphone-Based Activity Recognition using Fixed-Point Arithmetic. Journal of Universal Computer Science. Special Issue in Ambient Assisted Living: Home Care.   Volume 19, Issue 9. May 2013

[3] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. 4th International Workshop of Ambient Assited Living, IWAAL 2012, Vitoria-Gasteiz, Spain, December 3-5, 2012. Proceedings. Lecture Notes in Computer Science 2012, pp 216-223. 

[4] Jorge Luis Reyes-Ortiz, Alessandro Ghio, Xavier Parra-Llanas, Davide Anguita, Joan Cabestany, Andreu Català. Human Activity and Motion Disorder Recognition: Towards Smarter Interactive Cognitive Environments. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.
