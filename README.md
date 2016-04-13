### Introduction
    This readme markdown file describes the R script run_analysis.R used 
    to create the tidydatasets required in the assignment.  

### The run_analysis.R Script
    
    The run_analysis.R script does the following things:

1.  Reads in 8 text files and assigns them to variables
    set the value of the vector:

    * subjecttrain <- read.csv("subject_train.txt",header=FALSE)
    * subjecttest <- read.csv("subject_test.txt",header=FALSE)
    * activity <- read.csv("activity_labels.txt",header=FALSE, sep = " ")
    * activitytrain <- read.csv("y_train.txt",header=FALSE)
    * activitytest <- read.csv("y_test.txt",header=FALSE)      
    * features <- read.csv("features.txt",header=FALSE,sep = " ")
    * vartrain <- read.table("X_train.txt",header=FALSE,sep = "")
    * vartest <- read.table("X_test.txt",header=FALSE,sep = "")

    All of the files being read into R are in the working directory (same
    folder as this R script).

2.  Create the combined activities (names) of train and test data by 
    first joining the activity codes of training and test with the 
    activity names (labels).  Then create a combined activity variable 
    called ‘actcomb’ where the training activity is placed on top of the 
    test activity codes and names previously joined using “plyr” package. 
      
    * library(plyr)
    * activitytrain <- 
    * cbind(activitytrain,join(activitytrain,activity,"V1")) 
    * activitytest<- cbind(activitytest,join(activitytest,activity,"V1"))
    * actcomb <- rbind(activitytrain,activitytest)

    If you don't have plyr package installed you should use the next line 
    of code and install it - this code assume it is already installed on 
    your machine. If not use ‘install.packages("plyr")’

3.  Now we combine the subject ID’s for training and test data into one 
    column using ‘rbind’:
    
    * subject<-rbind(subjecttrain,subjecttest)
    
4.  Then we combine the subject ID’s with the activity names and store
    them in variable ‘subact’ (also add the header names to these two 
    columns of combined data:

    * subact <- cbind(subject,actcomb)
    * subact <- subact[,c(1,4)]
    * names(subact) <- c("subjectid","activity")
    

5.  We now construct the variable names from the ‘features.txt’ file.  
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
    and have either 'mean' or 'std' in their name.

    * index1 <- grep("^t.*(mean|std)",tf,value = FALSE)
    * headers <- tf[index1]
        
6.  Extract the X_data columns from the training and test data files 
    (vartrain and vartest above) after row binding then into one data
    frame:

    * variables <- rbind(vartrain, vartest)
    * variables <- variables[index1]
    * names(variables) <- headers
    
7.  Tidy data set Step 4. Created by column binding ‘subact’ variable and 
    Variables variable:

    * tidydataset1 <- cbind(subact,variables)
    
8.  Tidy data set Step 4. created
    * tidydat1 <- cbind(subact,variables)  
    * “tidy data set 1 combining ‘subact’ and ‘variables’”
    
    * library(reshape2)  
    * “need reshape2 package to melt tidydat1”
    
    * id <-1:length(tidydat1[,1])   
    * “create a unique id for each row of tidydat1 (for melt)”
    * tidydat1 <-cbind(id,tidydat1)        
    * “add unique id column to front of tidydat1 before melt”

    * “Melt tidydat1 to put "variables" in rows of data from columns” 
    * “currently using first 3 columns as ‘id.vars’”
    *  tidydat1 <- melt(tidydat1,id.vars = c(1,2,3))
    
    * “Split data into tables/data.frames (40) where each has only one”
    * “observation/value per row” (equivalent to separate tables for
    *  each variable”
    *   
    *  tidydat1 <- split(tidydat1,tidydat1$variable)



9.  Create the final tidy data set for Step 5 - by extracting names with
    ‘mean’ in them from tidydat1 there are 20 data.frames extracted from 
    list object created by split function above (from ‘mean’ in names of
    the list – variable).  
    
    * tidydat2 <- tidydat1[grep("mean",names(tidydat1),value = FALSE)]
    
    You can extract the data.frames from the list by using "ldply"
    function from "plyr" and then recombine them to create one data.frame
    for analysis.  The code below does that as an example.

    * tiddtrecreate <- tidydat2[1:length(names(tidydat2))] 
    * library(dplyr)
    * tiddtrecreate <- ldply(tiddtrecreate, data.frame) %>% select(2:6)
    
    
10. The last step is to use ‘write.table’ to create the text file to 
    output the tidy data set requested for Step 5: 

    * write.table (tidydat2,file = "tidyout.txt",row.names = FALSE)

    This line is commented out in the run_analysis.R script.  
	

 

