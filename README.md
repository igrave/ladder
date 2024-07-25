# SlidesTools.flextable

Add flextables to Google Slides

```r
library(SlidesTools.flextable)

# Select a presentation and authorise it for use with SlidesTools
slides_id <- choose_slides()

# Make a flextable
library(flextable)
ft <- flextable(iris[1:3, ])

# Add the table to the presentation
add_to_slides(ft, slides_id)
```
