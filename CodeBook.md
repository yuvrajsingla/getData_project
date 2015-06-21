### Code Book for the Getting and Cleaning Data Course Project 
***
#### The goal is to fetch data and process it to prepare tidy data that can be used for later analysis
#####The script does the following tasks in order :

1. Merges the training and the test sets to create one data set.  
    + For merging it makes use of cbind and rbind functions to append column and rows respectively to a single dataser. This is faster and quite straight forward way of clipping data together.
2. Extracts only the measurements on the mean and standard deviation for each measurement.  
    + It first fetches the column/feature names from the features.txt file and changes the column names of the dataset created in step 1 to the feature names.  
    + It also adds renames the column header for last 2 variables i.e. subject and activity  
    + It then uses grepl matching function to pick all variables with the words mean or std in the name but exluding the ones which have a F immedicately following the word mean. (This is to exclude features that are based on meanFreq)  
    + It then gets the subset of the dataset to only include the valid variables from the last step.  
3. Uses descriptive activity names to name the activities in the data set  
    + It fetches the activity label information from activity_labels.txt file.  
    + It uses match function to perform a join on the activity field of the dataset with the first column (V1) of the table fetched from activity_labels.txt file and replaces the numeric activity Ids with appropriate descriptive labels.
4. Appropriately labels the data set with descriptive variable names.  
    + Descriptive variable names means names based on the action the variable is recording, for example the Jerk of the body on the z axis of the phone. [2]
    + It loops through all the column names of the data set and splits them on "-" getting three part of the variable name. 
    + In the next series of steps, it builds a string using the paste function checking for substring matches that give information of how the variable was computed.
    + The final string is of the form "standard deviation of the frequency signals of the Jerk based on the body acceleration on X axis"
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  
    + This last step generates wide form of tidy data
    + It does so by converting the dataset into a molten form for easy casting with the activity and subject as the id variables and all other measurements as measured variables.
    + It then uses dcast function to cast the molten data frame into a wide form of clean data and perform mean of all measured varibales over the id variables.

***
####The final Tidy DataSet contains following variables:

1. subject  
    + Values from 1 to 30 each representing one of the 30 subjects/volunteers
    
2. activity  
    + Represents the 6 activites that the subjext performed
    + WALKING
    + WALKING_UPSTAIRS
    + WALKING_DOWNSTAIRS
    + SITTING
    + STANDING
    + LAYING
    
3. mean of the time signals based on the body acceleration on X axis
    + Range : 0.22159824394 0.3014610196
4. mean of the time signals based on the body acceleration on Y axis  
    + Range : -0.0405139534294 -0.00130828765170213
5. mean of the time signals based on the body acceleration on Z axis  
    + Range : -0.152513899520833 -0.07537846886
6. standard deviation of the time signals based on the body acceleration on X axis  
    + Range : -0.996068635384615 0.626917070512821
7. standard deviation of the time signals based on the body acceleration on Y axis  
    + Range : -0.990240946666667 0.616937015333333
8. standard deviation of the time signals based on the body acceleration on Z axis  
    + Range : -0.987658662307692 0.609017879074074
9. mean of the time signals based on the gravity acceleration on X axis  
    + Range : -0.680043155060241 0.974508732
10. mean of the time signals based on the gravity acceleration on Y axis  
    + Range : -0.479894842941176 0.956593814210526
11. mean of the time signals based on the gravity acceleration on Z axis  
    + Range : -0.49508872037037 0.9578730416
12. standard deviation of the time signals based on the gravity acceleration on X axis  
    + Range : -0.996764227384615 -0.829554947808219
13. standard deviation of the time signals based on the gravity acceleration on Y axis  
    + Range : -0.99424764884058 -0.643578361424658
14. standard deviation of the time signals based on the gravity acceleration on Z axis  
    + Range : -0.990957249538462 -0.610161166287671
15. mean of the time signals of the Jerk based on the body acceleration on X axis  
    + Range : 0.0426880986186441 0.130193043809524
16. mean of the time signals of the Jerk based on the body acceleration on Y axis  
    + Range : -0.0386872111282051 0.056818586275
17. mean of the time signals of the Jerk based on the body acceleration on Z axis  
    + Range : -0.0674583919268293 0.0380533591627451
18. standard deviation of the time signals of the Jerk based on the body acceleration on X axis  
    + Range : -0.994604542264151 0.544273037307692
19. standard deviation of the time signals of the Jerk based on the body acceleration on Y axis  
    + Range : -0.989513565652174 0.355306716915385
20. standard deviation of the time signals of the Jerk based on the body acceleration on Z axis  
    + Range : -0.993288313333333 0.0310157077775926
21. mean of the time signals based on the gyrometer reading on X axis  
    + Range : -0.205775427307692 0.19270447595122
22. mean of the time signals based on the gyrometer reading on Y axis  
    + Range : -0.204205356087805 0.0274707556666667
23. mean of the time signals based on the gyrometer reading on Z axis  
    + Range : -0.0724546025804878 0.179102058245614
24. standard deviation of the time signals based on the gyrometer reading on X axis  
    + Range : -0.994276591304348 0.267657219333333
25. standard deviation of the time signals based on the gyrometer reading on Y axis  
    + Range : -0.994210471914894 0.476518714444444
26. standard deviation of the time signals based on the gyrometer reading on Z axis  
    + Range : -0.985538363333333 0.564875818162963
27. mean of the time signals of the Jerk based on the gyrometer reading on X axis  
    + Range : -0.157212539189362 -0.0220916265065217
