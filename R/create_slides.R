#' Create a new Google Slides presentation
#'
#' @returns A presentation id
#' @export
#'
#' @examplesif interactive()
#' create_slides()
create_slides <- function() {
  p <- presentations.create(Presentation())
  slides_url(p$presentationId)
  p$presentationId
}


#' Add a slide to a presentation
#'
#' @param presentation_id
#' @param layout The layout to use for the slide
#' @param title
#' @param subtitle
#'
#' @returns
#' @export
#'
#' @examples
new_slide <- function(
    presentation_id,
    layout,
    centered_title = NULL,
    subtitle = NULL,
    title = NULL,
    body = NULL
) {
  requests <- list()
  placeholder_mappings <- list()

  if (!is.null(title)) {
    title_ids <- character(length(title))
    for (i in seq_along(title)) {
      if (is.na(title[i])) next
      assert_string(title[[i]], min.chars = 1)
      title_ids[i] <- new_id("title")
      add(placeholder_mappings) <- LayoutPlaceholderIdMapping(
        layoutPlaceholder = Placeholder(
          type = "TITLE",
          index = i - 1
        ),
        objectId = title_ids[i]
      )
    }
  }

  if (!is.null(subtitle)) {
    subtitle_ids <- character(length(subtitle))
    for (i in seq_along(subtitle)) {
      assert_string(subtitle[[i]], min.chars = 1)
      subtitle_ids[i] <- new_id("subtitle")
      add(placeholder_mappings) <- LayoutPlaceholderIdMapping(
        layoutPlaceholder = Placeholder(
          type = "SUBTITLE",
          index = i - 1
        ),
        objectId = subtitle_ids[i]
      )
    }
  }

  if (!is.null(body)) {
    body_ids <- character(length(body))
    for (i in seq_along(body)) {
      assert_string(body[[i]], min.chars = 1)
      body_ids[i] <- new_id("body")
      add(placeholder_mappings) <- LayoutPlaceholderIdMapping(
        layoutPlaceholder = Placeholder(
          type = "BODY",
          index = i - 1
        ),
        objectId = body_ids[i]
      )
    }
  }

  add(requests) <- CreateSlideRequest(
    objectId = new_id("slide"),
    slideLayoutReference = LayoutReference(layoutId = layout),
    placeholderIdMappings = placeholder_mappings
  )

  if (!is.null(title)) {
    for (i in seq_along(title)) {
      if (is.na(title[i])) next
      add(requests) <- InsertTextRequest(
        objectId = title_ids[i],
        text = title[i]
      )
    }
  }

  if (!is.null(subtitle)) {
    for (i in seq_along(subtitle)) {
      add(requests) <- InsertTextRequest(
        objectId = subtitle_ids[i],
        text = subtitle[i]
      )
    }
  }

  if (!is.null(body)) {
    for (i in seq_along(body)) {
      add(requests) <- InsertTextRequest(
        objectId = body_ids[i],
        text = body[i]
      )
    }
  }

  requests <- lapply(requests, trim_nulls)
  requests <- do.call(Request, requests)

  result <- presentations.batchUpdate(
    presentationId = presentation_id,
    BatchUpdatePresentationRequest = BatchUpdatePresentationRequest(
      requests = requests
    )
  )
  result
}


get_layouts <- function(presentation_id) {
  p <- presentations.get(presentation_id)
  layouts <- p$layouts
  layout_list <- lapply(
    layouts, function(lo) {
      objectId <- lo$objectId
      name <- lo$layoutProperties$name
      displayName <- lo$layoutProperties$displayName

      if (length(lo$pageElements)) {
        placeholders <- lapply(
          lo$pageElements, function(pe) {
            objectId <- if (is.null(pe$objectId)) NA else pe$objectId
            index <- if (is.null(pe$shape$placeholder$index)) NA else pe$shape$placeholder$index
            type <- if (is.null(pe$shape$placeholder$type)) NA else pe$shape$placeholder$type
            data.frame(placeholder_objectId = objectId, index = index, type = type)
          })
        placeholders_df <- do.call(rbind, placeholders)
      } else {
        placeholders_df <- data.frame(placeholder_objectId = NA, index = NA, type = NA)
      }
      df <- data.frame(layout_objectId = objectId, name, displayName, placeholders_df)
    })
  do.call(rbind.data.frame, layout_list)
}
