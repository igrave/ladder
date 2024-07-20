add_to_slides <- function(object, presentationId) {
  reqs <- make_table(ft, new_id("table"))
  result <- presentations.batchUpdate(
    presentationId = presentationId,
    BatchUpdatePresentationRequest = BatchUpdatePresentationRequest(
      requests = reqs
    )
  )
  slides_url(result)
  invisible(result)
}
