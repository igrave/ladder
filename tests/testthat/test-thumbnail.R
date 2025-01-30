test_that("get_slide_img works", {
  skip_on_cran()
  use_gauth_workflow(readLines("token.txt"))
  result <- get_slide_img("1Bu6ZD0mev_jYpLi-rbJnhl-X3xezY6i4cUPQBubJrEg", "p")
  expect_string(result)
  expect_file_exists(result)
})

test_that("dummy", {
  expect_true(TRUE)
})
