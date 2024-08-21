# ladder

To get on to the (Google) Slides 🛝

```r
# Install 'ladder' in R:
install.packages('ladder', repos = c('https://igrave.r-universe.dev', 'https://cloud.r-project.org'))

library(ladder)

# Select a presentation and authorise it for use with `ladder`
slides_id <- choose_slides()

# Add the table to the presentation
add_to_slides(head(mtcars), slides_id)
```

For more powerful formatting, use flextable!
```r
# Make a flextable
library(flextable)
ft <- flextable(head(mtcars))

# (Optional) Go wild with formatting
ft <- theme_box(ft)
ft <- bold(ft, bold = TRUE, part = "header")
ft <- bold(ft, part = "header", i = 1, j = 3, bold = FALSE)
ft <- bold(ft, part = "body", j = 2, bold = TRUE)
ft <- bold(ft, part = "body", i = 4, bold = TRUE)
ft <- fontsize(ft, i =1, size = 14)
ft <- color(ft, i = 5:6, j = 1:2, "pink", part = "body")
ft <- hline_top(ft, border = officer::fp_border(color = "green", width = 2), part = "header")
ft <- hline_top(ft, border = officer::fp_border(color = "blue", width = 1, style = "dashed"), part = "body")
ft <- hline(ft, i = 3, j = 3, border = officer::fp_border("yellow", "dotted", 3))
ft <- vline_right(ft, i = 3:4, border = officer::fp_border("black", "dashed", 4), part = "body")
ft <- vline_left(ft, border = officer::fp_border("red", "solid", 2))
ft <- vline_right(ft, border = officer::fp_border("red", "solid", 2))
ft <- vline(ft, i = 2:4, j = 10, border = officer::fp_border("red", "dashed", 2), part = "body")
ft <- valign(ft, i = 3, j = 3, valign = "top", part = "body")
ft <- merge_at(ft, i = 4:5, j = 5:6)
ft <- bg(ft, i = 4, j = 5, bg = "orange")
ft <- highlight(ft, i = 4:5, j = 5:7)
ft <- align(ft, i = 1, j = 6, part="header", align = "left")
ft <- align(ft,  j = 2, part="body", align = "left")
ft <- height(ft, i = 5, height = 2)
ft <- footnote(ft, i = 2, j = 2, value = as_paragraph("This is 6."), ref_symbols = "1")
ft <- add_footer_lines(ft, values = "hello feet")

# Add the table to the presentation
add_to_slides(ft, slides_id)
```
