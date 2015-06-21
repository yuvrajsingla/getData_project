## ReadMe to explain how all of the project scripts work and how they are connected 
***
#### Repo contains following file for the final project for the getData course on coursera

1. run_analysis.R : Main R script to fetch data and prepare tidy data that can be used for later analysis
    + Before running run_analysis.R, make sure you have the "UCI HAR Dataset" in the present working directory.
    + Running run_analysis.R, it reutrns the tidy data set and also generates a tindySet.txt file in the same folder which can be read using read.table
    + The script fetches and merges all the data to create one data set
    + It then extracts a subset of the dataset containing measurements that are based on the mean or standard deviation. 
    + Measurements such as "gravityMean" based on the angle variables were not considered as valid since they were processed form of already included angle variables.
    + It sets descriptive names of the activities rathen then mere IDs.
    + It also labels the variables with descriptive names which increases readability and helps the user better understand how the measurement was obtained. 
    + It then generates a tidy data text file that meets the principles of wide form of tidy data. [1][2]
2. codebook.md : a code book that describes the variables, the data, and any transformations or work that was performed to clean up the data
    + It also has the specific description of the tidy data file contents
    + It also discusses which functions were used for the transformation and what was the motivation behind using those function.s
3. UCI HAR Dataset : a copy of the dataset folder so that the script can be run directly on the dataset

***
#### Code for reading the tidy data into R
```
address <- "https://s3.amazonaws.com/coursera-uploads/user-c88ccad3531a3b2e39a4edab/973502/asst-3/357cf5d0186a11e5ac551547e6597696.txt"
address <- sub("^https", "http", address)
tidyData <- read.table(url(address), header = TRUE) 
View(tidyData)
```

Citation :  
[1] https://class.coursera.org/getdata-015/forum/thread?thread_id=26  
[2] https://class.coursera.org/getdata-015/forum/thread?thread_id=27  