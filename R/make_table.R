

make_table <- function(ft, table_id = new_id("table"), pageObjectId = "p") {
  my_tab <- list()

  nrows <-
    flextable::nrow_part(ft, part = "header") +
    flextable::nrow_part(ft, part = "body") +
    flextable::nrow_part(ft, part = "footer")

  ncols <- flextable::ncol_keys(ft)

  add(my_tab) <- CreateTableRequest(
    objectId = table_id,
    elementProperties = PageElementProperties(pageObjectId = pageObjectId),
    rows = nrows,
    columns = ncols
  )

  my_header <- table_requests(ft, table_id = table_id, part = "header")
  my_body <- table_requests(ft, table_id = table_id, part = "body")
  my_footer <- table_requests(ft, table_id = table_id, part = "footer")

  my_tab <- c(my_tab, my_header, my_body, my_footer)

  # update -------------
  my_tab_reqs <- lapply(my_tab, rm_null_objs)
  reqs <- do.call(Request, my_tab_reqs)
  reqs
}

