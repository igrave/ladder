#' Add data frame to Slides
#'
#' @param object A data.frame
#' @param presentationId The id from the Slides presentation
#' @param object_id A unique id for the table
#' @param on The id or number of the slide to add to
#' @param digits the minimum number of significant digits, see [format]. If `NULL`
#'   `getOption("digits")` is used.
#' @param ... Not used in this method
#'
#' @return A presentation object after updating
#' @details
#' The data frame is added as a table with the column names in bold as the first row.
#' For other formatting use the `flextable` package and [add_to_slides.flextable].
#'
#' @export
#'
#' @examples
#' \donttest{
#' s <- choose_slides()
#' obj <- iris[1:5, ]
#' add_to_slides(obj, s, on = 1, object_id = "iris_table")
#' }
add_to_slides.data.frame <- function(object, presentation_id, on = NULL, object_id = new_id("table"), digits = NULL, ...) {
  page_id <- on_slide_id(presentation_id, on)

  reqs <- make_df_table(object, object_id, page_id, digits)
  result <- presentations.batchUpdate(
    presentationId = presentation_id,
    BatchUpdatePresentationRequest = BatchUpdatePresentationRequest(
      requests = reqs
    )
  )
  slides_url(result$presentationId, page_id)
  invisible(result)
}

make_df_table <- function(df, table_id, page_id, digits = NULL) {
  ncols <- ncol(df)
  nrows <- nrow(df) + 1
  if (nrows < 1 || ncols < 1) stop("Must have at least 1 row and column.")
  if (nrows > 20 || ncols > 20) {
    stop("Large data.frame with >20 rows or columns is unlikely to fit on the slide.")
  }

  my_tab <- list()

  add(my_tab) <- CreateTableRequest(
    objectId = table_id,
    elementProperties = PageElementProperties(pageObjectId = page_id),
    rows = nrows,
    columns = ncols
  )


  m <- as.matrix(format.data.frame(df, digits = digits))
  m <- rbind(colnames(m), m)
  # Add text to each cell
  for(i in seq_len(nrows)) {
    for (j in seq_len(ncols)) {
      add(my_tab) <- InsertTextRequest(
        objectId = table_id,
        cellLocation = TableCellLocation(rowIndex = i - 1, columnIndex = j - 1),
        text = m[i, j],
        insertionIndex = 0
      )
      if (i == 1) {
        add(my_tab) <- UpdateTextStyleRequest(
          objectId = table_id,
          cellLocation = TableCellLocation(rowIndex =  i - 1, columnIndex = j - 1),
          style = TextStyle(bold = TRUE),
          textRange = Range(type = "ALL"),
          fields = "bold"
        )
      }
    }
  }
  my_tab_reqs <- lapply(my_tab, trim_nulls)
  reqs <- do.call(Request, my_tab_reqs)
  reqs
}
