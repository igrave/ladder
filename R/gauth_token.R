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
