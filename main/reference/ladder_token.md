# Produce configured token

For internal use or for those programming around the Slides API. Returns
a token pre-processed with
[`httr::config()`](https://httr.r-lib.org/reference/config.html). Most
users do not need to handle tokens "by hand" or, even if they need some
control,
[`ladder_auth()`](https://www.r-ladder.com/reference/ladder_auth.md) is
what they need. If there is no current token,
[`ladder_auth()`](https://www.r-ladder.com/reference/ladder_auth.md) is
called to either load from cache or initiate OAuth2.0 flow. If auth has
been deactivated via
[`ladder_deauth()`](https://www.r-ladder.com/reference/ladder_deauth.md),
`ladder_token()` returns `NULL`.

## Usage

``` r
ladder_token()
```

## Value

A `request` object (an S3 class provided by
[httr](https://httr.r-lib.org/reference/httr-package.html)).

## See also

Other low-level API functions:
[`ladder_has_token()`](https://www.r-ladder.com/reference/ladder_has_token.md)

## Examples

``` r
if (FALSE) { # interactive()
ladder_token()
}
```
