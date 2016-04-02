# 1 Merges the training and the test sets to create one data set.


##########################################################
### READ TRAINING AND TEST DATA SETS
##########################################################

X_train <- read.csv("./data/UCI/train/X_train.txt", sep="", header = FALSE)
X_train[,562] <- read.csv("./data/UCI/train/subject_train.txt", sep="", header = FALSE)
X_train[,563] <- read.csv("./data/UCI/train/Y_train.txt", header = FALSE)


X_test <- read.csv("./data/UCI/test/X_test.txt", sep="", header = FALSE)
X_test[,562] <- read.csv("./data/UCI/test/Y_test.txt", sep="", header = FALSE)
X_test[,563] <- read.csv("./data/UCI/test/subject_test.txt", header = FALSE)


aLabels = read.csv("./data/UCI/activity_labels.txt", sep="", header=FALSE)
features = read.csv("./data/UCI/features.txt", sep="", header=FALSE)
features[,2] = gsub('-mean', 'Mean', features[,2])
features[,2] = gsub('-std', 'Std', features[,2])
features[,2] = gsub('[-()]', '', features[,2])


xTotal = rbind(X_train, X_test)

meanstddev <- grep(".*Mean.*|.*Std.*", features[,2])
 
features <- features[meanstddev,]
 
meanstddev <- c(meanstddev, 562, 563)
 
xTotal <- xTotal[,meanstddev]
 
colnames(xTotal) <- c(features$V2, "activity", "subject")
colnames(xTotal) <- tolower(colnames(xTotal))

currentActivity = 1
for (currentActivityLabel in aLabels$V2) {
  xTotal$activity <- gsub(currentActivity, aLabels, xTotal$activity)
  currentActivity <- currentActivity + 1
}

xTotal$activity <- as.factor(xTotal$activity)
xTotal$subject <- as.factor(xTotal$subject)
  

##########################################################
### SUMARIZING MEAN BY ACTIVITY AND WRITING TIDY DATA SET
##########################################################

GroupedData <- aggregate(X_total, by=list(activity = X_total$activity, subject=X_total$subject), mean)

 
write.table(GroupedData, "tidy.txt", sep="\t")
 
