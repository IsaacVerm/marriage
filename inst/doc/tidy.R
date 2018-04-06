## ----setup, include=FALSE------------------------------------------------

library(knitr)

opts_chunk$set(echo=TRUE,
               warning=FALSE,
               message=FALSE,
               cache=FALSE)

devtools::load_all(here::here())


## ----year_of_birth_issues------------------------------------------------

select_worksheet(worksheet = "year_of_birth",
                 year = "2013",
                 type = "divorce")[1:20, ]




## ----tidy_year_of_birth--------------------------------------------------
types <- c("divorce","marriage")
years <- paste0("201", 3:4)

rep_years <- rep(years, times = length(types))
rep_types <- rep(types, each = length(years))

worksheets <- map2(.x = rep_years,
                   .y = rep_types,
                   .f = ~select_worksheet(worksheet = "year_of_birth",
                                          year = .x,
                                          type = .y)
                   )

tidy_args <- list(worksheet = worksheets,
                  year = rep_years,
                  type = rep_types)
tidy_dfs <- pmap(tidy_args,
                 function(worksheet, year, type) tidy_year_of_birth(worksheet, year, type)
                 )

year_of_birth <- bind_together(tidy_dfs)

save(year_of_birth,
     file = paste(data_path, "year_of_birth.RData", sep = "/")
     ) # data_path is object in tidy-year_of_birth.R


