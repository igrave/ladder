`add<-` <- function(x, value) {
  if (is.null(value)) {
    x
  } else {
    c(x, list(value))
  }
}

slides_url <- function(presentation) {
  id <- presentation$presentationId
  url <- paste0("https://docs.google.com/presentation/d/", id, "/")
  cat(cli::style_hyperlink(url, url))
}


col2RgbColor <- function(col) {
  rgb <- col2rgb(col) / 255
  RgbColor(red = rgb[1, 1], green = rgb[2, 1], blue = rgb[3, 1])
}




table_requests <- function(ft, part = c("header", "body", "footer")) {
  part <- match.arg(part)
  my_tab <- list()
  part_content <- ft[[part]]$content
  part_styles <- ft[[part]]$styles
  part_dim <- dim(part_content$data)
  part_spans <- ft[[part]]$spans
  part_spans$ind <- part_spans$rows * part_spans$columns >= 1

  row_offset <- switch(part,
    "footer" = flextable::nrow_part(ft, "body") + nrow_part(ft, "header"),
    "body" = flextable::nrow_part(ft, "header"),
    "header" = 0L
  )

  merge_requests <- merge_request(
    objectId = "mytab",
    row_offset = row_offset,
    part_spans = part_spans
  )
  border_requests <- border_requests(
    part_styles$cells,
    row_offset = row_offset,
    objectId = "mytab"
  )
  cell_properties_requests <- cell_properties(
    part_styles$cells,
    row_offset = row_offset,
    objectId = "mytab"
  )

  my_tab <- c(my_tab, merge_requests, border_requests, cell_properties_requests)

  for (i in seq.int(from = 1, length.out = part_dim[1])) {
    # i is 1-indexed and relative to table part
    i_gs <- i - 1 + row_offset # Slide table rows are 0-indexed and absolute

    for (j in seq.int(from = 1, length.out = part_dim[2])) {
      j_gs <- j - 1 # Slide table columns are 0-indexed and absolute


      df <- part_content$data[i, j][[1]]

      if (isTRUE(part_spans$ind[i, j])) {
        # Add all text
        add(my_tab) <- InsertTextRequest(
          objectId = "mytab",
          cellLocation = TableCellLocation(rowIndex = i_gs, columnIndex = j_gs),
          text = paste0(df$txt),
          insertionIndex = 0
        )

        # Set default cell style
        add(my_tab) <- UpdateTextStyleRequest(
          objectId = "mytab",
          cellLocation = TableCellLocation(rowIndex = i_gs, columnIndex = j_gs),
          style = TextStyle(
            backgroundColor = OptionalColor(opaqueColor = OpaqueColor(
              rgbColor = col2RgbColor(part_styles$text$shading.color$data[i, j])
            )),
            foregroundColor = OptionalColor(opaqueColor = OpaqueColor(
              rgbColor = col2RgbColor(part_styles$text$color$data[i, j])
            )),
            bold = part_styles$text$bold$data[i, j],
            italic = part_styles$text$italic$data[i, j],
            fontFamily = part_styles$text$font.family$data[i, j],
            fontSize = Dimension(part_styles$text$font.size$data[i, j], unit = "PT"),
            # link,
            # baselineOffset,
            # smallCaps = ,
            # strikethrough = ,
            # underline = ,
          ),
          textRange = Range(type = "ALL"),
          fields = "bold,italic,fontFamily,fontSize,foregroundColor,backgroundColor"
        )

        # set run style if any
        df$txt_ends <- cumsum(nchar(df$txt))
        df$txt_starts <- c(0, head(df$txt_ends, n = -1L))

        for (k in nrow(df)) {
          df_k <- df[k, ]
          if (!is.na(df_k$bold)) {
            add(my_tab) <- UpdateTextStyleRequest(
              "mytab",
              TableCellLocation(i, j),
              style = TextStyle(bold = df_k$bold),
              textRange = Range(df_k$txt_starts, df_k$txt_ends, "FIXED_RANGE"),
              fields = "bold"
            )
          }
        }
      }
    }
  }
  my_tab
}
