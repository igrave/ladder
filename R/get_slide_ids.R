#' Get ids of Slides pages
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

#' Get ids of objects on Slides
#'
#' @param presentation_id character, the presentation id
#'
#' @return A list of character vectors of object ids. The list has elements for each page. If a
#'   slide page has no objects the list element is `NULL` otherwise a character vector containing
#'   all object ids on that page. Contains ids for all tables, images, lines, shapes, etc.
#'
#' @examplesIf interactive()
#' \donttest{
#' s <- choose_slides()
#' get_object_ids(s)
#' }
get_object_ids <- function(presentation_id) {
  result <- presentations.get(
    presentation_id,
    params = list(fields = "slides(pageElements(objectId))")
  )
  lapply(result$slides, unlist, use.names = FALSE)
}

