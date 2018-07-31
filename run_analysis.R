#run_analysis.R is a script meant to compile, combine, analyze, and reproduce motion 
#data. Download the datasets provided at 
#"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
#Set your working directory using the path required to get to the  
#UCI HAR Dataset" directory 
#(i.e. setwd("C://Users/myusername/myfolder/UCI HAR Dataset"))

#Reading in the x_test, y_test, and subject_test text files, respectively.
x_test <- read.table(file = "./test/X_test.txt")
y_test <- read.table(file = "./test/y_test.txt")
subject_test <- read.table(file = "./test/subject_test.txt")

#Reading in the x_train, y_train, and subject_train text files, respectively.
x_train <- read.table(file = "./train/X_train.txt")
y_train <- read.table(file = "./train/y_train.txt")
subject_train <- read.table(file = "./train/subject_train.txt")

#Reading in the features text file
features <- read.table(file = "./features.txt")

#Column binding the three test data sets into big_test dataframe
big_test <- cbind(subject_test, y_test, x_test)

#Column binding the three train data sets into big_train dataframe
big_train <- cbind(subject_train, y_train, x_train)

#Row binding the two column-combined dataframes to create big_data
big_data <- rbind(big_test, big_train)

#Narrowing down the features values to those that contain names with the characters
# "mean()" and "std()" in them. This includes "meanFreq()", put in features_partial
features_partial <- features[(grepl("mean()", features$V2)|grepl("std()", features$V2)),]

#Narrowing down features_partial values to those that solely contain "mean()" and
#"std()". These are the desired values. 
final_features <- features_partial[!grepl("Freq", features_partial$V2),]

#Selecting all variables pertaining to means or standard deviations only from big_data
# as smaller_data. The "+2" in the subset is compensating for the two added columns
#in big_data from the binding of the subject and y columns. The 1 represents the
#subject column, the 2 represents the activity column.
smaller_data <- big_data[,c(1,2,as.numeric(final_features$V1)+2)]

#Creating a reference vector. Each activity is placed in the index corresponding to its
#value according to the activity_labels text file. 
reference_vec <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING"
                   ,"STANDING","LAYING")

#Utilizing the reference vector by changing all of the observations in V1.1 (activity
#column) in smaller_data. This changes the meaningless numerical values to something
#understandable. 
smaller_data$V1.1 <- reference_vec[smaller_data$V1.1]

#Renaming the subject (V1) and the activity (V1.1), and the remaining columns with
#the values of final_features. Substituting all "-" characters with  "." to increase
#legibility
colnames(smaller_data) <- c("Subject ID", "Activity", gsub("-", ".", final_features$V2 ))

#Changing the column names containing "f" to "freq"
colnames(smaller_data) <-sub("^f", "freq", colnames(smaller_data))

#Changing the column names containing "t" to "time"
colnames(smaller_data) <-sub("^t", "time", colnames(smaller_data))

#Ordering the dataframe by first Subject ID (1-30) and Activity. This is the data set 
#that contains all final names and is ordered first by subject ID then by activity
#label in alphabetical order 
ordered_data <- smaller_data[order(smaller_data$`Subject ID`,smaller_data$Activity),]

#Creating a tidy data frame that averages all of the observations for each variable
#from ordered_data that have the same subject ID and the same activity label. 
tidy_data <- summarize_all(group_by(smaller_data, `Subject ID`,Activity),.funs = mean )




