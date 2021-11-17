## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#### Script ID ####

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

## Script Data Cleaning: V-Dem and World Bank
## R version 4.1.0 (2021-05-18) -- "Camp Pontanezen"
## Date: November 2021

## Bastián González-Bustamante (University of Oxford, UK)
## ORCID iD 0000-0003-1510-6820
## https://bgonzalezbustamante.com

## Regularisation and Cross-Validation: Demonstration for R
## https://github.com/bgonzalezbustamante/demo-regularisation/

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#### Packages and Data ####

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

## Clean Environment
rm(list = ls())

## Packages
library(caret)
library(tidyverse)
library(coefplot)
library(stargazer)
library(glmnet)
library(broom)

## Data
vdem_wb <- read.csv("data/vdem_wb.csv", encoding = "UTF-8")

## Descriptives
nrow(vdem_wb)
min(vdem_wb$year)
max(vdem_wb$year)
length(unique(vdem_wb$country))

## Drop NAs
vdem_wb <- na.omit(vdem_wb) 

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#### OLS Regularisation ####

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

## Training Set (80%) and Test Set (20%)
set.seed(20211118)
train_index <- createDataPartition(vdem_wb$egal_dem, p = 0.8, list = FALSE)
train_set <- as.data.frame(vdem_wb[train_index,])
test_set <- as.data.frame(vdem_wb[-train_index,])

## Linear Models on the Train Set
slm_train <- lm(egal_dem ~ gdp, data = train_set)
mlm_train <- lm(egal_dem ~ ., data = train_set[-1])

## Coefplot
coefplot(mlm_train, title = "Coefficient Plot Training Set", color = "tomato")

## Review Predicted Observations on the Test Set
slm_train_test <- predict(slm_train, test_set)
mlm_train_test <- predict(mlm_train, test_set)

## Calculate Root Mean Squared Error (RMSE)
rmse_slm <- data.frame(predicted = slm_train_test, actual = test_set$egal_dem, 
                     se = ((slm_train_test - test_set$egal_dem) ^ 2 / 
                             length(slm_train_test)))

sqrt(sum(rmse_slm$se))

rmse_mlm <- data.frame(predicted = mlm_train_test, actual = test_set$egal_dem, 
                     se = ((mlm_train_test - test_set$egal_dem)^2 /
                             length(mlm_train_test)))

sqrt(sum(rmse_mlm$se))

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#### K-Fold Cross-Validation ####

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

## 10-Fold Cross-Validation
set.seed(20211118)
k10_cv <- trainControl(method = "cv", number = 10)
kf_slm <- train(egal_dem ~ gdp, data = vdem_wb, trControl = k10_cv, method = "lm")
kf_mlm <- train(egal_dem ~ ., data = vdem_wb[-1], trControl = k10_cv, method = "lm")

## Resample Comparison
kf_resample <- data.frame(kf_slm$resample, kf_mlm$resample)
kf_resample <- kf_resample[ ,!colnames(kf_resample) == "Resample.1"]
kf_resample <- kf_resample[,c(1,5,2,6,3,7,4)]
names(kf_resample)[1] = "RMSE-SLR"
names(kf_resample)[2] = "RMSE-MLR"
names(kf_resample)[3] = "R2-SLR"
names(kf_resample)[4] = "R2-MLR"
names(kf_resample)[5] = "MAE-SLR"
names(kf_resample)[6] = "MAE-MLR"

stargazer(kf_resample, type = "html", out = "output/table_1.html", 
          summary = FALSE, rownames = FALSE, header = FALSE,style = "ajps", 
          title = "10-Fold Cross-Validation Results", 
          notes = "Source: Compiled by author using V-Dem (2020) and World Bank (2021) data.", 
          notes.align = "c")

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#### LOOCV Cross-Validation ####

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

## Leave-One-Out Cross-Validation (LOOCV)
set.seed(20211118)
loocv <- trainControl(method = "LOOCV")
loocv_slm <- train(egal_dem ~ gdp, data = vdem_wb, trControl = loocv, method = "lm")
loocv_mlm <- train(egal_dem ~ ., data = vdem_wb[-1], trControl = loocv, method = "lm")

