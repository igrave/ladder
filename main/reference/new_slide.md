# Add a new slide to a presentation

Add a new slide to a presentation

## Usage

``` r
new_slide(
  presentation_id,
  layout,
  centered_title = NULL,
  subtitle = NULL,
  title = NULL,
  body = NULL
)
```

## Arguments

- presentation_id:

  The presentation id

- layout:

  The layout to use for the slide. See
  [get_layouts](https://www.r-ladder.com/reference/get_layouts.md).

- centered_title:

  Character vector to be inserted into the "centered_title" placeholders
  in order as for `title`

- subtitle:

  Character vector to be inserted into the subtitle placeholders in
  order as for `title`

- title:

  Character vector to be inserted into the title placeholders in order.
  Any `NA` entries will be skip the corresponding placeholder.

- body:

  Character vector to be inserted into the body placeholders in order as
  for `title`

## Value

The URL of the new slide. This function is mostly used for its side
effect of adding a slide to the presentation.

## Examples

``` r
if (FALSE) { # interactive()
s <- create_slides()
layout <- get_layouts(s)
layout_p9 <- layout$layout_objectId[20]
new_slide(s, layout_p9, title = "Slide Title", subtitle = "A Subtitle", body = "Body Text")
}
```
