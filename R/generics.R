#' Add Object to Slides
#'
#' @param object An object to add to slides
#' @param presentation_id The id from the Slides presentation
#' @param on The id or number of the slide to add `object` to
#' @param object_id A unique id for the new object on the slides
#' @param overwrite If TRUE and an object with `object_id` exists it will deleted and replaced.
#' @param ... Other arguments used in methods
#'
#' @return A presentation object after updating
#' @export
#'
#' @examplesIf interactive()
#' \donttest{
#' s <- choose_slides()
#' obj <- iris[1:5, ]
#' add_to_slides(obj, s, on = 1, object_id = "iris_table")
#' }
#'
add_to_slides <- function(object, presentation_id, on = NULL, object_id, ...) {
  UseMethod("add_to_slides")
}
