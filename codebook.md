Getting and Cleaning Data Project

Description

Additional information about the variables, data and transformations used in the course project for the Johns Hopkins Getting and Cleaning Data course.

Source Data

A full description of the data used in this project can be found at The UCI Machine Learning Repository

Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Setting working directory
setwd("D:/R Folder/data")
Download the file and store in directory
Storing data into working directory for further manipulation
temp <- "D:/R Folder/data/data_set.zip"
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp)
Unzip the file
unzip the file using "unzip" function in order to extract all the file which are compressed in zip folder
file_unzip<- unzip(temp)
Get the Data in R : Getting list of unziped file from UCHI HAR dataset
Checking list of files in UCHI HAR dataset folder

     file_rf<- file.path("D:/R Folder/data","UCI HAR dataset")

     files<- list.files(file_rf,recursive = TRUE)
Reading data from files into variable
Reading following files by storing into variable
  features.txt
  activity_labels.txt
  subject_train.txt
  x_train.txt
  y_train.txt
  subject_test.txt
  x_test.txt
  y_test.txt

  data_activity_test_Y<- read.table("./UCI HAR dataset/test/y_test.txt")
  data_activity_train_Y<- read.table("./UCI HAR dataset/train/y_train.txt")

  data_feature_test_X<- read.table("D:/R Folder/data/UCI HAR dataset/test/X_test.txt")
  data_feature_train_X<- read.table("D:/R Folder/data/UCI HAR dataset/train/X_train.txt")

  data_activity_test_subject<- read.table("D:/R Folder/data/UCI HAR dataset/test/subject_test.txt")
  data_activity_train_subject<- read.table("./UCI HAR dataset/train/subject_train.txt")
Binding row by using rbind
By using rbind row of subject_test.txt & subject_train.txt are binded and table created called "data_subject" similarly row of y_test.txt & y_train.txt are binded into one table called "data_activity" and row of X_test.txt & X_train.txt are binded and formed tabled called "data_feature"

data_subject<- rbind(data_activity_train_subject,data_activity_test_subject)
data_activity<- rbind(data_activity_train_Y,data_activity_test_Y)
data_feature<- rbind(data_feature_train_X, data_feature_test_X)
by binding row three tables are created 1) "data_subject" 2) "data_activity" 3) "data_feature"

Set variable
Setting header for variables by uisng "names" function

   names(data_subject)<-c("subject")

   names(data_activity)<-c("activity")

   dataFeaturesNames <- read.table(file.path(file_rf, "features.txt"),head=FALSE)

   names(data_feature)<- dataFeaturesNames$V2  
Combine Column by using cbind
Column for each table created above are combine by using function called "cbind"

  dataCombine <- cbind(data_subject, data_activity)

  all_data<- cbind(data_feature, dataCombine)
Subset Name of Features by measurements on the mean and standard deviation
As we required only column with mean and standard deviation so we created subset of data with same specification

    sub_dataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]
Subset the data frame Data by seleted names of Features
   selectedNames<-c(as.character(sub_dataFeaturesNames), "subject", "activity" )
   all_data<-subset(all_data,select=selectedNames)
Read descriptive activity names from “activity_labels.txt
    Assigning  lables from activity labels.txt files
    activityLabels <- read.table(file.path(file_rf, "activity_labels.txt"),header = FALSE)
Appropriately labels the data set with descriptive variable names
As one of the important component of tidydata is to have descriptive variable name of a variable there for proper labels are assinged to it. Body = related to body movement. Gravity = acceleration of gravity Acc = accelerometer measurement Gyro = gyroscopic measurements Jerk = sudden movement acceleration Mag = magnitude of movement

  names(all_data)<-gsub("^t", "time", names(all_data))
  names(all_data)<-gsub("^f", "frequency", names(all_data))
  names(all_data)<-gsub("Acc", "Accelerometer", names(all_data))
  names(all_data)<-gsub("Gyro", "Gyroscope", names(all_data))
  names(all_data)<-gsub("Mag", "Magnitude", names(all_data))
  names(all_data)<-gsub("BodyBody", "Body", names(all_data))
After converting variable code names to Variable descriptive names we could identify following changes.

# Before

     tBodyAcc-mean()-X          
     tBodyAcc-mean()-Y          
     tBodyAcc-mean()-Z          
     tBodyAcc-std()-X           
     tBodyAcc-std()-Y           
     tBodyAcc-std()-Z           
     tGravityAcc-mean()-X       
     tGravityAcc-mean()-Y       
     tGravityAcc-mean()-Z       
     tGravityAcc-std()-X        
     tGravityAcc-std()-Y        
     tGravityAcc-std()-Z        
     tBodyAccJerk-mean()-X      
     tBodyAccJerk-mean()-Y      
     tBodyAccJerk-mean()-Z      
     tBodyAccJerk-std()-X       
     tBodyAccJerk-std()-Y       
     tBodyAccJerk-std()-Z       
     tBodyGyro-mean()-X         
     tBodyGyro-mean()-Y         
     tBodyGyro-mean()-Z         
     tBodyGyro-std()-X          
     tBodyGyro-std()-Y          
     tBodyGyro-std()-Z          
     tBodyGyroJerk-mean()-X     
     tBodyGyroJerk-mean()-Y     
     tBodyGyroJerk-mean()-Z     
     tBodyGyroJerk-std()-X      
     tBodyGyroJerk-std()-Y      
     tBodyGyroJerk-std()-Z      
     tBodyAccMag-mean()         
     tBodyAccMag-std()          
     tGravityAccMag-mean()      
     tGravityAccMag-std()       
     tBodyAccJerkMag-mean()     
     tBodyAccJerkMag-std()      
     tBodyGyroMag-mean()        
     tBodyGyroMag-std()         
     tBodyGyroJerkMag-mean()    
     tBodyGyroJerkMag-std()     
     fBodyAcc-mean()-X          
     fBodyAcc-mean()-Y          
     fBodyAcc-mean()-Z          
     fBodyAcc-std()-X           
     fBodyAcc-std()-Y           
     fBodyAcc-std()-Z           
     fBodyAccJerk-mean()-X      
     fBodyAccJerk-mean()-Y      
     fBodyAccJerk-mean()-Z      
     fBodyAccJerk-std()-X       
     fBodyAccJerk-std()-Y       
     fBodyAccJerk-std()-Z       
     fBodyGyro-mean()-X         
     fBodyGyro-mean()-Y         
     fBodyGyro-mean()-Z         
     fBodyGyro-std()-X          
     fBodyGyro-std()-Y          
     fBodyGyro-std()-Z          
     fBodyAccMag-mean()         
     fBodyAccMag-std()          
     fBodyBodyAccJerkMag-mean() 
     fBodyBodyAccJerkMag-std()  
     fBodyBodyGyroMag-mean()    
     fBodyBodyGyroMag-std()     
     fBodyBodyGyroJerkMag-mean()
     fBodyBodyGyroJerkMag-std() 
