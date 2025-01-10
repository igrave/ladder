test_that("gluestick works", {
  name <- "Joe"
  result <- gluestick("Hello {{name}}")
  expect_equal(result, "Hello Joe")
})
