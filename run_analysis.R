
###########################
#   Read TRAINING data    # 
###########################
X_train <- read.csv("./data/UCI/train/X_train.txt", sep="", header=FALSE)
#   Aggregate labels  info 
X_train[,562] <- read.csv("./data/UCI/train/Y_train.txt", sep="", header=FALSE)
#   Aggregate subject info 
X_train[,563] <- read.csv("./data/UCI/train/subject_train.txt", sep="", header=FALSE)


###########################
#     Read TEST data      # 
###########################
X_test = read.csv("./data/UCI/test/X_test.txt", sep="", header=FALSE)
#   Aggregate labels info 
X_test[,562] <- read.csv("./data/UCI/test/Y_test.txt", sep="", header=FALSE)
#   Aggregate subject info 
X_test[,563] <- read.csv("./data/UCI/test/subject_test.txt", sep="", header=FALSE)


###########################
#    Read LABELS data     # 
###########################
aLabels <- read.csv("./data/UCI/activity_labels.txt", sep="", header=FALSE)

#   Clean label information to make look tidy 
features <- read.csv("./data/UCI/features.txt", sep="", header=FALSE)
features[,2] <- gsub("-","", features[,2])
features[,2] <- gsub('[)]', "", features[,2])
features[,2] <- gsub('[(]', "", features[,2])

###########################
#Combine TRAIN and TEST data 
###########################
X_total <- rbind(X_train, X_test)
#nrow(X_total)

###########################
#Select only mean and std.dev 
###########################
meanstd <- grep(".*mean.*|.*std.*", features[,2])
features <- features[meanstd,]
meanstd <- c(meanstd, 562, 563)
#Select only std and mean columns (plus 562 and 563 defined above) from TOTAL
X_total <- X_total[,meanstd]


#Name TOTAL data set with the names of the features
names(X_total) <- c(features$V2, "activity", "subject")
names(X_total) <- tolower(colnames(X_total))

#nrow(X_total)
#names(X_total)

###########################
#Loop through activities and apply label in Total
###########################
currActvt = 1
for (currActvtLab in aLabels$V2) {
  X_total$activity <- gsub(currActvt, currActvtLab, X_total$activity)
  currActvt <- currActvt + 1
}

#Transform activity and subject fields to factors
X_total$activity <- as.factor(X_total$activity)
X_total$subject <- as.factor(X_total$subject)

###########################
#Group data by activity and subject by mean
###########################
X_Grouped <- aggregate(X_total, by=list(activity = X_total$activity, subject=X_total$subject), mean)

###########################
#Write file
###########################
write.table(X_Grouped, "tidy.txt", sep="\t")