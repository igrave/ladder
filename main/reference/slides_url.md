# Print presentation URL

Print presentation URL

## Usage

``` r
slides_url(presentation_id, slide_id = NULL)
```

## Arguments

- presentation_id:

  ID of presentation

- slide_id:

  Optional slide id to link directly to a certain slide. See
  [get_slide_ids](https://www.r-ladder.com/reference/get_slide_ids.md).

## Value

Prints URL as a link and invisibly returns URL.

## Examples

``` r
slides_url("example_id_won't_work_1234567asdfbg")
#> https://docs.google.com/presentation/d/example_id_won't_work_1234567asdfbg/
slides_url("example_id_won't_work_1234567asdfbg", slide_id = "p")
#> https://docs.google.com/presentation/d/example_id_won't_work_1234567asdfbg/edit#slide=id.p
```
