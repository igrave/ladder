# auth -------
library(googleslides.api)
gsd_auth()
googleslides.api::presentation
new_pres <- presentations.create(NULL)
new_pres$presentationId

# example ---------

library('officer')
# create flextable ------
library(flextable)

ft <- flextable(head(mtcars))
ft <- theme_box(ft)
ft <- bold(ft, bold = TRUE, part = "header")
ft <- bold(ft, part = "header", i = 1, j = 3, bold = FALSE)
ft <- bold(ft, part = "body", j = 2, bold = TRUE)
ft <- bold(ft, part = "body", i = 4, bold = TRUE)
ft <- flextable::fontsize(ft, i =1, size = 14)
ft <- flextable::color(ft, i = 5:6, j = 1:2, "pink", part = "body")
ft <- hline_top(ft, border = fp_border(color = "green", width = 2), part = "header")
ft <- hline_top(ft, border = fp_border(color = "blue", width = 1, style = "dashed"), part = "body")
ft <- hline(ft, i = 3, j = 3, border = fp_border("yellow", "dotted", 3))
ft <- vline_right(ft, i = 3:4, border = fp_border("black", "dashed", 4), part = "body")
ft <- vline_left(ft, border = fp_border("red", "solid", 2))
ft <- vline_right(ft, border = fp_border("red", "solid", 2))
ft <- vline(ft, i = 2:4, j = 10, border = fp_border("red", "dashed", 2), part = "body")

ft <- valign(ft, i = 3, j = 3, valign = "top", part = "body")
ft <- merge_at(ft, i = 4:5, j = 5:6)
ft <- flextable::bg(ft, i = 4, j = 5, bg = "orange")
ft <- highlight(ft, i = 4:5, j = 5:7) # the merged cell exists at [4,5]
# ft$body$styles$text$shading.color$data has "yellow" for [4:5, 5:7]
# TODO see how google api will manage that
ft <- align(ft, i = 1, j = 6, part="header", align = "left")
ft <- align(ft,  j = 2, part="body", align = "left")
# ft <- autofit(ft)
ft <- height(ft, i = 5, height = 2)
ft

add_to_slides(ft, new_pres$presentationId)

my_tab <- make_table(ft, "hello_table2")
batch_res <- presentations.batchUpdate(
  presentationId = new_pres$presentationId,
  BatchUpdatePresentationRequest = BatchUpdatePresentationRequest(requests = my_tab)
)
slides_url(batch_res)
my_tab <- list()

# Create table:
# rows, cols

nrows <-
  flextable::nrow_part(ft, part = "header") +
  flextable::nrow_part(ft, part = "body") +
  flextable::nrow_part(ft, part = "footer")

ncols <- ncol_keys(ft)

add(my_tab) <- CreateTableRequest(
  objectId = "mytab",
  elementProperties = PageElementProperties(pageObjectId = "p"),
  rows = nrows,
  columns = ncols
)


my_header <- table_requests(ft, part = "header")
my_body <- table_requests(ft, part = "body")
# my_footer <- table_requests(ft, part = "footer")

my_tab <- c(my_tab, my_header, my_body)

# update -------------
my_tab_reqs <- lapply(my_tab, googleslides.api:::rm_null_objs) # rm_null_objs not exported, so this should be hidden
reqs <- do.call(Request, my_tab_reqs)
batch_res <- presentations.batchUpdate(
  presentationId = new_pres$presentationId,
  BatchUpdatePresentationRequest =  BatchUpdatePresentationRequest(requests = reqs)
)

slide_ids <- get_slide_ids(new_pres$presentationId)

thumb <- googleslides.api:::presentations.pages.getThumbnail(
  presentationId =new_pres$presentationId,
  pageObjectId = slide_ids[[1]][[1]]$objectId
)
thumb$width
dest <- tempfile("slide_", fileext = ".png", tmpdir = "./temp")
download.file(url = thumb$contentUrl, destfile = dest, method = "curl")
getOption("viewer")("./temp/slide_7c74640c20e0.png")
