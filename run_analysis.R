## run_analysis.R   does the following.
## 0 Downloads the file <- https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## 1. Extracts only the measurements on the mean and standard deviation for each measurement.
## 2. Uses descriptive activity names to name the activities in the data set
## 3. Appropriately labels the data set with descriptive variable names: X_test, X_train
## 4. Merges the training and the test sets to create one data set.  variable name "X"
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each 
##    variable for each activity and each subject. aveX
##
## Important variables
## X: datframe of merged test and train data (step 4 above)
## aveX: dataframe with average over each activity for each subect (step 5 above)
## mergedfile: output csv file name with full merged data set
## avemergedfile: output csv filename with average for each subject for each activity
##
##------------------------- Begin user Input
workingDir<-"C:/Users/Carina/Desktop/Coursera_R/Cleaning Data Class"
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
myzipfile<-"mydata.zip"
extractdir<-"wearableData"
mergedfile<-"mergedfile.csv"
avemergedfile<-"avemergedfile.csv"
##------------------------- End user Input
library(plyr)
##
## Download and unpack data of interest in "test" and "train" subdirectories
##
setwd(workingDir)
#download.file(url,myzipfile)
#unzip(myzipfile,exdir=extractdir)
archivedirs<-list.dirs(extractdir)
#archivedirs
dictpath<-paste0(extractdir,"/UCI HAR Dataset")
testpath<-paste0(extractdir,"/UCI HAR Dataset/test")
trainpath<-paste0(extractdir,"/UCI HAR Dataset/train")
dictfiles<-list.files(dictpath)
## dictfiles:[1] "activity_labels.txt" "features.txt"        "features_info.txt"   "README.txt"         
## [5] "test"                "train"  
testfiles<-list.files(testpath)
## testfiles: "Inertial Signals" "subject_test.txt" "X_test.txt"       "y_test.txt"   
trainfiles<-list.files(trainpath)
## trainfiles:  "Inertial Signals"  "subject_train.txt" "X_train.txt"       "y_train.txt" 
##
## Load in dataframes subject_test and subject_train
##
subject_test_file<-paste0(testpath,"/subject_test.txt")
subject_train_file<-paste0(trainpath,"/subject_train.txt")
subject_test<-read.table(subject_test_file,header=FALSE,sep=" ")
subject_train<-read.table(subject_train_file,header=FALSE,sep=" ")
names(subject_test)[1]<-"subjectid"
names(subject_train)[1]<-names(subject_test)[1]
##
## Load in feature information and pull out indices related to mean and std dev
##
feature_file<-paste0(dictpath,"/features.txt")
features<-read.table(feature_file)
features[,2]<-tolower(features[,2])
# --- look for mean and std dev columns
mean_indices<-grep("mean\\()",features[,2])
std_indices<-grep("std\\()",features[,2])
out_indices<-sort.int(c(mean_indices,std_indices))
##
## Load in activity label information
##
act_file<-paste0(dictpath,"/activity_labels.txt")
activities<-read.table(act_file)
activities[,2]<-tolower(activities[,2])
##
## Load in data frame y_test  and y_train and change to labels as given in activity labels
##
y_test_file<-paste0(testpath,"/y_test.txt")
y_train_file<-paste0(trainpath,"/y_train.txt")
y_test<-read.table(y_test_file)
act_test<-data.frame(activities[y_test[,1],2])
names(act_test)[1]<-"activity"
y_train<-read.table(y_train_file,header=FALSE)
act_train<-data.frame(activities[y_train[,1],2])
names(act_train)[1]<-names(act_test)[1]
##
## Load in date frame X_test  and X_train, pull out only mean and std columns
##
X_test_file<-paste0(testpath,"/X_test.txt")
X_train_file<-paste0(trainpath,"/X_train.txt")
X_test<-read.table(X_test_file,header=FALSE)
X_test<-X_test[,out_indices]
names(X_test)<-features[out_indices,2]
X_train<-read.table(X_train_file,header=FALSE)
X_train<-X_train[,out_indices]
names(X_train)<-features[out_indices,2]
##
## Combine Cols for test and train, and combine rows for finished variable X, output file mergedfile
##
X_test<-cbind(subject_test,act_test,X_test)
X_train<-cbind(subject_train,act_train,X_train)
X<-rbind(X_test,X_train)
write.csv(X,file=mergedfile)
##
## Find mean for each subjectid, activity, output averages file: aveX, avemergedfile
##
aveX<-ddply(X,.(subjectid, activity),colwise(mean))
write.csv(aveX,file=avemergedfile)
