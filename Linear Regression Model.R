# importing libraries
library(mlbench) # contains several benchmark data sets 
library(caret) # for machine learning algorithms 

# importing the data set
data(BostonHousing) # provided within ml bench package

head(BostonHousing)

# check missing data
sum(is.na(BostonHousing))

# set the random seed number
set.seed(100)

# performs random split of the data set
TrainingIndex <- createDataPartition(BostonHousing$medv, p=0.8, list = FALSE)
TrainingSet <- BostonHousing[TrainingIndex,] # training set
TestingSet <- BostonHousing[-TrainingIndex,] # test set


# build model
Model <- train(medv ~ ., data = TrainingSet,
               method = "lm",
               na.action = na.omit,
               preProcess=c("scale","center"),
               trControl= trainControl(method="none")
)

# apply model for prediction
Model.training <-predict(Model, TrainingSet) # apply model to make prediction on training set
Model.testing <-predict(Model, TestingSet) # apply model to make prediction on testing set

# displays scatter plot and performance metrics
plot(TrainingSet$medv,Model.training, col = "blue" )
plot(TestingSet$medv,Model.testing, col = "red" )
