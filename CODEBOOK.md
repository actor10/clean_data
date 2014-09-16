## Raw Data In

The measurements files (x_test & x_train) have values for each of the 531 "features"

The "subject" and "y" (activities) files within test and train have the 
subject and activity associated with each row of data in the measurement files

The measurements, subjects and activities from the test and training datasets were concatentated

The "features" file has the name associated with each of the 531 measurements.

## data restructured

We are only interested in the features that contain "mean()" and "std()" calculations.  So measurement table is limited to those columns

The "wide" data with one record per activity and subject is transformed into a "long" table

## Tidy_measurements data frame

The tidy_measurements data frame is our cleaned up and transformed data file.  It contains the following fields.  

* Subject - integer value with the subject's id
* activity_name - text string with the name of the activity
* feature_name - text string with the name of the feature
* measured - float point number with the measured result

## activity_subject_feature_means data frame

The activity_subject_feature_means data frame contains the means for each unique: subject, activity_name and feature_name.  It contains the following fields:

* activity
* subject
* feature
* average


