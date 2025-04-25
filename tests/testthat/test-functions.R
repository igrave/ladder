test_that("extract_id works with url", {
  file <- "https://docs.google.com/presentation/d/1RbEmFUkKs6gBp4ZasdfageargaergnPaLMABQ/present?slide=id.p5"
  result <- extract_id(file)
  expect_equal(result, "1RbEmFUkKs6gBp4ZasdfageargaergnPaLMABQ")
})

test_that("extract_id works with empty string", {
  file <- ""
  result <- extract_id(file)
  expect_equal(result, "")
})

test_that("extract_id works with non matching string", {
  file <- "1RbEmFUkKs6gBp4ZasdfageargaergnPaLMABQ"
  result <- extract_id(file)
  expect_equal(result, "1RbEmFUkKs6gBp4ZasdfageargaergnPaLMABQ")
})
