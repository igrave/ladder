
test_that("id_token variables exist", {
  id_token_url <- Sys.getenv("ACTIONS_ID_TOKEN_REQUEST_URL")
  id_token_request_token <- Sys.getenv("ACTIONS_ID_TOKEN_REQUEST_TOKEN")
  
  skip_if_not(nchar(id_token_url) > 0)
  skip_if_not(nchar(id_token_request_token) > 0)
})
# test_that("get_slide_img works", {
#   # skip_on_cran()
#   path <- file.path(Sys.getenv("HOME"), "token.txt")
#   expect_true(file.exists(path))
#   expect_true(file.size(path) > 0)
#   accesstoken <- readLines(path)[[1]]
#   expect_string(accesstoken)
#   use_gauth_workflow(accesstoken)
#   result <- get_slide_img("1Bu6ZD0mev_jYpLi-rbJnhl-X3xezY6i4cUPQBubJrEg", "p")
#   expect_string(result)
#   expect_file_exists(result)
# })
