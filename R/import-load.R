#' @param year year between 2013 and 2016
#' @param type divorce or marriage
#' @return nothing, used for side-effect of downloading
download <- function(year, type) {
  basic_part_url <- "https://statbel.fgov.be/sites/default/files/files/documents/bevolking/5.6%20Huwelijken%2C%20echtscheidingen%20en%20samenwonen/"

  mapping_types <- c("Echtscheidingen","Huwelijken")
  names(mapping_types) <- c("divorce","marriage")

  mapping_type_ids <- c("5.6.2.","5.6.1")
  names(mapping_type_ids) <- c("divorce","marriage")

  url_without_year <- paste0(basic_part_url,
                             mapping_type_ids[type],
                             "%20",
                             mapping_types[type],
                             "/Plus/NL/BE_",
                             mapping_types[type],
                             "_")

  if (year %in% c("2015","2016")) { # RR part only for recent years
    url <- paste0(url_without_year,
                  "RR_",
                  year,
                  "_NL.xls")
  } else {
    url <- paste0(url_without_year,
                  year,
                  "_NL.xls")
  }

  save_folder <- paste(here::here(), "inst", "extdata", sep = "/")
  save_filename <- paste0(type, "_", year, ".xls")

  download.file(url,
                destfile = paste(save_folder, save_filename, sep = "/")
  )

}

select_worksheet <- function(worksheet) {

}
