## This is a markdown file

This codebook has two clear areas: one is the output file and another is the Analysis.R code

1) For the output file Independenttidy.txt file which has 90 fields. For the details of the experiment that this output file is associated  refer to this:
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The meaning of the data file is as follows. The 30 subjects performed six tasks and the mean and std deviation of the accelerationinX,Y,Z direction of body, gravitym jerk, gyro etc is stored. 

First field is the activity:The data is stored as follows.

Activity is the six type of activity: 
LAYING
SITTING
STANDING
WALKING
WALKING_DOWNSTAIRS
WALKING_UPSTAIRS

Subjects 
1-30 subjects who wore the smartphone for the experiment

remainder of the fields are experimental measurements mean and standard deviation.

ActivitySubject	tBodyAccMeanX	tBodyAccMeanY	tBodyAccMeanZ	tBodyAccStdX	tBodyAccStdY	tBodyAccStdZ	tGravityAccMeanX	tGravityAccMeanY	tGravityAccMeanZ	tGravityAccStdX	tGravityAccStdY	tGravityAccStdZ	tBodyAccJerkMeanX	tBodyAccJerkMeanY	tBodyAccJerkMeanZ	tBodyAccJerkStdX	tBodyAccJerkStdY	tBodyAccJerkStdZ	tBodyGyroMeanX	tBodyGyroMeanY	tBodyGyroMeanZ	tBodyGyroStdX	tBodyGyroStdY	tBodyGyroStdZ	tBodyGyroJerkMeanX	tBodyGyroJerkMeanY	tBodyGyroJerkMeanZ	tBodyGyroJerkStdX	tBodyGyroJerkStdY	tBodyGyroJerkStdZ	tBodyAccMagMean	tBodyAccMagStd	tGravityAccMagMean	tGravityAccMagStd	tBodyAccJerkMagMean	tBodyAccJerkMagStd	tBodyGyroMagMean	tBodyGyroMagStd	tBodyGyroJerkMagMean	tBodyGyroJerkMagStd	fBodyAccMeanX	fBodyAccMeanY	fBodyAccMeanZ	fBodyAccStdX	fBodyAccStdY	fBodyAccStdZ	fBodyAccMeanFreqX	fBodyAccMeanFreqY	fBodyAccMeanFreqZ	fBodyAccJerkMeanX	fBodyAccJerkMeanY	fBodyAccJerkMeanZ	fBodyAccJerkStdX	fBodyAccJerkStdY	fBodyAccJerkStdZ	fBodyAccJerkMeanFreqX	fBodyAccJerkMeanFreqY	fBodyAccJerkMeanFreqZ	fBodyGyroMeanX	fBodyGyroMeanY	fBodyGyroMeanZ	fBodyGyroStdX	fBodyGyroStdY	fBodyGyroStdZ	fBodyGyroMeanFreqX	fBodyGyroMeanFreqY	fBodyGyroMeanFreqZ	fBodyAccMagMean	fBodyAccMagStd	fBodyAccMagMeanFreq	fBodyBodyAccJerkMagMean	fBodyBodyAccJerkMagStd	fBodyBodyAccJerkMagMeanFreq	fBodyBodyGyroMagMean	fBodyBodyGyroMagStd	fBodyBodyGyroMagMeanFreq	fBodyBodyGyroJerkMagMean	fBodyBodyGyroJerkMagStd	fBodyBodyGyroJerkMagMeanFreq	angletBodyAccMean,gravity	angletBodyAccJerkMean,gravityMean	angletBodyGyroMean,gravityMean	angletBodyGyroJerkMean,gravityMean	angleX,gravityMean	angleY,gravityMean	angleZ,gravityMean


As for the code book for the proram the following explanation will be added to the code
+Trainingdata<- read.csv ("./datacleaningproject/courseprojectwork/UCIHARDataset/train/X_train.txt",header=FALSE,sep="")
+dim(Trainingdata) # reads the train data that has the results of the experiment
+Trainingdata[,562]<- read.csv ("./datacleaningproject/courseprojectwork/UCIHARDataset/train/Y_train.txt",header=FALSE,sep="")
+dim(Trainingdata) # reads the train data for what Activity
+Trainingdata[,563]<- read.csv ("./datacleaningproject/courseprojectwork/UCIHARDataset/train/subject_train.txt",header=FALSE,sep="")
+dim(Trainingdata) # reads the train data for which subject
+Testdata<- read.csv ("./datacleaningproject/courseprojectwork/UCIHARDataset/test/X_test.txt",header=FALSE,sep="")
+dim(Testdata)# reads the test data that has the results of the experiment
+Testdata[,563] <- read.csv ("./datacleaningproject/courseprojectwork/UCIHARDataset/test/subject_test.txt",header=FALSE,sep="")# reads the test data for what Activity
+ActivityLabels = read.csv("./datacleaningproject/courseprojectwork/UCIHARDataset/activity_labels.txt", sep="", header=FALSE)# reads the test data for what subject
+Features <- read.csv("./datacleaningproject/courseprojectwork/UCIHARDataset/features.txt", sep="", header=FALSE)
+dim(Features) # activity names or variables that will be used as coloumn header is collected
+Features[,2]<-gsub('-std', 'Std', Features[,2]) # standardising the variable names
+Features[,2] <-gsub('-mean', 'Mean', Features[,2])
+Features[,2] <- gsub('[-()]', '',Features[,2])
+allData = rbind(Trainingdata, Testdata) # merging the test and train data
+dim(allData)
+colsWeWant <- grep(".*Mean.*|.*Std.*", Features[,2])# collecting the coloumns for mean and std
+Features <- Features[colsWeWant,] # collecting the coloumn names for mean and stsdd
+dim(Features)# check the dimensions to verify the code is performing as expected.
+colsWeWant <- c(colsWeWant, 562, 563)
+MeanAndStdData<-allData[,colsWeWant] # getting only mean and std data and ignore other information.
+dim(MeanAndStdData)
+colnames(MeanAndStdData) <- c(features$V2, "Activity", "Subject")
+MeanAndStdDataHeader<-MeanAndStdData
+currentActivity <- 1
+for (currentActivityLabel in ActivityLabels$V2) {
+ MeanAndStdDataHeader$Activity <- gsub(currentActivity, currentActivityLabel, MeanAndStdDataHeader$Activity)
+ currentActivity <- currentActivity + 1
+}
+MeanAndStdDataHeader$Activity <- as.factor(MeanAndStdDataHeader$Activity) # making the data as catagorical
+MeanAndStdDataHeader$Subject <- as.factor(MeanAndStdDataHeader$Subject)
+Independenttidy = aggregate(MeanAndStdDataHeader,by=list(Activity = MeanAndStdDataHeader$Activity, Subject=MeanAndStdDataHeader$Subject), mean)
+dim(Independenttidy) # get theb data aggregated by activity and subject.
+Independenttidy[,90]=NULL
+Independenttidy[,89]=NULL
+write.table(Independenttidy, "Independenttidy.txt", row.names= FALSE, sep="\t")