# After

     timeBodyAccelerometer-MEAN()-X                
     timeBodyAccelerometer-MEAN()-Y                
     timeBodyAccelerometer-MEAN()-Z                
     timeBodyAccelerometer-SD()-X                  
     timeBodyAccelerometer-SD()-Y                  
     timeBodyAccelerometer-SD()-Z                  
     timeGravityAccelerometer-MEAN()-X             
     timeGravityAccelerometer-MEAN()-Y             
     timeGravityAccelerometer-MEAN()-Z             
     timeGravityAccelerometer-SD()-X               
     timeGravityAccelerometer-SD()-Y               
     timeGravityAccelerometer-SD()-Z               
     timeBodyAccelerometerJerk-MEAN()-X            
     timeBodyAccelerometerJerk-MEAN()-Y            
     timeBodyAccelerometerJerk-MEAN()-Z            
     timeBodyAccelerometerJerk-SD()-X              
     timeBodyAccelerometerJerk-SD()-Y              
     timeBodyAccelerometerJerk-SD()-Z              
     timeBodyGyroscope-MEAN()-X                    
     timeBodyGyroscope-MEAN()-Y                    
     timeBodyGyroscope-MEAN()-Z                    
     timeBodyGyroscope-SD()-X                      
     timeBodyGyroscope-SD()-Y                      
     timeBodyGyroscope-SD()-Z                      
     timeBodyGyroscopeJerk-MEAN()-X                
     timeBodyGyroscopeJerk-MEAN()-Y                
     timeBodyGyroscopeJerk-MEAN()-Z                
     timeBodyGyroscopeJerk-SD()-X                  
     timeBodyGyroscopeJerk-SD()-Y                  
     timeBodyGyroscopeJerk-SD()-Z                  
     timeBodyAccelerometerMagnitude-MEAN()         
     timeBodyAccelerometerMagnitude-SD()           
     timeGravityAccelerometerMagnitude-MEAN()      
     timeGravityAccelerometerMagnitude-SD()        
     timeBodyAccelerometerJerkMagnitude-MEAN()     
     timeBodyAccelerometerJerkMagnitude-SD()       
     timeBodyGyroscopeMagnitude-MEAN()             
     timeBodyGyroscopeMagnitude-SD()               
     timeBodyGyroscopeJerkMagnitude-MEAN()         
     timeBodyGyroscopeJerkMagnitude-SD()           
     frequencyBodyAccelerometer-MEAN()-X           
     frequencyBodyAccelerometer-MEAN()-Y           
     frequencyBodyAccelerometer-MEAN()-Z           
     frequencyBodyAccelerometer-SD()-X             
     frequencyBodyAccelerometer-SD()-Y             
     frequencyBodyAccelerometer-SD()-Z             
     frequencyBodyAccelerometerJerk-MEAN()-X       
     frequencyBodyAccelerometerJerk-MEAN()-Y       
     frequencyBodyAccelerometerJerk-MEAN()-Z       
     frequencyBodyAccelerometerJerk-SD()-X         
     frequencyBodyAccelerometerJerk-SD()-Y         
     frequencyBodyAccelerometerJerk-SD()-Z         
     frequencyBodyGyroscope-MEAN()-X               
     frequencyBodyGyroscope-MEAN()-Y               
     frequencyBodyGyroscope-MEAN()-Z               
     frequencyBodyGyroscope-SD()-X                 
     frequencyBodyGyroscope-SD()-Y                 
     frequencyBodyGyroscope-SD()-Z                 
     frequencyBodyAccelerometerMagnitude-MEAN()    
     frequencyBodyAccelerometerMagnitude-SD()      
     frequencyBodyAccelerometerJerkMagnitude-MEAN()
     frequencyBodyAccelerometerJerkMagnitude-SD()  
     frequencyBodyGyroscopeMagnitude-MEAN()        
     frequencyBodyGyroscopeMagnitude-SD()          
     frequencyBodyGyroscopeJerkMagnitude-MEAN()    
     frequencyBodyGyroscopeJerkMagnitude-SD()      
In this part,a second, independent tidy data set will be created with the average of each variable for each activity and each subject
  Data2<-aggregate(. ~subject + activity, all_data, mean)
  Data2<-Data2[order(Data2$subject,Data2$activity),]
  write.table(Data2, file = "tidydata.txt",row.name=FALSE)
