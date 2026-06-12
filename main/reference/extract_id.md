# Extract the Presentation ID from a URL string

Extract the Presentation ID from a URL string

## Usage

``` r
extract_id(presentation)
```

## Arguments

- presentation:

  A string containing the presentation URL See
  [`slides_url()`](https://www.r-ladder.com/reference/slides_url.md) for
  the inverse operation.

## Value

The file ID of the presentation

## Examples

``` r
extract_id("https://docs.google.com/presentation/d/1RbEmFUkKs6gBp4ZMABQ/present?slide=id.p5")
#> [1] "1RbEmFUkKs6gBp4ZMABQ"
```
