
# pca
# =========================================
qual_vars = c('OverallQual',
              'ExterQual',
              'BsmtQual',
              'HeatingQC',
              'LowQualFinSF',
              'KitchenQual',
              'FireplaceQu',
              'GarageQual',
              'PoolQC',
              'Fence'
              )
pca = df[, c(qual_vars, area_vars)] %>%
  scale()

pca = prcomp(pca)[['x']] %>%
  as.data.frame()

pca[['Id']] = df[['Id']]


# join results to train & test
# =========================================
train = train %>%
  left_join(., pca)

test = test %>%
  left_join(., pca)

df = df %>%
  left_join(., pca)
rm(pca, qual_vars)

