### Introduction
This codebook does the following:
1. describes the input or raw data for this assignment.  
2. The variables we used to create the tidy data set required for the assignment.
3. The process used to take the variables and put them in tidy data format.
4. The tidy data format resulting from the previous steps.
a. A description of the resulting variables and format.
b. Any assumptions made along the way regarding the data.

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

     



 










### Input or Raw Data









### Assignment: Caching the Inverse of a Matrix

Matrix inversion is usually a costly computation and there may be some
benefit to caching the inverse of a matrix rather than computing it
repeatedly (there are also alternatives to matrix inversion that we will
not discuss here). Your assignment is to write a pair of functions that
cache the inverse of a matrix.

Write the following functions:

1.  `makeCacheMatrix`: This function creates a special "matrix" object
    that can cache its inverse.
2.  `cacheSolve`: This function computes the inverse of the special
    "matrix" returned by `makeCacheMatrix` above. If the inverse has
    already been calculated (and the matrix has not changed), then
    `cacheSolve` should retrieve the inverse from the cache.

Computing the inverse of a square matrix can be done with the `solve`
function in R. For example, if `X` is a square invertible matrix, then
`solve(X)` returns its inverse.

For this assignment, assume that the matrix supplied is always
invertible.

In order to complete this assignment, you must do the following:

1.  Fork the GitHub repository containing the stub R files at
    [https://github.com/rdpeng/ProgrammingAssignment2](https://github.com/rdpeng/ProgrammingAssignment2)
    to create a copy under your own account.
2.  Clone your forked GitHub repository to your computer so that you can
    edit the files locally on your own machine.
3.  Edit the R file contained in the git repository and place your
    solution in that file (please do not rename the file).
4.  Commit your completed R file into YOUR git repository and push your
    git branch to the GitHub repository under your account.
5.  Submit to Coursera the URL to your GitHub repository that contains
    the completed R code for the assignment.

