
# combine into one data frame. This way the factor vars have the same configuration
# =========================================
df = bind_rows(train, test, .id = 'set_id')


# var lists - to be used later
# =========================================
none_vars = c('Alley', 
              'BsmtQual', 
              'BsmtCond', 
              'BsmtExposure', 
              'BsmtFinType1', 
              'BsmtFinType2', 
              'FireplaceQu', 
              'GarageType', 
              'GarageFinish',
              'GarageQual',
              'GarageCond',
              'PoolQC',
              'Fence',
              'MiscFeature'
)

factor_vars = c('MSSubClass',
                'MSZoning',
                'Street',
                'Alley',
                'LotShape',
                'LandContour',
                'Utilities',
                'LotConfig',
                'LandSlope',
                'Neighborhood',
                'Condition1',
                'Condition2',
                'BldgType',
                'HouseStyle',
                'RoofStyle',
                'RoofMatl',
                'Exterior1st',
                'Exterior2nd',
                'MasVnrType',
                'Foundation',
                'Heating',
                'CentralAir',
                'Electrical',
                'Functional',
                'GarageType',
                'GarageFinish',
                'PavedDrive',
                'MiscFeature'
)

ord_factor_vars = c('OverallQual',
                    'OverallCond',
                    'ExterQual',
                    'ExterCond',
                    'BsmtQual',
                    'BsmtCond',
                    'BsmtExposure',
                    'BsmtFinType1',
                    'BsmtFinType2',
                    'HeatingQC',
                    'KitchenQual',
                    'FireplaceQu',
                    'GarageQual',
                    'GarageCond',
                    'PoolQC',
                    'Fence'
)


# explicitly set NA's based on data_desc.txt
# =========================================
ifna = function(var, replacement){
  ifelse(is.na(var), replacement, var)
}

df = df %>%
  mutate_at(none_vars, ifna, replacement = 'None')

# force the types of some variables
# =========================================
df = df %>%
  mutate_at(c(factor_vars,ord_factor_vars), as.factor)



# remodeled Yes/No
# basement Yes/No
# garage Yes/No
# WoodDeck Yes/No
# Porch Yes/No
# Pool Yes/No
# Age

# BsmtUnfSF/TotalBsmtSF - ratio >> maybe rather use complement as it'll ...
# GrLivArea/total home area