#' Add Object to Slides
#'
#' @param object An object to add to slides
#' @param presentation_id The id from the Slides presentation
#' @param on The id or number of the slide to add `object` to
#' @param object_id A unique id for the new object on the slides
#' @param overwrite If TRUE and an object with `object_id` exists it will deleted and replaced.
#' @param ... Other arguments used in methods
#' @param digits the minimum number of significant digits, see [format]. If `NULL`
#'   `getOption("digits")` is used.
#'
#' @return A presentation object after updating
#' @export
#'
add_to_slides <- function(object, presentation_id, on = NULL, object_id, overwrite, ...) {
  UseMethod("add_to_slides")
}
