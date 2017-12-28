# Function to read Excel file containing the dataset
readfile <- function(path_data){
  return (read_excel(path_data));
}

# Function to divide the dataset into training set(80%) and test set(20%)
divideDataset <- function(proj1.df){
  proj1.df$class.Continent <- as.factor(proj1.df$Continent)
  
  # Discarding Entity and Continent columns
  proj1.df <- as.data.frame(proj1.df[ , -which(names(proj1.df) %in% c("Entity","Continent"))])
  
  intrain <- createDataPartition(y = proj1.df$class.Continent, p= 0.8, list = FALSE)
  trainset <- proj1.df[intrain,]
  testset <- proj1.df[-intrain,]
  
  return(list(trainset,testset));
}

# Function to train SVM Model for classification
mySVM <- function(trainset){
  return (train(as.data.frame(trainset[, 1:4]),trainset$class.Continent, method='svmLinear3', preProcess = c("center", "scale"), tuneLength = 3))
}

# Function to predict Continent label for the test set data using SVM model
mySVMPredict <- function(svm_model,testset){
  pred_test <- predict(svm_model,as.data.frame(testset[, 1:4]))
  return (getResultMetrics(pred_test, testset$class.Continent));
}

# Function to train k-NN Model for classification
myKNN <- function(trainset){
  return (train(as.data.frame(trainset[, 1:4]),trainset$class.Continent, method='knn', preProcess = c("center", "scale"), tuneLength = 9))
}

# Function to predict Continent label for the test set data using k-NN model
myKNNPredict <- function(knn_model,testset){
  pred_test <- predict(knn_model,as.data.frame(testset[, 1:4]))
  return (getResultMetrics(pred_test, testset$class.Continent));
}

# Function to train Decision Tree Model (using RIPPER algorithm) for classification
myRIPPER <- function(trainset){
  return (train(as.data.frame(trainset[, 1:4]),trainset$class.Continent, method='JRip', preProcess = c("center", "scale"), tuneLength = 3))
}

# Function to predict Continent label for the test set data using Decision Tree model (RIPPER algorithm)
myRIPPERPredict <- function(rip_model,testset){
  pred_test <- predict(rip_model,as.data.frame(testset[, 1:4]))
  return (getResultMetrics(pred_test, testset$class.Continent));
}

# Function to train Decision Tree Model (using C4.5 algorithm) for classification
myC45 <- function(trainset){
  return (train(as.data.frame(trainset[, 1:4]),trainset$class.Continent, method='J48', preProcess = c("center", "scale"), tuneLength = 3))
}

# Function to predict Continent label for the test set data using Decision Tree model (C4.5 algorithm)
myC45Predict <- function(c45_model,testset){
  pred_test <- predict(c45_model,as.data.frame(testset[, 1:4]))
  return (getResultMetrics(pred_test, testset$class.Continent));
}

# Function to generate Confusion Matrix, Accuracy, Precision, Recall and F1-Measure for the model's predicted vs actual class labels
getResultMetrics<-function(predicted,actual)
{
  confMatrix <- confusionMatrix(predicted,actual,mode="prec_recall")
  accuracy <- confMatrix$overall['Accuracy']
  
  return(list(confMatrix,accuracy))
}


#install.packages(c("readxl","rJava","RWeka","LiblineaR","class","zeallot","gmodels","caret","e1071"))
#Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_144')

# Set to your dataset's file path
DATASET_FILEPATH <- "C:/Users/shikh/Documents/University of Florida/Courses/Sem2/Data Mining/Project 1/Submission/proj1_dataset.xlsx"

require(readxl)
require(rJava)
require(RWeka)
require(LiblineaR)
require(class)
require(zeallot)
require(gmodels)
require(caret)
require(e1071)

svm_results <- numeric()
knn_results <- numeric()
ripper_results <- numeric()
c45_results <- numeric()

set.seed(3033)

for(counter in 1:5)
{
  print("")
  print("Results Iteration")
  print(counter)
  print("")
  proj1 <-readfile(DATASET_FILEPATH)
  c(trainset,testset)%<-%divideDataset(proj1)
  
  svm_model <- mySVM(trainset)
  c(cf,accuracy)%<-%mySVMPredict(svm_model,testset)
  svm_results <- c(svm_results,accuracy)
  print("SVM algorithm:")
  print("Confusion Matrix")
  print(cf)
  
  knn_model <- myKNN(trainset)
  c(cf,accuracy)%<-%myKNNPredict(knn_model,testset)
  knn_results <- c(knn_results,accuracy)
  print("k-NN algorithm:")
  print ("Africa  Asia  Europe  North America   Oceania  South America")
  print("Confusion Matrix")
  print(cf)
  
  ripper_model <- myRIPPER(trainset)
  c(cf,accuracy)%<-%myRIPPERPredict(ripper_model,testset)
  ripper_results <- c(ripper_results,accuracy)
  print("RIPPER algorithm:")
  print("Confusion Matrix")
  print(cf)
  
  c45_model <- myC45(trainset)
  c(cf,accuracy)%<-%myC45Predict(c45_model,testset)
  c45_results <- c(c45_results,accuracy)
  print("C4.5 algorithm:")
  print("Confusion Matrix")
  print(cf)
}

classification_results_avg <- data.frame(matrix(ncol = 4, nrow = 1),row.names = c("Accuracy"))
colnames(classification_results_avg) <- c("SVM", "kNN", "RIPPER", "C45")
classification_results_avg$SVM <- c(mean(svm_results))
classification_results_avg$kNN <- c(mean(knn_results))
classification_results_avg$RIPPER <- c(mean(ripper_results))
classification_results_avg$C45 <- c(mean(c45_results))

classification_results_sd <- data.frame(matrix(ncol = 4, nrow = 1),row.names = c("Accuracy"))
colnames(classification_results_sd) <- c("SVM", "kNN", "RIPPER", "C45")
classification_results_sd$SVM <- c(sd(svm_results))
classification_results_sd$kNN <- c(sd(knn_results))
classification_results_sd$RIPPER <- c(sd(ripper_results))
classification_results_sd$C45 <- c(sd(c45_results))

