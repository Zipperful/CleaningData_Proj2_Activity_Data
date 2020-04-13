
##--------------------------------------------------------------------------------------------------------------
#Section 1
#Loading Data and Merging Data
  #Unzips folder and navigates in to proper working directory
  unzip("getdata_projectfiles_UCI HAR Dataset.zip", overwrite = TRUE)
  setwd("./UCI HAR Dataset/")
  #Loads data into data frames

  dfAccTest <- read.table("./test/X_test.txt")
  dfAccTrain <- read.table("./train/X_train.txt")
  vcVars <- read.table("./features.txt")
  
  vcSubTest <- read.table("./test/subject_test.txt")
  vcSubTrain <- read.table("./train/subject_train.txt")
  
  vcActTest <- read.table("./test/y_test.txt")
  vcActTrain <- read.table("./train/y_train.txt")


  #Merges the training and the test sets to create one data set.

  names(dfAccTest) <- vcVars[,2]
  names(dfAccTrain) <- vcVars[,2]
  
  dfAcc <- rbind(dfAccTest, dfAccTrain)
  vcSub <- rbind(vcSubTest, vcSubTrain)
  vcAct <- rbind(vcActTest, vcActTrain)
  
  names(vcSub) <- "subject_id"
  names(vcAct) <- "activity_type"
  
  
  dfAcc <- cbind(vcSub, vcAct, dfAcc)
  
  
  
##--------------------------------------------------------------------------------------------------------------
## Section 2
##Extracts only the measurements on the mean and standard deviation for each measurement type

  vcDataLabels <- names(dfAcc)[grepl("mean\\(\\)|std\\(\\)\\-[XYZ]", names(dfAcc)) & !grepl("Mag", names(dfAcc))]
  
  dfAccData <- dfAcc[,c("activity_type", "subject_id", vcDataLabels)]
  
  
  
##--------------------------------------------------------------------------------------------------------------
##Section 3
##Labelling Activities
  
  vcActLabels <- c("walking", "walking_upstairs", "walking_downstairs", "sitting", "standing", "laying")
  dfAccData[,1] <- as.character(dfAccData[,1])
  dfAccData[,1] <- sapply(dfAccData[,1], function(X){X<-vcActLabels[as.integer(X)]})
  
  
  
