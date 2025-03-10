#' @details
#' A matrix object is added as a table without any row or column names.
#' @rdname add_to_slides
#' @export
#'
#' @examplesIf interactive()
#' \donttest{
#' ## Add a matrix
#' s <- choose_slides()
#' obj <- cov(iris[, 1:4])
#' add_to_slides(obj, s, on = 1)
#' }
add_to_slides.matrix <- function(object,
                                 presentation_id,
                                 on = NULL,
                                 object_id = new_id("table"),
                                 overwrite = FALSE,
                                 digits = NULL,
                                 ...) {
  assert_string(object_id, min.chars = 5)
  page_id <- on_slide_id(presentation_id, on)

  reqs <- make_matrix_table(object, object_id, page_id, digits)

  if (isTRUE(overwrite)) {
    if (object_id %in% unlist(get_object_ids(presentation_id))) {
      reqs <- c(list(DeleteObjectRequest(objectId = object_id)), reqs)
    }
  }

  reqs <- do.call(Request, reqs)

  result <- presentations.batchUpdate(
    presentationId = presentation_id,
    BatchUpdatePresentationRequest = BatchUpdatePresentationRequest(
      requests = reqs
    )
  )
  slides_url(result$presentationId, page_id)
  invisible(result)
}

make_matrix_table <- function(m, table_id, page_id, digits = NULL) {
  ncols <- ncol(m)
  nrows <- nrow(m)
  if (nrows < 1 || ncols < 1) stop("Must have at least 1 row and column.")
  if (nrows > 20 || ncols > 20) {
    stop("Large matrix with >20 rows or columns is unlikely to fit on the slide.")
  }

  my_tab <- list()

  add(my_tab) <- CreateTableRequest(
    objectId = table_id,
    elementProperties = PageElementProperties(pageObjectId = page_id),
    rows = nrows,
    columns = ncols
  )

  if (is.numeric(m)) m <- format(m, trim = TRUE, digits = digits)
  # Add text to each cell
  for (i in seq_len(nrows)) {
    for (j in seq_len(ncols)) {
      add(my_tab) <- InsertTextRequest(
        objectId = table_id,
        cellLocation = TableCellLocation(rowIndex = i - 1, columnIndex = j - 1),
        text = m[i, j],
        insertionIndex = 0
      )
    }
  }
  reqs <- lapply(my_tab, trim_nulls)
  reqs
}
