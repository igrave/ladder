add_to_slides <- function(object, presentationId, table_id = new_id("table")) {
  reqs <- make_table(ft, table_id)
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
