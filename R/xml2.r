#' Extract parent node tags for all nodes in XML
#'
#' @param xml An xml2 object (xml_document)
#' @return A data frame with columns: node_path, tag_name, parent_path
#' @noRd
extract_parent_node_tags <- function(xml) {
  if (!inherits(xml, c("xml_document", "xml_node"))) {
    stop("Input must be an xml2 object (xml_document or xml_node)")
  }

  # Get all text nodes in the document
  all_nodes <- xml2::xml_find_all(xml2::xml_ns_strip(xml), ".//*")
# for html use this to get text nodes
# xml2::xml_find_all(xml2::xml_ns_strip(xml), ".//*[string-length(text()) > 0]")

  # Function to get parent path for a single node
  get_parent_path <- function(node) {
    parents <- character(0)
    current <- node

    # Walk up the parent chain
    while (!is.null(current) && xml_name(current) != "document" && xml_name(current) != "body") {
      tag <- xml2::xml_name(current)
      if (!is.na(tag) && tag != "") {
        parents <- c(tag, parents)
      }
      current <- xml2::xml_parent(current)
    }

    return(parents)
  }

  # Extract information for each node
  results <- lapply(all_nodes, function(node) {
    parent_path <- get_parent_path(node)
    current_tag <- xml2::xml_name(node)

    # Create the full path (parents + current node)
    full_path <- if (length(parent_path) > 1) {
      paste(parent_path, collapse = " > ")
    } else if (length(parent_path) == 1) {
      parent_path[1]
    } else {
      current_tag
    }

    # Parent path (excluding current node)
    parent_only <- if (length(parent_path) > 1) {
      paste(parent_path[-length(parent_path)], collapse = " > ")
    } else {
      ""
    }

    node_text <- xml2::xml_text(node)

    data.frame(
      node_path = full_path,
      tag_name = current_tag,
      parent_path = parent_only,
      text = node_text,
      stringsAsFactors = FALSE
    )
  })

  # Combine all results
  do.call(rbind, results)
}
