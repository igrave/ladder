

#' @include generics.R
#' @export
#' @rdname add_to_slides
#' @details A gt object is added with all formatting.
#' @examplesIf interactive()
#' ## Add a gt
#' s <- choose_slides()
#' library(gt)
#' gt_iris <- gt(iris[1:5, ])
#' add_to_slides(gt_iris, s, on = 1)
add_to_slides.gt_tbl <- function(object,
                                 presentation_id,
                                 on = NULL,
                                 object_id = new_id("table"),
                                 overwrite = FALSE,
                                 from_top_left = NULL,
                                 ...) {
  assert_string(object_id, min.chars = 5)
  assert_string(presentation_id)
  presentation_id <- extract_id(presentation_id)
  page_id <- on_slide_id(presentation_id, on)

  if (!is.null(from_top_left)) {
    assert_numeric(from_top_left, len = 2, finite = TRUE, any.missing = FALSE)
  } else {
    from_top_left <- c(571450, 1442675)
  }
  reqs <- make_table_gt(object, object_id, page_id, from_top_left)

  if (isTRUE(overwrite)) {
    if (object_id %in% unlist(get_object_ids(presentation_id))) {
      reqs <- c(list(DeleteObjectRequest(objectId = object_id)), reqs)
    }
  }

  reqs <- do.call(Request, reqs)
  result <- presentations.batchUpdate(
    presentationId = presentation_id,
    BatchUpdatePresentationRequest = BatchUpdatePresentationRequest(requests = reqs)
  )
  slides_url(result$presentationId, page_id)

  invisible(result)
}



make_table_gt <- function(object, table_id, page_id, from_top_left) {
  body_cols <- object[["_boxhead"]][["var"]][object[["_boxhead"]][["type"]] %in% c("default", "stub")]
  body <- extract_cells(object, columns = body_cols,  output = "plain") |> matrix(ncol = length(body_cols))

  nrows <- 0L + as.integer(!is_null_obj(object[["_heading"]])) +
    length(unique(object[["_spanners"]][["spanner_level"]])) +
    1 + # always have one row of headings
    length(object[["_row_groups"]]) +
    nrow(body) +
    nrow(object[["_footnotes"]]) +
    as.integer(!is_null_obj(object[["_source_notes"]]))

  ncols <- ncol(body)

  tab_reqs <- list()

  add(tab_reqs) <- CreateTableRequest(
    objectId = table_id,
    elementProperties = PageElementProperties(
      pageObjectId = page_id,
      transform = AffineTransform(
        1, 1, 0, 0,
        translateX = from_top_left[1],
        translateY = from_top_left[2],
        unit = "EMU"
      )
    ),
    rows = nrows,
    columns = ncols
  )

  add(tab_reqs) <- make_gt_header(object, table_id, ncols)
  # add(tab_reqs) <- make_gt_stub()
  # add(tab_reqs) <- make_gt_column_labels()
  # add(tab_reqs) <- make_gt_body()
  # add(tab_reqs) <- make_gt_footer()


  trim_nulls(tab_reqs)
}


make_gt_header <- function(object, object_id, ncols) {
  reqs <- list()

  if (is_null_obj(object[["_heading"]])) return(reqs)

  add(reqs) <- MergeTableCellsRequest(object_id, TableRange(TableCellLocation(0, 0), 1, ncols))

  # add title (text, text style, footnotes)
  title <- object[["_heading"]]$title
  if (inherits(title, "from_markdown")) {
    message("markdown not handled in titles")
    title_text <- paste0(vec_fmt_markdown(title, output = "plain"), "\n")
    title_text_length <- nchar(title_text)
    add(reqs) <- InsertTextRequest(
      object_id,
      TableCellLocation(0, 0),
      text = title_text,
      insertionIndex = 0L
    )
  } else if (inherits(title, "html")) {
    message("html not handled in titles")
    title_text <- paste0(title, "\n")
    title_text_length <- nchar(title_text)
    add(reqs) <- InsertTextRequest(object_id, TableCellLocation(0, 0), text = title_text, insertionIndex = 0L)
  } else {
    title_text <- paste0(title, "\n")
    title_text_length <- nchar(title_text)
    add(reqs) <- InsertTextRequest(object_id, TableCellLocation(0, 0), text = title_text, insertionIndex = 0L)
  }

  add(reqs) <- UpdateTextStyleRequest(
    object_id,
    TableCellLocation(0, 0),
    style = TextStyle(fontSize = Dimension(14, "PT")), textRange = Range(type = "ALL"), fields = "fontSize"
  )

  # add subtitle (text, text style, footnotes)
  subtitle <- object[["_heading"]]$subtitle
  if (!is.null(subtitle) || nchar(subtitle) == 0) {

    if (inherits(subtitle, "from_markdown")) {
      message("markdown not handled in subtitles")
      subtitle_text <- paste0(vec_fmt_markdown(subtitle, output = "plain"))
      add(reqs) <- InsertTextRequest(
        object_id,
        TableCellLocation(0, 0),
        text = subtitle_text,
        insertionIndex = title_text_length
      )
    } else if (inherits(subtitle, "html")) {
      message("html not handled in subtitles")
      subtitle_text <- paste0(subtitle)
      add(reqs) <- InsertTextRequest(object_id, TableCellLocation(0, 0), text = subtitle_text,
                                     insertionIndex = title_text_length)
    } else {
      subtitle_text <- paste0(subtitle)
      add(reqs) <- InsertTextRequest(object_id, TableCellLocation(0, 0), text = subtitle_text,
                                     insertionIndex = title_text_length)
    }

    add(reqs) <- UpdateTextStyleRequest(
      object_id,
      TableCellLocation(0, 0),
      style = TextStyle(fontSize = Dimension(10, "PT")),
      textRange = Range(startIndex = title_text_length, type = "FROM_START_INDEX"),
      fields = "fontSize"
    )
  }
    # style cell (background, borders, paragraph?)
  options <- object[["_options"]]
  header_alignment <- switch(
    options[options$parameter == "heading_align", "value"] |> unlist(),
    "left" = "START",
    "right" = "END",
    "center" = "CENTER"
  )

  add(reqs) <- UpdateParagraphStyleRequest(
    object_id,
    cellLocation = TableCellLocation(0, 0),
    style = ParagraphStyle(alignment = header_alignment),
    textRange = Range(type = "ALL"),
    fields = "alignment"
  )


  trim_nulls(reqs)
}





