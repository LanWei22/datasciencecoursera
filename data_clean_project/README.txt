In the script, fisrt download the zip file from the url, and unzip it, and read each file into tables.
Merge the tables from train and test data frame into one data frame using rbind.
Merge train and test data, subject data and activity data together using cbind.
Select the columns with names that contain "mean" and "std".
Using "merge" merges the two tables by the same column name and remove the activity id, and just leave the activity name.
I follow the rule of "all lower case", "descriptive", "no underscores or dots or white spaces" to rename the columns.
Using "group_by" groups the raws by column value of "activity", "subject", and get the mean of each variable after grouping.
Finially write the result into a text file.
