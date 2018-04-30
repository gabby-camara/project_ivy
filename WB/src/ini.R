# load required libraries
# =========================================
require(tidyverse)


# load custom functions
# =========================================


# create data folder if not exists
# =========================================
subDir <- "data"
if (!file.exists(subDir)){
  dir.create(subDir)
}
