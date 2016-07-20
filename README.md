 
## Tidy Data Assignmment: run_analysis.R   
#### Author:  Carina Ting   
#### Date: "July 20, 2016"  
 
### Overview
Script "run_analysis.R"" will load and generate the tidy data sets per:  
* Downloads the file and unzips directory structure   
        + url = https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
* Extracts only the measurements on the mean and standard deviation for each measurement.  
        + Pull out column named containing "mean()" and "std()"   
* Uses descriptive activity names to name the activities in the data set  
* Appropriately labels the data set with descriptive variable names (all lowercase)  
* Merges the training and the test sets to create one data set.    
        + dataframe variable name "X"  
        + dataframe csv file "mergedfile.csv" (use read.csv(" mergedfile.csv"))   
* From the data set in step 5, creates a second, independent tidy data set with the average of each variable for each activity and each subject   
        + dataframe variable name "aveX"  
        + dataframe csv file "avemergedfile.csv" (use read.csv("avemergedfile.csv"))        

Requires the following input variables set by user
workingDir<-{desired working path}
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
myzipfile<-{name of zip file that you download to}
extractdir<-{name of subdirectory to extract directory to}

#### Both X and aveX have same column names: aveX is averaged for each subject activty
#####col.num	col.name
1	subjectid  
2	activity  
3	tbodyacc-mean()-x  
4	tbodyacc-mean()-y  
5	tbodyacc-mean()-z  
6	tbodyacc-std()-x  
7	tbodyacc-std()-y  
8	tbodyacc-std()-z  
9	tgravityacc-mean()-x  
10	tgravityacc-mean()-y  
11	tgravityacc-mean()-z  
12	tgravityacc-std()-x  
13	tgravityacc-std()-y  
14	tgravityacc-std()-z  
15	tbodyaccjerk-mean()-x  
16	tbodyaccjerk-mean()-y  
17	tbodyaccjerk-mean()-z  
18	tbodyaccjerk-std()-x  
19	tbodyaccjerk-std()-y  
20	tbodyaccjerk-std()-z  
21	tbodygyro-mean()-x  
22	tbodygyro-mean()-y  
23	tbodygyro-mean()-z  
24	tbodygyro-std()-x  
25	tbodygyro-std()-y  
26	tbodygyro-std()-z  
27	tbodygyrojerk-mean()-x  
28	tbodygyrojerk-mean()-y  
29	tbodygyrojerk-mean()-z  
30	tbodygyrojerk-std()-x  
31	tbodygyrojerk-std()-y  
32	tbodygyrojerk-std()-z  
33	tbodyaccmag-mean()  
34	tbodyaccmag-std()  
35	tgravityaccmag-mean()   
36	tgravityaccmag-std()  
37	tbodyaccjerkmag-mean()  
38	tbodyaccjerkmag-std()  
39	tbodygyromag-mean()  
40	tbodygyromag-std()  
41	tbodygyrojerkmag-mean()  
42	tbodygyrojerkmag-std()  
43	fbodyacc-mean()-x  
44	fbodyacc-mean()-y  
45	fbodyacc-mean()-z  
46	fbodyacc-std()-x  
47	fbodyacc-std()-y  
48	fbodyacc-std()-z  
49	fbodyaccjerk-mean()-x  
50	fbodyaccjerk-mean()-y  
51	fbodyaccjerk-mean()-z  
52	fbodyaccjerk-std()-x  
53	fbodyaccjerk-std()-y  
54	fbodyaccjerk-std()-z  
55	fbodygyro-mean()-x  
56	fbodygyro-mean()-y  
57	fbodygyro-mean()-z  
58	fbodygyro-std()-x  
59	fbodygyro-std()-y
60	fbodygyro-std()-z  
61	fbodyaccmag-mean()  
62	fbodyaccmag-std()  
63	fbodybodyaccjerkmag-mean()  
64	fbodybodyaccjerkmag-std()  
65	fbodybodygyromag-mean()  
66	fbodybodygyromag-std()  
67	fbodybodygyrojerkmag-mean()  
68	fbodybodygyrojerkmag-std()  
	
### subject id	column 1 "subject id"  
integer between 1 and 30 identifying user
### 6 activity types: column 2 "activity'  
1. walking  
2. walking_upstairs  
3. walking_downstairs  
4. sitting  
5. standing  
6. laying 

### Measured data summaries: colunmns 3 through 68     

These are a subset of the data collected from the smart phones sensors for various people performing certain types of ativities  
X: mean and standard deviation for each data sample of sensor output per subject per activity collected data  
aveX: mean over each sample in an activity for each subject corresponding to data described by dataframe X above  

Reference
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones