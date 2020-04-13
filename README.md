# CleaningData_Proj2_Activity_Data
 Second project in Getting and Cleaning Data Course

==================================================================

Tim Keele Johns Hopkins Coursera Data Science Coursework, Project 2 of Getting and Cleaning Data


==================================================================

In this README file, we will talk about the run_analysis.R R script file, and walk through what it is going to do to a given dataset of Samsung accelerometer data called "Human Activity Recognition Using Smartphones Dataset" by Smartlab with Università degli Studi di Genova.  This dataset has its own README, and to run our file, or to look at the README describing the dataset, you will need to posess the zipped folder named "getdata_projectfiles_UCI HAR Dataset.zip" and run the script in the same directory.  It will unzip the dataset for you and start analyzing it; if you already have a folder named "getdata_projectfiles_UCI HAR Dataset" it WILL get overwritten.  Basic understanding of the dataset is assumed for this document, and you can work with the Dataset and its readme yourself if you need to first familiarize yourself with it.  We describe our final version of the dataset in the file "final_features_info.txt" as a codebook and the names of the features can be found in "final_features.txt"

==================================================================

Dataset Outline

The dataset has recorded statistics about acceleration measurements for 30 subjects doing various activities, and the X,Y, and Z components of these measurements.  One difficulty with the data is that the each X,Y, and Z component is a different observation of the same value (say, mean jerk) in the time series, yet the X,Y and Z components of mean jerk are expressed of different variables as columns rather than different measurements of the same variable under different circumstances.  As such, our dataset is not tidy, and we want to treat X readings of mean jerk for Subject 2 while sitting down as a different row of data than they Y readings of mean jerk for Subject 2 while sitting down.  So we will gather our data into one dataset and transform it so that directional data columns become unique row observation, creating an ID for each measurement based on subject-activity-dimension in that order.  We then take the mean of the data and store it in a dataframe and write it to a file.

Caveat

Notice that although we gather the data into one dataframe initially, we rapidly split it up into several dataframes grouped based on data type.  This was done so that I could keep track of the naming and reordering and melting of the large dataframes more easily, and they are all rejoined at the end of the analysis.  It makes for a lot of repetition in code, but it made it easier to make sure I was assigning the correct names to the correct features and allowed for easier exploratory analysis.

==================================================================

Analysis

Section 1
Here we unzip the folder, load and merge the data from the test and train directories in with read.table and read in the names of the variables into a vector.  We also load in the subject id's for each row of the test and train sets so that we can accurately label the data with the activity and subject associated with it.  We pass the names of the variables in to our dataset and then merge the datasets with rbind, then the ID vectors with the datasets with cbind to create our main dataframe dfAcc.

Section 2
Here we extract the features of the data we care about for this analysis, the means and standard deviations in the X,Y, and Z directions for various acceleration measurements.  We get the names of these variables using regular expressions and omit the variables with "Mag" in them, as magnitudes of the vectors are just calculated from the X,Y and Z data and including them would be redundant.  We then select only those columns and the id columns to put in our new datafram, dfAccData.

Section 3
Here we simply relabel the activity data using the vcActLabels vector holding the names of the activities for each feature, with the categories "walking", "walking_upstairs", "walking_downstairs", "sitting", "standing", and "laying". Previously our data was stored numerically, referring to an activity by its numeric order in this list of activity types.

Section 4
Here we hit a problem with our data.  We would like to descriptively name all of our variables as per the instructions, but our data is not tidy.  If we name them as they currently stand, we would have 3 variables for say, MeanJerkDat" called "MeanJerkDat-X", "MeanJerkDat-Y" and "MeanJerkDat-Z".  So we melt the data by stripping whatever comes after the token "-" as new observations names, recording them in their own rows.  This grabs the X Y and Z parts, then renames the variables descriptively- "mean of jerk signal" instead of "MeanJerkDat".  This is then executed for each variable seperately.  The result is our dataframes- still split by feature type for my own analysis- tidied and given descriptive names.

Section 5

Here we start to gather our dataframes in to one, doing some bookeeping along the way.  We join thematically related factors first- keeping signal data and fequency data, and mean and standard deviation data seperate- then create an ID for each row.  We make the subject ID's factors and create factors out of the string concatenation of the activity type, subject id, and dimension of a variable, looking like "laying-2-Z" for data taken in the Z dimension of subject 2 laying down.  This allow us to use the factor variables to find the means more easily for each unique data observation.  We load up an empty dataframe with 540, or 30 * 3 * 6 rows, one for each combination of activity-subject-dimension, and columns for all of our associated data.  We then iterate over the levels of the factor of the activity-subject-dimension ID we have created to take the mean of all measurements in the same column with the same ID.  This is then stored in the appropriate row of our final dataframe.

Now that we have a final tidy dataframe, re rename the dataset as needed to indicate our variables now represent the means of our various measurement types, then we write it to a text file "finalactivitydataframe.txt" and return to our initial directory.
