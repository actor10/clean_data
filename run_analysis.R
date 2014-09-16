# You should create one R script called run_analysis.R that does the following. 
#
#    Merges the training and the test sets to create one data set.
#    Extracts only the measurements on the mean and standard deviation for each measurement. 
#    Uses descriptive activity names to name the activities in the data set
#    Appropriately labels the data set with descriptive variable names. 

#    From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##### PROGRAM STARTS HERE #####

# read in the test and train measurements.  
#      append together in "measurements"

x_test <- read.table("test/x_test.txt")
x_train <- read.table("train/x_train.txt")
measurements = rbind(x_test,x_train)

# read in the subject and activity associated with the test and train, 
#     append together in "subjects" and "activities"

subject_test <- read.table("test/subject_test.txt",header=FALSE,col.names=c("subject"))
subject_train <- read.table("train/subject_train.txt",header=FALSE,col.names=c("subject"))
subjects = rbind(subject_test,subject_train)

y_test <- read.table("test/y_test.txt",header=FALSE,col.names=("activity_number"))
y_train <- read.table("train/y_train.txt",header=FALSE,col.names=("activity_number"))
activities <- rbind(y_test,y_train)

# read in the feature list.  Find the features that have "mean()" or "std()".  
#      Combine them into "features_mean_std"
features <- read.table("features.txt",header=FALSE,
                       col.names=c("feature_number","feature_name"))
features_mean <- features[grep("mean()",features$feature_name,fixed=TRUE),]
features_std <- features[grep("std()",features$feature_name,fixed=TRUE),]
features_mean_std = rbind(features_mean,features_std)

# limit to only those columns that have mean() or std() measurements
measure_mean_std = measurements[,features_mean_std$feature_number]

# get the activities labels
activity_labels <- read.table("activity_labels.txt",header=FALSE,
                              col.names=c("activity_number","activity_name"))

# create a list of variable names that we want to rotate from "wide" to "long" 
varlist = list(names(measure_mean_std))

# slap on the subject and activity number associated with that set of measurements
measure_mean_std$subject = subjects$subject
measure_mean_std$activity_number = activities$activity_number

# reshape the wide data frame into a long data frame where 
#          each record is a subject, activity and feature.
tidy_measurements = reshape(measure_mean_std,varying=varlist,timevar="feature_number",
                            v.names="measured", direction="long")

# pair up the feature number with its name.   
#         Do the same for the activity number and its name
tidy_measurements$feature_name = features_mean_std$feature_name[tidy_measurements$feature_number]
tidy_measurements$activity_name = activity_labels$activity_name[tidy_measurements$activity_number]

# clean up the data frame by dropping unneeded columns
tidy_measurements = subset(tidy_measurements,select=-c(activity_number,id,feature_number))

#####  tidy_measurements is our cleaned up data frame #####

activity_subject_feature_means = aggregate(tidy_measurements$measured, 
					list(activity=tidy_measurements$activity_name,
						 subject=tidy_measurements$subject,
						 feature=tidy_measurements$feature_name),
					mean)

# change the column name from x to mean
activity_subject_feature_means$average = activity_subject_feature_means$x
activity_subject_feature_means = subset(activity_subject_feature_means,select=-c(x))

##### activity_subject_feature_means is our end calculation data frame #####
