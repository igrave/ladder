#' Add matrix to Slides
#'
#' @param object A matrix
#' @param presentationId The id from the Slides presentation
#' @param object_id A unique id for the table
#' @param on The id or number of the slide to add to
#' @param digits the minimum number of significant digits, see [format]. If `NULL`
#'   `getOption("digits")` is used.
#' @param ... Not used in this method
#'
#' @return A presentation object is returned invisibly
#' @details
#' The matrix is added as a table without any row or column names.
#'
#' @export
#'
#' @examples
#' \donttest{
#' s <- choose_slides()
#' obj <- cov(iris[, 1:4])
#' add_to_slides(obj, s, on = 1, object_id = "iris_table")
#' }
add_to_slides.matrix <- function(object, presentation_id, on = NULL, object_id = new_id("table"), digits = NULL, ...) {
  page_id <- on_slide_id(presentation_id, on)

  reqs <- make_matrix_table(object, object_id, page_id, digits)
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
  for(i in seq_len(nrows)) {
    for (j in seq_len(ncols)) {
      add(my_tab) <- InsertTextRequest(
        objectId = table_id,
        cellLocation = TableCellLocation(rowIndex = i - 1, columnIndex = j - 1),
        text = m[i, j],
        insertionIndex = 0
      )
    }
  }
  my_tab_reqs <- lapply(my_tab, trim_nulls)
  reqs <- do.call(Request, my_tab_reqs)
  reqs
}
