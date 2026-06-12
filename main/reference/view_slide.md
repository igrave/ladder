# Preview Slide as Image

Preview Slide as Image

## Usage

``` r
view_slide(presentation_id, page, size = "MEDIUM", viewer = TRUE)
```

## Arguments

- presentation_id:

  character, the presentation id

- page:

  character, the page number or id

- size:

  character, the size of the image. One of "SMALL", "MEDIUM", "LARGE"

- viewer:

  logical, if TRUE opens the image in the viewer

## Value

A character string of the file path to the saved image and opens the
image in the viewer or browser if `viewer = TRUE`.

## Examples

``` r
if (FALSE) { # interactive()
s <- choose_slides()
tmp_image <- view_slide(s, 1)
file.remove(tmp_image)
}
```
