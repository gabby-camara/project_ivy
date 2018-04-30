

# combine data into one set - this ensures that factor levels are consistent
# =========================================
df = bind_rows(train, test, .id = 'id')

# first impute missing ages based on passenger title
# =========================================
titles = regmatches(df$name, regexpr(',\\s\\w+.', df$name))
df$titles = as.factor(gsub('[^A-Za-z]', '', titles))

# calc mean age by title and use it to impute missing ages
# -----------------------------------------
mu_ages = df %>%
  select(titles, age) %>%
  filter(!is.na(age)) %>%
  group_by(titles) %>%
  summarise(mu = mean(age))

df = left_join(df, mu_ages) %>%
  mutate(age = ifelse(is.na(age), mu, age))

df$mu = NULL
df$titles = NULL


# continue with other variables
# =========================================
df$sex = as.factor(df$sex)
df$pclass = as.factor(df$pclass)
df$child = as.factor(df$age < 12)
df$mother = as.factor(df$age > 22 & df$sex == 'female' & df$sibsp > 0)
df$father = as.factor(df$age > 22 & df$sex == 'male' & df$sibsp > 0)


# split into train, test
# =========================================
train = df[df$id == 1, c(names(train), 'child', 'mother', 'father')]
test = df[df$id == 2, c(names(test), 'child', 'mother', 'father')]
rm(df, mu_ages)
