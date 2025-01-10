#' Preview Slide as Image
#'
#' @param presentation_id character, the presentation id
#' @param page character, the page number or id
#' @param size character, the size of the image. One of "SMALL", "MEDIUM",
#' "LARGE"
#' @param viewer logical, if TRUE opens the image in the viewer
#' @return A character string of the file path to the saved image and
#'  opens the image in the viewer or browser if `viewer = TRUE`.
#' @export
view_slide <- function(presentation_id, page, size = "MEDIUM", viewer = TRUE) {
  size <- match.arg(size, c("SMALL", "MEDIUM", "LARGE"))
  page_id <- on_slide_id(presentation_id, page)
  file <- get_slide_img(presentation_id, page_id, size)
  message("Slide preview saved at ", file)
  viewer_fun <- getOption("viewer")
  if (viewer) {
    if (is.null(viewer_fun)) {
      utils::browseURL(file)
    } else {
      viewer_fun(file)
    }
  }
  file
}

get_slide_img <- function(presentation_id, page_id, size = "MEDIUM") {
  thumbnail <- presentations.pages.getThumbnail(
    presentationId = presentation_id,
    pageObjectId = page_id,
    thumbnailProperties.mimeType = "PNG",
    thumbnailProperties.thumbnailSize = size
  )
  temp_file <- tempfile("slide_", fileext = ".png", tmpdir = tempdir(TRUE))
  httr::GET(thumbnail$contentUrl, httr::write_disk(temp_file, overwrite = TRUE))
  temp_file
}
