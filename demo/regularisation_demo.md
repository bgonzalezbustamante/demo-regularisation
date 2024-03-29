Regularisation and Cross-Validation
================

## Packages and Data

``` r
## Packages
library(caret)
library(tidyverse)
library(coefplot)
library(stargazer)
library(glmnet)
library(broom)
```

``` r
## Data
vdem_wb <- read.csv("../data/raw/vdem_wb.csv", encoding = "UTF-8")

## Descriptives
nrow(vdem_wb)
```

    ## [1] 27013

``` r
min(vdem_wb$year)
```

    ## [1] 1789

``` r
max(vdem_wb$year)
```

    ## [1] 2019

``` r
length(unique(vdem_wb$country))
```

    ## [1] 202

``` r
## Drop NAs
vdem_wb <- na.omit(vdem_wb) 
```

## OLS Regularisation

``` r
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
```

![](regularisation_demo_files/figure-gfm/ols1-1.png)<!-- -->

The predictions are used to compare the test set and the Root Mean
Square Error (RMSE) measure. The lowest values are better, however, it
could compromise parsimonious.

``` r
## Review Predicted Observations on the Test Set
slm_train_test <- predict(slm_train, test_set)
mlm_train_test <- predict(mlm_train, test_set)

## Calculate Root Mean Squared Error (RMSE)
rmse_slm <- data.frame(predicted = slm_train_test, actual = test_set$egal_dem, 
                     se = ((slm_train_test - test_set$egal_dem) ^ 2 / 
                             length(slm_train_test)))

sqrt(sum(rmse_slm$se))
```

    ## [1] 0.2519691

``` r
rmse_mlm <- data.frame(predicted = mlm_train_test, actual = test_set$egal_dem, 
                     se = ((mlm_train_test - test_set$egal_dem)^2 /
                             length(mlm_train_test)))

sqrt(sum(rmse_mlm$se))
```

    ## [1] 0.08815624

## K-Fold Cross-Validation

K-fold cross-validation implies a random division of the data set into
*k*-*h* folder, generally *k* = 10. The first fold is considered a test
set for validation, and the models are fitted in the remaining ones.

``` r
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

stargazer(kf_resample, type = "html", summary = FALSE, rownames = FALSE, 
          header = FALSE, style = "ajps", 
          title = "10-Fold Cross-Validation Results", 
          notes = "Source: Compiled by author using V-Dem (2020) and World Bank (2021) data.", 
          notes.align = "c")
```

<table style="text-align:center">
<caption>
<strong>10-Fold Cross-Validation Results</strong>
</caption>
<tr>
<td colspan="7" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
RMSE-SLR
</td>
<td>
RMSE-MLR
</td>
<td>
R2-SLR
</td>
<td>
R2-MLR
</td>
<td>
MAE-SLR
</td>
<td>
MAE-MLR
</td>
<td>
Resample
</td>
</tr>
<tr>
<td colspan="7" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
0.251
</td>
<td>
0.093
</td>
<td>
0.032
</td>
<td>
0.867
</td>
<td>
0.220
</td>
<td>
0.074
</td>
<td>
Fold01
</td>
</tr>
<tr>
<td style="text-align:left">
0.256
</td>
<td>
0.091
</td>
<td>
0.008
</td>
<td>
0.872
</td>
<td>
0.225
</td>
<td>
0.073
</td>
<td>
Fold02
</td>
</tr>
<tr>
<td style="text-align:left">
0.250
</td>
<td>
0.087
</td>
<td>
0.013
</td>
<td>
0.883
</td>
<td>
0.221
</td>
<td>
0.070
</td>
<td>
Fold03
</td>
</tr>
<tr>
<td style="text-align:left">
0.251
</td>
<td>
0.087
</td>
<td>
0.006
</td>
<td>
0.885
</td>
<td>
0.219
</td>
<td>
0.071
</td>
<td>
Fold04
</td>
</tr>
<tr>
<td style="text-align:left">
0.255
</td>
<td>
0.086
</td>
<td>
0.014
</td>
<td>
0.887
</td>
<td>
0.224
</td>
<td>
0.070
</td>
<td>
Fold05
</td>
</tr>
<tr>
<td style="text-align:left">
0.252
</td>
<td>
0.085
</td>
<td>
0.021
</td>
<td>
0.889
</td>
<td>
0.220
</td>
<td>
0.069
</td>
<td>
Fold06
</td>
</tr>
<tr>
<td style="text-align:left">
0.250
</td>
<td>
0.086
</td>
<td>
0.015
</td>
<td>
0.887
</td>
<td>
0.219
</td>
<td>
0.070
</td>
<td>
Fold07
</td>
</tr>
<tr>
<td style="text-align:left">
0.251
</td>
<td>
0.087
</td>
<td>
0.024
</td>
<td>
0.883
</td>
<td>
0.221
</td>
<td>
0.071
</td>
<td>
Fold08
</td>
</tr>
<tr>
<td style="text-align:left">
0.259
</td>
<td>
0.089
</td>
<td>
0.008
</td>
<td>
0.880
</td>
<td>
0.227
</td>
<td>
0.071
</td>
<td>
Fold09
</td>
</tr>
<tr>
<td style="text-align:left">
0.253
</td>
<td>
0.088
</td>
<td>
0.022
</td>
<td>
0.878
</td>
<td>
0.223
</td>
<td>
0.072
</td>
<td>
Fold10
</td>
</tr>
<tr>
<td colspan="7" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td colspan="7">
Source: Compiled by author using V-Dem (2020) and World Bank (2021)
data.
</td>
</tr>
</table>

