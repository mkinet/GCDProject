
# Download Dataset
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipfile <- './data.zip'
download.file(fileurl,destfile = zipfile,method='curl')
dateDownloaded <- date()
# Unzip Data
unzip(zipfile)

# Read the datasets
# Training Set
file <- './UCI HAR Dataset/train/X_train.txt'
Xtrain <- read.table(file)
file <- './UCI HAR Dataset/train/y_train.txt'
ytrain <- read.table(file)
file <- './UCI HAR Dataset/train/subject_train.txt'
subjecttrain <- read.table(file)
   
file <- './UCI HAR Dataset/test/X_test.txt'
Xtest <- read.table(file)
file <- './UCI HAR Dataset/test/y_test.txt'
ytest <- read.table(file)
file <- './UCI HAR Dataset/test/subject_test.txt'
subjecttest <- read.table(file)

# Merge training and test datasets. Keep 3 separate datasets for now, full merging is achieved later
X <- rbind(Xtrain,Xtest)
y <- rbind(ytrain,ytest)
subject <- rbind(subjecttrain,subjecttest)
colnames(subject) <- "subject"
## 2)
# Extract Names of features
file <- './UCI HAR Dataset/features.txt'
feat <- read.table(file)
featnames <- feat[,2]
## use grep expression to select the feature names that are about mean and std-dev of measurements
## keep1 and keep2 are two logical vectors
keep1 <- grepl("mean()",featnames)
keep2 <- grepl("std()",featnames)
## subset X to keep only those features
X <- X[,keep1|keep2]
## keep the names of the features and assign them to the features in X
featnames <- featnames[keep1|keep2]
colnames(X) <- featnames

## 3)
## extract activity labels
file <- './UCI HAR Dataset/activity_Labels.txt'
labels <- read.table(file)

## 4) 
## Replace the number in y by the text labels
replaceLabels <- function(x){labels[x,2]}
y <- sapply(y,replaceLabels)
colnames(y) <- "activity"

## 1)
## Merge all the data in one dataset
data <- cbind(subject,y,X)

## 5)
# using the aggregate function :
cdata <- aggregate(data[,3:81], by=data[c("subject","activity")], FUN=mean)

write.table(cdata, "submit.txt", row.names=FALSE)