28. mean of the time signals of the Jerk based on the gyrometer reading on Y axis  
    + Range : -0.0768089915604167 -0.0132022768074468
29. mean of the time signals of the Jerk based on the gyrometer reading on Z axis  
    + Range : -0.0924998531372549 -0.00694066389361702
30. standard deviation of the time signals of the Jerk based on the gyrometer reading on X axis  
    + Range : -0.99654254057971 0.179148649684615
31. standard deviation of the time signals of the Jerk based on the gyrometer reading on Y axis  
    + Range : -0.997081575652174 0.295945926186441
32. standard deviation of the time signals of the Jerk based on the gyrometer reading on Z axis  
    + Range : -0.995380794637681 0.193206498960417
33. mean of the magnitude of the time signals based on the body acceleration  
    + Range : -0.986493196666667 0.644604325128205
34. standard deviation of the magnitude of the time signals based on the body acceleration  
    + Range : -0.986464542615385 0.428405922622222
35. mean of the magnitude of the time signals based on the gravity acceleration  
    + Range : -0.986493196666667 0.644604325128205
36. standard deviation of the magnitude of the time signals based on the gravity acceleration  
    + Range : -0.986464542615385 0.428405922622222
37. mean of the magnitude of the time signals of the Jerk based on the body acceleration  
    + Range : -0.99281471515625 0.434490400974359
38. standard deviation of the magnitude of the time signals of the Jerk based on the body acceleration  
    + Range : -0.994646916811594 0.450612065720513
39. mean of the magnitude of the time signals based on the gyrometer reading  
    + Range : -0.980740846769231 0.418004608615385
40. standard deviation of the magnitude of the time signals based on the gyrometer reading  
    + Range : -0.981372675614035 0.299975979851852
41. mean of the magnitude of the time signals of the Jerk based on the gyrometer reading  
    + Range : -0.997322526811594 0.0875816618205128
42. standard deviation of the magnitude of the time signals of the Jerk based on the gyrometer reading  
    + Range : -0.997666071594203 0.250173204117966
43. mean of the frequency signals based on the body acceleration on X axis  
    + Range : -0.995249932641509 0.537012022051282
44. mean of the frequency signals based on the body acceleration on Y axis  
    + Range : -0.989034304057971 0.524187686888889
45. mean of the frequency signals based on the body acceleration on Z axis  
    + Range : -0.989473926666667 0.280735952206667
46. standard deviation of the frequency signals based on the body acceleration on X axis  
    + Range : -0.996604570307692 0.658506543333333
47. standard deviation of the frequency signals based on the body acceleration on Y axis  
    + Range : -0.990680395362319 0.560191344
48. standard deviation of the frequency signals based on the body acceleration on Z axis  
    + Range : -0.987224804307692 0.687124163703704
49. mean of the frequency signals of the Jerk based on the body acceleration on X axis  
    + Range : -0.994630797358491 0.474317256051282
50. mean of the frequency signals of the Jerk based on the body acceleration on Y axis  
    + Range : -0.989398823913043 0.276716853307692
51. mean of the frequency signals of the Jerk based on the body acceleration on Z axis  
    + Range : -0.992018447826087 0.157775692377778
52. standard deviation of the frequency signals of the Jerk based on the body acceleration on X axis  
    + Range : -0.995073759245283 0.476803887476923
53. standard deviation of the frequency signals of the Jerk based on the body acceleration on Y axis  
    + Range : -0.990468082753623 0.349771285415897
54. standard deviation of the frequency signals of the Jerk based on the body acceleration on Z axis  
    + Range : -0.993107759855072 -0.00623647528983051
55. mean of the frequency signals based on the gyrometer reading on X axis  
    + Range : -0.99312260884058 0.474962448333333
56. mean of the frequency signals based on the gyrometer reading on Y axis  
    + Range : -0.994025488297872 0.328817010088889
57. mean of the frequency signals based on the gyrometer reading on Z axis  
    + Range : -0.985957788 0.492414379822222
58. standard deviation of the frequency signals based on the gyrometer reading on X axis  
    + Range : -0.994652185217391 0.196613286661538
59. standard deviation of the frequency signals based on the gyrometer reading on Y axis  
    + Range : -0.994353086595745 0.646233637037037
60. standard deviation of the frequency signals based on the gyrometer reading on Z axis  
    + Range : -0.986725274871795 0.522454216314815
61. mean of the magnitude of the frequency signals based on the body acceleration  
    + Range : -0.986800645362319 0.586637550769231
62. standard deviation of the magnitude of the frequency signals based on the body acceleration  
    + Range : -0.987648484461539 0.178684580868889
63. mean of the magnitude of the frequency signals of the Jerk based on the body acceleration  
    + Range : -0.993998275797101 0.538404846128205
64. standard deviation of the magnitude of the frequency signals of the Jerk based on the body acceleration
    + Range : -0.994366667681159 0.316346415348718
65. mean of the magnitude of the frequency signals based on the gyrometer reading  
    + Range : -0.986535242105263 0.203979764835897
66. standard deviation of the magnitude of the frequency signals based on the gyrometer reading  
    + Range : -0.981468841692308 0.236659662496296
67. mean of the magnitude of the frequency signals of the Jerk based on the gyrometer reading  
    + Range : -0.997617389275362 0.146618569064407
68. standard deviation of the magnitude of the frequency signals of the Jerk based on the gyrometer reading
    + Range : -0.99758523057971 0.287834616098305
