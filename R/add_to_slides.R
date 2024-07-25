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
add_to_slides <- function(object, presentationId, on = NULL,  table_id = new_id("table")) {
  if (!is.null(on)) {
    slide_ids <- get_slide_ids(presentationId)

    if (is.numeric(on)) {
      pageObjectId <- unlist(slide_ids)[as.integer(on)]
    }
    if (is.character(on[1]) && on[1] %in% unlist(slide_ids)) {
      pageObjectId <- on[1]
    }
  } else {
    pageObjectId <- NULL
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
