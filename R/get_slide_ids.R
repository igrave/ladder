#' Get ids in Slides
#'
#' @param presentation_id character, the presentation id
#'
#' @return A vector of slide ids.
#'
#' @export
#' @examplesIf interactive()
#' \donttest{
#' s <- choose_slides()
#' get_slide_ids(s)
#' }
get_slide_ids <- function(presentation_id) {
  result <- presentations.get(presentation_id, params = list(fields = "slides(objectId)"))
  setNames(unlist(result), seq_along(result))
}
