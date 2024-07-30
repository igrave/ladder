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
add_to_slides <- function(object, presentationId, on = NULL, table_id = new_id("table")) {
  slide_ids <- unlist(get_slide_ids(presentationId))
  if (!is.null(on)) {
    if (is.numeric(on)) {
      pageObjectId <- slide_ids[as.integer(on)]
    }
    if (is.character(on[1]) && on[1] %in% slide_ids) {
      pageObjectId <- on[1]
    }
  } else {
    pageObjectId <- tail(slide_ids, n = 1L)
  }

  reqs <- make_table(object, table_id, pageObjectId)
  result <- presentations.batchUpdate(
    presentationId = presentationId,
    BatchUpdatePresentationRequest = BatchUpdatePresentationRequest(
      requests = reqs
    )
  )
  slides_url(result, pageObjectId)
  # cat("id:", table_id)
  invisible(result)
}
