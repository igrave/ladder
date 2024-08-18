make_text_style <- function(text_style = NULL,
                            content_data = NULL,
                            paragraph_default = NULL,
                            i,
                            j,
                            k = 1) {

  if (!is.null(text_style)) {
    s <- data.frame(
      shading.color = text_style$shading.color$data[i, j],
      color = text_style$color$data[i, j],
      bold = text_style$bold$data[i, j],
      italic = text_style$italic$data[i, j],
      font.family = text_style$font.family$data[i, j],
      font.size = text_style$font.size$data[i, j],
      vertical.align = text_style$vertical.align$data[i, j]
    )
  } else if (!is.null(content_data)) {
    s <- content_data[i, j][[1]][k, ]
  } else if (!is.null(paragraph_default)) {
    s <- paragraph_default[[1]]
  }

  na2null <- function(x) {
    if (!is.na(x)) x else NULL
  }
  style_list <- list()

  style_list$backgroundColor <- if(!is.na(s$shading.color)) {
    OptionalColor(opaqueColor = OpaqueColor(
      rgbColor = col2RgbColor(s$shading.color)
    ))
  }

  style_list$foregroundColor <- if(!is.na(s$color)) {
    OptionalColor(opaqueColor = OpaqueColor(
      rgbColor = col2RgbColor(s$color)
    ))
  }
  style_list$bold <- na2null(s$bold)
  style_list$italic <- na2null(s$italic)
  style_list$fontFamily <- na2null(s$font.family)
  style_list$fontSize <- if (!is.na(s$font.size)) Dimension(s$font.size, unit = "PT")
  style_list$baselineOffset <- switch(
      s$vertical.align,
      "superscript" = "SUPERSCRIPT",
      "subscript" = "SUBSCRIPT"
    )
    # link,
    # baselineOffset,
    # smallCaps = ,
    # strikethrough = ,
    # underline = ,

  ts <- do.call(TextStyle, style_list)
  trim_nulls(ts)
}
