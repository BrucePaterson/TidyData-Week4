### Introduction

This codebook does the following:  
* Describes the input or raw data for this assignment.  
* The variables we used to create the tidy data set required for the
assignment. The process used to take the variables and put them in
tidy data format.
* The tidy data format resulting from the previous steps.
*   A description of the resulting variables and format, and,
*   Any assumptions made along the way regarding the data.

### 1. Input or Raw Data

The complete description of the raw data is provided in the following link:(https://github.com/BrucePaterson/TidyData-Week4/blob/master/README.txt)

We read in the following input files as per the code that follows:
* subjecttrain <- read.csv("subject_train.txt",header=FALSE)
* subjecttest <- read.csv("subject_test.txt",header=FALSE)
* activity <- read.csv("activity_labels.txt",header=FALSE, sep = " ")
* activitytrain <- read.csv("y_train.txt",header=FALSE)
* activitytest <- read.csv("y_test.txt",header=FALSE)      
* features <- read.csv("features.txt",header=FALSE,sep = " ")
* vartrain <- read.table("X_train.txt",header=FALSE,sep = "")
* vartest <- read.table("X_test.txt",header=FALSE,sep = "")

‘subject’ (‘train or test’) is the 1 to 30 identifier of people participating in the study.  Train is the training set and Test is the test set of data.

‘activity’ are labels or names of activity in the study – 6 of them.
 
‘activity’ (‘train or test’) are identifiers from 1 to 6.

‘features’ are the 561 features created from the measurements in the study.  These were created using pre-processing of the raw data.

‘vartrain’ and ‘vartest’ are the 561 features as measured/pre-processed for the study.  Train is the training set (7352 rows of observations) and Test (2947 rows of observations) is the test set of data.  Combined you have 10,299 rows of 561 features.

### 2. Variables Used and Process (Tidy Data Set Creation)      

Create the combined activities (names) of train and test data by 
first joining the activity codes of training and test with the 
activity names (labels).  Then create a combined activity variable 
called ‘actcomb’ where the training activity is placed on top of the 
test activity codes and names previously joined using “plyr” package. 
      
* activitytrain <- 
  cbind(activitytrain,join(activitytrain,activity,"V1")) 
* activitytest<- cbind(activitytest,join(activitytest,activity,"V1"))
* actcomb <- rbind(activitytrain,activitytest)

   
Now we combine the subject ID’s for training and test data into one 
column:
    
* subject<-rbind(subjecttrain,subjecttest)

Then we combine the subject ID’s with the activity names and store
them in variable ‘subact’ (also add the header names to these two 
columns of combined data:

* subact <- cbind(subject,actcomb)
* subact <- subact[,c(1,4)]
* names(subact) <- c("subjectid","activity")
    

We now construct the variable names from the ‘features.txt’ file.  
There are 561 names in the file so we created a transposed data frame
called ‘tf’ of the names and the column number from the raw data.
The we extracted the names and we kept the variable names as already
provided – in our opinion using only the time variables provided that
the ‘t’ representing time were sufficiently descriptive of the values
contained.        
    
Transpose the features variable to extract the second row of names 
for the variables we are extracting:

* tf <- t(features)
* tf <- tf[2,]

Create index1 using a regular expression where names start with 't' 
and have either 'mean' or 'std' in their name.  Only extracted the ‘time’ domain variables – beginning with ‘t’ (assuming frequency domain variables are not helpful without complete understanding of the FFT process). 

* index1 <- grep("^t.*(mean|std)",tf,value = FALSE)
* headers <- tf[index1]
        
Extract the X_data columns from the training and test data files 
(vartrain and vartest above) after row binding then into one data
frame:

* variables <- rbind(vartrain, vartest)
* variables <- variables[index1]
* names(variables) <- headers
    
Tidy data set Step 4. Created by column binding ‘subact’ variable and 
‘variables’ variable:

* tidydataset1 <- cbind(subact,variables)

Tidy data set Step 4. Is now created:
* tidydat1 <- cbind(subact,variables)  
 ‘tidy data set 1 combining ‘subact’ and ‘variables’
* id <-1:length(tidydat1[,1])   
 ‘create a unique id for each row of tidydat1 (for melt)’
* tidydat1 <-cbind(id,tidydat1)        
 ‘add unique id column to front of tidydat1 before melt’

Melt tidydat1 to put "variables" in rows of data from columns 
currently using first 3 columns as ‘id.vars’

* tidydat1 <- melt(tidydat1,id.vars = c(1,2,3))
    
Split data into tables/data.frames (40) where each has only one
observation/value per row (equivalent to separate tables for
each variable
       
* tidydat1 <- split(tidydat1,tidydat1$variable)

###3. Tidy Data Set Output for Assignment

Create the final tidy data set for Step 5 - by extracting names with
‘mean’ in them from tidydat1 there are 20 data.frames extracted from 
list object created by split function above (from ‘mean’ in names of
the list – variable).  
    
* tidydat2 <- tidydat1[grep("mean",names(tidydat1),value = FALSE)]
    
You can extract the data.frames from the list by using "ldply"
function from "plyr" and then recombine them to create one data.frame
for analysis.  The code below does that as an example:

* tiddtrecreate <- tidydat2[1:length(names(tidydat2))] 
* tiddtrecreate <- ldply(tiddtrecreate, data.frame) %>% select(2:6)
    
The list class object created with the split command and reduced for
‘mean’ values requested – ‘tidydat2’ is what is written as a text
file for upload.  You can use the ‘tiddtrecreate’ variable from
running script to check output.
 
The output is:   ‘id’  ‘subject’  ‘activity’  ‘variable’  ‘value’ 
For each of the 20 variables:

*  tBodyAcc-mean()-X
*  tBodyAcc-mean()-Y
*  tBodyAcc-mean()-Z
*  tGravityAcc-mean()-X
*  tGravityAcc-mean()-Y
*  tGravityAcc-mean()-Z
*  tBodyAccJerk-mean()-X
*  tBodyAccJerk-mean()-Y
*  tBodyAccJerk-mean()-Z
*  tBodyGyro-mean()-X
*  tBodyGyro-mean()-Y
*  tBodyGyro-mean()-Z
*  tBodyGyroJerk-mean()-X
*  tBodyGyroJerk-mean()-Y
*  tBodyGyroJerk-mean()-Z
*  tBodyAccMag-mean()
*  tGravityAccMag-mean()
*  tBodyAccJerkMag-mean()
*  tBodyGyroMag-mean()
*  tBodyGyroJerkMag-mean()

We didn’t change the variable names as they seemed descriptive enough for this exercise. The use of the word “We” was preferred over the use of the word “I” thoughout this exercise.

