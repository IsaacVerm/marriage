## ----setup, include=FALSE------------------------------------------------

library(knitr)

opts_chunk$set(echo=TRUE,
               warning=FALSE,
               message=FALSE,
               cache=FALSE)

devtools::load_all(here::here())


## ----download, eval = FALSE----------------------------------------------
#  types <- c("divorce","marriage")
#  years <- paste0("201", 3:6)
#  
#  rep_years <- rep(years, times = length(types))
#  rep_types <- rep(types, each = length(years))
#  
#  purrr::walk2(.x = rep_years,
#               .y = rep_types,
#               ~download(year = .x, type = .y))
#  

