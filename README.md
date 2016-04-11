### Introduction
    This readme markdown file describes the R script run_analysis.R used 
    to create the tidydatasets required in the assignment.  

### The run_analysis.R Script
    
    The run_analysis.R script does the following things:

1.  Reads in 8 text files and assigns them to variables
    set the value of the vector:

    subjecttrain <- read.csv("subject_train.txt",header=FALSE)
    subjecttest <- read.csv("subject_test.txt",header=FALSE)
    activity <- read.csv("activity_labels.txt",header=FALSE, sep = " ")
    activitytrain <- read.csv("y_train.txt",header=FALSE)
    activitytest <- read.csv("y_test.txt",header=FALSE)      
    features <- read.csv("features.txt",header=FALSE,sep = " ")
    Vartrain <- read.table("X_train.txt",header=FALSE,sep = "")
    Vartest <- read.table("X_test.txt",header=FALSE,sep = "")

    All of the files being read into R are in the working directory (same
    folder as this R script).

2.  Create the combined activities (names) of train and test data by 
    first joining the activity codes of training and test with the 
    activity names (labels).  Then create a combined activity variable 
    called ‘actcomb’ where the training activity is placed on top of the 
    test activity codes and names previously joined using “plyr” package. 
      
    library(plyr)
    activitytrain <- 
    cbind(activitytrain,join(activitytrain,activity,"V1")) 
    activitytest <- cbind(activitytest,join(activitytest,activity,"V1"))
    actcomb <- rbind(activitytrain,activitytest)

    If you don't have plyr package installed you should use the next line 
    of code and install it - this code assume it is already installed on 
    your machine. If not use ‘install.packages("plyr")’

3.  Now we combine the subject ID’s for training and test data into one 
    column using Rbind:
    
    subject<-rbind(subjecttrain,subjecttest)
    
4.  Then we combine the subject ID’s with the activity names and store
    them in variable ‘subact’ (also add the header names to these two 
    columns of combined data:

    subact <- cbind(subject,actcomb)
    subact <- subact[,c(1,4)]
    names(subact) <- c("Subjectid","Activity")
    
5.  We create 2 indices of columns for selecting header(names) and
    columns – ‘index1’ for reducing the data in X_training and X_test
    files with the means and std as required in the assignment:
    
    index1 <- 
c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,162,163,+
164,165,166,201,202,214,215,227,228,240,241,253,254)
    
    These numbers were derived from the ‘features.txt’ file where all of
    the features created from the pre-processed measurement raw data on 
    the various tri-axial and angular accelerations from the body Samsung 
    devices used in the experiment.

    index2 is used for reducing the first tidy data file to the final
    tidy data file Step 5.
   
    index2 <- c(1,2,3,7,8,9,13,14,15,19,20,21,25,26,27,31,33,35,37,39)

    These index was derived from index1 as it is a subset of index1.

6.  We now construct the variable names from the ‘features.txt’ file.  
    There are 561 names in the file so we created a transposed data frame
    called ‘tf’ of the names and the column number from the raw data.
    The we extracted the names and we kept the variable names as already
    provided – in our opinion using only the time variables provided that
    the ‘t’ representing time were sufficiently descriptive of the values
    contained.        
    
    Transpose the features variable to extract the second row of names 
    for the variables we are extracting:

    tf <- t(features)
    tf <- tf[2,]

    We also then get the variables/header names we need for tidydataset1 
    Using index1.

    headers <- tf[index1]  
    
7.  Extract the X_data columns from the training and test data files 
    (Vartrain and Vartest above) after row binding then into one data
    frame:

    Variables <- rbind(Vartrain, Vartest)
    Variables <- Variables[index1]
    names(Variables) <- headers
    
8.  Tidy data set Step 4. Created by column binding ‘subact’ variable and 
    Variables variable:

    tidydataset1 <- cbind(subact,Variables)
    
9.  Create the final tidy data set for Step 5 using index2 defined above.
    The index is adjusted by 2 as we are adding two columns for subject 
    id’s and activity names:

    index2 <- c(c(1,2),index2+2)
    tidydataset2 <- tidydataset1[index2]
    
10. The last step is to use ‘write.table’ to create the text file to 
    Output the ‘tidydataset2’ rerquested for Step 5: 

    write.table (tidydataset2,file = "tidyout.txt",row.names = FALSE)

    This line is commented out in the run_analysis.R script.  
	
 ###A Partial Sample of the output is shown below:  

 
Subjectid	Activity	tBodyAcc-mean()-X	tBodyAcc-mean()-Y
1	STANDING	0.28858451	-0.020294171
1	STANDING	0.27841883	-0.016410568
1	STANDING	0.27965306	-0.019467156
1	STANDING	0.27917394	-0.026200646
1	STANDING	0.27662877	-0.016569655
