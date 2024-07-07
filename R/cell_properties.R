cell_properties <- function(style_data, row_offset, objectId) {
  part_dim <- dim(style_data[[1]][["data"]])
  i <- seq_len(part_dim[1]) # i is 1-indexed and relative to table part
  i_gs <- i - 1 + row_offset # Slide table rows are 0-indexed and absolute
  j <- seq_len(part_dim[2]) # j is 1-index and relative to table part
  j_gs <- j - 1 # Slide table columns are 0-indexed and absolute

  browser()

  reqs <- list()

  # Cell properties (vertical align and background colour) -----
  enum_valign <- function(x) {
    switch(x,
      "top" = "TOP",
      "center" = "MIDDLE",
      "bottom" = "BOTTOM",
      "CONTENT_ALIGNMENT_UNSPECIFIED"
    )
  }
  va <- apply(style_data[["vertical.align"]][["data"]], 1:2, enum_valign)
  va_default <- enum_valign(style_data[["vertical.align"]][["default"]])
  bg <- style_data[["background.color"]][["data"]]
  bg_default <- style_data[["background.color"]][["default"]]


  if (any(va == va_default) && (any(bg == bg_default))) {
    # apply defaults everywhere
    add(reqs) <- UpdateTableCellPropertiesRequest(
      objectId = objectId,
      tableRange = TableRange(
        location = TableCellLocation(rowIndex = i_gs[1], columnIndex = j_gs[1]),
        rowSpan = part_dim[1],
        columnSpan = part_dim[2]
      ),
      tableCellProperties = TableCellProperties(
        tableCellBackgroundFill = background_fill_helper(bg_default),
        contentAlignment = va_default
      ),
      fields = "tableCellBackgroundFill.solidFill.color,tableCellBackgroundFill.propertyState,contentAlignment"
    )
  }

  bg_other <- which(bg != bg_default, arr.ind = TRUE)
  if (nrow(bg_other)) {
    for (s in seq_len(nrow(bg_other))) {
      add(reqs) <- UpdateTableCellPropertiesRequest(
        objectId = objectId,
        tableRange = TableRange(
          location = TableCellLocation(
            rowIndex = i_gs[bg_other[s, 1]],
            columnIndex = j_gs[bg_other[s, 2]]
          ),
          rowSpan = 1,
          columnSpan = 1
        ),
        tableCellProperties = TableCellProperties(
          tableCellBackgroundFill = background_fill_helper(bg[bg_other[s, , drop = FALSE]])
        ),
        fields = "tableCellBackgroundFill.solidFill.color,tableCellBackgroundFill.propertyState"
      )
    }
  }

  va_other <- which(va != va_default, arr.ind = TRUE)
  if (nrow(va_other)) {
    for (s in seq_len(nrow(va_other))) {
      add(reqs) <- UpdateTableCellPropertiesRequest(
        objectId = objectId,
        tableRange = TableRange(
          location = TableCellLocation(
            rowIndex = i_gs[va_other[s, 1]],
            columnIndex = j_gs[va_other[s, 2]]
          ),
          rowSpan = 1,
          columnSpan = 1
        ),
        tableCellProperties = TableCellProperties(
          contentAlignment = va[va_other[s, , drop = FALSE]]
        ),
        fields = "contentAlignment"
      )
    }
  }

  reqs
}

background_fill_helper <- function(col) {
  if (col == "transparent") {
    prop_state <- "NOT_RENDERED"
    fill_col <- col2RgbColor(col)
  } else {
    prop_state <- "RENDERED"
    fill_col <- col2RgbColor(col)
  }
  TableCellBackgroundFill(
    propertyState = prop_state,
    solidFill = SolidFill(color = OpaqueColor(rgbColor = fill_col))
  )
}
