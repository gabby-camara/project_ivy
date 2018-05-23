Prediction
================

Multiple linear regression
--------------------------

At a first glance we tried 4 different multiple linear regression models.

-   saturated: model containing al variables
-   area: model with only area related varialbes
-   cluster: model using the first 7 principal components (with addresses 90% of the total variance) and the area cluster
-   qual: model containing only quality related variables, which have been enumerated.

The results of these models are as follows:

``` r
# results
results = data.frame(
  AdjRsq = lapply(lm_models, '[[', 'arsq') %>% unlist() %>% round(., 3),
  TrainError = lapply(lm_models, '[[', 'err') %>% unlist() %>% round(., 3),
  TestError = lapply(lm_models, '[[', 'pred_score') %>% unlist() %>% round(., 3))
print(results)
```

    ##         AdjRsq TrainError TestError
    ## satured  0.931      0.042     0.157
    ## area     0.801      0.077     0.169
    ## cluster  0.829      0.071     0.166
    ## qual     0.746      0.087     0.203

Let's use the area and cluster models as examples to see if we can further improve the accuracy.

``` r
require(car)
```

    ## Loading required package: car

    ## Warning: package 'car' was built under R version 3.4.4

    ## Loading required package: carData

    ## Warning: package 'carData' was built under R version 3.4.4

    ## 
    ## Attaching package: 'car'

    ## The following object is masked from 'package:dplyr':
    ## 
    ##     recode

    ## The following object is masked from 'package:purrr':
    ## 
    ##     some

``` r
vif(lm_models$area$fit)
```

    ##                   GVIF Df GVIF^(1/(2*Df))
    ## LotFrontage   1.545091  1        1.243017
    ## LotArea       1.213841  1        1.101745
    ## MasVnrArea    1.341652  1        1.158297
    ## BsmtUnfSF     1.367250  1        1.169295
    ## TotalBsmtSF   3.947838  1        1.986917
    ## GrLivArea   119.941262  1       10.951770
    ## GarageArea    1.726111  1        1.313815
    ## OverallQual   2.466877  1        1.570630
    ## x_1stFlrSF   69.711847  1        8.349362
    ## x_2ndFlrSF   89.401113  1        9.455216
    ## PoolArea      1.076267  1        1.037433
    ## area_cl      12.413458  2        1.877039

``` r
summary(lm_models$area$fit)
```

    ## 
    ## Call:
    ## lm(formula = formula, data = train)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -1.02917 -0.03054  0.00608  0.04375  0.33250 
    ## 
    ## Coefficients:
    ##               Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)  4.579e+00  1.361e-02 336.377  < 2e-16 ***
    ## LotFrontage  2.355e-05  1.091e-04   0.216 0.829184    
    ## LotArea      1.109e-06  2.239e-07   4.952 8.22e-07 ***
    ## MasVnrArea  -2.544e-06  1.299e-05  -0.196 0.844788    
    ## BsmtUnfSF   -3.878e-05  5.367e-06  -7.225 8.10e-13 ***
    ## TotalBsmtSF  5.721e-05  9.186e-06   6.228 6.19e-10 ***
    ## GrLivArea   -4.394e-05  4.227e-05  -1.040 0.298724    
    ## GarageArea   1.354e-04  1.246e-05  10.863  < 2e-16 ***
    ## OverallQual  6.128e-02  2.303e-03  26.606  < 2e-16 ***
    ## x_1stFlrSF   1.312e-04  4.380e-05   2.995 0.002796 ** 
    ## x_2ndFlrSF   1.543e-04  4.393e-05   3.512 0.000459 ***
    ## PoolArea    -1.910e-04  5.237e-05  -3.647 0.000275 ***
    ## area_cl2     1.939e-02  9.639e-03   2.012 0.044450 *  
    ## area_cl3     3.254e-02  1.178e-02   2.761 0.005831 ** 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.07747 on 1446 degrees of freedom
    ## Multiple R-squared:  0.8023, Adjusted R-squared:  0.8006 
    ## F-statistic: 451.5 on 13 and 1446 DF,  p-value: < 2.2e-16

``` r
require(car)
vif(lm_models$cluster$fit)
```

    ##              GVIF Df GVIF^(1/(2*Df))
    ## PC1      1.842150  1        1.357258
    ## PC2      1.354440  1        1.163804
    ## PC3      4.609340  1        2.146937
    ## PC4      2.075648  1        1.440711
    ## PC5      1.093911  1        1.045902
    ## PC6      1.050723  1        1.025048
    ## PC7      1.025897  1        1.012866
    ## PC8      1.138886  1        1.067186
    ## PC9      1.246622  1        1.116522
    ## PC10     1.034956  1        1.017328
    ## PC11     1.130874  1        1.063425
    ## PC12     1.021513  1        1.010699
    ## PC13     1.069056  1        1.033952
    ## area_cl 11.889498  2        1.856910

