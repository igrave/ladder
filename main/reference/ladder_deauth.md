# Suspend authorization

Put ladder into a de-authorized state. Instead of sending a token,
ladder will send an API key. This can be used to access public resources
for which no Google sign-in is required. This is handy for using ladder
in a non-interactive setting to make requests that do not require a
token. It will prevent the attempt to obtain a token interactively in
the browser. The user can configure their own API key via
[`ladder_auth_configure()`](https://www.r-ladder.com/reference/ladder_auth_configure.md)
and retrieve that key via
[`ladder_api_key()`](https://www.r-ladder.com/reference/ladder_auth_configure.md).
In the absence of a user-configured key, a built-in default key is used.

## Usage

``` r
ladder_deauth()
```

## Value

Called for side-effect. Returns invisible `NULL`.

## See also

Other auth functions:
[`ladder_auth()`](https://www.r-ladder.com/reference/ladder_auth.md),
[`ladder_auth_configure()`](https://www.r-ladder.com/reference/ladder_auth_configure.md)

## Examples

``` r
if (FALSE) { # interactive()
ladder_deauth()
ladder_user()
}
```
