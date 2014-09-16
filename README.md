
## Please see the embedded commented within the run_analysis.R file for per statement descriptions.

## General overview of the processing

The "test" and "train" subdirectories have files that are structured the same with different sets of data.  They need to be read in and appended.  This includes the measurement files ("x_test.txt" and "x_train.txt"), the subjects ("subject_test.txt" and "subject_train.txt") and the activity files ("y_test.txt" and "y_train.txt")

The "features.txt" file has the names associated with the 531 columns in the "x_test.txt" and "x_train.txt" files.  Since we only interested in the "mean()" and "std()" features, those are filtered into a smaller list.  That smaller list is used to filter down the main "measurements" data frame.

Since there is a "one to one" match between the rows on the measurements and subjects/activities, we can just create new columns with that data.

The "reshape()" function is used to turn the "wide" data frame into a "long" data frame.  After that function, we only have the feature number so we need to retrieve the names and match them up.

The "aggregate()" function is used to generate the means calculations for the requested per activity per subject per feature.
