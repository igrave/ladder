% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/api_slides_auth.R
\name{ladder_deauth}
\alias{ladder_deauth}
\title{Suspend authorization}
\usage{
ladder_deauth()
}
\description{
Put ladder into a de-authorized state. Instead of sending a token,
ladder will send an API key. This can be used to access public
resources for which no Google sign-in is required. This is handy for using
ladder in a non-interactive setting to make requests that do not
require a token. It will prevent the attempt to obtain a token
interactively in the browser. The user can configure their own API key
via \code{\link[=ladder_auth_configure]{ladder_auth_configure()}} and retrieve that key via
\code{\link[=ladder_api_key]{ladder_api_key()}}.
In the absence of a user-configured key, a built-in default key is used.
}
\examples{
\dontrun{
ladder_deauth()
ladder_user()
}
}
\seealso{
Other auth functions: 
\code{\link{ladder_auth}()},
\code{\link{ladder_auth_configure}()}
}
\concept{auth functions}
