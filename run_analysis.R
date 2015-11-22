library(dplyr)

# Adds objectid column to the data frame which represents
# record # from 1 to n
add_oid <- function(df)
{
    num_of_records <- length(df[,1])
    
    mutate(df, objectid=1:num_of_records)
}

# reads main, subj and activity tables and
# merges them into a single data.frame
# activity and subject fields are in the end
# the first field is objectid (# of record)
get_har_dataset <- function(main, subj, activity)
{
    # read train dataset
    main.df <- read.table(main, header = FALSE)
    subj.df <- read.table(subj, header = FALSE)
    activity.df <- read.table(activity, header = FALSE)
    
    
    # we will join the three
    # need the field to join on (objectid)
    # and need unique variable names in the datasets to join
    subj.df <- subj.df %>% 
        add_oid %>%
        rename(subject = V1)
    
    activity.df <- activity.df %>% 
        add_oid %>%
        rename(activity = V1)
    
    main.df %>%
        add_oid %>%
        merge(activity.df, by.x = "objectid", by.y = "objectid") %>%
        merge(subj.df, by.x = "objectid", by.y = "objectid")
    
}

setwd("c:\\Coursera\\UCI HAR Dataset")

train.df <- get_har_dataset(".\\train\\X_train.txt",
                            ".\\train\\subject_train.txt",
                            ".\\train\\y_train.txt")


test.df <- get_har_dataset(".\\test\\X_test.txt",
                           ".\\test\\subject_test.txt",
                           ".\\test\\y_test.txt")

# REQUIREMENT #1: Merge two datasets
full_df <- rbind(test.df, train.df)

# check which measurements contain "std" and "mean" and only extract those
# plus subject and activity of course
# objectid is not needed anymore

# REQUIREMENT 2: extract only std and mean
# at the same time REQUIREMENT #4: 
# label dataset set with descriptive names
features <- read.table(".\\features.txt", header = FALSE)
features <- features %>%
    rename(objectid=V1) %>%
    rename(activitylabel=V2)

std_mean_features <- filter(features, 
       grepl("\\-mean\\(\\)",activitylabel, ignore.case = TRUE) | 
       grepl("\\-std\\(\\)",activitylabel, ignore.case = TRUE))

std_mean_field_indexes = std_mean_features$objectid

proper_names <- features$activitylabel

# for each column extract the data from full_df
# and write to a new data.frame under the correct name
renamed_fields_df = data.frame(objectid = full_df$objectid)
for(i in std_mean_field_indexes)
{
    # extract vector
    data <- full_df[,i+1] # need to shift by 1, first column is oid
    label = as.character(proper_names[i])
    renamed_fields_df[label] <- data
}

# REQUIREMENT#3: replace cryptic activity# with activity name
activity <- full_df$activity
activity_df <- read.table(".\\activity_labels.txt", header = FALSE)
labels <- activity_df$V2
activity_names <- labels[activity]
renamed_fields_df<- mutate(renamed_fields_df, activityname = activity_names)

# WRITE first dataset
write.table(renamed_fields_df, file = "tidy_ds_1.csv", row.names=FALSE)

# REQUIREMENT#6 - group by activity and subject and find mean of
# each variable
# add subject first
renamed_fields_df <- mutate(renamed_fields_df, subject = full_df$subject)
groupped <- group_by(renamed_fields_df, activityname, subject)

# calculate average for each of the variables

groupped_df <- summarize(groupped) # no summaries yet

for(i in std_mean_field_indexes)
{
    var_name = as.character(proper_names[i])
    formula <- paste0("mean(`", var_name, "`)")
    summed <- summarize_(groupped, summed_var = formula )
    
    # put it to the resultant DF
    groupped_df[[var_name]] <- summed$summed_var
}

write.table(groupped_df, file = "tidy_ds_2.csv", row.names=FALSE)