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



## ----distribution_age_marriage-------------------------------------------
recent_marriage_belgium <- year_of_birth %>%
  filter(year == "2014" & type == "marriage" & region == "belgium")

ggplot(data = recent_marriage_belgium,
       aes(x = age, y = quantity)) +
  geom_line(group = 1) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))



## ----regional_difference_age_marriage------------------------------------
# no german community and age as continuous variable
recent_marriage_regions <- year_of_birth %>%
  filter(year == "2014" & type == "marriage") %>% 
  only_main_regions %>%
  age_continuous

# percentages
recent_marriage_regions <- recent_marriage_regions %>% 
  percentage_of_total_by_region

# graph
ggplot(data = recent_marriage_regions,
       aes(x = age, y = percentage)) +
  geom_path(aes(color = region)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


## ----time_difference_age_marriage----------------------------------------
# marriage regions
marriage_regions <- year_of_birth %>%
  filter(type == "marriage") %>%
  age_continuous %>% 
  only_main_regions %>% 
  percentage_of_total_by_region

# year-to-year differences
marriage_regions <- marriage_regions %>%
  year_to_year_percentage_differences

# graph
ggplot(data = marriage_regions, aes(x = age, y = difference)) +
  geom_path(aes(color = region)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
  


