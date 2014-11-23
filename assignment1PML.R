#----------------------------#
# PRACTICAL MACHINE LEARNING #
#----------------------------#

#---------------------------#
#  PROJECT FOR ASSIGNMENT 1 #
#---------------------------#

setwd("C:/Users/Sofia Cividini/Documents/COURSERA COURSES/Data Science Specialization_JHU/Practical Machine Learning/
Assignment1_Write up")
file.exists("C:/Users/Sofia Cividini/Documents/COURSERA COURSES/Data Science Specialization_JHU/Practical Machine Learning/
Assignment1_Write up")
getwd()

pml.training <- read.csv("C:/Users/Sofia Cividini/Documents/COURSERA COURSES/Data Science Specialization_JHU/
Practical Machine Learning/Assignment1_Write up/pml-training.csv", header=TRUE, sep=",")
pml.training <- edit(pml.training) 
# attributes(pml.training)
dim(pml.training)

library(caret)
library(randomForest)

# I delete all the columns where the data are almost all missing.

pml.training2 <- pml.training[,-c(12:36, 50:59, 69:83, 87:101, 103:112, 125:139, 141:150)]
pml.training2 <- edit(pml.training2) 
# attributes(pml.training2)
dim(pml.training2)

# I delete all the other variables which are not to be considered.

pml.training3 <- pml.training2[,-c(1:7)]
pml.training3 <- edit(pml.training3) 
dim(pml.training3)

# I do a plot for the exploratory analysis.

plot <- ggplot(pml.training3, aes(x=classe, fill=classe)) + geom_histogram()
plot 

#..........................................................................................
# Model with an Algorithm based on Random Forests.
#..........................................................................................

# I subdivided the data set called pml.training3 in a training data set (60% of observations) 
# and in a test dataset (40% of observations).

inTrain <- createDataPartition(y=pml.training3$classe, p=0.6, list=FALSE)
training <- pml.training3
training <- pml.training3[inTrain,]
testing <- pml.training3[-inTrain,]
dim(training); dim(testing)


# RANDOM FOREST

set.seed(12345)
modFit <- randomForest(classe ~ ., data=training, proximity=TRUE, importance=TRUE)
print(modFit)

# This plot shows the trend of the error along the 500 trees which were considered by the model.
plot(modFit, log="y")

# I take a look at the most important variables.
varImpPlot(modFit)

# I did a prediction on the testing data set
prediction <- predict(modFit, testing)
testing$predRight <- prediction==testing$classe
table(prediction, testing$classe)


