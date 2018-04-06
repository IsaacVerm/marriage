## ----setup, include=FALSE------------------------------------------------

library(knitr)

opts_chunk$set(echo=TRUE,
               warning=FALSE,
               message=FALSE,
               cache=FALSE,
               fig.width=12,
               fig.height=8)

devtools::load_all(here::here())


## ----load_data-----------------------------------------------------------

load(file = paste(data_path, "year_of_birth.RData", sep = "/"))


