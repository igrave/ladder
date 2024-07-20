new_id <- function(prefix = "ID") {
  paste0(
    prefix, "-",
    as.integer(Sys.time()),
    "-",
    paste0(sample(c(letters, LETTERS), size = 4), collapse = "")
  )
}

same <- function(x) {
  all(x[1] == x)
}
