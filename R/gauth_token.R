GAuthToken <- R6::R6Class("GAuthToken", inherit = httr::Token2.0, list(
  secrets = NULL,
  initialize = function(access_token) {
    self$credentials <- list(
      access_token = access_token,
      expires_in = 300,
      token_type = "Bearer"
    )

    self
  },
  can_refresh = function() {
    FALSE
  },
  refresh = function() {
    self
  },
  sign = function(method, url) {
    httr_request(
      url = url,
      headers = c(Authorization = paste("Bearer", self$credentials$access_token))
    )
  },
  # Never cache
  cache = function(path) self,
  load_from_cache = function() self
))

#' Use a Google token from github auth workflow
#' @param access_token The access token from github auth workflow
#' @export
use_gauth_workflow <- function(access_token) {
  token <- GAuthToken$new(access_token = access_token)
  .auth$set_cred(token)
}


httr_request <- function (method = NULL, url = NULL, headers = NULL, fields = NULL,
                          options = NULL, auth_token = NULL, output = NULL)
{
  if (!is.null(method)) {
    stopifnot(is.character(method), length(method) == 1)
  }
  if (!is.null(url)) {
    stopifnot(is.character(url), length(url) == 1)
  }
  if (!is.null(headers)) {
    stopifnot(is.character(headers))
  }
  if (!is.null(fields)) {
    stopifnot(is.list(fields))
  }
  if (!is.null(output)) {
    stopifnot(inherits(output, "write_function"))
  }
  structure(list(method = method, url = url, headers = keep_last(headers),
                 fields = fields, options = compact(keep_last(options)),
                 auth_token = auth_token, output = output), class = "request")
}
