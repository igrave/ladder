# function myFunction() {
#   var slides = SlidesApp.getActivePresentation().getSlides();
#   slides[0].getShapes().forEach(function(shape){
#     // if(shape.getTitle() == "image") {
#       var checkHeader = shape.getText().asString().split(",");
#       var bytes = Utilities.base64Decode(checkHeader.length == 1 ? src : checkHeader[1]);
#       var blob = Utilities.newBlob(bytes, 'image/png', 'MyImageName');
#       shape.replaceWithImage(blob)
#       //  }
#   });
#
#
# }
#
# function(pres_id, slide_id, image_data, left, top, width, height, shape_id)
# dev.print(png("hello.png"))
# readBin("hello.png", what = "raw", n = 1e6) -> rb
# jsonlite::base64_enc(rb) -> b64
