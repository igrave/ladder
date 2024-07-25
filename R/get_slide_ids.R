
#' Get ids in Slides
#'
#' @param presentationId character, the presentation id
#'
#' @return The response from the API
#'
#' This function is not polished. Probably should be moved to the SlidesTools package.
#'
#' @export
#' @examples
get_slide_ids <- function(presentationId){
  request <- gargle::request_build(
    method = "GET",
    path = "/v1/presentations/{presentationId}",
    params = list(presentationId = presentationId,
                  fields = "slides(objectId)"),
    base_url = "https://slides.googleapis.com",
    token = slides_token()
  )
response <- gargle::request_make(request)
gargle::response_process(response)
}
