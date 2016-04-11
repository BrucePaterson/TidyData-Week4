##R Script to clean and create a tidy data set as per instructions in the assignment
##The first step is to read in the following datasets (first training data and second the test data):
##        1. subject_train.txt
##        2. subject_test.txt
##        3. y_train.txt
##        4. y_test.txt
##        5. X_train.txt
##        6. X_test.txt
##        7. features.txt
##        8. activity_labels.txt

##All of the files being read into R are in the working directory (same folder as this R script).

    subjecttrain <- read.csv("subject_train.txt",header=FALSE)
    subjecttest <- read.csv("subject_test.txt",header=FALSE)
    activity <- read.csv("activity_labels.txt",header=FALSE, sep = " ")
    activitytrain <- read.csv("y_train.txt",header=FALSE)
    activitytest <- read.csv("y_test.txt",header=FALSE)      
    features <- read.csv("features.txt",header=FALSE,sep = " ")
    Vartrain <- read.table("X_train.txt",header=FALSE,sep = "")
    Vartest <- read.table("X_test.txt",header=FALSE,sep = "")

##  If you don't have plyr package installed you should use the next line of code and
##  install it - this code assume it is already installed on your machine.
##  install.packages("plyr")
    ## Create the combined activities (names) of train and test data
  
    library(plyr)
    activitytrain <- cbind(activitytrain,join(activitytrain,activity,"V1")) 
    activitytest <- cbind(activitytest,join(activitytest,activity,"V1"))
    actcomb <- rbind(activitytrain,activitytest)
    
    ##Create the combined subject ids for train and test data
    subject<-rbind(subjecttrain,subjecttest)
    
    ##Create the combined Subject ids with the activity names and add their names
    subact <- cbind(subject,actcomb)
    subact <- subact[,c(1,4)]
    names(subact) <- c("Subjectid","Activity")
    
    ##Index1 for reducing the X_data to cols required (index1)
    index1 <- c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,162,163,+
                 164,165,166,201,202,214,215,227,228,240,241,253,254)
    
    ##Index2 for reducing the first tidy data file to the final tidy data file Step 5.
    index2 <- c(1,2,3,7,8,9,13,14,15,19,20,21,25,26,27,31,33,35,37,39)
    
    ##Transpose the features variable to extract the second row of names for the variables we are extracting
    ##and use the Index1 to create the names header for both train and test X_data
    tf <- t(features)
    tf <- tf[2,]
    headers <- tf[index1]  
    
    ##Extract the X_data columns from the training and test data files (VArtrain and Vartest above)
    Variables <- rbind(Vartrain, Vartest)
    Variables <- Variables[index1]
    names(Variables) <- headers
    
    ##Tidy data set Step 4. created
    tidydataset1 <- cbind(subact,Variables)
    
    ##Create the final tidy data set for Step 5.
    index2 <- c(c(1,2),index2+2)
    tidydataset2 <- tidydataset1[index2]
    
##  write.table (tidydataset2,file = "tidyout.txt",row.names = FALSE) 
    
