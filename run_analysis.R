
  # Setup working directory
    setwd("D:/R Folder/data")
  
  #Download the file and store in directory  
    temp <- "D:/R Folder/data/data_set.zip"
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp)
    
  #Unzip the file  
    file_unzip <- unzip(temp)
  
  # Get the Data in R : Getting list of unziped file from "UCHI HAR dataset"  
    file_rf <- file.path("D:/R Folder/data","UCI HAR dataset")
    files <- list.files(file_rf,recursive = TRUE)
    
  # Reading data from files into variable  
    data_activity_test_Y <- read.table("./UCI HAR dataset/test/y_test.txt")
    data_activity_train_Y <- read.table("./UCI HAR dataset/train/y_train.txt")
    
    data_feature_test_X <- read.table("D:/R Folder/data/UCI HAR dataset/test/X_test.txt")
    data_feature_train_X <- read.table("D:/R Folder/data/UCI HAR dataset/train/X_train.txt")
    
    data_activity_test_subject <- read.table("D:/R Folder/data/UCI HAR dataset/test/subject_test.txt")
    data_activity_train_subject <- read.table("./UCI HAR dataset/train/subject_train.txt")
    
  # binding row by using rbind   
    data_subject <- rbind(data_activity_train_subject,data_activity_test_subject)
    data_activity <- rbind(data_activity_train_Y,data_activity_test_Y)
    data_feature <- rbind(data_feature_train_X, data_feature_test_X)
    
  #set_variable  
    names(data_subject) <- c("subject")
    names(data_activity) <- c("activity")
    dataFeaturesNames <- read.table(file.path(file_rf, "features.txt"),head=FALSE)
    names(data_feature) <- dataFeaturesNames$V2  
    
  # Combine Column by using cbind  
    dataCombine <- cbind(data_subject, data_activity)
    all_data <- cbind(data_feature, dataCombine)
    
  # Subset Name of Features by measurements on the mean and standard deviation  
    sub_dataFeaturesNames <- dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]
    
  # Subset the data frame Data by seleted names of Features
    selectedNames <- c(as.character(sub_dataFeaturesNames), "subject", "activity" )
    all_data <- subset(all_data,select=selectedNames)
    
  # Read descriptive activity names from ?activity_labels.txt  
    activityLabels <- read.table(file.path(file_rf, "activity_labels.txt"),header = FALSE)
    
  #Appropriately labels the data set with descriptive variable names
    names(all_data) <- gsub("^t", "time", names(all_data))
    names(all_data) <- gsub("^f", "frequency", names(all_data))
    names(all_data) <- gsub("Acc", "Accelerometer", names(all_data))
    names(all_data) <- gsub("Gyro", "Gyroscope", names(all_data))
    names(all_data) <- gsub("Mag", "Magnitude", names(all_data))
    names(all_data) <- gsub("BodyBody", "Body", names(all_data))
    
  # In this part,a second, independent tidy data set will be created with the average of each variable for each activity and each subject  
    library(plyr)
    Data2 <- aggregate(. ~subject + activity, all_data, mean)
    Data2 <- Data2[order(Data2$subject,Data2$activity),]
    write.table(Data2, file = "tidydata.txt",row.name=FALSE)
