context("percentage_of_total_by_region")

skip("devtools doesn't manage to load the file on travis, works fine when using devtools::test()")

load(paste(here::here(),"data","year_of_birth.RData", sep = "/"))
df_with_percentages <- percentage_of_total_by_region(year_of_birth)

test_that("percentages of all regions add up to 100%", {
  percentages <- df_with_percentages %>%
    group_by(region) %>%
    summarise(total_percentage = sum(percentage)) %>%
    pull(total_percentage)

  percentages %>% walk(~expect_gt(., 99.8))
  percentages %>% walk(~expect_lt(., 100.2))

})
