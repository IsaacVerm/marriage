regions <- c("belgium","brussels","flanders","wallonia","german_community")
data_path <- paste(here::here(), "data", sep = "/")

#' @import purrr
tidy_year_of_birth <- function(worksheet, year, type) {

  remove_description_header <- function(df) {
    headers <- df %>%
      .[1, ] %>%
      unlist(., use.names = FALSE)

    df %>%
      .[-1, ] %>%
      setNames(headers)
  }

  readable_column_names <- function(df) {
    readable_cols <- c("age",
                       "year_of_birth",
                       paste(rep(regions, each = 2),
                             c("first","second"),
                             sep = "_")
                       )

    df %>%
      setNames(readable_cols)
  }

  remove_total <- function(df) {
    df %>%
      .[-2, ]
  }

  remove_source <- function(df) {
    source_ind <- nrow(df):(nrow(df) - 2)

    df %>%
      .[-source_ind, ]
  }

  remove_spouse_row <- function(df) {
    df %>%
      .[-1, ]
  }

  summarise_spouse <- function(df) {
    region_pairs <- regions %>%
      purrr::map(~dplyr::select(df,
                                dplyr::one_of(paste(.,
                                                    c("first","second"),
                                                    sep = "_")))
      )

    sum_region_pairs <- region_pairs %>%
      purrr::map(~apply(X = .,
                        MARGIN = 1,
                        FUN = function(x) sum(as.numeric(x))))

    names(sum_region_pairs) <- regions

    dplyr::bind_cols(dplyr::select(df,
                                   dplyr::one_of(c("age","year_of_birth"))),
                     sum_region_pairs)
  }

  summarise_age <- function(df) {
    df %>%
      dplyr::select(-year_of_birth) %>%
      tidyr::fill(age) %>%
      dplyr::group_by(age) %>%
      dplyr::summarise_all(sum)
  }

  add_year <- function(df, year) {
    df$year <- year

    return(df)
  }

  add_type <- function(df, type) {
    df$type <- type

    return(df)
  }

  gather_region <- function(df) {
    tidyr::gather(data = df,
                  key = "region",
                  value = "quantity",
                  -c("age","year","type"))
  }

  recode_age <- function(df) {
    df %>%
      dplyr::mutate(age = dplyr::recode(age,
                                        "60 en +" = "60+",
                                        "80 jaar en +" = "80+",
                                        "- dan 12 jaar" = "12-")) %>%
      dplyr::mutate(age = stringr::str_replace(string = age,
                                               pattern = " jaar",
                                               replacement = ""))
  }


  worksheet %>%
    remove_description_header() %>%
    readable_column_names () %>%
    remove_total() %>%
    remove_source() %>%
    remove_spouse_row() %>%
    summarise_spouse() %>%
    summarise_age() %>%
    add_year(year) %>%
    add_type(type) %>%
    gather_region() %>%
    recode_age()
}

bind_together <- function(list_of_dfs) {
  df <- dplyr::bind_rows(list_of_dfs)

  df %>%
    dplyr::mutate_if(is.character, factor)
}
