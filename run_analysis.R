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
    vartrain <- read.table("X_train.txt",header=FALSE,sep = "")
    vartest <- read.table("X_test.txt",header=FALSE,sep = "")

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
    names(subact) <- c("subjectid","activity")
    
    ##Transpose the features variable to extract the second row of names for the variables we are extracting
    ##and use the Index1 to create the names header for both train and test X_data
    tf <- t(features)
    tf <- tf[2,]
    
    ##Create index1 using a regular expression where names start with 't' and have either 'mean' or 'std' in
    ##name.
    index1 <- grep("mean|std",tf,value = FALSE)
    headers <- tf[index1]  
    
    ##Extract the X_data columns from the training and test data files (vartrain and vartest above)
    variables <- rbind(vartrain, vartest)
    variables <- variables[index1]
    names(variables) <- headers
    
    ##Tidy data set Step 4. created:
    tidydat1 <- cbind(subact,variables)  ##tidy data set 1 combining subact and variables
    library(reshape2)                    ##need reshape2 package to melt tidydat1
    id <-1:length(tidydat1[,1])          ##create a unique id for each row of tidydat1 (for melt)
    tidydat1 <-cbind(id,tidydat1)        ##add unique id column to front of tidydat1 before melt
    
    ##Melt tidydat1 to put "variables" in rows of data from columns currently usig first 3 cols as 
    ##id.vars
    tidydat1 <- melt(tidydat1,id.vars = c(1,2,3))
    
    ##Split data into tables/data.frames (40) where each has only one observation/value per row 
    tidydat1 <- split(tidydat1,tidydat1$variable)
    
    
    ##Create the final tidy data set for Step 5: 
    
    ##You can extract the data.frames from the list by using "ldply" function from "plyr" and then
    ##recombine them to create one data.frame for analysis.
    tiddtrecreate <- tidydat1[1:length(names(tidydat1))] 
    library(dplyr)
    tiddtrecreate <- ldply(tiddtrecreate, data.frame) %>% select(2:6)
    
    tidydat2 <- ddply(tiddtrecreate,c("subjectid","activity","variable"),summarise,mean = mean(value))
    
    write.table (tidydat2,file = "tidyout.txt",row.names = FALSE) ##output the tidy data as per Step 5.
    ##instructions as a text file.