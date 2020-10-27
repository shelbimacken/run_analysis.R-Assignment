This project takes data from the Human Activity Recognition Using Smartphones Data Set (<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>) and turns it into a tidy data set for the purposes of the course assignment.

What makes the data tidy?
1. There is one record (the average) per subject and activity for each measurment. 
2. The data is ordered by activity so that you can compare subject measurements for each activity
3. Each meaurement has a meaningful title. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- README.txt
- Codebook.Rmd - Markdown for the codebook
- run_analysis.R - Script to create the tidyData.txt
- tidyData.txt - Tidy data set created
