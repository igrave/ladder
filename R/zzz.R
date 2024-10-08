.onLoad <- function(libname, pkgname) {
  # .auth is created in R/drive_auth.R
  # this is to insure we get an instance of gargle's AuthState using the
  # current, locally installed version of gargle

  Sys.setenv(SLIDES_KEY = "DwRpLbD_jXSFKxhjwrgHQg")

  utils::assignInMyNamespace(
    ".auth",
    gargle::init_AuthState(
      package = "ladder",
      auth_active = TRUE
    )
  )
}
