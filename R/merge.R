merge_request <- function(objectId, row_offset, part_spans) {
  span_index <- which(
    part_spans$rows * part_spans$columns > 1,
    arr.ind = TRUE
  )
  n_merges <- nrow(span_index)

  if (n_merges == 0L) {
    return(NULL)
  }
  span_dim <- list(
    rows = part_spans$rows[span_index],
    cols = part_spans$columns[span_index]
  )
  merge_requests <- list()
  for(i in seq_len(n_merges)) {
    add(merge_requests) <- MergeTableCellsRequest(
      objectId = objectId,
      tableRange = TableRange(
        location = TableCellLocation(
          rowIndex = span_index[i, 1] + row_offset - 1,
          columnIndex = span_index[i, 2] - 1
        ),
        rowSpan = span_dim$rows[[i]],
        columnSpan = span_dim$cols[[i]]
      )
    )
  }
  merge_requests
}
