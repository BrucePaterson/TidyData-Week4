### Introduction

This codebook does the following:  
* Input or Raw data – described and used for this assignment.  
* The Variables Used and Process (Tidy Data Set Creation) - the variables we used to create the tidy data set required for the assignment.  The process used to take the variables and put them in tidy data format.
* Tidy Data Set Output for Assignment (Step 5) - the tidy data set created from Step 4 - averages by subject and activity and feature (variable) plus any assumptions made along the way regarding the data.

### 1. Input or Raw Data

The complete description of the raw data (including units of measure) is provided in the following:(https://github.com/BrucePaterson/TidyData-Week4/blob/master/README.txt)

We read in the following input files:
* subject_train.txt – subjects in the training data (1 to 30)
* subject_test.txt - subjects in the test data (1 to 30)
* activity_labels.txt – activity labels or names (6 of them)
* y_train.txt – activity codes in training data (1 to 6)
* y_test.txt - activity codes in test data (1 to 6)      
* features.txt – the features names (561)
* X_train.txt – feature values in training data (7352 by 561)
* X_test.txt – feature values in test data (2947 by 561)

‘subject’ (‘train or test’) is the 1 to 30 identifier of people participating in the study.  Train is the training set and Test is the test set of data.

‘activity’ are labels or names of activity in the study – 6 of them:
 WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING 
 
‘activity’ (‘train or test’) are identifiers from 1 to 6.

‘features’ are the 561 features created from the measurements in the study.  These were created by pre-processing the raw data.

Training data 7352 rows of observations and Test 2947 rows of 
Observations - combined you have 10,299 rows of 561 features.

### 2. Variables Used and Process (Tidy Data Set Creation)      

a. Create the combined activities (names) of train and test data by 
first joining the activity codes of training and test with the 
activity names (labels).  Then create a combined activity variable 
called ‘actcomb’ where the training activity is placed on top of the 
test activity codes and names previously joined using “plyr” package and
the “join” function. 
      
b. Now we combine the subject ID’s for training and test data into one 
Column. Then we combine the subject ID’s with the activity names and store them in variable ‘subact’ (also add the header names to these two  
columns of combined data: "subjectid" and "activity".

c. We now construct the variable names from the ‘features.txt’ file.  
There are 561 names in the file so we created a transposed data frame
called ‘tf’ of the names we extracted - we kept the variable names as already provided as sufficiently descriptive.        
    
d. Create and index using a regular expression where names have either 'mean' or 'std' in their name from the ‘tf’ variable with all 561 names.  So we can get the columns of data we want from the training and test data. 
       
e. Extract the X_data columns from the training and test data files after row binding then into one data set with index applied to the X_data files: X_training and X_test after being combined.  We then apply the names to the combined dataset using the same index on the ‘tf’ variable above – called ‘variables’
    
f. Combined ‘subact’ and ‘variables’ into one data frame 

g. We then melt this data frame "variables" (selected features with means and std’s there are 79 of them) in rows of data from columns using the subject ID and activity name as the other column items in the melted data frame we also added a unique id to the first column of the melted data frame for table creation for each combination of subject activity variable and value.

h. Split data into tables/data.frames (79) one for each selected feature where each has only one observation/value per row (equivalent to separate tables for each variable in a database structure – where the data frame is split among the selected features – tidy data set for Step 4.

###3. Tidy Data Set Output for Assignment (Step 5)

You can extract the data.frames from the list object created above ini Step 4. by using "ldply" function from "plyr" and then recombine them to create one data.frame.  The tidy data set for Step 5. requires Averages by Subject by Activity by Variable (feature) - one average value per row (tidy) – “tidydat2” is the name of this tidy date set.
   
    
The “tidydat2” variable is the written to the text file called “tidyout.txt” and uploaded as per instructions for the assignment.
    
The output is: ‘subjectid’  ‘activity’  ‘variable’  ‘mean value’ 
For each of the 79 ‘variables’:

*  tBodyAcc-mean()-X
*  tBodyAcc-mean()-Y
*  tBodyAcc-mean()-Z
*  tBodyAcc-std()-X
*  tBodyAcc-std()-Y
*  tBodyAcc-std()-Z
*  tGravityAcc-mean()-X
*  tGravityAcc-mean()-Y
*  tGravityAcc-mean()-Z
*  tGravityAcc-std()-X
*  tGravityAcc-std()-Y
*  tGravityAcc-std()-Z
*  tBodyAccJerk-mean()-X
*  tBodyAccJerk-mean()-Y
*  tBodyAccJerk-mean()-Z
*  tBodyAccJerk-std()-X
*  tBodyAccJerk-std()-Y
*  tBodyAccJerk-std()-Z
*  tBodyGyro-mean()-X
*  tBodyGyro-mean()-Y
*  tBodyGyro-mean()-Z
*  tBodyGyro-std()-X
*  tBodyGyro-std()-Y
*  tBodyGyro-std()-Z
*  tBodyGyroJerk-mean()-X
*  tBodyGyroJerk-mean()-Y
*  tBodyGyroJerk-mean()-Z
*  tBodyGyroJerk-std()-X
*  tBodyGyroJerk-std()-Y
*  tBodyGyroJerk-std()-Z
*  tBodyAccMag-mean()
*  tBodyAccMag-std()
*  tGravityAccMag-mean()
*  tGravityAccMag-std()
*  tBodyAccJerkMag-mean()
*  tBodyAccJerkMag-std()
*  tBodyGyroMag-mean()
*  tBodyGyroMag-std()
*  tBodyGyroJerkMag-mean()
*  tBodyGyroJerkMag-std()
*  fBodyAcc-mean()-X
*  fBodyAcc-mean()-Y
*  fBodyAcc-mean()-Z
*  fBodyAcc-std()-X
*  fBodyAcc-std()-Y
*  fBodyAcc-std()-Z
*  fBodyAcc-meanFreq()-X
*  fBodyAcc-meanFreq()-Y
*  fBodyAcc-meanFreq()-Z
*  fBodyAccJerk-mean()-X
*  fBodyAccJerk-mean()-Y
*  fBodyAccJerk-mean()-Z
*  fBodyAccJerk-std()-X
*  fBodyAccJerk-std()-Y
*  fBodyAccJerk-std()-Z
*  fBodyAccJerk-meanFreq()-X
*  fBodyAccJerk-meanFreq()-Y
*  fBodyAccJerk-meanFreq()-Z
*  fBodyGyro-mean()-X
*  fBodyGyro-mean()-Y
*  fBodyGyro-mean()-Z
*  fBodyGyro-std()-X
*  fBodyGyro-std()-Y
*  fBodyGyro-std()-Z
*  fBodyGyro-meanFreq()-X
*  fBodyGyro-meanFreq()-Y
*  fBodyGyro-meanFreq()-Z
*  fBodyAccMag-mean()
*  fBodyAccMag-std()
*  fBodyAccMag-meanFreq()
*  fBodyBodyAccJerkMag-mean()
*  fBodyBodyAccJerkMag-std()
*  fBodyBodyAccJerkMag-meanFreq()
*  fBodyBodyGyroMag-mean()
*  fBodyBodyGyroMag-std()
*  fBodyBodyGyroMag-meanFreq()
*  fBodyBodyGyroJerkMag-mean()
*  fBodyBodyGyroJerkMag-std()
*  fBodyBodyGyroJerkMag-meanFreq()

We didn’t change the variable names as they seemed descriptive enough for this exercise. The use of the word “We” was preferred over the use of the word “I” throughout this exercise.

