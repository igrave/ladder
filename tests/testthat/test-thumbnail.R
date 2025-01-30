test_that("token exists", {
  expect_string(Sys.getenv("access_token"), min.chars = 1)
})

test_that("get_slide_img works", {
  # skip_on_cran()
  Sys.getenv("access_token")
  path <- file.path(Sys.getenv("HOME"), "token.txt")
  expect_true(file.exists(path))
  expect_true(file.size(path) > 0)
  accesstoken <- readLines(path)[[1]]
  expect_string(accesstoken)
  use_gauth_workflow(accesstoken)
  result <- get_slide_img("1Bu6ZD0mev_jYpLi-rbJnhl-X3xezY6i4cUPQBubJrEg", "p")
  expect_string(result)
  expect_file_exists(result)
})

test_that("dummy", {
  expect_true(TRUE)
})
