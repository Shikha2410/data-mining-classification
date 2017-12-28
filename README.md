# Data Mining Classification
The goal of the project is to increase familiarity with the classification packages, available in R to do data mining analysis on real-world problems. Several different classification methods were used on the given Life Expectancy dataset. The dataset was obtained from the Wikipedia website. The continent column was added as per the requirements to be used as class label. kNN, Support Vector Machine, C4.5 and RIPPER were the classification methods used on the data set.

I. Working Environment
----------------------
RStudio (latest version)


II. Packages to be installed
-----------------------------
Run the following command in RStudio's console to install all the required packages:
install.packages(c("readxl","rJava","RWeka","LiblineaR","class","zeallot","gmodels","caret","e1071"))


III. Setting environment variables
-----------------------------------
After the "rJava" package is installed, copy the name of the 'jre' folder on your computer under C: > Program Files > Java. Replace {jre_folder_name} in the command below with this folder name, and execute the command in R console.
Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\{jre_folder_name}')


IV. Continued Instructions for Execution
-----------------------------------------
1. Set the DATASET_FILEPATH parameter in Project1_Classification.R to the complete file path of the input dataset (shared in the zipped folder).
2. Execute the functions in the beginning of the Project1_Classification.R file to load them into the R environment.
3. Run the script immediately after the functions in Project1_Classification.R to get the classification results.


V. Results
-----------
1. The confusion matrix is printed on the console for every algorithm per iteration. This matrix contains Accuracy, Precision per class, Recall per class, and F1-measure per class metrics.
2. classification_results_avg variable has comparative results of all classifiers for their Accuracy values averaged over the 5 iterations.
3. classification_results_sd variable has comparative results of all classifiers computed as the standard deviation of Accuracy values over the 5 iterations.
