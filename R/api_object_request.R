# This is manually modified so is separate from api_objects.R so it doesn't get overwritten


#' Request Object
#'
#' @details
#' A single kind of update to apply to a presentation.
#'
#' @param createSlide ([CreateSlideRequest])
#'  Creates a new slide.
#' @param createShape ([CreateShapeRequest])
#'  Creates a new shape.
#' @param createTable ([CreateTableRequest])
#'  Creates a new table.
#' @param insertText ([InsertTextRequest])
#'  Inserts text into a shape or table cell.
#' @param insertTableRows ([InsertTableRowsRequest])
#'  Inserts rows into a table.
#' @param insertTableColumns ([InsertTableColumnsRequest])
#'  Inserts columns into a table.
#' @param deleteTableRow ([DeleteTableRowRequest])
#'  Deletes a row from a table.
#' @param deleteTableColumn ([DeleteTableColumnRequest])
#'  Deletes a column from a table.
#' @param replaceAllText ([ReplaceAllTextRequest])
#'  Replaces all instances of specified text.
#' @param deleteObject ([DeleteObjectRequest])
#'  Deletes a page or page element from the presentation.
#' @param updatePageElementTransform ([UpdatePageElementTransformRequest])
#'  Updates the transform of a page element.
#' @param updateSlidesPosition ([UpdateSlidesPositionRequest])
#'  Updates the position of a set of slides in the presentation.
#' @param deleteText ([DeleteTextRequest])
#'  Deletes text from a shape or a table cell.
#' @param createImage ([CreateImageRequest])
#'  Creates an image.
#' @param createVideo ([CreateVideoRequest])
#'  Creates a video.
#' @param createSheetsChart ([CreateSheetsChartRequest])
#'  Creates an embedded Google Sheets chart.
#' @param createLine ([CreateLineRequest])
#'  Creates a line.
#' @param refreshSheetsChart ([RefreshSheetsChartRequest])
#'  Refreshes a Google Sheets chart.
#' @param updateShapeProperties ([UpdateShapePropertiesRequest])
#'  Updates the properties of a Shape.
#' @param updateImageProperties ([UpdateImagePropertiesRequest])
#'  Updates the properties of an Image.
#' @param updateVideoProperties ([UpdateVideoPropertiesRequest])
#'  Updates the properties of a Video.
#' @param updatePageProperties ([UpdatePagePropertiesRequest])
#'  Updates the properties of a Page.
#' @param updateTableCellProperties ([UpdateTableCellPropertiesRequest])
#'  Updates the properties of a TableCell.
#' @param updateLineProperties ([UpdateLinePropertiesRequest])
#'  Updates the properties of a Line.
#' @param createParagraphBullets ([CreateParagraphBulletsRequest])
#'  Creates bullets for paragraphs.
#' @param replaceAllShapesWithImage ([ReplaceAllShapesWithImageRequest])
#'  Replaces all shapes matching some criteria with an image.
#' @param duplicateObject ([DuplicateObjectRequest])
#'  Duplicates a slide or page element.
#' @param updateTextStyle ([UpdateTextStyleRequest])
#'  Updates the styling of text within a Shape or Table.
#' @param replaceAllShapesWithSheetsChart ([ReplaceAllShapesWithSheetsChartRequest])
#'  Replaces all shapes matching some criteria with a Google Sheets chart.
#' @param deleteParagraphBullets ([DeleteParagraphBulletsRequest])
#'  Deletes bullets from paragraphs.
#' @param updateParagraphStyle ([UpdateParagraphStyleRequest])
#'  Updates the styling of paragraphs within a Shape or Table.
#' @param updateTableBorderProperties ([UpdateTableBorderPropertiesRequest])
#'  Updates the properties of the table borders in a Table.
#' @param updateTableColumnProperties ([UpdateTableColumnPropertiesRequest])
#'  Updates the properties of a Table column.
#' @param updateTableRowProperties ([UpdateTableRowPropertiesRequest])
#'  Updates the properties of a Table row.
#' @param mergeTableCells ([MergeTableCellsRequest])
#'  Merges cells in a Table.
#' @param unmergeTableCells ([UnmergeTableCellsRequest])
#'  Unmerges cells in a Table.
#' @param groupObjects ([GroupObjectsRequest])
#'  Groups objects, such as page elements.
#' @param ungroupObjects ([UngroupObjectsRequest])
#'  Ungroups objects, such as groups.
#' @param updatePageElementAltText ([UpdatePageElementAltTextRequest])
#'  Updates the alt text title and/or description of a page element.
#' @param replaceImage ([ReplaceImageRequest])
#'  Replaces an existing image with a new image.
#' @param updateSlideProperties ([UpdateSlidePropertiesRequest])
#'  Updates the properties of a Slide
#' @param updatePageElementsZOrder ([UpdatePageElementsZOrderRequest])
#'  Updates the Z-order of page elements.
#' @param updateLineCategory ([UpdateLineCategoryRequest])
#'  Updates the category of a line.
#' @param rerouteLine ([RerouteLineRequest])
#'  Reroutes a line such that it's connected at the two closest connection sites on the connected page elements.
#'
#' @return Request object
#'
#' @noRd
Request <- function(...) {
  req_list <- list(...)
  req_types <- lapply(req_list, function(req) {
    req_type <- switch(
      class(req)[1],
      "InsertTableColumnsRequest" = "insertTableColumns",
      "DeleteTableColumnRequest" = "deleteTableColumn",
      "UpdateSlidesPositionRequest" = "updateSlidesPosition",
      "UpdateTextStyleRequest" = "updateTextStyle",
      "CreateSlideRequest" = "createSlide",
      "UpdateParagraphStyleRequest" = "updateParagraphStyle",
      "UpdateTableRowPropertiesRequest" = "updateTableRowProperties",
      "UpdateTableBorderPropertiesRequest" = "updateTableBorderProperties",
      "ReplaceAllShapesWithSheetsChartRequest" = "replaceAllShapesWithSheetsChart",
      "UpdateTableColumnPropertiesRequest" = "updateTableColumnProperties",
      "UngroupObjectsRequest" = "ungroupObjects",
      "ReplaceImageRequest" = "replaceImage",
      "DeleteTableRowRequest" = "deleteTableRow",
      "CreateParagraphBulletsRequest" = "createParagraphBullets",
      "UpdateLinePropertiesRequest" = "updateLineProperties",
      "UpdateImagePropertiesRequest" = "updateImageProperties",
      "DeleteParagraphBulletsRequest" = "deleteParagraphBullets",
      "CreateSheetsChartRequest" = "createSheetsChart",
      "UpdateVideoPropertiesRequest" = "updateVideoProperties",
      "UpdateShapePropertiesRequest" = "updateShapeProperties",
      "GroupObjectsRequest" = "groupObjects",
      "MergeTableCellsRequest" = "mergeTableCells",
      "ReplaceAllShapesWithImageRequest" = "replaceAllShapesWithImage",
      "RefreshSheetsChartRequest" = "refreshSheetsChart",
      "UnmergeTableCellsRequest" = "unmergeTableCells",
      "UpdateSlidePropertiesRequest" = "updateSlideProperties",
      "UpdatePageElementTransformRequest" = "updatePageElementTransform",
      "InsertTableRowsRequest" = "insertTableRows",
      "DeleteTextRequest" = "deleteText",
      "CreateImageRequest" = "createImage",
      "CreateVideoRequest" = "createVideo",
      "UpdatePageElementAltTextRequest" = "updatePageElementAltText",
      "CreateLineRequest" = "createLine",
      "RerouteLineRequest" = "rerouteLine",
      "CreateTableRequest" = "createTable",
      "UpdateLineCategoryRequest" = "updateLineCategory",
      "UpdatePageElementsZOrderRequest" = "updatePageElementsZOrder",
      "UpdatePagePropertiesRequest" = "updatePageProperties",
      "CreateShapeRequest" = "createShape",
      "UpdateTableCellPropertiesRequest" = "updateTableCellProperties",
      "InsertTextRequest" = "insertText",
      "DuplicateObjectRequest" = "duplicateObject",
      "DeleteObjectRequest" = "deleteObject",
      "ReplaceAllTextRequest" = "replaceAllText"
    )
    # req_type
    req_list <- list()
    req_list[[req_type]] <- req
    req_list
  })
  # names(req_list) <- req_types
  structure(req_types, class = c("Request", "list"))
}
