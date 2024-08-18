
#' Get ids in Slides
#'
#' @param presentationId character, the presentation id
#'
#' @return A vector of slide ids.
#'
#' @export
#' @examplesIf interactive()
#' \donttest{
#' s <- choose_slides()
#' get_slide_ids(s)
#' }

get_slide_ids <- function(presentationId){
  result <- presentations.get(presentationId, params = list(fields = "slides(objectId)"))
  setNames(unlist(result), seq_along(result))
}
