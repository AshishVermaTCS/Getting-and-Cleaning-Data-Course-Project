##STEP:0 >> SET THE WORKING DIRECTORY TO "~\getdata_projectfiles_UCI HAR Dataset\UCI HAR Dataset"

##STEP:1 >> LOAD TEST DATA SET [X_test.txt]
temp_test_data <- read.table("test\\X_test.txt")
temp_test_data$ID_Data <- seq.int(nrow(temp_test_data)) ##ADD SEQUENCE NUMBER

##STEP:2 >> LOAD ACTIVITIES FOR TEST DATA SET [Y_test.txt]
temp_test_Activity <- read.table("test\\y_test.txt")
temp_test_Activity$ID_Activity <- seq.int(nrow(temp_test_Activity)) ##ADD SEQUENCE NUMBER

##STEP:3 >> LOAD SUBJECTS USED IN TEST DATA SET [subject_test.txt]
temp_test_subject <- read.table("test\\subject_test.txt")
temp_test_subject$ID_Subject <- seq.int(nrow(temp_test_subject)) ##ADD SEQUENCE NUMBER

##MERGE DATA SET FROM 1,2 AND 3

test_merged <- merge(temp_test_data,temp_test_subject,by.x="ID_Data",by.y="ID_Subject")
names(test_merged)[names(test_merged)== "V1.x"] <- "V1"
names(test_merged)[names(test_merged)== "V1.y"] <- "Subject"

test_merged <- merge(test_merged,temp_test_Activity,by.x="ID_Data",by.y="ID_Activity")
names(test_merged)[names(test_merged)== "V1.x"] <- "V1"
names(test_merged)[names(test_merged)== "V1.y"] <- "Activity"

##STEP:4 >> LOAD TRAINING DATA SET [X_train.txt]
temp_train_data <- read.table("train\\X_train.txt")
temp_train_data$ID_Data <- seq.int(nrow(temp_train_data)) ##ADD SEQUENCE NUMBER

##STEP:5 >> LOAD ACTIVITIES FOR TRAINING DATA SET [Y_train.txt]
temp_train_Activity <- read.table("train\\Y_train.txt")
temp_train_Activity$ID_Activity <- seq.int(nrow(temp_train_Activity)) ##ADD SEQUENCE NUMBER

##STEP:6 >> LOAD SUBJECTS USED IN TRAINING DATA SET [subject_train.txt]
temp_train_subject <- read.table("train\\subject_train.txt")
temp_train_subject$ID_Subject <- seq.int(nrow(temp_train_subject)) ##ADD SEQUENCE NUMBER

##MERGE DATA SET FROM 4,5 AND 6

train_merged <- merge(temp_train_data,temp_train_subject,by.x="ID_Data",by.y="ID_Subject")
names(train_merged)[names(train_merged)== "V1.x"] <- "V1"
names(train_merged)[names(train_merged)== "V1.y"] <- "Subject"

train_merged <- merge(train_merged,temp_train_Activity,by.x="ID_Data",by.y="ID_Activity")
names(train_merged)[names(train_merged)== "V1.x"] <- "V1"
names(train_merged)[names(train_merged)== "V1.y"] <- "Activity"

##STEP:7 >> MERGE TEST AND TRAIN DATA SETS
final_full <- rbind(test_merged, train_merged)

##STEP:8 >> LOAD FEATURE DATA [features.txt]
columnlist <- read.table("features.txt")

##STEP:9 >> CLEANSE AND EXTRACT FEATURE DATA TO EXTRACT THE COLUMN SEQUENCE NUMBER FOR MEAN AND STANDARD DEVIATION COLUMNS
columnlist_mean <- grep("mean",columnlist[,c("V2")])
columnlist_std <- grep("std",columnlist[,c("V2")])

columnlist_temp <- columnlist[c(columnlist_mean,columnlist_std),]

##APPEND "V" TO THE COLUMN NAME
columnlist_temp$V1 <- paste("V",columnlist_temp$V1,sep="")

##STEP:10 >> FETCH THE RELEVANT COLUMNS FROM FINAL MERGED DATASET HAVING VARIABLE NAMES LIKE "MEAN" OR "STD"
final_subset <- final_full[,c(columnlist_temp$V1,"Subject","Activity")]

##STEP:11 >> RENAME COLUMNS

counter <- 1
numberofcolumn <- nrow(columnlist_temp)

while (counter <= numberofcolumn)
{
	colname <- as.character(columnlist_temp[counter,"V2"])
	names(final_subset)[names(final_subset)== columnlist_temp[counter,"V1"]] <- colname
	counter <- counter + 1
}

##STEP:12 >> UPDATE THE ACTIVITY NAMES
final_subset[final_subset$Activity == "1" , "Activity"] <- "WALKING"
final_subset[final_subset$Activity == "2" , "Activity"] <- "WALKING_UPSTAIRS"
final_subset[final_subset$Activity == "3" , "Activity"] <- "WALKING_DOWNSTAIRS"
final_subset[final_subset$Activity == "4" , "Activity"] <- "SITTING"
final_subset[final_subset$Activity == "5" , "Activity"] <- "STANDING"
final_subset[final_subset$Activity == "6" , "Activity"] <- "LAYING"

##STEP:13 >> CREATE A SECOND, INDEPENDENT TIDY DATA SET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT.
subset_2 <- aggregate(final_subset[,1:79], final_subset[,80:81], FUN = mean)

##STEP:14 >> WRITE THE FINAL DATA SET TO A .TXT FILE
write.table(subset_2,"Tidy Data Set_Subset.txt",row.name=FALSE)


