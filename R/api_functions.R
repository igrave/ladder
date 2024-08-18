#' Gets the latest version of the specified presentation.
#'
#' @seealso \href{https://developers.google.com/slides/}{Google Documentation}
#'
#' @param presentationId The ID of the presentation to retrieve
#' @param params A list of parameters to include in the GET request, such as fields.
#' @noRd
presentations.get <- function(presentationId, params = list()) {
  checkmate::assert_string(presentationId)
  checkmate::assert_list(params)

  request <- gargle::request_build(
    method = "GET",
    path = "/v1/presentations/{presentationId}",
    params = c(list(presentationId = presentationId), params),
    base_url = "https://slides.googleapis.com",
    token = ladder_token()
  )
  response <- gargle::request_make(request)
  gargle::response_process(response)
}

#' Applies one or more updates to the presentation.
#'
#' Each request is validated before being applied. If any request is not valid, then the entire
#' request will fail and nothing will be applied. Some requests have replies to give you some
#' information about how they are applied. Other requests do not need to return information; these
#' each return an empty reply. The order of replies matches that of the requests. For example,
#' suppose you call batchUpdate with four updates, and only the third one returns information. The
#' response would have two empty replies: the reply to the third request, and another empty reply,
#' in that order. Because other users may be editing the presentation, the presentation might not
#' exactly reflect your changes: your changes may be altered with respect to collaborator changes.
#' If there are no collaborators, the presentation should reflect your changes. In any case, the
#' updates in your request are guaranteed to be applied together atomically.
#'
#' @seealso \href{https://developers.google.com/slides/}{Google Documentation}
#'
#' @param BatchUpdatePresentationRequest The \link{BatchUpdatePresentationRequest} object to pass to
#'   this method
#' @param presentationId The presentation to apply the updates to
#' @family BatchUpdatePresentationRequest functions
#' @noRd
presentations.batchUpdate <- function(BatchUpdatePresentationRequest, presentationId) {
  # stopifnot(inherits(BatchUpdatePresentationRequest, "BatchUpdatePresentationRequest"))

  request <- gargle::request_build(
    method = "POST",
    path = "/v1/presentations/{presentationId}:batchUpdate",
    params = list(presentationId = presentationId),
    body = BatchUpdatePresentationRequest,
    base_url = "https://slides.googleapis.com",
    token = ladder_token()
  )
  response <- gargle::request_make(request)
  gargle::response_process(response)
}

#' Creates a blank presentation using the title given in the request.
#'
#' If a `presentationId` is provided, it is used as the ID of the new
#' presentation. Otherwise, a new ID is generated. Other fields in the request,
#' including any provided content, are ignored. Returns the created presentation.
#'
#'
#' @seealso \href{https://developers.google.com/slides/}{Google Documentation}
#'
#' @param Presentation The \link{Presentation} object to pass to this method
#' @family Presentation functions
#' @noRd
presentations.create <- function(Presentation) {
  request <- gargle::request_build(
    method = "POST",
    path = "/v1/presentations",
    body = Presentation,
    base_url = "https://slides.googleapis.com",
    token = ladder_token()
  )
  response <- gargle::request_make(request)
  gargle::response_process(response)
}




#' Gets the latest version of the specified page in the presentation.
#'
#'
#' @seealso \href{https://developers.google.com/slides/}{Google Documentation}
#'
#' @param presentationId The ID of the presentation to retrieve
#' @param pageObjectId The object ID of the page to retrieve
#'
#' @importFrom gargle request_build request_make response_process
#'
presentations.pages.get <- function(presentationId, pageObjectId) {
  request <- gargle::request_build(
    method = "GET",
    path = "/v1/presentations/{presentationId}/pages/{pageObjectId}",
    params = list(presentationId = presentationId, pageObjectId = pageObjectId),
    base_url = "https://slides.googleapis.com",
    token = ladder_token()
  )
  response <- gargle::request_make(request)
  gargle::response_process(response)
}


#' Generates a thumbnail of the latest version of the specified page.
#'
#' Generates a thumbnail of the latest version of the specified page in the presentation and returns
#' a URL to the thumbnail image. This request counts as an [expensive read request](/slides/limits)
#' for quota purposes.
#'
#'
#' @seealso \href{https://developers.google.com/slides/}{Google Documentation}
#'
#' @param presentationId The ID of the presentation to retrieve
#' @param pageObjectId The object ID of the page whose thumbnail to retrieve
#' @param thumbnailProperties.thumbnailSize The optional thumbnail image size
#' @param thumbnailProperties.mimeType The optional mime type of the thumbnail image
#'
#'
presentations.pages.getThumbnail <- function(presentationId,
                                             pageObjectId,
                                             thumbnailProperties.thumbnailSize = NULL,
                                             thumbnailProperties.mimeType = NULL) {
  query_params <- trim_nulls(list(
    thumbnailProperties.thumbnailSize = thumbnailProperties.thumbnailSize,
    thumbnailProperties.mimeType = thumbnailProperties.mimeType
  ))

  request <- gargle::request_build(
    method = "GET",
    path = "/v1/presentations/{presentationId}/pages/{pageObjectId}/thumbnail",
    params = c(
      list(presentationId = presentationId, pageObjectId = pageObjectId),
      query_params
    ),
    base_url = "https://slides.googleapis.com",
    token = ladder_token()
  )
  response <- gargle::request_make(request)
  gargle::response_process(response)
}
