#' Add an item to a list
#' @param x A list like object, typically a list of *Request objects
#' @param value An item to append to the list
#' @returns A list
#' @noRd
`add<-` <- function(x, value) {
  if (is.null(value)) {
    x
  } else {
    c(x, list(value))
  }
}

#' Print presentation URL
#'
#' @param presentation_id ID of presentation
#' @param slide_id Optional slide id to link directly to a certain slide. See [get_slide_ids].
#'
#' @return Prints URL as a link and invisibly returns URL.
#' @export
#'
#' @examples
#' slides_url("example_id_won't_work_1234567asdfbg")
#' slides_url("example_id_won't_work_1234567asdfbg", slide_id = "p")
#'
slides_url <- function(presentation_id, slide_id = NULL) {
  checkmate::assert_string(slide_id, null.ok = TRUE)
  checkmate::assert_string(presentation_id, null.ok = FALSE)
  slide_part <- if (!is.null(slide_id)) paste0("edit#slide=id.", slide_id) else ""
  url <- paste0("https://docs.google.com/presentation/d/", presentation_id, "/", slide_part)
  cat(cli::style_hyperlink(url, url))
  invisible(url)
}


on_slide_id <- function(presentation_id, on) {
  slide_ids <- get_slide_ids(presentation_id)
  if (!is.null(on)) {
    on <- on[1]
    if (is.numeric(on)) {
      assert_integerish(on, lower = 1, upper = length(slide_ids), any.missing = FALSE)
      this_slide_id <- slide_ids[on]
    } else if (is.character(on)) {
      assert_choice(on, slide_ids)
      this_slide_id <- on
    } else {
      stop("Unrecognised `on` value: ", on)
    }
  } else {
    this_slide_id <- tail(slide_ids, n = 1L)
  }
  this_slide_id
}


#' Extract the Presentation ID from a URL string
#'
#' @param presentation A string containing the presentation URL
#' See [slides_url()] for the inverse operation.
#' @returns The file ID of the presentation
#' @export
#' @keywords internal
#' @examples
#' extract_id("https://docs.google.com/presentation/d/1RbEmFUkKs6gBp4ZMABQ/present?slide=id.p5")
extract_id <- function(presentation) {
  if (!is.null(presentation)) {
    if (grepl("docs.google.com", presentation, fixed = TRUE)) {
      sub("/.*$", "", sub("^.*/d/", "", presentation))
    } else {
      presentation
    }
  } else {
    ""
  }
}



#' Convert lengths to EMU
#'
#' @param ... One or more numeric values to convert
#'
#' @returns A numeric vector of lengths converted to EMU
#' @export
#' @rdname convert-units
#' @examples
#' inches(2, 0)
inches <- function(...) {
  x <- list(...)
  assert_list(x, types = "numeric")
  inch_to_emu(unlist(x))
}

#' @rdname convert-units
#' @export
#' @examples
#' cm(3, 2)
cm <- function(...) {
  x <- list(...)
  assert_list(x, types = "numeric")
  cm_to_emu(unlist(x))
}