## Comparison KF-CV and LOOCV
cv_table <- data.frame(Measure = c(names(kf_mlm$results)[2], names(kf_mlm$results)[3],
                                   names(kf_mlm$results)[4]),
                       KF_SLR = c(kf_slm$results[1,2], kf_slm$results[1,3],
                                  kf_slm$results[1,4]),
                       KF_MLR = c(kf_mlm$results[1,2], kf_mlm$results[1,3],
                                  kf_mlm$results[1,4]),
                       LOOCV_SLR = c(round(loocv_slm$results[1,2], digits = 3),
                                     round(loocv_slm$results[1,3], digits = 3),
                                     format((round(loocv_slm$results[1,4], 
                                                   digits = 3)), nsmall = 3)),
                       LOOCV_MLR = c(round(loocv_mlm$results[1,2], digits = 3),
                                     round(loocv_mlm$results[1,3], digits = 3),
                                     round(loocv_mlm$results[1,4], digits = 3)))
names(cv_table)[2] = "KF-SLR"
names(cv_table)[3] = "KF-MLR"
names(cv_table)[4] = "LOOCV-SLR"
names(cv_table)[5] = "LOOCV-MLR"

stargazer(cv_table, type = "html", out = "output/table_2.html", 
          summary = FALSE, rownames = FALSE, header = FALSE, style = "ajps", 
          title = "10-Fold Cross-Validation and LOOCV", 
          notes = "Source: Compiled by author using V-Dem (2020) and World Bank (2021) data.", 
          notes.align = "c")

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

#### Shrinkage Methods ####

## +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

## Matrix of Factors and Possible Interactions
## X excluding country dummies N = 38,528
x <- model.matrix(egal_dem ~ ., data = train_set[-1])[,-1] 
x2 <- model.matrix(egal_dem ~ ., data = test_set[-1])[,-1]

## Ridge Regression
set.seed(20211118)
ridge <- cv.glmnet(x = x , y = train_set$egal_dem, family = "gaussian", 
                   alpha = 0)

## Examine Log-Lambdas to Identify the Lowest MSE
plot(ridge, sub = "Ridge Regression") 
ridge$lambda.min
log(ridge$lambda.min) ## Vertical Line 1
log(ridge$lambda.1se) ## Vertical Line 2

## MSE Ridge Model
## s = 0, OLS Model
pred_ridge <- predict(ridge, s = ridge$lambda.min, newx = x2)
mse_ridge <- mean((test_set$egal_dem - pred_ridge)^2)
coef(ridge, s = ridge$lambda.min)

## Plot Ridge Model
coef(ridge, s = "lambda.1se") %>%
  tidy() %>%
  filter(row != "(Intercept)") %>%
  top_n(70, wt = abs(value)) %>%
  ggplot(aes(value, reorder(row, value))) +
  geom_point(size = 1.5, color = "Tomato") + theme_minimal() +
  ggtitle("Influential Variables Ridge Regression") +
  xlab("Coefficient") +
  ylab("Predictors")

## LASSO Model
set.seed(20211118)
lasso <- cv.glmnet(x = x , y = train_set$egal_dem, family = "gaussian", alpha = 1)
plot(lasso, sub = "LASSO Model")
coef(lasso, s = lasso$lambda.min)

## LASSO Model
coef(lasso, s = "lambda.1se") %>%
  tidy() %>%
  filter(row != "(Intercept)") %>%
  ggplot(aes(value, reorder(row, value), color = value > 0)) +
  geom_point(show.legend = FALSE) + theme_minimal() +
  ggtitle("Influential Variables LASSO Model")  +
  xlab("Coefficient") +
  ylab("Predictors")

## MSE LASSO Model
pred_lasso <- predict(lasso, s = lasso$lambda.min, newx = x2)
mse_lasso <- mean((test_set$egal_dem - pred_lasso)^2) 

## Comparison Ridge and LASSO
mse_ridge
mse_lasso
