get_slide_ids <- function(presentationId){
  request <- gargle::request_build(
    method = "GET",
    path = "/v1/presentations/{presentationId}",
    params = list(presentationId = presentationId,
                  fields = "slides(objectId)"),
    base_url = "https://slides.googleapis.com",
    token = gsd_token()
  )
response <- gargle::request_make(request)
gargle::response_process(response)
}
