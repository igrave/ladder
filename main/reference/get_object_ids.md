# Get ids of objects on Slides

Get ids of objects on Slides

## Usage

``` r
get_object_ids(presentation_id)
```

## Arguments

- presentation_id:

  character, the presentation id

## Value

A list of character vectors of object ids. The list has elements for
each page. If a slide page has no objects the list element is `NULL`
otherwise a character vector containing all object ids on that page.
Contains ids for all tables, images, lines, shapes, etc.

## Examples

``` r
if (FALSE) { # interactive()
s <- choose_slides()
get_object_ids(s)
}
```
