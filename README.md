# Getting_Cleaning_Data_Courseproj
Created by Sameen Salam

This repo contains run_analysis.R and codebook for the final project of the Getting and Cleaning Data Course in the Data Science Specialization provided by Johns Hopkins University. This algorithm selects from, organizes, and cleans up accelerometer data taken from Samsung Galaxy S phones. It is assumed that the user can download and save the files somewhere appropriate, and then can set the correct working directory in R.

First, this algorithm reads in the test, training, features, subjects, and activities datasets.

The test and training sets are then combined through rows. 

The features dataset is first parsed through to eliminate any features (aka variables) that do not contain "mean" or "std". This particular command also brings in variables with the name "meanfreq". These "meanfreq" features were removed by a subsequent command. 

The subject ID, Activity, and other variables (stored to final_features), would form the column names of the final dataset. 

Using a reference index vector, all of the numerical labeling in activity was replaced by interpretable labels for the activities (i.e. walking, laying, etc)

The variable names were also corrected. If a variable name contained ".t", it would be changed to ".time", and if it contained ".f", it would be changed to ".freq". 

The data was then ordered, first by Subject ID (numerical values 1-30), and then activity (ordered alphabetically)

The data was then condensed. Multiple observations of the same Subject ID and activity label was a trait of the original data. A mean was taken of every variable for which Subject ID and activity label were the same. This resulted in a final tidy dataset of 180 observations (30 subjects * 6 possible activities), where one observation was marked for every subject for each activity, saved in tidy_data.


