paragraph_style <- function(style_data, row_offset, objectId) {
  part_dim <- dim(style_data[[1]][["data"]])
  i <- seq_len(part_dim[1]) # i is 1-indexed and relative to table part
  i_gs <- i - 1 + row_offset # Slide table rows are 0-indexed and absolute
  j <- seq_len(part_dim[2]) # j is 1-index and relative to table part
  j_gs <- j - 1 # Slide table columns are 0-indexed and absolute

  reqs <- list()

  ta <- style_data[["text.align"]][["data"]]

  # ft has c("left", "right", "center", "justify")
  # slides has textDirection and alignment, but let's only handle left to right
  # so map to c("START", "END", "CENTER", "JUSTIFIED")
  map <- setNames(
    c("START", "END", "CENTER", "JUSTIFIED"),
    c("left", "right", "center", "justify")
  )

  # iterate over columns, assuming text alignment is usually consistent column-wise
  for (this_i in i) {
    for (this_j in j) {
      add(reqs) <- UpdateParagraphStyleRequest(
        objectId = objectId,
        cellLocation = TableCellLocation(rowIndex = i_gs[this_i], j_gs[this_j]),
        style = ParagraphStyle(
          direction = "LEFT_TO_RIGHT",
          alignment = map[ta[this_i, this_j]]
        ),
        textRange = Range(type = "ALL"),
        fields = "alignment,direction"
      )
    }
  }
  reqs
}
