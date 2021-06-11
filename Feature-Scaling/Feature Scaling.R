#data processing 

#importing datadset
dataset = read.csv('data.csv')

#taking care of missing data
dataset$Age = ifelse(is.na(dataset$Age),
                     ave(dataset$Age, FUN = function(x) mean(x, na.rm = TRUE)),
                     dataset$Age)
dataset$Salary = ifelse(is.na(dataset$Salary),
                        ave(dataset$Salary, FUN = function(x) mean(x, na.rm = TRUE)),
                        dataset$Salary)

# Encoding categorical data
dataset$Country = factor(dataset$Country, 
                         levels = c('France','Spain','Germany'), # c is a vector 
                         labels = c(1,2,3)) # which number has to given for France,Spain,Germany
dataset$Purchased = factor(dataset$Purchased,
                         levels = c('No','Yes'),
                         labels = c(0,1)) # which number has to given for 'No','Yes'

#Splitting the dataset into the Training set and Test set 
install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$Purchased, SplitRatio = 0.8)
training_set = subset(dataset,split==TRUE)
test_set = subset(dataset,split==FALSE)

#Feature Scaling 
training_set[, 2:3] = scale(training_set[,2:3])
test_set[, 2:3] = scale(test_set[, 2:3])