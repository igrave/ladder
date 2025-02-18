create_slides <- function() {
  p <- presentations.create(Presentation())
  slides_url(p$presentationId)
  p$presentationId
}


new_slide <- function(presentation_id, title = NULL, subtitle = NULL, layout) {
  requests <- list()
  placeholder_mappings <- list()

  if (!missing(title)) {
    assert_string(title, min.chars = 1)
    title_id <- new_id("title")
    add(placeholder_mappings) <- LayoutPlaceholderIdMapping(
      layoutPlaceholder = Placeholder(
        type = "TITLE",
        index = 1
      ),
      objectId = title_id
    )
  }
  if (!missing(subtitle)) {
    assert_string(subtitle, min.chars = 1)
    subtitle_id <- new_id("subtitle")
    add(placeholder_mappings) <- LayoutPlaceholderIdMapping(
      layoutPlaceholder = Placeholder(
        type = "SUBTITLE",
        index = 1
      ),
      objectId = subtitle_id
    )
  }

  add(requests) <- CreateSlideRequest(
    objectId = new_id("slide"),
    slideLayoutReference = LayoutReference(layoutId = layout),
    placeholderIdMappings = placeholder_mappings
  )

  if (!missing(title)) {
    add(requests) <- InsertTextRequest(
      objectId = title_id,
      text = title
    )
  }
  if (!missing(subtitle)) {
    add(requests) <- InsertTextRequest(
      objectId = subtitle_id,
      text = subtitle
    )
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
