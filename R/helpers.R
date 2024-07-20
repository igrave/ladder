new_id <- function(prefix = "ID") {
  paste0(
    prefix, "-",
    paste0(sample(c(letters, LETTERS, 0:9), 20, replace = TRUE), collapse = "")
  )
}

same <- function(x) {
  all(x[1] == x)
}
