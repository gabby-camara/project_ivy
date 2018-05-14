
remove_vars = c('GarageYrBlt', 'GarageCars', 'BsmtUnfSF')
train[, remove_vars] = NULL
test[, remove_vars] = NULL

