train_y <- read.table("Y_train.txt", header = FALSE)
col_names <- read.table("features.txt", sep = "", header = FALSE)
train_subject <- read.table("subject_train.txt", sep = "", header = FALSE)
df_train <- read.table("X_train.txt", sep = "", header = FALSE, dec = ".", col.names = col_names$V2)
df_train <- cbind(train_subject, train_y, df_train)
names(df_train)[1] <- "subject"
names(df_train)[2] <- "activity_labels"

test_y <- read.table("Y_test.txt", header = FALSE)
test_subject <- read.table("subject_test.txt", sep = "", header = FALSE)
df_test <- read.table("X_test.txt", sep = "", header = FALSE, dec = ".", col.names = col_names$V2)
df_test <- cbind(test_subject, test_y, df_test)
names(df_test)[1] <- "subject"
names(df_test)[2] <- "activity_labels"
df_full <- rbind(df_train, df_test)

activity_labels <- read.table("activity_labels.txt", sep = "", header = FALSE)
df_full$activity_labels <- activity_labels[match(df_full$activity_labels, activity_labels$V1), 2]

df_mean_sd <- df_full %>% select(matches("mean|std"))

df_summary <- df_full %>% group_by(activity_labels, subject) %>% summarise_all(funs(mean))