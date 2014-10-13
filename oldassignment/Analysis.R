Trainingdata<- read.csv ("./datacleaningproject/courseprojectwork/UCIHARDataset/train/X_train.txt",header=FALSE,sep="")
dim(Trainingdata)
Trainingdata[,562]<- read.csv ("./datacleaningproject/courseprojectwork/UCIHARDataset/train/Y_train.txt",header=FALSE,sep="")
dim(Trainingdata)
Trainingdata[,563]<- read.csv ("./datacleaningproject/courseprojectwork/UCIHARDataset/train/subject_train.txt",header=FALSE,sep="")
dim(Trainingdata)
Testdata<- read.csv ("./datacleaningproject/courseprojectwork/UCIHARDataset/test/X_test.txt",header=FALSE,sep="")
dim(Testdata)
Testdata[,563] <- read.csv ("./datacleaningproject/courseprojectwork/UCIHARDataset/test/subject_test.txt",header=FALSE,sep="")
ActivityLabels = read.csv("./datacleaningproject/courseprojectwork/UCIHARDataset/activity_labels.txt", sep="", header=FALSE)
Features <- read.csv("./datacleaningproject/courseprojectwork/UCIHARDataset/features.txt", sep="", header=FALSE)
dim(Features)
Features[,2]<-gsub('-std', 'Std', Features[,2])
Features[,2] <-gsub('-mean', 'Mean', Features[,2])
Features[,2] <- gsub('[-()]', '',Features[,2])
allData = rbind(Trainingdata, Testdata)
dim(allData)
colsWeWant <- grep(".*Mean.*|.*Std.*", Features[,2])
Features <- Features[colsWeWant,]
dim(Features)
colsWeWant <- c(colsWeWant, 562, 563)
MeanAndStdData<-allData[,colsWeWant]
dim(MeanAndStdData)
colnames(MeanAndStdData) <- c(features$V2, "Activity", "Subject")
MeanAndStdDataHeader<-MeanAndStdData
currentActivity <- 1
for (currentActivityLabel in ActivityLabels$V2) {
  MeanAndStdDataHeader$Activity <- gsub(currentActivity, currentActivityLabel, MeanAndStdDataHeader$Activity)
  currentActivity <- currentActivity + 1
}
MeanAndStdDataHeader$Activity <- as.factor(MeanAndStdDataHeader$Activity)
MeanAndStdDataHeader$Subject <- as.factor(MeanAndStdDataHeader$Subject)
Independenttidy = aggregate(MeanAndStdDataHeader,by=list(Activity = MeanAndStdDataHeader$Activity, Subject=MeanAndStdDataHeader$Subject), mean)
dim(Independenttidy)
Independenttidy[,90]=NULL
Independenttidy[,89]=NULL
write.table(Independenttidy, "Independenttidy.txt", row.names= FALSE, sep="\t")
