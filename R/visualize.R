only_main_regions <- function(df) {
  df %>% 
    filter(region %in% c("flanders","wallonia","brussels"))
}

age_continuous <- function(df) {
  df %>% 
    filter(!(age %in% c("60 en +","12-"))) %>% 
    mutate(age = as.numeric(as.character(age))) %>% 
    filter(age >= 18)
}

percentage_of_total_by_region <- function(df_without_perc) {
  nr_marriages_by_region <- df_without_perc %>%
    group_by(region) %>%
    summarise(total_marriages = sum(quantity))

  df_with_perc <- df_without_perc %>%
    left_join(., nr_marriages_by_region) %>%
    mutate(percentage = round((quantity/total_marriages)*100,
                              digits = 2)) %>% 
    select(-one_of(c("total_marriages")))
}