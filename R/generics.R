#' Add Object to Slides
#'
#' @param object An object to add to slides
#' @param presentation_id The id from the Slides presentation
#' @param on The id or number of the slide to add `object` to
#' @param object_id A unique id for the new object on the slides
#' @param overwrite If TRUE and an object with `object_id` exists it will deleted and replaced.
#' @param from_top_left Numerical vector of length two giving the position of the table as
#'  the distance in from the left and down from the top of the slide in EMU.
#'  Use `cm(x)` or `inches(x)` to convert to EMU. If `NULL` a default position is used.
#' @param size Numerical vector of length two giving the width and height of the table in EMU.
#'  Use `cm(x)` or `inches(x)` to convert to EMU. If `NULL` a default size is used.
#' @param ... Other arguments used in methods
#'
#' @return A presentation object updated with the new object. This function is used for its side
#' effect of adding an object to the slides. The returned object in R is mostly for inspection.
#' @export
#'
add_to_slides <- function(
    object,
    presentation_id,
    on = NULL,
    object_id,
    overwrite,
    from_top_left = NULL,
    ...) {
  UseMethod("add_to_slides")
}
