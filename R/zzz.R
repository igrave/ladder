.onLoad <- function(libname, pkgname) {
  # .auth is created in R/drive_auth.R
  # this is to insure we get an instance of gargle's AuthState using the
  # current, locally installed version of gargle

  Sys.setenv(SLIDES_KEY = "DwRpLbD_jXSFKxhjwrgHQg")

  utils::assignInMyNamespace(
    ".auth",
    gargle::init_AuthState(
      package = "ladder",
      auth_active = TRUE,
      gargle::gargle_oauth_client_from_json(
        path = gargle::secret_decrypt_json(
          path = system.file("api.json.enc", package = "ladder"),
          key = "SLIDES_KEY"
        )
      )
    )
  )
}
