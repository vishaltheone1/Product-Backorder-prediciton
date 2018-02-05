#initialization
library(caret)
library(dplyr)
library(pROC)
library(DMwR)

train_data = read.csv("Kaggle_Training_Dataset_v2.csv", header = T)
test_data = read.csv("Kaggle_Test_Dataset_v2.csv", header = T)


#data cleaning
good = complete.cases(train_data)
train_clean = train_data[good, ]

good1 = complete.cases(test_data)
test_clean = test_data[good1, ]

table(train_clean$went_on_backorder)

train_clean$sku = as.numeric(as.character(train_clean$sku))
test_clean$sku = as.numeric(as.character(test_clean$sku))
 

#yes/no to 1/0
indx = sapply(train_clean, is.factor)
indx1 = sapply(test_clean, is.factor)

train_clean[indx] = lapply(train_clean[indx], as.character)
test_clean[indx1] = lapply(test_clean[indx1], as.character)

train_clean[train_clean == "Yes"] = 1
train_clean[train_clean == "No"] = 0
test_clean[test_clean == "Yes"] = 1
test_clean[test_clean == "No"] = 0

train_clean[indx] = lapply(train_clean[indx], as.numeric)
test_clean[indx1] = lapply(test_clean[indx1], as.numeric)

train_clean$went_on_backorder = as.factor(train_clean$went_on_backorder)
test_clean$went_on_backorder = as.factor(test_clean$went_on_backorder)


#treating imbalance with SMOTE
prop.table(table(train_clean$went_on_backorder))

train_clean_data = SMOTE(went_on_backorder ~ ., train_clean, perc.over = 150, perc.under = 100)
prop.table(table(train_clean_data$went_on_backorder))
train_clean_data$went_on_backorder = as.numeric(train_clean_data$went_on_backorder)


#treebag model building
ctrl = trainControl(method = "cv", number = 5)
tbmod = train(went_on_backorder ~ ., data = train_clean_data[-1], method = "treebag", trControl = ctrl)
predictors = names(train_clean_data[names(train_clean_data) != "went_on_backorder"])
pred = predict(tbmod$finalModel, test_clean[ , predictors])


#checking results
auc = roc(test_clean$went_on_backorder, pred)
print(auc)
plot(auc)