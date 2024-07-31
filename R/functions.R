`add<-` <- function(x, value) {
  if (is.null(value)) {
    x
  } else {
    c(x, list(value))
  }
}

slides_url <- function(presentation, slide_id) {
  id <- presentation$presentationId
  slide_part <- if (!is.null(slide_id)) paste0("edit#slide=id.", slide_id) else ""
  url <- paste0("https://docs.google.com/presentation/d/", id, "/", slide_part)
  cat(cli::style_hyperlink(url, url))
}


col2RgbColor <- function(col) {
  rgb <- col2rgb(col) / 255
  RgbColor(red = rgb[1, 1], green = rgb[2, 1], blue = rgb[3, 1])
}




table_requests <- function(ft, table_id = table_id, part = c("header", "body", "footer")) {
  part <- match.arg(part)
  my_tab <- list()
  part_content <- ft[[part]]$content
  part_styles <- ft[[part]]$styles
  part_dim <- dim(part_content$data)
  part_spans <- ft[[part]]$spans
  part_spans$ind <- part_spans$rows * part_spans$columns >= 1

  if (any(part_dim == 0)) return(list())

  row_offset <- switch(part,
    "footer" = flextable::nrow_part(ft, "body") + flextable::nrow_part(ft, "header"),
    "body" = flextable::nrow_part(ft, "header"),
    "header" = 0L
  )

  dim_requests <- column_row_requests(
    table_id,
    row_offset = row_offset,
    widths = ft[[part]]$colwidths,
    heights = ft[[part]]$rowheights
  )


  merge_requests <- merge_request(
    objectId = table_id,
    row_offset = row_offset,
    part_spans = part_spans
  )
  border_requests <- border_requests(
    part_styles$cells,
    row_offset = row_offset,
    objectId = table_id
  )
  cell_properties_requests <- cell_properties(
    part_styles$cells,
    row_offset = row_offset,
    objectId = table_id
  )

  my_tab <- c(my_tab, dim_requests, merge_requests, border_requests, cell_properties_requests)

  for (i in seq.int(from = 1, length.out = part_dim[1])) {
    # i is 1-indexed and relative to table part
    i_gs <- i - 1 + row_offset # Slide table rows are 0-indexed and absolute

    for (j in seq.int(from = 1, length.out = part_dim[2])) {
      j_gs <- j - 1 # Slide table columns are 0-indexed and absolute


      df <- part_content$data[i, j][[1]]

      if (isTRUE(part_spans$ind[i, j])) {
        # Add all text
        add(my_tab) <- InsertTextRequest(
          objectId = table_id,
          cellLocation = TableCellLocation(rowIndex = i_gs, columnIndex = j_gs),
          text = paste0(df$txt, collapse = ""),
          insertionIndex = 0
        )

        # Set default cell style
        cell_text_style <- make_text_style(
          text_style = part_styles$text,
          i = i,
          j = j
        )

        add(my_tab) <- UpdateTextStyleRequest(
          objectId = table_id,
          cellLocation = TableCellLocation(rowIndex = i_gs, columnIndex = j_gs),
          style = cell_text_style,
          textRange = Range(type = "ALL"),
          fields = paste0(names(cell_text_style), collapse = ",")
        )

        # set run style if any
        df$txt_ends <- cumsum(nchar(df$txt))
        df$txt_starts <- c(0, head(df$txt_ends, n = -1L))

        for (k in seq_len(nrow(df))) {
          run_text_style <- make_text_style(
            content_data = part_content$data,
            i = i,
            j = j,
            k = k
          )
          df_k <- df[k, ]
          if (length(run_text_style)) {
            add(my_tab) <- UpdateTextStyleRequest(
              table_id,
              TableCellLocation(i_gs, j_gs),
              style = run_text_style,
              textRange = Range(df_k$txt_starts, df_k$txt_ends, "FIXED_RANGE"),
              fields = paste0(names(run_text_style), collapse = ",")
            )
          }
        }
      }
    }
  }

  par_style_requests <- paragraph_style(
    part_styles$pars,
    row_offset = row_offset,
    objectId = table_id
  )
  c(my_tab, par_style_requests)
  my_tab
}
