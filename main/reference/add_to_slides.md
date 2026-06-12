# Add Object to Slides

Add Object to Slides

## Usage

``` r
add_to_slides(
  object,
  presentation_id,
  on = NULL,
  object_id,
  overwrite,
  from_top_left = NULL,
  ...
)

# S3 method for class 'data.frame'
add_to_slides(
  object,
  presentation_id,
  on = NULL,
  object_id = new_id("table"),
  overwrite = FALSE,
  from_top_left = NULL,
  digits = NULL,
  size = NULL,
  ...
)

# S3 method for class 'flextable'
add_to_slides(
  object,
  presentation_id,
  on = NULL,
  object_id = new_id("table"),
  overwrite = FALSE,
  from_top_left = NULL,
  ...
)

# S3 method for class 'matrix'
add_to_slides(
  object,
  presentation_id,
  on = NULL,
  object_id = new_id("table"),
  overwrite = FALSE,
  from_top_left = NULL,
  digits = NULL,
  size = NULL,
  ...
)
```

## Arguments

- object:

  An object to add to slides

- presentation_id:

  The id from the Slides presentation

- on:

  The id or number of the slide to add `object` to

- object_id:

  A unique id for the new object on the slides

- overwrite:

  If TRUE and an object with `object_id` exists it will deleted and
  replaced.

- from_top_left:

  Numerical vector of length two giving the position of the table as the
  distance in from the left and down from the top of the slide in EMU.
  Use `cm(x)` or `inches(x)` to convert to EMU. If `NULL` a default
  position is used.

- ...:

  Other arguments used in methods

- digits:

  Number of digits to passed to
  [format](https://rdrr.io/r/base/format.html) for numeric matrices and
  data frame columns.

- size:

  Numerical vector of length two giving the width and height of the
  table in EMU. Use `cm(x)` or `inches(x)` to convert to EMU. If `NULL`
  a default size is used.

## Value

A presentation object updated with the new object. This function is used
for its side effect of adding an object to the slides. The returned
object in R is mostly for inspection.

## Details

A data.frame object is added as a table with the column names in bold as
the first row. For other formatting use the `flextable` package and
add_to_slides.flextable.

A flextable object is added with all formatting.

A matrix object is added as a table without any row or column names.

## Examples

``` r
if (FALSE) { # interactive()
## Add a data.frame
s <- choose_slides()
obj <- iris[1:5, ]
add_to_slides(obj, s, on = 1)
}
if (FALSE) { # interactive()
## Add a flextable
s <- choose_slides()
library(flextable)
ft <- flextable(iris[1:5, ])
ft <- theme_box(ft)
ft <- color(ft, i = 1:3, j = 1:2, "pink", part = "body")
ft <- autofit(ft)
add_to_slides(ft, s, on = 1)
}
if (FALSE) { # interactive()
## Add a matrix
s <- choose_slides()
obj <- cov(iris[, 1:4])
add_to_slides(obj, s, on = 1)
}
```
