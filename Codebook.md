Codebook
================
Shelbi
10/25/2020

## Data Source

This project uses data from the Human Activity Recognition Using
Smartphones Data Set
(<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>).
The data is included in the repo and can also be downloaded as a .zip
here
(<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>).

## About the Data Set

> The experiments have been carried out with a group of 30 volunteers
> within an age bracket of 19-48 years. Each person performed six
> activities (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING,
> STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the
> waist. Using its embedded accelerometer and gyroscope, we captured
> 3-axial linear acceleration and 3-axial angular velocity at a constant
> rate of 50Hz. The experiments have been video-recorded to label the
> data manually. The obtained dataset has been randomly partitioned into
> two sets, where 70% of the volunteers was selected for generating the
> training data and 30% the test data.

> The sensor signals (accelerometer and gyroscope) were pre-processed by
> applying noise filters and then sampled in fixed-width sliding windows
> of 2.56 sec and 50% overlap (128 readings/window). The sensor
> acceleration signal, which has gravitational and body motion
> components, was separated using a Butterworth low-pass filter into
> body acceleration and gravity. The gravitational force is assumed to
> have only low frequency components, therefore a filter with 0.3 Hz
> cutoff frequency was used. From each window, a vector of features was
> obtained by calculating variables from the time and frequency domain.
> See ‘features\_info.txt’ for more details.

## Libraries Used

dplyr is used to aggregate and conform variables into tidy data

    library(dplyr)

## Data Used

run\_analysis.R imports the subject (/test/subject\_test.txt into
`SubjectTestData` and /train/subject\_train.txt into
`SubjectTrainData`), activity (/test/Y\_test.txt into `ActivityTestData`
and /train/Y\_train.txt into `ActivityTrainData`), and features
(/test/X\_test.txt into `FeaturesTestData` and /test/X\_train.txt into
`FeaturesTrainData`) data accordingly into their own variables. The
features labels (/features.txt) are read into `FeaturesNamesData`.

# run\_analysis.R

## Merge data into one table, extract only means and std measurements

Row data was merged using `add_row` from the `dplyr` package. Column
names were assigned during this step using the chain function These were
stored in: `ActivityData`, `SubjectData`, `FeatureData`

Data was then combined using `col_bind` from `dplyr` package Data for
only means and standard deviations for each feature were extracted in
the same step by chaining the `select` function This data was stored in:
`mergedData`

## Uses descriptive names for each activity

Activities, originally denoted by numbers, were changed into descriptive
names. “WALKING” “WALKING\_UPSTAIRS” “WALKING\_DOWNSTAIRS” “SITTING”
“STANDING” “LAYING”

## Appropriately labels data set with descriptive variable names

By examining mergedData, the following items were replaced using gsub:

`Acc` replaced with Accelerometer `Gyro` replaced with Gyroscope
`BodyBody` replaced with Body `Mag` replaced with Magnitude Character
`f` replaced with Frequency Character `t` replaced with Time

variables after they were edited

``` r
names(mergedData)
```

    ##  [1] "activity"                                      
    ##  [2] "subject"                                       
    ##  [3] "TimeBodyAccelerometer-mean()-X"                
    ##  [4] "TimeBodyAccelerometer-mean()-Y"                
    ##  [5] "TimeBodyAccelerometer-mean()-Z"                
    ##  [6] "TimeGravityAccelerometer-mean()-X"             
    ##  [7] "TimeGravityAccelerometer-mean()-Y"             
    ##  [8] "TimeGravityAccelerometer-mean()-Z"             
    ##  [9] "TimeBodyAccelerometerJerk-mean()-X"            
    ## [10] "TimeBodyAccelerometerJerk-mean()-Y"            
    ## [11] "TimeBodyAccelerometerJerk-mean()-Z"            
    ## [12] "TimeBodyGyroscope-mean()-X"                    
    ## [13] "TimeBodyGyroscope-mean()-Y"                    
    ## [14] "TimeBodyGyroscope-mean()-Z"                    
    ## [15] "TimeBodyGyroscopeJerk-mean()-X"                
    ## [16] "TimeBodyGyroscopeJerk-mean()-Y"                
    ## [17] "TimeBodyGyroscopeJerk-mean()-Z"                
    ## [18] "TimeBodyAccelerometerMagnitude-mean()"         
    ## [19] "TimeGravityAccelerometerMagnitude-mean()"      
    ## [20] "TimeBodyAccelerometerJerkMagnitude-mean()"     
    ## [21] "TimeBodyGyroscopeMagnitude-mean()"             
    ## [22] "TimeBodyGyroscopeJerkMagnitude-mean()"         
    ## [23] "FrequencyBodyAccelerometer-mean()-X"           
    ## [24] "FrequencyBodyAccelerometer-mean()-Y"           
    ## [25] "FrequencyBodyAccelerometer-mean()-Z"           
    ## [26] "FrequencyBodyAccelerometerJerk-mean()-X"       
    ## [27] "FrequencyBodyAccelerometerJerk-mean()-Y"       
    ## [28] "FrequencyBodyAccelerometerJerk-mean()-Z"       
    ## [29] "FrequencyBodyGyroscope-mean()-X"               
    ## [30] "FrequencyBodyGyroscope-mean()-Y"               
    ## [31] "FrequencyBodyGyroscope-mean()-Z"               
    ## [32] "FrequencyBodyAccelerometerMagnitude-mean()"    
    ## [33] "FrequencyBodyAccelerometerJerkMagnitude-mean()"
    ## [34] "FrequencyBodyGyroscopeMagnitude-mean()"        
    ## [35] "FrequencyBodyGyroscopeJerkMagnitude-mean()"    
    ## [36] "TimeBodyAccelerometer-std()-X"                 
    ## [37] "TimeBodyAccelerometer-std()-Y"                 
    ## [38] "TimeBodyAccelerometer-std()-Z"                 
    ## [39] "TimeGravityAccelerometer-std()-X"              
    ## [40] "TimeGravityAccelerometer-std()-Y"              
    ## [41] "TimeGravityAccelerometer-std()-Z"              
    ## [42] "TimeBodyAccelerometerJerk-std()-X"             
    ## [43] "TimeBodyAccelerometerJerk-std()-Y"             
    ## [44] "TimeBodyAccelerometerJerk-std()-Z"             
    ## [45] "TimeBodyGyroscope-std()-X"                     
    ## [46] "TimeBodyGyroscope-std()-Y"                     
    ## [47] "TimeBodyGyroscope-std()-Z"                     
    ## [48] "TimeBodyGyroscopeJerk-std()-X"                 
    ## [49] "TimeBodyGyroscopeJerk-std()-Y"                 
    ## [50] "TimeBodyGyroscopeJerk-std()-Z"                 
    ## [51] "TimeBodyAccelerometerMagnitude-std()"          
    ## [52] "TimeGravityAccelerometerMagnitude-std()"       
    ## [53] "TimeBodyAccelerometerJerkMagnitude-std()"      
    ## [54] "TimeBodyGyroscopeMagnitude-std()"              
    ## [55] "TimeBodyGyroscopeJerkMagnitude-std()"          
    ## [56] "FrequencyBodyAccelerometer-std()-X"            
    ## [57] "FrequencyBodyAccelerometer-std()-Y"            
    ## [58] "FrequencyBodyAccelerometer-std()-Z"            
    ## [59] "FrequencyBodyAccelerometerJerk-std()-X"        
    ## [60] "FrequencyBodyAccelerometerJerk-std()-Y"        
    ## [61] "FrequencyBodyAccelerometerJerk-std()-Z"        
    ## [62] "FrequencyBodyGyroscope-std()-X"                
    ## [63] "FrequencyBodyGyroscope-std()-Y"                
    ## [64] "FrequencyBodyGyroscope-std()-Z"                
    ## [65] "FrequencyBodyAccelerometerMagnitude-std()"     
    ## [66] "FrequencyBodyAccelerometerJerkMagnitude-std()" 
    ## [67] "FrequencyBodyGyroscopeMagnitude-std()"         
    ## [68] "FrequencyBodyGyroscopeJerkMagnitude-std()"

## Create a second data set with the average of each variable for each activity and subject

Using `dplyr` functions `group_by`, `summarize_all` and `mean` a new
data set was created:

    mean_Data

and written into the file “tidyData.txt”
