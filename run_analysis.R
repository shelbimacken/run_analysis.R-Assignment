##Downloads data
library(dplyr)

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")

#unzip
unzip(zipfile="./data/Dataset.zip",exdir="./data")
#create list of files
path <- file.path("./data" , "UCI HAR Dataset")
files<-list.files(path, recursive=TRUE)

#read relevant data into variables
ActivityTestData  <- read.table(file.path(path, "test" , "Y_test.txt" ),header = FALSE)
ActivityTrainData <- read.table(file.path(path, "train", "Y_train.txt"),header = FALSE)
SubjectTrainData <- read.table(file.path(path, "train", "subject_train.txt"),header = FALSE)
SubjectTestData  <- read.table(file.path(path, "test" , "subject_test.txt"),header = FALSE)
FeaturesTestData  <- read.table(file.path(path, "test" , "X_test.txt" ),header = FALSE)
FeaturesTrainData <- read.table(file.path(path, "train", "X_train.txt"),header = FALSE)
FeaturesNamesData <- read.table(file.path(path, "features.txt"),head=FALSE)

#combine data tables by row and rename them

ActivityData<- ActivityTestData %>% 
        add_row(ActivityTrainData) %>%
        rename(activity=V1)

SubjectData<- SubjectTestData %>% 
        add_row(SubjectTrainData) %>%
        rename(subject= V1)

FeaturesData<- FeaturesTestData %>%
        add_row(FeaturesTrainData) 
names(FeaturesData)<- FeaturesNamesData$V2


#combine the data sets and select only means and std
mergedData<-ActivityData %>%
        bind_cols(SubjectData, FeaturesData) %>%
        select(activity, subject, contains("mean()"), contains("std()"))

#rename the activities
mergedData$activity[mergedData$activity == 1] <- "WALKING"
mergedData$activity[mergedData$activity == 2] <- "WALKING_UPSTAIRS"
mergedData$activity[mergedData$activity == 3] <- "WALKING_DOWNSTAIRS"
mergedData$activity[mergedData$activity == 4] <- "SITTING"
mergedData$activity[mergedData$activity == 5] <- "STANDING"
mergedData$activity[mergedData$activity == 6] <- "LAYING"

#appropriately label data set with descriptive variable names
names(mergedData)<- gsub("^t", "Time", names(mergedData))
names(mergedData)<- gsub("^f", "Frequency", names(mergedData))
names(mergedData)<- gsub("Acc", "Accelerometer", names(mergedData))
names(mergedData)<- gsub("Gyro", "Gyroscope", names(mergedData))
names(mergedData) <- gsub("Mag", "Magnitude", names(mergedData))
names(mergedData)<- gsub("BodyBody", "Body", names(mergedData))


#Create a second data set with average of each variable for each activity and subject

mean_Data<-mergedData%>% 
        group_by(activity, subject) %>% #Groups the activity and subject variables together in the table
        summarize_all(list(mean)) #Creates new data set with average of each variable

write.table(mean_Data, file= "tidyData.txt", row.names = FALSE)