# Use a Google token from github auth workflow

Use a Google token from github auth workflow

## Usage

``` r
use_gauth_workflow(access_token)
```

## Arguments

- access_token:

  The access token from github auth workflow

## Value

Sets the internal token to use the provided `access_token` string and
returns the `AuthState` token object.

See <https://github.com/google-github-actions/auth/> for more details.

## Examples

``` r
google_access_token <- Sys.getenv("access_token")
use_gauth_workflow("your_access_token")
```
