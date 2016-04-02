# 1 Merges the training and the test sets to create one data set.

##########################################################
#Merges the training and the test sets to create one data set.
##########################################################

##########################################################
### BUILD THE VECTOR CONTAINING THE LABELS
##########################################################
library(data.table)
Cnames <- read.csv("./data/UCI/features.txt",header = FALSE, sep="|")
ColunmNames <- as.vector(Cnames$V1)
#---------------------------------------------------------

##########################################################
### MERGE TRAINING AND TEST DATA SETS
##########################################################

X_test <- read.csv("./data/UCI/test/X_test.txt", sep="", header = FALSE, col.names = ColunmNames)
#length(names(X_test))
#names(X_test)

X_train <- read.csv("./data/UCI/train/X_train.txt", sep="", header = FALSE, col.names = ColunmNames)
#length(names(X_train))

X_total <- rbind(X_test, X_train) 
#---------------------------------------------------------


# 2 Extracts only the measurements on the mean and standard deviation for 
#each measurement.

##########################################################
### GETTING THE MEASUREMENTS ON MEAN OR STD DEV
##########################################################

mean_stddev <- X_total[ , grep("Mean|std", colnames(X_total))]

#names(mean_stddev)
#---------------------------------------------------------



# 3 Uses descriptive activity names to name the activities in the data set


##########################################################
### CREATING LABEL NAMES DATA SET
##########################################################
Y_test <- read.csv("./data/UCI/test/Y_test.txt", header = FALSE)
#length(names(Y_test))

Y_train <- read.csv("./data/UCI/train/Y_train.txt", header = FALSE)
#length(names(Y_train))

Y_total <- rbind(Y_test, Y_train) 
names(Y_total) <- c("codactivity") 

activity_labels <- read.csv("./data/UCI/activity_labels.txt",col.names=c("codactivity","descactivity"), sep=" ", header = FALSE)

Y_totallabel <- merge(activity_labels, Y_total, all = TRUE, by = c("codactivity"))
X_total$codactivity <- Y_totallabel$codactivity
X_total$descactivity <- Y_totallabel$descactivity
#---------------------------------------------------------


# 4 Appropriately labels the data set with descriptive variable names.


##########################################################
### CHANGING LABLES IN THE DATASET
##########################################################
names(X_total) = tolower(names(X_total))
names(X_total) = gsub("[(]","",names(X_total))
names(X_total) = gsub(")","",names(X_total))
names(X_total) = gsub("[.]","",names(X_total))
names(X_total) = gsub("^x","",names(X_total))
names(X_total) = gsub("descactivity","activitydescription",names(X_total))
names(X_total) = gsub("codactivity","activitycode",names(X_total))
names(X_total) 

#---------------------------------------------------------

#From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.

##########################################################
### SUMARIZING MEAN BY ACTIVITY 
##########################################################

#X_total <- data.table(X_total)

GroupedData <- aggregate(X_total[,1:561], list(X_total$activitydescription), mean)