context("select_worksheet")

worksheet <- select_worksheet(worksheet = "duration",
                              year = "2013",
                              type = "divorce")

test_that("returns dataframe", {
  expect_is(worksheet, "data.frame")
})