run_analysis <- function() {
  
  ##  ****************************************************************************************************************
  ##  This script:
  ##  1. Merges the training and the test sets to create one data set.
  ##  2. Extracts only the measurements on the mean and standard deviation for each measurement.
  ##  3. Uses descriptive activity names to name the activities in the data set
  ##  4. Appropriately labels the data set with descriptive variable names.
  ##  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
  ##     for each activity and each subject.
  ##  ****************************************************************************************************************
  
  
  ##  checks for needed packages and install them if not already installed
  if (!require("data.table")) {
    install.packages("data.table")
  }
  
  if (!require("reshape2")) {
    install.packages("reshape2")
  }
  
  ##  loads needed libraries
  require("data.table")
  require("reshape2")

  
  ##  ------------------------------------------------------------------------------------------------------------------------------------------------
  ##  imports lookup data
  ##  ------------------------------------------------------------------------------------------------------------------------------------------------
  activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)[,2]        ## import activity labels.
  features <- read.table("./UCI HAR Dataset/features.txt", header = FALSE)[,2]                      ## import data column names.
  extract_features <- grepl("mean|std", features)                                   ## mask to extract only the mean and standard deviation for each measurement.
  
  ##  ------------------------------------------------------------------------------------------------------------------------------------------------
  ##  imports and processes test data
  ##  ------------------------------------------------------------------------------------------------------------------------------------------------
  X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)                         ## import X_test data.
  y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)                         ## import y_test data.
  subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)             ## import subject_test data.
  names(X_test) <- features                                                         ## set the names of x_test data frame
  X_test = X_test[,extract_features]                                                ## only considering the the extract_features(mean & std)
  y_test[,2] = activity_labels[y_test[,1]]                                          ## creates new column on y_test
  names(y_test) = c("ActivityID", "ActivityLabel")                                  ## set the names of y_test data frame
  names(subject_test) = "subject"                                                   ## set the name of subject_test data frame
  test_data <- cbind(as.data.table(subject_test), y_test, X_test)                   ## Bind test_data data
  
  
  ##  ------------------------------------------------------------------------------------------------------------------------------------------------
  ##  imports and processes train data
  ##  ------------------------------------------------------------------------------------------------------------------------------------------------
  X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)                      ## import X_train data.
  y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)                      ## import y_train data.
  subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)    ## import subject_train data.
  names(X_train) = features                                                         ## set the names of x_train data frame
  X_train = X_train[,extract_features]                                              ## only considering the the extract_features(mean & std)
  y_train[,2] = activity_labels[y_train[,1]]                                        ## creates new column in y_train
  names(y_train) = c("ActivityID", "ActivityLabel")                                 ## set the names of y_train data frame
  names(subject_train) = "subject"                                                  ## set the name of the subject_train data frame            
  train_data <- cbind(as.data.table(subject_train), y_train, X_train)               ## Bind train_data data
  
  ##  ------------------------------------------------------------------------------------------------------------------------------------------------
  ##  Merge the two data frames test_data and train_data
  ##  ------------------------------------------------------------------------------------------------------------------------------------------------
  merged_data = rbind(test_data, train_data)
  
  id_labels   = c("subject", "ActivityID", "ActivityLabel")                         ## set variables to be used as identifiers in melt
  data_labels = setdiff(colnames(merged_data), id_labels)                           ## gets colnames in merged_data but not in id_labels
  melt_data      = melt(merged_data, id = id_labels, measure.vars = data_labels)    ## melts a data frame with id_lables as identifier variables and data_labels as measured variables
  final_data_set   = dcast(melt_data, subject + ActivityLabel ~ variable, mean)     ## using dcast function to apply mean function to melt_data returning the final data set
  
  write.table(final_data_set, file = "./analysis.txt", row.names = FALSE)          ##  writes final data set to working directory
}