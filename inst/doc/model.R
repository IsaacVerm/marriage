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


## ------------------------------------------------------------------------
marriage <- year_of_birth %>% # most modelling takes place on the aggregate level of belgium
  filter(type == "marriage" & region == "belgium")  %>% # so we don't mention belgium in the object name
  age_continuous

## ----split_data----------------------------------------------------------
ind <- 1:nrow(marriage)
train_ind <- sample(ind,
                    size = length(ind)*2/3)
test_ind <- setdiff(ind, train_ind)

marriage_train <- slice(marriage, train_ind)
marriage_test <- slice(marriage, test_ind)


## ----distribution_age_marriage-------------------------------------------
# average both years
marriage_train <- marriage_train %>%
  group_by(age, region) %>% 
  summarise(nr_marriages = round(mean(quantity),
                                 digits = 0))
  

# graph
ggplot(data = marriage_train,
       aes(x = age, y = nr_marriages)) +
  geom_line(group = 1) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  ylab("number of marriages")



## ----fit_polynomial_model------------------------------------------------

poly_model <- lm(nr_marriages ~ poly(age, 3), data = marriage_train)


## ----data_grid-----------------------------------------------------------
grid <- marriage_train %>%
  data_grid(age)


## ----add_predictions-----------------------------------------------------
grid <- grid %>%
  add_predictions(poly_model)

marriage_train <- marriage_train %>% 
  add_predictions(poly_model)


## ----visualize_predictions-----------------------------------------------
ggplot(data = marriage_train) +
  geom_line(aes(x = age, y = nr_marriages), group = 1) +
  geom_point(aes(x = age, y = pred), color = "red")


