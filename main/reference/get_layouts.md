# Get layouts from a presentation

Get layouts from a presentation

## Usage

``` r
get_layouts(presentation_id)
```

## Arguments

- presentation_id:

  The presentation id

## Value

A data frame with columns `layout_objectId`, `name`, `displayName`, and
`placeholders_df`

## Examples

``` r
if (FALSE) { # interactive()
s <- choose_slides()
get_layouts(s)
}
```