## LOOCV Method

LOOCV uses a simple observation of the dataset as a test set, while the
remaining cases are considered a training set. Then, the model is fitted
on the training set, and the predictions are used to compare with the
excluded observation.

``` r
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

stargazer(cv_table, type = "html", summary = FALSE, rownames = FALSE, 
          header = FALSE, style = "ajps", 
          title = "10-Fold Cross-Validation and LOOCV", 
          notes = "Source: Compiled by author using V-Dem (2020) and World Bank (2021) data.", 
          notes.align = "c")
```

<table style="text-align:center">
<caption>
<strong>10-Fold Cross-Validation and LOOCV</strong>
</caption>
<tr>
<td colspan="5" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
Measure
</td>
<td>
KF-SLR
</td>
<td>
KF-MLR
</td>
<td>
LOOCV-SLR
</td>
<td>
LOOCV-MLR
</td>
</tr>
<tr>
<td colspan="5" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td style="text-align:left">
RMSE
</td>
<td>
0.253
</td>
<td>
0.088
</td>
<td>
0.253
</td>
<td>
0.088
</td>
</tr>
<tr>
<td style="text-align:left">
Rsquared
</td>
<td>
0.016
</td>
<td>
0.881
</td>
<td>
0.013
</td>
<td>
0.881
</td>
</tr>
<tr>
<td style="text-align:left">
MAE
</td>
<td>
0.222
</td>
<td>
0.071
</td>
<td>
0.222
</td>
<td>
0.071
</td>
</tr>
<tr>
<td colspan="5" style="border-bottom: 1px solid black">
</td>
</tr>
<tr>
<td colspan="5">
Source: Compiled by author using V-Dem (2020) and World Bank (2021)
data.
</td>
</tr>
</table>

## Shrinkage Methods

### Ridge Regression

Ridge regression is similar to OLS, but it includes a shrinkage penalty
*lambda* in the equation, which is small when *beta* coefficients are
near to zero.

``` r
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
```

![](regularisation_demo_files/figure-gfm/ridge-1.png)<!-- -->

``` r
ridge$lambda.min
```

    ## [1] 0.02155215

``` r
log(ridge$lambda.min) ## Vertical Line 1
```

    ## [1] -3.83728

``` r
log(ridge$lambda.1se) ## Vertical Line 2
```

    ## [1] -3.558179

``` r
## MSE Ridge Model
## s = 0, OLS Model
pred_ridge <- predict(ridge, s = ridge$lambda.min, newx = x2)
mse_ridge <- mean((test_set$egal_dem - pred_ridge)^2)
coef(ridge, s = ridge$lambda.min)
```

    ## 9 x 1 sparse Matrix of class "dgCMatrix"
    ##                        s1
    ## (Intercept) -5.844769e-01
    ## year         4.342589e-04
    ## corruption  -3.357150e-01
    ## military    -9.299923e-02
    ## free_exp     4.200462e-01
    ## fed_uni      6.307179e-02
    ## inflation   -5.987034e-06
    ## gdp         -5.095104e-03
    ## gdp_pc       4.737862e-03

``` r
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
```

![](regularisation_demo_files/figure-gfm/ridge-2.png)<!-- -->

### LASSO

LASSO model is similar to Ridge regression. The main difference is that
the penalty term is replaced, which forces some *beta* coefficients to
be zero. Therefore, while Ridge tends to include all variables in the
final model because a higher *lamda* only reduces the beta coefficients
towards zero. In sum, LASSO allows the selection/exclusion of variables
since a significant tuning parameter should force several *beta*
coefficients to be equal to zero.

``` r
## LASSO Model
set.seed(20211118)
lasso <- cv.glmnet(x = x , y = train_set$egal_dem, family = "gaussian", alpha = 1)
plot(lasso, sub = "LASSO Model")
```

![](regularisation_demo_files/figure-gfm/lasso-1.png)<!-- -->

``` r
coef(lasso, s = lasso$lambda.min)
```

    ## 9 x 1 sparse Matrix of class "dgCMatrix"
    ##                        s1
    ## (Intercept) -3.548772e-01
    ## year         3.227773e-04
    ## corruption  -3.464308e-01
    ## military    -5.896220e-02
    ## free_exp     4.553965e-01
    ## fed_uni      3.818824e-02
    ## inflation   -6.231470e-06
    ## gdp         -1.744492e-02
    ## gdp_pc       1.748148e-02

``` r
## LASSO Model
coef(lasso, s = "lambda.1se") %>%
  tidy() %>%
  filter(row != "(Intercept)") %>%
  ggplot(aes(value, reorder(row, value), color = value > 0)) +
  geom_point(show.legend = FALSE) + theme_minimal() +
  ggtitle("Influential Variables LASSO Model")  +
  xlab("Coefficient") +
  ylab("Predictors")
```

![](regularisation_demo_files/figure-gfm/lasso-2.png)<!-- -->

``` r
## MSE LASSO Model
pred_lasso <- predict(lasso, s = lasso$lambda.min, newx = x2)
mse_lasso <- mean((test_set$egal_dem - pred_lasso)^2) 

## Comparison Ridge and LASSO
mse_ridge
```

    ## [1] 0.008317099

``` r
mse_lasso
```

    ## [1] 0.007779615
