column_row_requests <- function(table_id, row_offset, widths, heights) {
  i <- seq_along(heights) # i is 1-indexed and relative to table part
  i_gs <- i - 1 + row_offset # Slide table rows are 0-indexed and absolute
  j <- seq_along(widths) # j is 1-index and relative to table part
  j_gs <- j - 1 # Slide table columns are 0-indexed and absolute

  reqs <- list()

  same_widths <- split(j_gs, widths)
  for (w in seq_along(same_widths)) {
    width <- as.numeric(names(same_widths[w]))
    cols <- same_widths[[w]]
    add(reqs) <- UpdateTableColumnPropertiesRequest(
      objectId = table_id,
      columnIndices = cols,
      tableColumnProperties = TableColumnProperties(
        columnWidth = Dimension(width * 914400, unit = "EMU")
      ),
      fields = "columnWidth"
    )
  }

  same_heights <- split(i_gs, heights)
  for (h in seq_along(same_heights)) {
    height <- as.numeric(names(same_heights[h]))
    rows <- same_heights[[h]]
    add(reqs) <- UpdateTableRowPropertiesRequest(
      objectId = table_id,
      rowIndices = rows,
      tableRowProperties = TableRowProperties(
        minRowHeight = Dimension(height * 914400, unit = "EMU")
      ),
      fields = "minRowHeight"
    )
  }

  reqs
}