##--------------------------------------------------------------------------------------------------------------
##Section 4
## Labelling Data Set Variables with Descriptive Names
  ## Splits data frames in to variable means and variable standard deviations to be melted by XYZ values, as variables
  ## cannot be appropriately named unless separated and frames melted

  ## Melts data according to dimension, as X,Y, and Z are not variables but different measurements for each measurement category
  
  ## Also assigns descriptive names to each measurement type
  
  library(reshape2)
  dftBodyAccMean <- melt(dfAccData[,c(1,2,3:5)], id.vars = c("activity_type", "subject_id")); names(dftBodyAccMean)[3:4]<-c("direction", "mean of acceleration on body over time")
  dftBodyAccMean$direction<-as.factor(sapply(strsplit(as.character(dftBodyAccMean$direction), "-"), dplyr::last))
  dftBodyAccStd <- melt(dfAccData[,c(1,2,6:8)], id.vars = c("activity_type", "subject_id")); names(dftBodyAccStd)[3:4]<-c("direction", "standard deviation of acceleration on body over time")
  dftBodyAccStd$direction<-as.factor(sapply(strsplit(as.character(dftBodyAccStd$direction), "-"), dplyr::last))
  dftGravityAccMean <- melt(dfAccData[,c(1,2,9:11)], id.vars = c("activity_type", "subject_id")); names(dftGravityAccMean)[3:4]<-c("direction", "mean of gravitational acceleration signal over time")
  dftGravityAccMean$direction<-as.factor(sapply(strsplit(as.character(dftGravityAccMean$direction), "-"), dplyr::last))
  dftGravityAccStd <- melt(dfAccData[,c(1,2,12:14)], id.vars = c("activity_type", "subject_id")); names(dftGravityAccStd)[3:4]<-c("direction","standard deviation of gravitational acceleration signal over time")
  dftGravityAccStd$direction<-as.factor(sapply(strsplit(as.character(dftGravityAccStd$direction), "-"), dplyr::last))
  dftBodyAccJerkMean <- melt(dfAccData[,c(1,2,15:17)], id.vars = c("activity_type", "subject_id")); names(dftBodyAccJerkMean)[3:4]<-c("direction", "mean of jerk on body over time")
  dftBodyAccJerkMean$direction<-as.factor(sapply(strsplit(as.character(dftBodyAccJerkMean$direction), "-"), dplyr::last))
  dftBodyAccJerkStd <- melt(dfAccData[,c(1,2,18:20)], id.vars = c("activity_type", "subject_id")); names(dftBodyAccJerkStd)[3:4]<-c("direction","standard deviation of jerk on body over time")
  dftBodyAccJerkStd$direction<-as.factor(sapply(strsplit(as.character(dftBodyAccJerkStd$direction), "-"), dplyr::last))
  dftBodyGyroMean <- melt(dfAccData[,c(1,2,21:23)], id.vars = c("activity_type", "subject_id")); names(dftBodyGyroMean)[3:4]<-c("direction", "mean of gyroscopic acceleration on body over time")
  dftBodyGyroMean$direction<-as.factor(sapply(strsplit(as.character(dftBodyGyroMean$direction), "-"), dplyr::last))
  dftBodyGyroStd <- melt(dfAccData[,c(1,2,24:26)], id.vars = c("activity_type", "subject_id")); names(dftBodyGyroStd)[3:4]<-c("direction", "standard deviation of gyroscopic acceleration on body over time")
  dftBodyGyroStd$direction<-as.factor(sapply(strsplit(as.character(dftBodyGyroStd$direction), "-"), dplyr::last))
  dftBodyGyroJerkMean <- melt(dfAccData[,c(1,2,27:29)], id.vars = c("activity_type", "subject_id")); names(dftBodyGyroJerkMean)[3:4]<-c("direction", "mean of gyroscopic jerk on body over time")
  dftBodyGyroJerkMean$direction<-as.factor(sapply(strsplit(as.character(dftBodyGyroJerkMean$direction), "-"), dplyr::last))
  dftBodyGyroJerkStd <- melt(dfAccData[,c(1,2,30:32)], id.vars = c("activity_type", "subject_id")); names(dftBodyGyroJerkStd)[3:4]<-c("direction", "standard deviation of gyroscopic jerk on body over time")
  dftBodyGyroJerkStd$direction<-as.factor(sapply(strsplit(as.character(dftBodyGyroJerkStd$direction), "-"), dplyr::last))
  dffBodyAccMean <- melt(dfAccData[,c(1,2,33:35)], id.vars = c("activity_type", "subject_id")); names(dffBodyAccMean)[3:4]<-c("direction", "mean of body acceleration frequency signal")
  dffBodyAccMean$direction<-as.factor(sapply(strsplit(as.character(dffBodyAccMean$direction), "-"), dplyr::last))
  dffBodyAccStd <- melt(dfAccData[,c(1,2,36:38)], id.vars = c("activity_type", "subject_id")); names(dffBodyAccStd)[3:4]<-c("direction", "standard deviation of acceleration frequency signal")
  dffBodyAccStd$direction<-as.factor(sapply(strsplit(as.character(dffBodyAccStd$direction), "-"), dplyr::last))
  dffBodyAccJerkMean <- melt(dfAccData[,c(1,2,39:41)], id.vars = c("activity_type", "subject_id")); names(dffBodyAccJerkMean)[3:4]<-c("direction", "mean of jerk frequency signal")
  dffBodyAccJerkMean$direction<-as.factor(sapply(strsplit(as.character(dffBodyAccJerkMean$direction), "-"), dplyr::last))
  dffBodyAccJerkStd <- melt(dfAccData[,c(1,2,42:44)], id.vars = c("activity_type", "subject_id")); names(dffBodyAccJerkStd)[3:4]<-c("direction", "standard deviation of jerk frequency signal")
  dffBodyAccJerkStd$direction<-as.factor(sapply(strsplit(as.character(dffBodyAccJerkStd$direction), "-"), dplyr::last))
  dffBodyGyroMean <- melt(dfAccData[,c(1,2,45:47)], id.vars = c("activity_type", "subject_id")); names(dffBodyGyroMean)[3:4]<-c("direction", "mean of gyroscopic frequency signal of body")
  dffBodyGyroMean$direction<-as.factor(sapply(strsplit(as.character(dffBodyGyroMean$direction), "-"), dplyr::last))
  dffBodyGyroStd <- melt(dfAccData[,c(1,2,48:50)], id.vars = c("activity_type", "subject_id")); names(dffBodyGyroStd)[3:4]<-c("direction", "standard deviation of gyroscopic frequency signal of body")
  dffBodyGyroStd$direction<-as.factor(sapply(strsplit(as.character(dffBodyGyroStd$direction), "-"), dplyr::last))

  
