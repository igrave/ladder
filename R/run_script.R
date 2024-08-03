
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
run_script <- function(presentationId){
  request <- gargle::request_build(
    method = "POST",
    path = "/v1/scripts/{scriptId}:run",
    params = list(scriptId = "AKfycbxTjsjs_MBE7meDAIaAw_2AiSauC-SaGTv0d6j5ocFzAH_hgbyA2c_qxlFTTqc5TbI"),
    body = list(
      "function" = "myFunction",
      parameters = list(presentationId)
    ),
    base_url = "https://script.googleapis.com",
    token = slides_token()
  )
  response <- gargle::request_make(request)
  gargle::response_process(response)
}
