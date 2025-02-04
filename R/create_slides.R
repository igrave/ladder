create_slides <- function() {
  p <- presentations.create(Presentation())
  slides_url(p$presentationId)
  p$presentationId
}


new_slide <- function(presentation_id, title, subtitle, layout) {
  requests <- list()
  title_id <- new_id("title")
  subtitle_id <- new_id("subtitle")

  add(requests) <- CreateSlideRequest(
    objectId = presentation_id,
    slideLayoutReference = LayoutReference(layoutId = layout),
    placeholderIdMappings = list(
      LayoutPlaceholderIdMapping(
        layoutPlaceholder = Placeholder(
          type = "TITLE",
          index = 1
        ),
        objectId = title_id
      ),
      LayoutPlaceholderIdMapping(
        layoutPlaceholder = Placeholder(
          type = "SUBTITLE",
          index = 0
        ),
        objectId = subtitle_id
      )
    )
  )


  add(requests) <- InsertTextRequest(
    objectId = title_id,
    text = title
  )

  add(requests) <- InsertTextRequest(
    objectId = subtitle_id,
    text = subtitle
  )

  requests <- lapply(requests, trim_nulls)
  requests <- do.call(Request, requests)

  result <- presentations.batchUpdate(
    presentationId = presentation_id,
    BatchUpdatePresentationRequest = BatchUpdatePresentationRequest(
      requests = requests
    )
  )

}


get_layouts <- function(presentation_id) {
  p <- presentations.get(presentation_id)
  layouts <- p$layouts
  layout_list <- lapply(
    layouts, function(lo) {
      objectId <- lo$objectId
      name <- lo$layoutProperties$name
      displayName <- lo$layoutProperties$displayName

      placeholders <- lapply(
        lo$pageElements, function(pe) {
          if (is.null(pe$shape$placeholder)) {
            return(NULL)
          } else {
            objectId <- if (is.null(pe$objectId)) NA else pe$objectId
            index <- if (is.null(pe$shape$placeholder$index)) NA else pe$shape$placeholder$index
            type <- if (is.null(pe$shape$placeholder$type)) NA else pe$shape$placeholder$type
            data.frame(placeholder_objectId = objectId, index = index, type = type)
          }
        })

      if (length(trim_nulls(placeholders)) == 0) {
        placeholders_df <- data.frame(placeholder_objectId = NA, index = NA, type = NA)
      } else {
        placeholders_df <- do.call(rbind, placeholders)
      }
      df <- data.frame(layout_objectId = objectId, name, displayName, placeholders_df)
    })
  do.call(rbind.data.frame, layout_list)
}
