border_request_helper <- function(objectId, i, j, rowspan, colspan, border_position, col, lwd, lty) {
  this_colour <- col
  this_width <- lwd
  this_style <- switch(lty,
    "solid" = "SOLID",
    "dotted" = "DOT",
    "dashed" = "DASH",
    "dotDash" = "DASH_DOT",
    "dashSmallGap" = "LONG_DASH",
    "dotDotDash" = "LONG_DASH_DOT",
    "SOLID"
  )

  border_position <- match.arg(border_position, c("BOTTOM", "LEFT", "RIGHT", "TOP"))

  if (this_width == 0) {
    return(NULL)
  }

  UpdateTableBorderPropertiesRequest(
    objectId = objectId,
    tableRange = TableRange(
      location = TableCellLocation(rowIndex = i, columnIndex = j),
      rowSpan = rowspan,
      columnSpan = colspan
    ),
    borderPosition = border_position,
    tableBorderProperties = TableBorderProperties(
      tableBorderFill = TableBorderFill(
        solidFill = SolidFill(color = OpaqueColor(rgbColor = col2RgbColor(this_colour)))
      ),
      weight = Dimension(magnitude = this_width * 9525, unit = "EMU"),
      dashStyle = this_style
    ),
    fields = "tableBorderFill.solidFill.color,weight,dashStyle"
  )
}


border_requests <- function(style_data, row_offset, objectId) {
  part_dim <- dim(style_data[[1]][["data"]])
  if (any(part_dim == 0)) return(list())

  i <- seq_len(part_dim[1]) # i is 1-indexed and relative to table part
  i_gs <- i - 1 + row_offset # Slide table rows are 0-indexed and absolute
  j <- seq_len(part_dim[2]) # j is 1-index and relative to table part
  j_gs <- j - 1 # Slide table columns are 0-indexed and absolute

  reqs <- list()


  # Borders ---------
  # Process Rows
  # TOP border only
  wi <- style_data[["border.width.top"]][["data"]][1, ]
  co <- style_data[["border.color.top"]][["data"]][1, ]
  st <- style_data[["border.style.top"]][["data"]][1, ]

  if (all(wi == wi[1]) && all(co == co[1]) && all(st == st[1])) {
    add(reqs) <- border_request_helper(
      objectId,
      i = i_gs[1], j = j_gs[1], rowspan = 1, colspan = part_dim[2],
      border_position = "TOP", col = co[1], lwd = wi[1], lty = st[1]
    )
  } else {
    for (this_j in j) {
      add(reqs) <- border_request_helper(
        objectId,
        i = i_gs[1], j = j_gs[this_j], rowspan = 1, colspan = 1,
        border_position = "TOP", col = co[this_j], lwd = wi[this_j], lty = st[this_j]
      )
    }
  }

  # BOTTOM borders
  for (this_i in i) {
    wi <- style_data[["border.width.bottom"]][["data"]][this_i, ]
    co <- style_data[["border.color.bottom"]][["data"]][this_i, ]
    st <- style_data[["border.style.bottom"]][["data"]][this_i, ]

    if (all(wi == wi[1]) && all(co == co[1]) && all(st == st[1])) {
      add(reqs) <- border_request_helper(
        objectId,
        i = i_gs[this_i], j = j_gs[1], rowspan = 1, colspan = part_dim[2],
        border_position = "BOTTOM", col = co[1], lwd = wi[1], lty = st[1]
      )
    } else {
      for (this_j in seq_len(part_dim[2])) {
        add(reqs) <- border_request_helper(
          objectId,
          i = i_gs[this_i], j = j_gs[this_j], rowspan = 1, colspan = 1,
          border_position = "BOTTOM", col = co[this_j], lwd = wi[this_j], lty = st[this_j]
        )
      }
    }
  } # end BOTTOM

  # LEFT border only
  wi <- style_data[["border.width.left"]][["data"]][, 1]
  co <- style_data[["border.color.left"]][["data"]][, 1]
  st <- style_data[["border.style.left"]][["data"]][, 1]
  if (all(wi == wi[1]) && all(co == co[1]) && all(st == st[1])) {
    add(reqs) <- border_request_helper(
      objectId,
      i = i_gs[1], j = j_gs[1], rowspan = part_dim[1], colspan = 1,
      border_position = "LEFT", col = co[1], lwd = wi[1], lty = st[1]
    )
  } else {
    for (this_i in i) {
      add(reqs) <- border_request_helper(
        objectId,
        i = i_gs[this_i], j = j_gs[1], rowspan = 1, colspan = 1,
        border_position = "LEFT", col = co[this_i], lwd = wi[this_i], lty = st[this_i]
      )
    }
  } # end LEFT

  # RIGHT borders
  for (this_j in j) {
    wi <- style_data[["border.width.right"]][["data"]][, this_j]
    co <- style_data[["border.color.right"]][["data"]][, this_j]
    st <- style_data[["border.style.right"]][["data"]][, this_j]

    if (all(wi == wi[1]) && all(co == co[1]) && all(st == st[1])) {
      add(reqs) <- border_request_helper(
        objectId,
        i = i_gs[1], j = j_gs[this_j], rowspan = part_dim[1], colspan = 1,
        border_position = "RIGHT", col = co[1], lwd = wi[1], lty = st[1]
      )
    } else {
      for (this_i in i) {
        add(reqs) <- border_request_helper(
          objectId,
          i = i_gs[this_i], j = j_gs[this_j], rowspan = 1, colspan = 1,
          border_position = "RIGHT", col = co[this_i], lwd = wi[this_i], lty = st[this_i]
        )
      }
    }
  } # end RIGHT
  reqs
}