``` r
summary(lm_models$cluster$fit)
```

    ## 
    ## Call:
    ## lm(formula = formula, data = train)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.84244 -0.03347  0.00563  0.04006  0.21948 
    ## 
    ## Coefficients:
    ##               Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)  5.2028165  0.0057402 906.378  < 2e-16 ***
    ## PC1         -0.0576698  0.0009799 -58.856  < 2e-16 ***
    ## PC2          0.0060164  0.0013618   4.418 1.07e-05 ***
    ## PC3         -0.0171271  0.0029479  -5.810 7.68e-09 ***
    ## PC4         -0.0171296  0.0021200  -8.080 1.35e-15 ***
    ## PC5         -0.0120176  0.0017285  -6.953 5.42e-12 ***
    ## PC6          0.0022207  0.0018884   1.176 0.239799    
    ## PC7         -0.0039219  0.0019769  -1.984 0.047465 *  
    ## PC8         -0.0008062  0.0022138  -0.364 0.715788    
    ## PC9         -0.0100357  0.0021505  -4.667 3.34e-06 ***
    ## PC10        -0.0075298  0.0021971  -3.427 0.000627 ***
    ## PC11        -0.0058184  0.0022331  -2.605 0.009268 ** 
    ## PC12         0.0089741  0.0024247   3.701 0.000223 ***
    ## PC13         0.0016368  0.0026598   0.615 0.538413    
    ## area_cl2     0.0177705  0.0089568   1.984 0.047441 *  
    ## area_cl3     0.0405103  0.0107648   3.763 0.000174 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.0717 on 1444 degrees of freedom
    ## Multiple R-squared:  0.8309, Adjusted R-squared:  0.8292 
    ## F-statistic: 473.1 on 15 and 1444 DF,  p-value: < 2.2e-16

Let's remove variables that where the VIF &gt; 5 **or** are not significant. For the cluster model these include: **GrLivArea**, **LotFrontage**, **MasVnrArea**. For the cluster model these include: **PC6**, **PC8**, **PC13**.

``` r
lm_models$area_upd = f_update_model(update.formula(lm_models$area$formula, ~. - GrLivArea - LotFrontage - MasVnrArea))
lm_models$cluster_upd = f_update_model(update.formula(lm_models$cluster$formula, ~. - PC6 - PC8 - PC13))

anova(lm_models$area$fit, lm_models$area_upd$fit)
```

    ## Analysis of Variance Table
    ## 
    ## Model 1: SalePriceLog ~ LotFrontage + LotArea + MasVnrArea + BsmtUnfSF + 
    ##     TotalBsmtSF + GrLivArea + GarageArea + OverallQual + x_1stFlrSF + 
    ##     x_2ndFlrSF + PoolArea + area_cl
    ## Model 2: SalePriceLog ~ LotArea + BsmtUnfSF + TotalBsmtSF + GarageArea + 
    ##     OverallQual + x_1stFlrSF + x_2ndFlrSF + PoolArea + area_cl
    ##   Res.Df    RSS Df  Sum of Sq     F Pr(>F)
    ## 1   1446 8.6787                           
    ## 2   1449 8.6855 -3 -0.0067704 0.376 0.7703

``` r
anova(lm_models$cluster$fit, lm_models$cluster_upd$fit)
```

    ## Analysis of Variance Table
    ## 
    ## Model 1: SalePriceLog ~ PC1 + PC2 + PC3 + PC4 + PC5 + PC6 + PC7 + PC8 + 
    ##     PC9 + PC10 + PC11 + PC12 + PC13 + area_cl
    ## Model 2: SalePriceLog ~ PC1 + PC2 + PC3 + PC4 + PC5 + PC7 + PC9 + PC10 + 
    ##     PC11 + PC12 + area_cl
    ##   Res.Df    RSS Df  Sum of Sq      F Pr(>F)
    ## 1   1444 7.4237                            
    ## 2   1447 7.4332 -3 -0.0094996 0.6159 0.6047

``` r
results = data.frame(
  AdjRsq = lapply(lm_models, '[[', 'arsq') %>% unlist() %>% round(., 3),
  TrainError = lapply(lm_models, '[[', 'err') %>% unlist() %>% round(., 3),
  TestError = lapply(lm_models, '[[', 'pred_score') %>% unlist() %>% round(., 3))
print(results)
```

    ##             AdjRsq TrainError TestError
    ## satured      0.931      0.042     0.157
    ## area         0.801      0.077     0.169
    ## cluster      0.829      0.071     0.166
    ## qual         0.746      0.087     0.203
    ## area_upd     0.801      0.077        NA
    ## cluster_upd  0.829      0.071        NA

The anova indicates that we can remove these variables, without any loss of information, but we didn't gain anything in terms of accuracy either.

Going through the above process for the saturated model is going to be extremely time consuming. Especially if it only means gaining efficiency and not accuracy. There must be a better way. One option would be to automate the variable selection via stepwise procedure.
