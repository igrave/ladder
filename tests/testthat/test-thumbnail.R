test_that("get_slide_img works", {
  # skip_on_cran()
  expect_true(file.exists("token.txt"))
  expect_true(file.size("token.txt") > 0)
  accesstoken <- readLines("token.txt")[[1]]
  expect_string(accesstoken)
  use_gauth_workflow(accesstoken)
  result <- get_slide_img("1Bu6ZD0mev_jYpLi-rbJnhl-X3xezY6i4cUPQBubJrEg", "p")
  expect_string(result)
  expect_file_exists(result)
})

test_that("dummy", {
  expect_true(TRUE)
})