##--------------------------------------------------------------------------------------------------------------
## Section 5
## Creating a Tidy Dataset with Means of Each Variable
  ## I kept the datasets seperated so I could do exploratory analyses on them, so I start with combining dataframes in logical groups
 
   # Joins together related variable types to make dataframes sensibly ordered mached on their matching rows describing suject number, dimension of observation, and activity type
  
  library(plyr)
  dfSignalMeans <- join_all(list(dftBodyAccMean, dftGravityAccMean, dftBodyAccJerkMean, dftBodyGyroMean, dftBodyGyroJerkMean), match="first")
  dfSignalStds <- join_all(list(dftBodyAccStd, dftGravityAccStd, dftBodyAccJerkStd, dftBodyGyroStd, dftBodyGyroJerkStd), match="first")
  dfFreqMeans <- join_all(list(dffBodyAccMean, dffBodyAccJerkMean, dffBodyGyroMean), match="first")
  dfFreqStds <- join_all(list(dffBodyAccStd, dffBodyAccJerkStd, dffBodyGyroStd), match="first")
  
  #converts the measurement types- suject number, dimension of observation, and activity type - to factors
  
  dfSignalMeans[,1] <- as.factor(dfSignalMeans[,1])
  dfSignalMeans[,2] <- as.factor(dfSignalMeans[,2])
  dfSignalStds[,1] <- as.factor(dfSignalStds[,1])
  dfSignalStds[,2] <- as.factor(dfSignalStds[,2])
  dfFreqMeans[,1] <- as.factor(dfFreqMeans[,1])
  dfFreqMeans[,2] <- as.factor(dfFreqMeans[,2])
  dfFreqStds[,1] <- as.factor(dfFreqStds[,1])
  dfFreqStds[,2] <- as.factor(dfFreqStds[,2])
  
  #Creates a new column that tracks the measurement types -suject number, dimension of observation, and activity type- in one ID format for easy sorting of data
  
  nwSignalMeans<-mutate(dfSignalMeans[1:8], id=as.factor(paste(dfSignalMeans[,1], dfSignalMeans[,2], dfSignalMeans[,3], sep="-")))
  nwSignalStds<-mutate(dfSignalStds[1:8], id=as.factor(paste(dfSignalStds[,1], dfSignalStds[,2], dfSignalStds[,3], sep="-")))
  nwFreqMeans<-mutate(dfFreqMeans[1:6], id=as.factor(paste(dfFreqMeans[,1], dfFreqMeans[,2], dfFreqMeans[,3], sep="-")))
  nwFreqStds<-mutate(dfFreqStds[1:6], id=as.factor(paste(dfFreqStds[,1], dfFreqStds[,2], dfFreqStds[,3], sep="-")))

  #Creates a dataframe to load means of variables in to and a counter to iterate over called dffin for final dataframe output

  dffin<-as.data.frame(matrix(rep(0, (30*3*6)*(4+5+5+3+3)),nrow = 30*3*6))
  count<-0
  
  #Iterates over all unique observation types categorized by the subject's ID, activity type, and dimension activity is being measured in, and finds the mean of each of the variables and stores it in an appropriate column of our final dataframe output
 
  for(x in levels(nwSignalMeans[,9])) {
    count=count+1; 
    dffin[count,1]=x
    dffin[count,2]=as.character(nwSignalMeans[nwSignalMeans[,9]==x,1])[1]
    dffin[count,3]=as.character(nwSignalMeans[nwSignalMeans[,9]==x,2])[1]
    dffin[count,4]=as.character(nwSignalMeans[nwSignalMeans[,9]==x,3])[1]
    dffin[count,5]=mean(nwSignalMeans[nwSignalMeans[,9]==x,4])
    dffin[count,6]=mean(nwSignalMeans[nwSignalMeans[,9]==x,5])
    dffin[count,7]=mean(nwSignalMeans[nwSignalMeans[,9]==x,6])
    dffin[count,8]=mean(nwSignalMeans[nwSignalMeans[,9]==x,7])
    dffin[count,9]=mean(nwSignalMeans[nwSignalMeans[,9]==x,8])
    dffin[count,10]=mean(nwSignalStds[nwSignalStds[,9]==x,4])
    dffin[count,11]=mean(nwSignalStds[nwSignalStds[,9]==x,5])
    dffin[count,12]=mean(nwSignalStds[nwSignalStds[,9]==x,6])
    dffin[count,13]=mean(nwSignalStds[nwSignalStds[,9]==x,7])
    dffin[count,14]=mean(nwSignalStds[nwSignalStds[,9]==x,8])
    dffin[count,15]=mean(nwFreqMeans[nwFreqMeans[,7]==x,4])
    dffin[count,16]=mean(nwFreqMeans[nwFreqMeans[,7]==x,5])
    dffin[count,17]=mean(nwFreqMeans[nwFreqMeans[,7]==x,6])
    dffin[count,18]=mean(nwFreqStds[nwFreqStds[,7]==x,4])
    dffin[count,19]=mean(nwFreqStds[nwFreqStds[,7]==x,5])
    dffin[count,20]=mean(nwFreqStds[nwFreqStds[,7]==x,6])
  } 
  
  # names the final data rows as 'mean of ...' followed by the descriptive names assigned to the variables earlier
  
  names(dffin)<-c("data_id", "activity_type", "subject_id", "direction", "mean of means of acceleration on body over time", "mean of means of gravitational acceleration signal over time", "mean of means of jerk on body over time", "mean of means of gyroscopic acceleration on body over time", "mean of means of gyroscopic jerk on body over time", "mean of standard deviations of acceleration on body over time", "mean of standard deviations of gravitational acceleration signal over time", "mean of standard deviations of jerk on body over time", "mean of standard deviations of gyroscopic acceleration on body over time", "mean of standard deviations of gyroscopic jerk on body over time", "mean of means of body acceleration frequency signal", "mean of means of jerk frequency signals", "mean of means of gyroscopic frequency signal of body", "mean of standard deviations of acceleration frequency signal", "mean of standard deviations of jerk frequency signal", "mean of standard deviations of gyroscopic frequency signal of body")
tail(dffin)
  
  # Writing Dataset to File, resets working directory
  write.table(x = dffin, file = "./../finalactivitydataframe.txt",  row.names=FALSE)
  setwd("./..")
  
  #Outputs dataframe as well, as instructions were ambiguous about this funcationlity
  dffin
  paste("Output Dataframe Also Recorded in Working Directory in 'finalactivitydataframe.txt'")
