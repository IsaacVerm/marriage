split_data <- function(df, size_train_set) {
  ind <- 1:nrow(df)
  
  train_ind <- sample(ind,
                      size = length(ind)*size_train_set)
  test_ind <- setdiff(ind, train_ind)
  
  split_data_sets <- list()
  split_data_sets[["train"]] <- slice(df, train_ind)
  split_data_sets[["test"]] <- slice(df, test_ind)
  
  return(split_data_sets)
}

average_all_years <- 