#' Add table to Slides
#'
#' @param object A table object (flextable)
#' @param presentationId The id from the Slides presentation
#' @param table_id A unique id for the table
#'
#' @return A presentation object after updating
#' @export
#'
#' @examples
add_to_slides <- function(object, presentationId, table_id = new_id("table")) {
  reqs <- make_table(object, table_id)
  result <- presentations.batchUpdate(
    presentationId = presentationId,
    BatchUpdatePresentationRequest = BatchUpdatePresentationRequest(
      requests = reqs
    )
  )
  slides_url(result)
  cat("id:", table_id)
  invisible(result)
}
