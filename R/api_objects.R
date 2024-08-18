#' Presentation Object
#'
#' @details A Google Slides presentation.
#'
#' @param presentationId (string) The ID of the presentation.
#' @param pageSize ([Size]) The size of pages in the presentation.
#' @param slides (list of [Page] objects) The slides in the presentation. A slide inherits
#'   properties from a slide layout.
#' @param title (string) The title of the presentation.
#' @param masters (list of [Page] objects) The slide masters in the presentation. A slide master
#'   contains all common page elements and the common properties for a set of layouts. They serve
#'   three purposes: - Placeholder shapes on a master contain the default text styles and shape
#'   properties of all placeholder shapes on pages that use that master. - The master page
#'   properties define the common page properties inherited by its layouts. - Any other shapes on
#'   the master slide appear on all slides using that master, regardless of their layout.
#' @param layouts (list of [Page] objects) The layouts in the presentation. A layout is a template
#'   that determines how content is arranged and styled on the slides that inherit from that layout.
#' @param locale (string) The locale of the presentation, as an IETF BCP 47 language tag.
#' @param revisionId (string) Output only. The revision ID of the presentation. Can be used in
#'   update requests to assert the presentation revision hasn't changed since the last read
#'   operation. Only populated if the user has edit access to the presentation. The revision ID is
#'   not a sequential number but a nebulous string. The format of the revision ID may change over
#'   time, so it should be treated opaquely. A returned revision ID is only guaranteed to be valid
#'   for 24 hours after it has been returned and cannot be shared across users. If the revision ID
#'   is unchanged between calls, then the presentation has not changed. Conversely, a changed ID
#'   (for the same presentation and user) usually means the presentation has been updated. However,
#'   a changed ID can also be due to internal factors such as ID format changes.
#' @param notesMaster ([Page]) The notes master in the presentation. It serves three purposes: -
#'   Placeholder shapes on a notes master contain the default text styles and shape properties of
#'   all placeholder shapes on notes pages. Specifically, a `SLIDE_IMAGE` placeholder shape contains
#'   the slide thumbnail, and a `BODY` placeholder shape contains the speaker notes. - The notes
#'   master page properties define the common page properties inherited by all notes pages. - Any
#'   other shapes on the notes master appear on all notes pages. The notes master is read-only.
#'
#' @return Presentation object
#'
#' @noRd
Presentation <- function(
    presentationId = NULL,
    pageSize = NULL,
    slides = NULL,
    title = NULL,
    masters = NULL,
    layouts = NULL,
    locale = NULL,
    revisionId = NULL,
    notesMaster = NULL) {
  structure(
    list(
      "presentationId" = presentationId,
      "pageSize" = pageSize,
      "slides" = slides,
      "title" = title,
      "masters" = masters,
      "layouts" = layouts,
      "locale" = locale,
      "revisionId" = revisionId,
      "notesMaster" = notesMaster
    ),
    class = c("Presentation", "list")
  )
}

#' Size Object
#'
#' @details
#' A width and height.
#'
#' @param width ([Dimension])
#'  The width of the object.
#' @param height ([Dimension])
#'  The height of the object.
#'
#' @return Size object
#'
#' @noRd
Size <- function(
    width = NULL,
    height = NULL) {
  structure(
    list(
      "width" = width,
      "height" = height
    ),
    class = c("Size", "list")
  )
}

#' Dimension Object
#'
#' @details A magnitude in a single direction in the specified units.
#'
#' @param magnitude (number) The magnitude.
#' @param unit (string) The units for magnitude.
#' - `UNIT_UNSPECIFIED`: The units are unknown.
#' - `EMU`: An English Metric Unit (EMU) is defined as 1/360,000 of a centimeter and thus there are 914,400 EMUs per inch, and 12,700 EMUs per point.
#' - `PT`: A point, 1/72 of an inch.
#'
#' @return Dimension object
#'
#' @noRd
Dimension <- function(
    magnitude = NULL,
    unit = NULL) {
  checkmate::assert_choice(unit, c("UNIT_UNSPECIFIED", "EMU", "PT"), null.ok = TRUE)
  structure(
    list(
      "magnitude" = magnitude,
      "unit" = unit
    ),
    class = c("Dimension", "list")
  )
}

#' Page Object
#'
#' @details A page in a presentation.
#'
#' @param objectId (string) The object ID for this page. Object IDs used by Page and PageElement
#'   share the same namespace.
#' @param pageType (string) The type of the page.
#' - `SLIDE`: A slide page.
#' - `MASTER`: A master slide page.
#' - `LAYOUT`: A layout page.
#' - `NOTES`: A notes page.
#' - `NOTES_MASTER`: A notes master page.
#' @param pageElements (list of [PageElement] objects) The page elements rendered on the page.
#' @param slideProperties ([SlideProperties]) Slide specific properties. Only set if page_type =
#'   SLIDE.
#' @param layoutProperties ([LayoutProperties]) Layout specific properties. Only set if page_type =
#'   LAYOUT.
#' @param notesProperties ([NotesProperties]) Notes specific properties. Only set if page_type =
#'   NOTES.
#' @param masterProperties ([MasterProperties]) Master specific properties. Only set if page_type =
#'   MASTER.
#' @param revisionId (string) Output only. The revision ID of the presentation. Can be used in
#'   update requests to assert the presentation revision hasn't changed since the last read
#'   operation. Only populated if the user has edit access to the presentation. The revision ID is
#'   not a sequential number but an opaque string. The format of the revision ID might change over
#'   time. A returned revision ID is only guaranteed to be valid for 24 hours after it has been
#'   returned and cannot be shared across users. If the revision ID is unchanged between calls, then
#'   the presentation has not changed. Conversely, a changed ID (for the same presentation and user)
#'   usually means the presentation has been updated. However, a changed ID can also be due to
#'   internal factors such as ID format changes.
#' @param pageProperties ([PageProperties]) The properties of the page.
#'
#' @return Page object
#'
#' @noRd
Page <- function(
    objectId = NULL,
    pageType = NULL,
    pageElements = NULL,
    slideProperties = NULL,
    layoutProperties = NULL,
    notesProperties = NULL,
    masterProperties = NULL,
    revisionId = NULL,
    pageProperties = NULL) {
  checkmate::assert_choice(pageType, c("SLIDE", "MASTER", "LAYOUT", "NOTES", "NOTES_MASTER"), null.ok = TRUE)
  structure(
    list(
      "objectId" = objectId,
      "pageType" = pageType,
      "pageElements" = pageElements,
      "slideProperties" = slideProperties,
      "layoutProperties" = layoutProperties,
      "notesProperties" = notesProperties,
      "masterProperties" = masterProperties,
      "revisionId" = revisionId,
      "pageProperties" = pageProperties
    ),
    class = c("Page", "list")
  )
}

#' PageElement Object
#'
#' @details
#' A visual element rendered on a page.
#'
#' @param objectId (string)
#'  The object ID for this page element. Object IDs used by google.apps.slides.v1.Page and google.apps.slides.v1.PageElement share the same namespace.
#' @param size ([Size])
#'  The size of the page element.
#' @param transform ([AffineTransform])
#'  The transform of the page element. The visual appearance of the page element is determined by its absolute transform. To compute the absolute transform, preconcatenate a page element's transform with the transforms of all of its parent groups. If the page element is not in a group, its absolute transform is the same as the value in this field. The initial transform for the newly created Group is always the identity transform.
#' @param title (string)
#'  The title of the page element. Combined with description to display alt text. The field is not supported for Group elements.
#' @param description (string)
#'  The description of the page element. Combined with title to display alt text. The field is not supported for Group elements.
#' @param elementGroup ([Group])
#'  A collection of page elements joined as a single unit.
#' @param shape ([Shape])
#'  A generic shape.
#' @param image ([Image])
#'  An image page element.
#' @param video ([Video])
#'  A video page element.
#' @param line ([Line])
#'  A line page element.
#' @param table ([Table])
#'  A table page element.
#' @param wordArt ([WordArt])
#'  A word art page element.
#' @param sheetsChart ([SheetsChart])
#'  A linked chart embedded from Google Sheets. Unlinked charts are represented as images.
#' @param speakerSpotlight ([SpeakerSpotlight])
#'  A Speaker Spotlight.
#'
#' @return PageElement object
#'
#' @noRd
PageElement <- function(
    objectId = NULL,
    size = NULL,
    transform = NULL,
    title = NULL,
    description = NULL,
    elementGroup = NULL,
    shape = NULL,
    image = NULL,
    video = NULL,
    line = NULL,
    table = NULL,
    wordArt = NULL,
    sheetsChart = NULL,
    speakerSpotlight = NULL) {
  structure(
    list(
      "objectId" = objectId,
      "size" = size,
      "transform" = transform,
      "title" = title,
      "description" = description,
      "elementGroup" = elementGroup,
      "shape" = shape,
      "image" = image,
      "video" = video,
      "line" = line,
      "table" = table,
      "wordArt" = wordArt,
      "sheetsChart" = sheetsChart,
      "speakerSpotlight" = speakerSpotlight
    ),
    class = c("PageElement", "list")
  )
}

#' AffineTransform Object
#'
#' @details
#' AffineTransform uses a 3x3 matrix with an implied last row of \[ 0 0 1 \] to transform source coordinates (x,y) into destination coordinates (x', y') according to: x' x = shear_y scale_y translate_y 1 \[ 1 \] After transformation, x' = scale_x * x + shear_x * y + translate_x; y' = scale_y * y + shear_y * x + translate_y; This message is therefore composed of these six matrix elements.
#'
#' @param scaleX (number)
#'  The X coordinate scaling element.
#' @param scaleY (number)
#'  The Y coordinate scaling element.
#' @param shearX (number)
#'  The X coordinate shearing element.
#' @param shearY (number)
#'  The Y coordinate shearing element.
#' @param translateX (number)
#'  The X coordinate translation element.
#' @param translateY (number)
#'  The Y coordinate translation element.
#' @param unit (string)
#'  The units for translate elements.
#' - `UNIT_UNSPECIFIED`: The units are unknown.
#' - `EMU`: An English Metric Unit (EMU) is defined as 1/360,000 of a centimeter and thus there are 914,400 EMUs per inch, and 12,700 EMUs per point.
#' - `PT`: A point, 1/72 of an inch.
#'
#' @return AffineTransform object
#'
#' @noRd
AffineTransform <- function(
    scaleX = NULL,
    scaleY = NULL,
    shearX = NULL,
    shearY = NULL,
    translateX = NULL,
    translateY = NULL,
    unit = NULL) {
  checkmate::assert_choice(unit, c("UNIT_UNSPECIFIED", "EMU", "PT"), null.ok = TRUE)
  structure(
    list(
      "scaleX" = scaleX,
      "scaleY" = scaleY,
      "shearX" = shearX,
      "shearY" = shearY,
      "translateX" = translateX,
      "translateY" = translateY,
      "unit" = unit
    ),
    class = c("AffineTransform", "list")
  )
}

#' Group Object
#'
#' @details
#' A PageElement kind representing a joined collection of PageElements.
#'
#' @param children (list of [PageElement] objects)
#'  The collection of elements in the group. The minimum size of a group is 2.
#'
#' @return Group object
#'
#' @noRd
Group <- function(children = NULL) {
  structure(
    list(
      "children" = children
    ),
    class = c("Group", "list")
  )
}

#' Shape Object
#'
#' @details
#' A PageElement kind representing a generic shape that does not have a more specific classification.
#'
#' @param shapeType (string)
#'  The type of the shape.
#' - `TYPE_UNSPECIFIED`: The shape type that is not predefined.
#' - `TEXT_BOX`: Text box shape.
#' - `RECTANGLE`: Rectangle shape. Corresponds to ECMA-376 ST_ShapeType 'rect'.
#' - `ROUND_RECTANGLE`: Round corner rectangle shape. Corresponds to ECMA-376 ST_ShapeType 'roundRect'
#' - `ELLIPSE`: Ellipse shape. Corresponds to ECMA-376 ST_ShapeType 'ellipse'
#' - `ARC`: Curved arc shape. Corresponds to ECMA-376 ST_ShapeType 'arc'
#' - `BENT_ARROW`: Bent arrow shape. Corresponds to ECMA-376 ST_ShapeType 'bentArrow'
#' - `BENT_UP_ARROW`: Bent up arrow shape. Corresponds to ECMA-376 ST_ShapeType 'bentUpArrow'
#' - `BEVEL`: Bevel shape. Corresponds to ECMA-376 ST_ShapeType 'bevel'
#' - `BLOCK_ARC`: Block arc shape. Corresponds to ECMA-376 ST_ShapeType 'blockArc'
#' - `BRACE_PAIR`: Brace pair shape. Corresponds to ECMA-376 ST_ShapeType 'bracePair'
#' - `BRACKET_PAIR`: Bracket pair shape. Corresponds to ECMA-376 ST_ShapeType 'bracketPair'
#' - `CAN`: Can shape. Corresponds to ECMA-376 ST_ShapeType 'can'
#' - `CHEVRON`: Chevron shape. Corresponds to ECMA-376 ST_ShapeType 'chevron'
#' - `CHORD`: Chord shape. Corresponds to ECMA-376 ST_ShapeType 'chord'
#' - `CLOUD`: Cloud shape. Corresponds to ECMA-376 ST_ShapeType 'cloud'
#' - `CORNER`: Corner shape. Corresponds to ECMA-376 ST_ShapeType 'corner'
#' - `CUBE`: Cube shape. Corresponds to ECMA-376 ST_ShapeType 'cube'
#' - `CURVED_DOWN_ARROW`: Curved down arrow shape. Corresponds to ECMA-376 ST_ShapeType 'curvedDownArrow'
#' - `CURVED_LEFT_ARROW`: Curved left arrow shape. Corresponds to ECMA-376 ST_ShapeType 'curvedLeftArrow'
#' - `CURVED_RIGHT_ARROW`: Curved right arrow shape. Corresponds to ECMA-376 ST_ShapeType 'curvedRightArrow'
#' - `CURVED_UP_ARROW`: Curved up arrow shape. Corresponds to ECMA-376 ST_ShapeType 'curvedUpArrow'
#' - `DECAGON`: Decagon shape. Corresponds to ECMA-376 ST_ShapeType 'decagon'
#' - `DIAGONAL_STRIPE`: Diagonal stripe shape. Corresponds to ECMA-376 ST_ShapeType 'diagStripe'
#' - `DIAMOND`: Diamond shape. Corresponds to ECMA-376 ST_ShapeType 'diamond'
#' - `DODECAGON`: Dodecagon shape. Corresponds to ECMA-376 ST_ShapeType 'dodecagon'
#' - `DONUT`: Donut shape. Corresponds to ECMA-376 ST_ShapeType 'donut'
#' - `DOUBLE_WAVE`: Double wave shape. Corresponds to ECMA-376 ST_ShapeType 'doubleWave'
#' - `DOWN_ARROW`: Down arrow shape. Corresponds to ECMA-376 ST_ShapeType 'downArrow'
#' - `DOWN_ARROW_CALLOUT`: Callout down arrow shape. Corresponds to ECMA-376 ST_ShapeType 'downArrowCallout'
#' - `FOLDED_CORNER`: Folded corner shape. Corresponds to ECMA-376 ST_ShapeType 'foldedCorner'
#' - `FRAME`: Frame shape. Corresponds to ECMA-376 ST_ShapeType 'frame'
#' - `HALF_FRAME`: Half frame shape. Corresponds to ECMA-376 ST_ShapeType 'halfFrame'
#' - `HEART`: Heart shape. Corresponds to ECMA-376 ST_ShapeType 'heart'
#' - `HEPTAGON`: Heptagon shape. Corresponds to ECMA-376 ST_ShapeType 'heptagon'
#' - `HEXAGON`: Hexagon shape. Corresponds to ECMA-376 ST_ShapeType 'hexagon'
#' - `HOME_PLATE`: Home plate shape. Corresponds to ECMA-376 ST_ShapeType 'homePlate'
#' - `HORIZONTAL_SCROLL`: Horizontal scroll shape. Corresponds to ECMA-376 ST_ShapeType 'horizontalScroll'
#' - `IRREGULAR_SEAL_1`: Irregular seal 1 shape. Corresponds to ECMA-376 ST_ShapeType 'irregularSeal1'
#' - `IRREGULAR_SEAL_2`: Irregular seal 2 shape. Corresponds to ECMA-376 ST_ShapeType 'irregularSeal2'
#' - `LEFT_ARROW`: Left arrow shape. Corresponds to ECMA-376 ST_ShapeType 'leftArrow'
#' - `LEFT_ARROW_CALLOUT`: Callout left arrow shape. Corresponds to ECMA-376 ST_ShapeType 'leftArrowCallout'
#' - `LEFT_BRACE`: Left brace shape. Corresponds to ECMA-376 ST_ShapeType 'leftBrace'
#' - `LEFT_BRACKET`: Left bracket shape. Corresponds to ECMA-376 ST_ShapeType 'leftBracket'
#' - `LEFT_RIGHT_ARROW`: Left right arrow shape. Corresponds to ECMA-376 ST_ShapeType 'leftRightArrow'
#' - `LEFT_RIGHT_ARROW_CALLOUT`: Callout left right arrow shape. Corresponds to ECMA-376 ST_ShapeType 'leftRightArrowCallout'
#' - `LEFT_RIGHT_UP_ARROW`: Left right up arrow shape. Corresponds to ECMA-376 ST_ShapeType 'leftRightUpArrow'
#' - `LEFT_UP_ARROW`: Left up arrow shape. Corresponds to ECMA-376 ST_ShapeType 'leftUpArrow'
#' - `LIGHTNING_BOLT`: Lightning bolt shape. Corresponds to ECMA-376 ST_ShapeType 'lightningBolt'
#' - `MATH_DIVIDE`: Divide math shape. Corresponds to ECMA-376 ST_ShapeType 'mathDivide'
#' - `MATH_EQUAL`: Equal math shape. Corresponds to ECMA-376 ST_ShapeType 'mathEqual'
#' - `MATH_MINUS`: Minus math shape. Corresponds to ECMA-376 ST_ShapeType 'mathMinus'
#' - `MATH_MULTIPLY`: Multiply math shape. Corresponds to ECMA-376 ST_ShapeType 'mathMultiply'
#' - `MATH_NOT_EQUAL`: Not equal math shape. Corresponds to ECMA-376 ST_ShapeType 'mathNotEqual'
#' - `MATH_PLUS`: Plus math shape. Corresponds to ECMA-376 ST_ShapeType 'mathPlus'
#' - `MOON`: Moon shape. Corresponds to ECMA-376 ST_ShapeType 'moon'
#' - `NO_SMOKING`: No smoking shape. Corresponds to ECMA-376 ST_ShapeType 'noSmoking'
#' - `NOTCHED_RIGHT_ARROW`: Notched right arrow shape. Corresponds to ECMA-376 ST_ShapeType 'notchedRightArrow'
#' - `OCTAGON`: Octagon shape. Corresponds to ECMA-376 ST_ShapeType 'octagon'
#' - `PARALLELOGRAM`: Parallelogram shape. Corresponds to ECMA-376 ST_ShapeType 'parallelogram'
#' - `PENTAGON`: Pentagon shape. Corresponds to ECMA-376 ST_ShapeType 'pentagon'
#' - `PIE`: Pie shape. Corresponds to ECMA-376 ST_ShapeType 'pie'
#' - `PLAQUE`: Plaque shape. Corresponds to ECMA-376 ST_ShapeType 'plaque'
#' - `PLUS`: Plus shape. Corresponds to ECMA-376 ST_ShapeType 'plus'
#' - `QUAD_ARROW`: Quad-arrow shape. Corresponds to ECMA-376 ST_ShapeType 'quadArrow'
#' - `QUAD_ARROW_CALLOUT`: Callout quad-arrow shape. Corresponds to ECMA-376 ST_ShapeType 'quadArrowCallout'
#' - `RIBBON`: Ribbon shape. Corresponds to ECMA-376 ST_ShapeType 'ribbon'
#' - `RIBBON_2`: Ribbon 2 shape. Corresponds to ECMA-376 ST_ShapeType 'ribbon2'
#' - `RIGHT_ARROW`: Right arrow shape. Corresponds to ECMA-376 ST_ShapeType 'rightArrow'
#' - `RIGHT_ARROW_CALLOUT`: Callout right arrow shape. Corresponds to ECMA-376 ST_ShapeType 'rightArrowCallout'
#' - `RIGHT_BRACE`: Right brace shape. Corresponds to ECMA-376 ST_ShapeType 'rightBrace'
#' - `RIGHT_BRACKET`: Right bracket shape. Corresponds to ECMA-376 ST_ShapeType 'rightBracket'
#' - `ROUND_1_RECTANGLE`: One round corner rectangle shape. Corresponds to ECMA-376 ST_ShapeType 'round1Rect'
#' - `ROUND_2_DIAGONAL_RECTANGLE`: Two diagonal round corner rectangle shape. Corresponds to ECMA-376 ST_ShapeType 'round2DiagRect'
#' - `ROUND_2_SAME_RECTANGLE`: Two same-side round corner rectangle shape. Corresponds to ECMA-376 ST_ShapeType 'round2SameRect'
#' - `RIGHT_TRIANGLE`: Right triangle shape. Corresponds to ECMA-376 ST_ShapeType 'rtTriangle'
#' - `SMILEY_FACE`: Smiley face shape. Corresponds to ECMA-376 ST_ShapeType 'smileyFace'
#' - `SNIP_1_RECTANGLE`: One snip corner rectangle shape. Corresponds to ECMA-376 ST_ShapeType 'snip1Rect'
#' - `SNIP_2_DIAGONAL_RECTANGLE`: Two diagonal snip corner rectangle shape. Corresponds to ECMA-376 ST_ShapeType 'snip2DiagRect'
#' - `SNIP_2_SAME_RECTANGLE`: Two same-side snip corner rectangle shape. Corresponds to ECMA-376 ST_ShapeType 'snip2SameRect'
#' - `SNIP_ROUND_RECTANGLE`: One snip one round corner rectangle shape. Corresponds to ECMA-376 ST_ShapeType 'snipRoundRect'
#' - `STAR_10`: Ten pointed star shape. Corresponds to ECMA-376 ST_ShapeType 'star10'
#' - `STAR_12`: Twelve pointed star shape. Corresponds to ECMA-376 ST_ShapeType 'star12'
#' - `STAR_16`: Sixteen pointed star shape. Corresponds to ECMA-376 ST_ShapeType 'star16'
#' - `STAR_24`: Twenty four pointed star shape. Corresponds to ECMA-376 ST_ShapeType 'star24'
#' - `STAR_32`: Thirty two pointed star shape. Corresponds to ECMA-376 ST_ShapeType 'star32'
#' - `STAR_4`: Four pointed star shape. Corresponds to ECMA-376 ST_ShapeType 'star4'
#' - `STAR_5`: Five pointed star shape. Corresponds to ECMA-376 ST_ShapeType 'star5'
#' - `STAR_6`: Six pointed star shape. Corresponds to ECMA-376 ST_ShapeType 'star6'
#' - `STAR_7`: Seven pointed star shape. Corresponds to ECMA-376 ST_ShapeType 'star7'
#' - `STAR_8`: Eight pointed star shape. Corresponds to ECMA-376 ST_ShapeType 'star8'
#' - `STRIPED_RIGHT_ARROW`: Striped right arrow shape. Corresponds to ECMA-376 ST_ShapeType 'stripedRightArrow'
#' - `SUN`: Sun shape. Corresponds to ECMA-376 ST_ShapeType 'sun'
#' - `TRAPEZOID`: Trapezoid shape. Corresponds to ECMA-376 ST_ShapeType 'trapezoid'
#' - `TRIANGLE`: Triangle shape. Corresponds to ECMA-376 ST_ShapeType 'triangle'
#' - `UP_ARROW`: Up arrow shape. Corresponds to ECMA-376 ST_ShapeType 'upArrow'
#' - `UP_ARROW_CALLOUT`: Callout up arrow shape. Corresponds to ECMA-376 ST_ShapeType 'upArrowCallout'
#' - `UP_DOWN_ARROW`: Up down arrow shape. Corresponds to ECMA-376 ST_ShapeType 'upDownArrow'
#' - `UTURN_ARROW`: U-turn arrow shape. Corresponds to ECMA-376 ST_ShapeType 'uturnArrow'
#' - `VERTICAL_SCROLL`: Vertical scroll shape. Corresponds to ECMA-376 ST_ShapeType 'verticalScroll'
#' - `WAVE`: Wave shape. Corresponds to ECMA-376 ST_ShapeType 'wave'
#' - `WEDGE_ELLIPSE_CALLOUT`: Callout wedge ellipse shape. Corresponds to ECMA-376 ST_ShapeType 'wedgeEllipseCallout'
#' - `WEDGE_RECTANGLE_CALLOUT`: Callout wedge rectangle shape. Corresponds to ECMA-376 ST_ShapeType 'wedgeRectCallout'
#' - `WEDGE_ROUND_RECTANGLE_CALLOUT`: Callout wedge round rectangle shape. Corresponds to ECMA-376 ST_ShapeType 'wedgeRoundRectCallout'
#' - `FLOW_CHART_ALTERNATE_PROCESS`: Alternate process flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartAlternateProcess'
#' - `FLOW_CHART_COLLATE`: Collate flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartCollate'
#' - `FLOW_CHART_CONNECTOR`: Connector flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartConnector'
#' - `FLOW_CHART_DECISION`: Decision flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartDecision'
#' - `FLOW_CHART_DELAY`: Delay flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartDelay'
#' - `FLOW_CHART_DISPLAY`: Display flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartDisplay'
#' - `FLOW_CHART_DOCUMENT`: Document flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartDocument'
#' - `FLOW_CHART_EXTRACT`: Extract flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartExtract'
#' - `FLOW_CHART_INPUT_OUTPUT`: Input output flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartInputOutput'
#' - `FLOW_CHART_INTERNAL_STORAGE`: Internal storage flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartInternalStorage'
#' - `FLOW_CHART_MAGNETIC_DISK`: Magnetic disk flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartMagneticDisk'
#' - `FLOW_CHART_MAGNETIC_DRUM`: Magnetic drum flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartMagneticDrum'
#' - `FLOW_CHART_MAGNETIC_TAPE`: Magnetic tape flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartMagneticTape'
#' - `FLOW_CHART_MANUAL_INPUT`: Manual input flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartManualInput'
#' - `FLOW_CHART_MANUAL_OPERATION`: Manual operation flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartManualOperation'
#' - `FLOW_CHART_MERGE`: Merge flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartMerge'
#' - `FLOW_CHART_MULTIDOCUMENT`: Multi-document flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartMultidocument'
#' - `FLOW_CHART_OFFLINE_STORAGE`: Offline storage flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartOfflineStorage'
#' - `FLOW_CHART_OFFPAGE_CONNECTOR`: Off-page connector flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartOffpageConnector'
#' - `FLOW_CHART_ONLINE_STORAGE`: Online storage flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartOnlineStorage'
#' - `FLOW_CHART_OR`: Or flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartOr'
#' - `FLOW_CHART_PREDEFINED_PROCESS`: Predefined process flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartPredefinedProcess'
#' - `FLOW_CHART_PREPARATION`: Preparation flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartPreparation'
#' - `FLOW_CHART_PROCESS`: Process flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartProcess'
#' - `FLOW_CHART_PUNCHED_CARD`: Punched card flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartPunchedCard'
#' - `FLOW_CHART_PUNCHED_TAPE`: Punched tape flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartPunchedTape'
#' - `FLOW_CHART_SORT`: Sort flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartSort'
#' - `FLOW_CHART_SUMMING_JUNCTION`: Summing junction flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartSummingJunction'
#' - `FLOW_CHART_TERMINATOR`: Terminator flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartTerminator'
#' - `ARROW_EAST`: East arrow shape.
#' - `ARROW_NORTH_EAST`: Northeast arrow shape.
#' - `ARROW_NORTH`: North arrow shape.
#' - `SPEECH`: Speech shape.
#' - `STARBURST`: Star burst shape.
#' - `TEARDROP`: Teardrop shape. Corresponds to ECMA-376 ST_ShapeType 'teardrop'
#' - `ELLIPSE_RIBBON`: Ellipse ribbon shape. Corresponds to ECMA-376 ST_ShapeType 'ellipseRibbon'
#' - `ELLIPSE_RIBBON_2`: Ellipse ribbon 2 shape. Corresponds to ECMA-376 ST_ShapeType 'ellipseRibbon2'
#' - `CLOUD_CALLOUT`: Callout cloud shape. Corresponds to ECMA-376 ST_ShapeType 'cloudCallout'
#' - `CUSTOM`: Custom shape.
#' @param text ([TextContent])
#'  The text content of the shape.
#' @param shapeProperties ([ShapeProperties])
#'  The properties of the shape.
#' @param placeholder ([Placeholder])
#'  Placeholders are page elements that inherit from corresponding placeholders on layouts and masters. If set, the shape is a placeholder shape and any inherited properties can be resolved by looking at the parent placeholder identified by the Placeholder.parent_object_id field.
#'
#' @return Shape object
#'
#' @noRd
Shape <- function(
    shapeType = NULL,
    text = NULL,
    shapeProperties = NULL,
    placeholder = NULL) {
  checkmate::assert_choice(shapeType, c("TYPE_UNSPECIFIED", "TEXT_BOX", "RECTANGLE", "ROUND_RECTANGLE", "ELLIPSE", "ARC", "BENT_ARROW", "BENT_UP_ARROW", "BEVEL", "BLOCK_ARC", "BRACE_PAIR", "BRACKET_PAIR", "CAN", "CHEVRON", "CHORD", "CLOUD", "CORNER", "CUBE", "CURVED_DOWN_ARROW", "CURVED_LEFT_ARROW", "CURVED_RIGHT_ARROW", "CURVED_UP_ARROW", "DECAGON", "DIAGONAL_STRIPE", "DIAMOND", "DODECAGON", "DONUT", "DOUBLE_WAVE", "DOWN_ARROW", "DOWN_ARROW_CALLOUT", "FOLDED_CORNER", "FRAME", "HALF_FRAME", "HEART", "HEPTAGON", "HEXAGON", "HOME_PLATE", "HORIZONTAL_SCROLL", "IRREGULAR_SEAL_1", "IRREGULAR_SEAL_2", "LEFT_ARROW", "LEFT_ARROW_CALLOUT", "LEFT_BRACE", "LEFT_BRACKET", "LEFT_RIGHT_ARROW", "LEFT_RIGHT_ARROW_CALLOUT", "LEFT_RIGHT_UP_ARROW", "LEFT_UP_ARROW", "LIGHTNING_BOLT", "MATH_DIVIDE", "MATH_EQUAL", "MATH_MINUS", "MATH_MULTIPLY", "MATH_NOT_EQUAL", "MATH_PLUS", "MOON", "NO_SMOKING", "NOTCHED_RIGHT_ARROW", "OCTAGON", "PARALLELOGRAM", "PENTAGON", "PIE", "PLAQUE", "PLUS", "QUAD_ARROW", "QUAD_ARROW_CALLOUT", "RIBBON", "RIBBON_2", "RIGHT_ARROW", "RIGHT_ARROW_CALLOUT", "RIGHT_BRACE", "RIGHT_BRACKET", "ROUND_1_RECTANGLE", "ROUND_2_DIAGONAL_RECTANGLE", "ROUND_2_SAME_RECTANGLE", "RIGHT_TRIANGLE", "SMILEY_FACE", "SNIP_1_RECTANGLE", "SNIP_2_DIAGONAL_RECTANGLE", "SNIP_2_SAME_RECTANGLE", "SNIP_ROUND_RECTANGLE", "STAR_10", "STAR_12", "STAR_16", "STAR_24", "STAR_32", "STAR_4", "STAR_5", "STAR_6", "STAR_7", "STAR_8", "STRIPED_RIGHT_ARROW", "SUN", "TRAPEZOID", "TRIANGLE", "UP_ARROW", "UP_ARROW_CALLOUT", "UP_DOWN_ARROW", "UTURN_ARROW", "VERTICAL_SCROLL", "WAVE", "WEDGE_ELLIPSE_CALLOUT", "WEDGE_RECTANGLE_CALLOUT", "WEDGE_ROUND_RECTANGLE_CALLOUT", "FLOW_CHART_ALTERNATE_PROCESS", "FLOW_CHART_COLLATE", "FLOW_CHART_CONNECTOR", "FLOW_CHART_DECISION", "FLOW_CHART_DELAY", "FLOW_CHART_DISPLAY", "FLOW_CHART_DOCUMENT", "FLOW_CHART_EXTRACT", "FLOW_CHART_INPUT_OUTPUT", "FLOW_CHART_INTERNAL_STORAGE", "FLOW_CHART_MAGNETIC_DISK", "FLOW_CHART_MAGNETIC_DRUM", "FLOW_CHART_MAGNETIC_TAPE", "FLOW_CHART_MANUAL_INPUT", "FLOW_CHART_MANUAL_OPERATION", "FLOW_CHART_MERGE", "FLOW_CHART_MULTIDOCUMENT", "FLOW_CHART_OFFLINE_STORAGE", "FLOW_CHART_OFFPAGE_CONNECTOR", "FLOW_CHART_ONLINE_STORAGE", "FLOW_CHART_OR", "FLOW_CHART_PREDEFINED_PROCESS", "FLOW_CHART_PREPARATION", "FLOW_CHART_PROCESS", "FLOW_CHART_PUNCHED_CARD", "FLOW_CHART_PUNCHED_TAPE", "FLOW_CHART_SORT", "FLOW_CHART_SUMMING_JUNCTION", "FLOW_CHART_TERMINATOR", "ARROW_EAST", "ARROW_NORTH_EAST", "ARROW_NORTH", "SPEECH", "STARBURST", "TEARDROP", "ELLIPSE_RIBBON", "ELLIPSE_RIBBON_2", "CLOUD_CALLOUT", "CUSTOM"), null.ok = TRUE)
  structure(
    list(
      "shapeType" = shapeType,
      "text" = text,
      "shapeProperties" = shapeProperties,
      "placeholder" = placeholder
    ),
    class = c("Shape", "list")
  )
}

#' TextContent Object
#'
#' @details
#' The general text content. The text must reside in a compatible shape (e.g. text box or rectangle) or a table cell in a page.
#'
#' @param textElements (list of [TextElement] objects)
#'  The text contents broken down into its component parts, including styling information. This property is read-only.
#' @param lists (named list of [List] objects)
#'  The bulleted lists contained in this text, keyed by list ID.
#'
#' @return TextContent object
#'
#' @noRd
TextContent <- function(
    textElements = NULL,
    lists = NULL) {
  structure(
    list(
      "textElements" = textElements,
      "lists" = lists
    ),
    class = c("TextContent", "list")
  )
}

#' TextElement Object
#'
#' @details
#' A TextElement describes the content of a range of indices in the text content of a Shape or TableCell.
#'
#' @param startIndex (integer)
#'  The zero-based start index of this text element, in Unicode code units.
#' @param endIndex (integer)
#'  The zero-based end index of this text element, exclusive, in Unicode code units.
#' @param paragraphMarker ([ParagraphMarker])
#'  A marker representing the beginning of a new paragraph. The `start_index` and `end_index` of this TextElement represent the range of the paragraph. Other TextElements with an index range contained inside this paragraph's range are considered to be part of this paragraph. The range of indices of two separate paragraphs will never overlap.
#' @param textRun ([TextRun])
#'  A TextElement representing a run of text where all of the characters in the run have the same TextStyle. The `start_index` and `end_index` of TextRuns will always be fully contained in the index range of a single `paragraph_marker` TextElement. In other words, a TextRun will never span multiple paragraphs.
#' @param autoText ([AutoText])
#'  A TextElement representing a spot in the text that is dynamically replaced with content that can change over time.
#'
#' @return TextElement object
#'
#' @noRd
TextElement <- function(
    startIndex = NULL,
    endIndex = NULL,
    paragraphMarker = NULL,
    textRun = NULL,
    autoText = NULL) {
  structure(
    list(
      "startIndex" = startIndex,
      "endIndex" = endIndex,
      "paragraphMarker" = paragraphMarker,
      "textRun" = textRun,
      "autoText" = autoText
    ),
    class = c("TextElement", "list")
  )
}

#' ParagraphMarker Object
#'
#' @details
#' A TextElement kind that represents the beginning of a new paragraph.
#'
#' @param style ([ParagraphStyle])
#'  The paragraph's style
#' @param bullet ([Bullet])
#'  The bullet for this paragraph. If not present, the paragraph does not belong to a list.
#'
#' @return ParagraphMarker object
#'
#' @noRd
ParagraphMarker <- function(
    style = NULL,
    bullet = NULL) {
  structure(
    list(
      "style" = style,
      "bullet" = bullet
    ),
    class = c("ParagraphMarker", "list")
  )
}

#' ParagraphStyle Object
#'
#' @details
#' Styles that apply to a whole paragraph. If this text is contained in a shape with a parent placeholder, then these paragraph styles may be inherited from the parent. Which paragraph styles are inherited depend on the nesting level of lists:
#'  - A paragraph not in a list will inherit its paragraph style from the paragraph at the 0 nesting level of the list inside the parent placeholder.
#'  - A paragraph in a list will inherit its paragraph style from the paragraph at its corresponding nesting level of the list inside the parent placeholder. Inherited paragraph styles are represented as unset fields in this message.
#'
#' @param lineSpacing (number)
#'  The amount of space between lines, as a percentage of normal, where normal is represented as 100.0. If unset, the value is inherited from the parent.
#' @param alignment (string)
#'  The text alignment for this paragraph.
#' - `ALIGNMENT_UNSPECIFIED`: The paragraph alignment is inherited from the parent.
#' - `START`: The paragraph is aligned to the start of the line. Left-aligned for LTR text, right-aligned otherwise.
#' - `CENTER`: The paragraph is centered.
#' - `END`: The paragraph is aligned to the end of the line. Right-aligned for LTR text, left-aligned otherwise.
#' - `JUSTIFIED`: The paragraph is justified.
#' @param indentStart ([Dimension])
#'  The amount indentation for the paragraph on the side that corresponds to the start of the text, based on the current text direction. If unset, the value is inherited from the parent.
#' @param indentEnd ([Dimension])
#'  The amount indentation for the paragraph on the side that corresponds to the end of the text, based on the current text direction. If unset, the value is inherited from the parent.
#' @param spaceAbove ([Dimension])
#'  The amount of extra space above the paragraph. If unset, the value is inherited from the parent.
#' @param spaceBelow ([Dimension])
#'  The amount of extra space below the paragraph. If unset, the value is inherited from the parent.
#' @param indentFirstLine ([Dimension])
#'  The amount of indentation for the start of the first line of the paragraph. If unset, the value is inherited from the parent.
#' @param direction (string)
#'  The text direction of this paragraph. If unset, the value defaults to LEFT_TO_RIGHT since text direction is not inherited.
#' - `TEXT_DIRECTION_UNSPECIFIED`: The text direction is inherited from the parent.
#' - `LEFT_TO_RIGHT`: The text goes from left to right.
#' - `RIGHT_TO_LEFT`: The text goes from right to left.
#' @param spacingMode (string)
#'  The spacing mode for the paragraph.
#' - `SPACING_MODE_UNSPECIFIED`: The spacing mode is inherited from the parent.
#' - `NEVER_COLLAPSE`: Paragraph spacing is always rendered.
#' - `COLLAPSE_LISTS`: Paragraph spacing is skipped between list elements.
#'
#' @return ParagraphStyle object
#'
#' @noRd
ParagraphStyle <- function(
    lineSpacing = NULL,
    alignment = NULL,
    indentStart = NULL,
    indentEnd = NULL,
    spaceAbove = NULL,
    spaceBelow = NULL,
    indentFirstLine = NULL,
    direction = NULL,
    spacingMode = NULL) {
  checkmate::assert_choice(alignment, c("ALIGNMENT_UNSPECIFIED", "START", "CENTER", "END", "JUSTIFIED"), null.ok = TRUE)
  checkmate::assert_choice(direction, c("TEXT_DIRECTION_UNSPECIFIED", "LEFT_TO_RIGHT", "RIGHT_TO_LEFT"), null.ok = TRUE)
  checkmate::assert_choice(spacingMode, c("SPACING_MODE_UNSPECIFIED", "NEVER_COLLAPSE", "COLLAPSE_LISTS"), null.ok = TRUE)
  structure(
    list(
      "lineSpacing" = lineSpacing,
      "alignment" = alignment,
      "indentStart" = indentStart,
      "indentEnd" = indentEnd,
      "spaceAbove" = spaceAbove,
      "spaceBelow" = spaceBelow,
      "indentFirstLine" = indentFirstLine,
      "direction" = direction,
      "spacingMode" = spacingMode
    ),
    class = c("ParagraphStyle", "list")
  )
}

#' Bullet Object
#'
#' @details
#' Describes the bullet of a paragraph.
#'
#' @param listId (string)
#'  The ID of the list this paragraph belongs to.
#' @param nestingLevel (integer)
#'  The nesting level of this paragraph in the list.
#' @param glyph (string)
#'  The rendered bullet glyph for this paragraph.
#' @param bulletStyle ([TextStyle])
#'  The paragraph specific text style applied to this bullet.
#'
#' @return Bullet object
#'
#' @noRd
Bullet <- function(
    listId = NULL,
    nestingLevel = NULL,
    glyph = NULL,
    bulletStyle = NULL) {
  structure(
    list(
      "listId" = listId,
      "nestingLevel" = nestingLevel,
      "glyph" = glyph,
      "bulletStyle" = bulletStyle
    ),
    class = c("Bullet", "list")
  )
}

#' TextStyle Object
#'
#' @details
#' Represents the styling that can be applied to a TextRun. If this text is contained in a shape with a parent placeholder, then these text styles may be inherited from the parent. Which text styles are inherited depend on the nesting level of lists:
#'  - A text run in a paragraph that is not in a list will inherit its text style from the the newline character in the paragraph at the 0 nesting level of the list inside the parent placeholder.
#'  - A text run in a paragraph that is in a list will inherit its text style from the newline character in the paragraph at its corresponding nesting level of the list inside the parent placeholder. Inherited text styles are represented as unset fields in this message. If text is contained in a shape without a parent placeholder, unsetting these fields will revert the style to a value matching the defaults in the Slides editor.
#'
#' @param backgroundColor ([OptionalColor])
#'  The background color of the text. If set, the color is either opaque or transparent, depending on if the `opaque_color` field in it is set.
#' @param foregroundColor ([OptionalColor])
#'  The color of the text itself. If set, the color is either opaque or transparent, depending on if the `opaque_color` field in it is set.
#' @param bold (boolean)
#'  Whether or not the text is rendered as bold.
#' @param italic (boolean)
#'  Whether or not the text is italicized.
#' @param fontFamily (string)
#'  The font family of the text. The font family can be any font from the Font menu in Slides or from [Google Fonts](https://fonts.google.com/). If the font name is unrecognized, the text is rendered in `Arial`. Some fonts can affect the weight of the text. If an update request specifies values for both `font_family` and `bold`, the explicitly-set `bold` value is used.
#' @param fontSize ([Dimension])
#'  The size of the text's font. When read, the `font_size` will specified in points.
#' @param link ([Link])
#'  The hyperlink destination of the text. If unset, there is no link. Links are not inherited from parent text. Changing the link in an update request causes some other changes to the text style of the range:
#'  * When setting a link, the text foreground color will be set to ThemeColorType.HYPERLINK and the text will be underlined. If these fields are modified in the same request, those values will be used instead of the link defaults.
#'  * Setting a link on a text range that overlaps with an existing link will also update the existing link to point to the new URL.
#'  * Links are not settable on newline characters. As a result, setting a link on a text range that crosses a paragraph boundary, such as `"ABC\n123"`, will separate the newline character(s) into their own text runs. The link will be applied separately to the runs before and after the newline.
#'  * Removing a link will update the text style of the range to match the style of the preceding text (or the default text styles if the preceding text is another link) unless different styles are being set in the same request.
#' @param baselineOffset (string)
#'  The text's vertical offset from its normal position. Text with `SUPERSCRIPT` or `SUBSCRIPT` baseline offsets is automatically rendered in a smaller font size, computed based on the `font_size` field. The `font_size` itself is not affected by changes in this field.
#' - `BASELINE_OFFSET_UNSPECIFIED`: The text's baseline offset is inherited from the parent.
#' - `NONE`: The text is not vertically offset.
#' - `SUPERSCRIPT`: The text is vertically offset upwards (superscript).
#' - `SUBSCRIPT`: The text is vertically offset downwards (subscript).
#' @param smallCaps (boolean)
#'  Whether or not the text is in small capital letters.
#' @param strikethrough (boolean)
#'  Whether or not the text is struck through.
#' @param underline (boolean)
#'  Whether or not the text is underlined.
#' @param weightedFontFamily ([WeightedFontFamily])
#'  The font family and rendered weight of the text. This field is an extension of `font_family` meant to support explicit font weights without breaking backwards compatibility. As such, when reading the style of a range of text, the value of `weighted_font_family#font_family` will always be equal to that of `font_family`. However, when writing, if both fields are included in the field mask (either explicitly or through the wildcard `"*"`), their values are reconciled as follows:
#'  * If `font_family` is set and `weighted_font_family` is not, the value of `font_family` is applied with weight `400` ("normal").
#'  * If both fields are set, the value of `font_family` must match that of `weighted_font_family#font_family`. If so, the font family and weight of `weighted_font_family` is applied. Otherwise, a 400 bad request error is returned.
#'  * If `weighted_font_family` is set and `font_family` is not, the font family and weight of `weighted_font_family` is applied.
#'  * If neither field is set, the font family and weight of the text inherit from the parent. Note that these properties cannot inherit separately from each other. If an update request specifies values for both `weighted_font_family` and `bold`, the `weighted_font_family` is applied first, then `bold`. If `weighted_font_family#weight` is not set, it defaults to `400`. If `weighted_font_family` is set, then `weighted_font_family#font_family` must also be set with a non-empty value. Otherwise, a 400 bad request error is returned.
#'
#' @return TextStyle object
#'
#' @noRd
TextStyle <- function(
    backgroundColor = NULL,
    foregroundColor = NULL,
    bold = NULL,
    italic = NULL,
    fontFamily = NULL,
    fontSize = NULL,
    link = NULL,
    baselineOffset = NULL,
    smallCaps = NULL,
    strikethrough = NULL,
    underline = NULL,
    weightedFontFamily = NULL) {
  checkmate::assert_choice(baselineOffset, c("BASELINE_OFFSET_UNSPECIFIED", "NONE", "SUPERSCRIPT", "SUBSCRIPT"), null.ok = TRUE)
  structure(
    list(
      "backgroundColor" = backgroundColor,
      "foregroundColor" = foregroundColor,
      "bold" = bold,
      "italic" = italic,
      "fontFamily" = fontFamily,
      "fontSize" = fontSize,
      "link" = link,
      "baselineOffset" = baselineOffset,
      "smallCaps" = smallCaps,
      "strikethrough" = strikethrough,
      "underline" = underline,
      "weightedFontFamily" = weightedFontFamily
    ),
    class = c("TextStyle", "list")
  )
}

#' OptionalColor Object
#'
#' @details
#' A color that can either be fully opaque or fully transparent.
#'
#' @param opaqueColor ([OpaqueColor])
#'  If set, this will be used as an opaque color. If unset, this represents a transparent color.
#'
#' @return OptionalColor object
#'
#' @noRd
OptionalColor <- function(opaqueColor = NULL) {
  structure(
    list(
      "opaqueColor" = opaqueColor
    ),
    class = c("OptionalColor", "list")
  )
}

#' OpaqueColor Object
#'
#' @details
#' A themeable solid color value.
#'
#' @param rgbColor ([RgbColor])
#'  An opaque RGB color.
#' @param themeColor (string)
#'  An opaque theme color.
#' - `THEME_COLOR_TYPE_UNSPECIFIED`: Unspecified theme color. This value should not be used.
#' - `DARK1`: Represents the first dark color.
#' - `LIGHT1`: Represents the first light color.
#' - `DARK2`: Represents the second dark color.
#' - `LIGHT2`: Represents the second light color.
#' - `ACCENT1`: Represents the first accent color.
#' - `ACCENT2`: Represents the second accent color.
#' - `ACCENT3`: Represents the third accent color.
#' - `ACCENT4`: Represents the fourth accent color.
#' - `ACCENT5`: Represents the fifth accent color.
#' - `ACCENT6`: Represents the sixth accent color.
#' - `HYPERLINK`: Represents the color to use for hyperlinks.
#' - `FOLLOWED_HYPERLINK`: Represents the color to use for visited hyperlinks.
#' - `TEXT1`: Represents the first text color.
#' - `BACKGROUND1`: Represents the first background color.
#' - `TEXT2`: Represents the second text color.
#' - `BACKGROUND2`: Represents the second background color.
#'
#' @return OpaqueColor object
#'
#' @noRd
OpaqueColor <- function(
    rgbColor = NULL,
    themeColor = NULL) {
  checkmate::assert_choice(themeColor, c("THEME_COLOR_TYPE_UNSPECIFIED", "DARK1", "LIGHT1", "DARK2", "LIGHT2", "ACCENT1", "ACCENT2", "ACCENT3", "ACCENT4", "ACCENT5", "ACCENT6", "HYPERLINK", "FOLLOWED_HYPERLINK", "TEXT1", "BACKGROUND1", "TEXT2", "BACKGROUND2"), null.ok = TRUE)
  structure(
    list(
      "rgbColor" = rgbColor,
      "themeColor" = themeColor
    ),
    class = c("OpaqueColor", "list")
  )
}

#' RgbColor Object
#'
#' @details
#' An RGB color.
#'
#' @param red (number)
#'  The red component of the color, from 0.0 to 1.0.
#' @param green (number)
#'  The green component of the color, from 0.0 to 1.0.
#' @param blue (number)
#'  The blue component of the color, from 0.0 to 1.0.
#'
#' @return RgbColor object
#'
#' @noRd
RgbColor <- function(
    red = NULL,
    green = NULL,
    blue = NULL) {
  structure(
    list(
      "red" = red,
      "green" = green,
      "blue" = blue
    ),
    class = c("RgbColor", "list")
  )
}

#' Link Object
#'
#' @details
#' A hypertext link.
#'
#' @param url (string)
#'  If set, indicates this is a link to the external web page at this URL.
#' @param relativeLink (string)
#'  If set, indicates this is a link to a slide in this presentation, addressed by its position.
#' - `RELATIVE_SLIDE_LINK_UNSPECIFIED`: An unspecified relative slide link.
#' - `NEXT_SLIDE`: A link to the next slide.
#' - `PREVIOUS_SLIDE`: A link to the previous slide.
#' - `FIRST_SLIDE`: A link to the first slide in the presentation.
#' - `LAST_SLIDE`: A link to the last slide in the presentation.
#' @param pageObjectId (string)
#'  If set, indicates this is a link to the specific page in this presentation with this ID. A page with this ID may not exist.
#' @param slideIndex (integer)
#'  If set, indicates this is a link to the slide at this zero-based index in the presentation. There may not be a slide at this index.
#'
#' @return Link object
#'
#' @noRd
Link <- function(
    url = NULL,
    relativeLink = NULL,
    pageObjectId = NULL,
    slideIndex = NULL) {
  checkmate::assert_choice(relativeLink, c("RELATIVE_SLIDE_LINK_UNSPECIFIED", "NEXT_SLIDE", "PREVIOUS_SLIDE", "FIRST_SLIDE", "LAST_SLIDE"), null.ok = TRUE)
  structure(
    list(
      "url" = url,
      "relativeLink" = relativeLink,
      "pageObjectId" = pageObjectId,
      "slideIndex" = slideIndex
    ),
    class = c("Link", "list")
  )
}

#' WeightedFontFamily Object
#'
#' @details
#' Represents a font family and weight used to style a TextRun.
#'
#' @param fontFamily (string)
#'  The font family of the text. The font family can be any font from the Font menu in Slides or from [Google Fonts](https://fonts.google.com/). If the font name is unrecognized, the text is rendered in `Arial`.
#' @param weight (integer)
#'  The rendered weight of the text. This field can have any value that is a multiple of `100` between `100` and `900`, inclusive. This range corresponds to the numerical values described in the CSS 2.1 Specification, [section 15.6](https://www.w3.org/TR/CSS21/fonts.html#font-boldness), with non-numerical values disallowed. Weights greater than or equal to `700` are considered bold, and weights less than `700`are not bold. The default value is `400` ("normal").
#'
#' @return WeightedFontFamily object
#'
#' @noRd
WeightedFontFamily <- function(
    fontFamily = NULL,
    weight = NULL) {
  structure(
    list(
      "fontFamily" = fontFamily,
      "weight" = weight
    ),
    class = c("WeightedFontFamily", "list")
  )
}

#' TextRun Object
#'
#' @details
#' A TextElement kind that represents a run of text that all has the same styling.
#'
#' @param content (string)
#'  The text of this run.
#' @param style ([TextStyle])
#'  The styling applied to this run.
#'
#' @return TextRun object
#'
#' @noRd
TextRun <- function(
    content = NULL,
    style = NULL) {
  structure(
    list(
      "content" = content,
      "style" = style
    ),
    class = c("TextRun", "list")
  )
}

#' AutoText Object
#'
#' @details
#' A TextElement kind that represents auto text.
#'
#' @param type (string)
#'  The type of this auto text.
#' - `TYPE_UNSPECIFIED`: An unspecified autotext type.
#' - `SLIDE_NUMBER`: Type for autotext that represents the current slide number.
#' @param content (string)
#'  The rendered content of this auto text, if available.
#' @param style ([TextStyle])
#'  The styling applied to this auto text.
#'
#' @return AutoText object
#'
#' @noRd
AutoText <- function(
    type = NULL,
    content = NULL,
    style = NULL) {
  checkmate::assert_choice(type, c("TYPE_UNSPECIFIED", "SLIDE_NUMBER"), null.ok = TRUE)
  structure(
    list(
      "type" = type,
      "content" = content,
      "style" = style
    ),
    class = c("AutoText", "list")
  )
}

#' List Object
#'
#' @details
#' A List describes the look and feel of bullets belonging to paragraphs associated with a list. A paragraph that is part of a list has an implicit reference to that list's ID.
#'
#' @param listId (string)
#'  The ID of the list.
#' @param nestingLevel (named list of [NestingLevel] objects)
#'  A map of nesting levels to the properties of bullets at the associated level. A list has at most nine levels of nesting, so the possible values for the keys of this map are 0 through 8, inclusive.
#'
#' @return List object
#'
#' @noRd
List <- function(
    listId = NULL,
    nestingLevel = NULL) {
  structure(
    list(
      "listId" = listId,
      "nestingLevel" = nestingLevel
    ),
    class = c("List", "list")
  )
}

#' NestingLevel Object
#'
#' @details
#' Contains properties describing the look and feel of a list bullet at a given level of nesting.
#'
#' @param bulletStyle ([TextStyle])
#'  The style of a bullet at this level of nesting.
#'
#' @return NestingLevel object
#'
#' @noRd
NestingLevel <- function(bulletStyle = NULL) {
  structure(
    list(
      "bulletStyle" = bulletStyle
    ),
    class = c("NestingLevel", "list")
  )
}

#' ShapeProperties Object
#'
#' @details
#' The properties of a Shape. If the shape is a placeholder shape as determined by the placeholder field, then these properties may be inherited from a parent placeholder shape. Determining the rendered value of the property depends on the corresponding property_state field value. Any text autofit settings on the shape are automatically deactivated by requests that can impact how text fits in the shape.
#'
#' @param shapeBackgroundFill ([ShapeBackgroundFill])
#'  The background fill of the shape. If unset, the background fill is inherited from a parent placeholder if it exists. If the shape has no parent, then the default background fill depends on the shape type, matching the defaults for new shapes created in the Slides editor.
#' @param outline ([Outline])
#'  The outline of the shape. If unset, the outline is inherited from a parent placeholder if it exists. If the shape has no parent, then the default outline depends on the shape type, matching the defaults for new shapes created in the Slides editor.
#' @param shadow ([Shadow])
#'  The shadow properties of the shape. If unset, the shadow is inherited from a parent placeholder if it exists. If the shape has no parent, then the default shadow matches the defaults for new shapes created in the Slides editor. This property is read-only.
#' @param link ([Link])
#'  The hyperlink destination of the shape. If unset, there is no link. Links are not inherited from parent placeholders.
#' @param contentAlignment (string)
#'  The alignment of the content in the shape. If unspecified, the alignment is inherited from a parent placeholder if it exists. If the shape has no parent, the default alignment matches the alignment for new shapes created in the Slides editor.
#' - `CONTENT_ALIGNMENT_UNSPECIFIED`: An unspecified content alignment. The content alignment is inherited from the parent if it exists.
#' - `CONTENT_ALIGNMENT_UNSUPPORTED`: An unsupported content alignment.
#' - `TOP`: An alignment that aligns the content to the top of the content holder. Corresponds to ECMA-376 ST_TextAnchoringType 't'.
#' - `MIDDLE`: An alignment that aligns the content to the middle of the content holder. Corresponds to ECMA-376 ST_TextAnchoringType 'ctr'.
#' - `BOTTOM`: An alignment that aligns the content to the bottom of the content holder. Corresponds to ECMA-376 ST_TextAnchoringType 'b'.
#' @param autofit ([Autofit])
#'  The autofit properties of the shape. This property is only set for shapes that allow text.
#'
#' @return ShapeProperties object
#'
#' @noRd
ShapeProperties <- function(
    shapeBackgroundFill = NULL,
    outline = NULL,
    shadow = NULL,
    link = NULL,
    contentAlignment = NULL,
    autofit = NULL) {
  checkmate::assert_choice(contentAlignment, c("CONTENT_ALIGNMENT_UNSPECIFIED", "CONTENT_ALIGNMENT_UNSUPPORTED", "TOP", "MIDDLE", "BOTTOM"), null.ok = TRUE)
  structure(
    list(
      "shapeBackgroundFill" = shapeBackgroundFill,
      "outline" = outline,
      "shadow" = shadow,
      "link" = link,
      "contentAlignment" = contentAlignment,
      "autofit" = autofit
    ),
    class = c("ShapeProperties", "list")
  )
}

#' ShapeBackgroundFill Object
#'
#' @details
#' The shape background fill.
#'
#' @param propertyState (string)
#'  The background fill property state. Updating the fill on a shape will implicitly update this field to `RENDERED`, unless another value is specified in the same request. To have no fill on a shape, set this field to `NOT_RENDERED`. In this case, any other fill fields set in the same request will be ignored.
#' - `RENDERED`: If a property's state is RENDERED, then the element has the corresponding property when rendered on a page. If the element is a placeholder shape as determined by the placeholder field, and it inherits from a placeholder shape, the corresponding field may be unset, meaning that the property value is inherited from a parent placeholder. If the element does not inherit, then the field will contain the rendered value. This is the default value.
#' - `NOT_RENDERED`: If a property's state is NOT_RENDERED, then the element does not have the corresponding property when rendered on a page. However, the field may still be set so it can be inherited by child shapes. To remove a property from a rendered element, set its property_state to NOT_RENDERED.
#' - `INHERIT`: If a property's state is INHERIT, then the property state uses the value of corresponding `property_state` field on the parent shape. Elements that do not inherit will never have an INHERIT property state.
#' @param solidFill ([SolidFill])
#'  Solid color fill.
#'
#' @return ShapeBackgroundFill object
#'
#' @noRd
ShapeBackgroundFill <- function(
    propertyState = NULL,
    solidFill = NULL) {
  checkmate::assert_choice(propertyState, c("RENDERED", "NOT_RENDERED", "INHERIT"), null.ok = TRUE)
  structure(
    list(
      "propertyState" = propertyState,
      "solidFill" = solidFill
    ),
    class = c("ShapeBackgroundFill", "list")
  )
}

#' SolidFill Object
#'
#' @details
#' A solid color fill. The page or page element is filled entirely with the specified color value. If any field is unset, its value may be inherited from a parent placeholder if it exists.
#'
#' @param color ([OpaqueColor])
#'  The color value of the solid fill.
#' @param alpha (number)
#'  The fraction of this `color` that should be applied to the pixel. That is, the final pixel color is defined by the equation: pixel color = alpha
#'  * (color) + (1.0 - alpha)
#'  * (background color) This means that a value of 1.0 corresponds to a solid color, whereas a value of 0.0 corresponds to a completely transparent color.
#'
#' @return SolidFill object
#'
#' @noRd
SolidFill <- function(
    color = NULL,
    alpha = NULL) {
  structure(
    list(
      "color" = color,
      "alpha" = alpha
    ),
    class = c("SolidFill", "list")
  )
}

#' Outline Object
#'
#' @details
#' The outline of a PageElement. If these fields are unset, they may be inherited from a parent placeholder if it exists. If there is no parent, the fields will default to the value used for new page elements created in the Slides editor, which may depend on the page element kind.
#'
#' @param outlineFill ([OutlineFill])
#'  The fill of the outline.
#' @param weight ([Dimension])
#'  The thickness of the outline.
#' @param dashStyle (string)
#'  The dash style of the outline.
#' - `DASH_STYLE_UNSPECIFIED`: Unspecified dash style.
#' - `SOLID`: Solid line. Corresponds to ECMA-376 ST_PresetLineDashVal value 'solid'. This is the default dash style.
#' - `DOT`: Dotted line. Corresponds to ECMA-376 ST_PresetLineDashVal value 'dot'.
#' - `DASH`: Dashed line. Corresponds to ECMA-376 ST_PresetLineDashVal value 'dash'.
#' - `DASH_DOT`: Alternating dashes and dots. Corresponds to ECMA-376 ST_PresetLineDashVal value 'dashDot'.
#' - `LONG_DASH`: Line with large dashes. Corresponds to ECMA-376 ST_PresetLineDashVal value 'lgDash'.
#' - `LONG_DASH_DOT`: Alternating large dashes and dots. Corresponds to ECMA-376 ST_PresetLineDashVal value 'lgDashDot'.
#' @param propertyState (string)
#'  The outline property state. Updating the outline on a page element will implicitly update this field to `RENDERED`, unless another value is specified in the same request. To have no outline on a page element, set this field to `NOT_RENDERED`. In this case, any other outline fields set in the same request will be ignored.
#' - `RENDERED`: If a property's state is RENDERED, then the element has the corresponding property when rendered on a page. If the element is a placeholder shape as determined by the placeholder field, and it inherits from a placeholder shape, the corresponding field may be unset, meaning that the property value is inherited from a parent placeholder. If the element does not inherit, then the field will contain the rendered value. This is the default value.
#' - `NOT_RENDERED`: If a property's state is NOT_RENDERED, then the element does not have the corresponding property when rendered on a page. However, the field may still be set so it can be inherited by child shapes. To remove a property from a rendered element, set its property_state to NOT_RENDERED.
#' - `INHERIT`: If a property's state is INHERIT, then the property state uses the value of corresponding `property_state` field on the parent shape. Elements that do not inherit will never have an INHERIT property state.
#'
#' @return Outline object
#'
#' @noRd
Outline <- function(
    outlineFill = NULL,
    weight = NULL,
    dashStyle = NULL,
    propertyState = NULL) {
  checkmate::assert_choice(dashStyle, c("DASH_STYLE_UNSPECIFIED", "SOLID", "DOT", "DASH", "DASH_DOT", "LONG_DASH", "LONG_DASH_DOT"), null.ok = TRUE)
  checkmate::assert_choice(propertyState, c("RENDERED", "NOT_RENDERED", "INHERIT"), null.ok = TRUE)
  structure(
    list(
      "outlineFill" = outlineFill,
      "weight" = weight,
      "dashStyle" = dashStyle,
      "propertyState" = propertyState
    ),
    class = c("Outline", "list")
  )
}

#' OutlineFill Object
#'
#' @details
#' The fill of the outline.
#'
#' @param solidFill ([SolidFill])
#'  Solid color fill.
#'
#' @return OutlineFill object
#'
#' @noRd
OutlineFill <- function(solidFill = NULL) {
  structure(
    list(
      "solidFill" = solidFill
    ),
    class = c("OutlineFill", "list")
  )
}

#' Shadow Object
#'
#' @details
#' The shadow properties of a page element. If these fields are unset, they may be inherited from a parent placeholder if it exists. If there is no parent, the fields will default to the value used for new page elements created in the Slides editor, which may depend on the page element kind.
#'
#' @param type (string)
#'  The type of the shadow. This property is read-only.
#' - `SHADOW_TYPE_UNSPECIFIED`: Unspecified shadow type.
#' - `OUTER`: Outer shadow.
#' @param transform ([AffineTransform])
#'  Transform that encodes the translate, scale, and skew of the shadow, relative to the alignment position.
#' @param alignment (string)
#'  The alignment point of the shadow, that sets the origin for translate, scale and skew of the shadow. This property is read-only.
#' - `RECTANGLE_POSITION_UNSPECIFIED`: Unspecified.
#' - `TOP_LEFT`: Top left.
#' - `TOP_CENTER`: Top center.
#' - `TOP_RIGHT`: Top right.
#' - `LEFT_CENTER`: Left center.
#' - `CENTER`: Center.
#' - `RIGHT_CENTER`: Right center.
#' - `BOTTOM_LEFT`: Bottom left.
#' - `BOTTOM_CENTER`: Bottom center.
#' - `BOTTOM_RIGHT`: Bottom right.
#' @param blurRadius ([Dimension])
#'  The radius of the shadow blur. The larger the radius, the more diffuse the shadow becomes.
#' @param color ([OpaqueColor])
#'  The shadow color value.
#' @param alpha (number)
#'  The alpha of the shadow's color, from 0.0 to 1.0.
#' @param rotateWithShape (boolean)
#'  Whether the shadow should rotate with the shape. This property is read-only.
#' @param propertyState (string)
#'  The shadow property state. Updating the shadow on a page element will implicitly update this field to `RENDERED`, unless another value is specified in the same request. To have no shadow on a page element, set this field to `NOT_RENDERED`. In this case, any other shadow fields set in the same request will be ignored.
#' - `RENDERED`: If a property's state is RENDERED, then the element has the corresponding property when rendered on a page. If the element is a placeholder shape as determined by the placeholder field, and it inherits from a placeholder shape, the corresponding field may be unset, meaning that the property value is inherited from a parent placeholder. If the element does not inherit, then the field will contain the rendered value. This is the default value.
#' - `NOT_RENDERED`: If a property's state is NOT_RENDERED, then the element does not have the corresponding property when rendered on a page. However, the field may still be set so it can be inherited by child shapes. To remove a property from a rendered element, set its property_state to NOT_RENDERED.
#' - `INHERIT`: If a property's state is INHERIT, then the property state uses the value of corresponding `property_state` field on the parent shape. Elements that do not inherit will never have an INHERIT property state.
#'
#' @return Shadow object
#'
#' @noRd
Shadow <- function(
    type = NULL,
    transform = NULL,
    alignment = NULL,
    blurRadius = NULL,
    color = NULL,
    alpha = NULL,
    rotateWithShape = NULL,
    propertyState = NULL) {
  checkmate::assert_choice(type, c("SHADOW_TYPE_UNSPECIFIED", "OUTER"), null.ok = TRUE)
  checkmate::assert_choice(alignment, c("RECTANGLE_POSITION_UNSPECIFIED", "TOP_LEFT", "TOP_CENTER", "TOP_RIGHT", "LEFT_CENTER", "CENTER", "RIGHT_CENTER", "BOTTOM_LEFT", "BOTTOM_CENTER", "BOTTOM_RIGHT"), null.ok = TRUE)
  checkmate::assert_choice(propertyState, c("RENDERED", "NOT_RENDERED", "INHERIT"), null.ok = TRUE)
  structure(
    list(
      "type" = type,
      "transform" = transform,
      "alignment" = alignment,
      "blurRadius" = blurRadius,
      "color" = color,
      "alpha" = alpha,
      "rotateWithShape" = rotateWithShape,
      "propertyState" = propertyState
    ),
    class = c("Shadow", "list")
  )
}

#' Autofit Object
#'
#' @details
#' The autofit properties of a Shape.
#'
#' @param autofitType (string)
#'  The autofit type of the shape. If the autofit type is AUTOFIT_TYPE_UNSPECIFIED, the autofit type is inherited from a parent placeholder if it exists. The field is automatically set to NONE if a request is made that might affect text fitting within its bounding text box. In this case the font_scale is applied to the font_size and the line_spacing_reduction is applied to the line_spacing. Both properties are also reset to default values.
#' - `AUTOFIT_TYPE_UNSPECIFIED`: The autofit type is unspecified.
#' - `NONE`: Do not autofit.
#' - `TEXT_AUTOFIT`: Shrink text on overflow to fit the shape.
#' - `SHAPE_AUTOFIT`: Resize the shape to fit the text.
#' @param fontScale (number)
#'  The font scale applied to the shape. For shapes with autofit_type NONE or SHAPE_AUTOFIT, this value is the default value of 1. For TEXT_AUTOFIT, this value multiplied by the font_size gives the font size that is rendered in the editor. This property is read-only.
#' @param lineSpacingReduction (number)
#'  The line spacing reduction applied to the shape. For shapes with autofit_type NONE or SHAPE_AUTOFIT, this value is the default value of 0. For TEXT_AUTOFIT, this value subtracted from the line_spacing gives the line spacing that is rendered in the editor. This property is read-only.
#'
#' @return Autofit object
#'
#' @noRd
Autofit <- function(
    autofitType = NULL,
    fontScale = NULL,
    lineSpacingReduction = NULL) {
  checkmate::assert_choice(autofitType, c("AUTOFIT_TYPE_UNSPECIFIED", "NONE", "TEXT_AUTOFIT", "SHAPE_AUTOFIT"), null.ok = TRUE)
  structure(
    list(
      "autofitType" = autofitType,
      "fontScale" = fontScale,
      "lineSpacingReduction" = lineSpacingReduction
    ),
    class = c("Autofit", "list")
  )
}

#' Placeholder Object
#'
#' @details
#' The placeholder information that uniquely identifies a placeholder shape.
#'
#' @param type (string)
#'  The type of the placeholder.
#' - `NONE`: Default value, signifies it is not a placeholder.
#' - `BODY`: Body text.
#' - `CHART`: Chart or graph.
#' - `CLIP_ART`: Clip art image.
#' - `CENTERED_TITLE`: Title centered.
#' - `DIAGRAM`: Diagram.
#' - `DATE_AND_TIME`: Date and time.
#' - `FOOTER`: Footer text.
#' - `HEADER`: Header text.
#' - `MEDIA`: Multimedia.
#' - `OBJECT`: Any content type.
#' - `PICTURE`: Picture.
#' - `SLIDE_NUMBER`: Number of a slide.
#' - `SUBTITLE`: Subtitle.
#' - `TABLE`: Table.
#' - `TITLE`: Slide title.
#' - `SLIDE_IMAGE`: Slide image.
#' @param index (integer)
#'  The index of the placeholder. If the same placeholder types are present in the same page, they would have different index values.
#' @param parentObjectId (string)
#'  The object ID of this shape's parent placeholder. If unset, the parent placeholder shape does not exist, so the shape does not inherit properties from any other shape.
#'
#' @return Placeholder object
#'
#' @noRd
Placeholder <- function(
    type = NULL,
    index = NULL,
    parentObjectId = NULL) {
  checkmate::assert_choice(type, c("NONE", "BODY", "CHART", "CLIP_ART", "CENTERED_TITLE", "DIAGRAM", "DATE_AND_TIME", "FOOTER", "HEADER", "MEDIA", "OBJECT", "PICTURE", "SLIDE_NUMBER", "SUBTITLE", "TABLE", "TITLE", "SLIDE_IMAGE"), null.ok = TRUE)
  structure(
    list(
      "type" = type,
      "index" = index,
      "parentObjectId" = parentObjectId
    ),
    class = c("Placeholder", "list")
  )
}

#' Image Object
#'
#' @details
#' A PageElement kind representing an image.
#'
#' @param contentUrl (string)
#'  An URL to an image with a default lifetime of 30 minutes. This URL is tagged with the account of the requester. Anyone with the URL effectively accesses the image as the original requester. Access to the image may be lost if the presentation's sharing settings change.
#' @param imageProperties ([ImageProperties])
#'  The properties of the image.
#' @param sourceUrl (string)
#'  The source URL is the URL used to insert the image. The source URL can be empty.
#' @param placeholder ([Placeholder])
#'  Placeholders are page elements that inherit from corresponding placeholders on layouts and masters. If set, the image is a placeholder image and any inherited properties can be resolved by looking at the parent placeholder identified by the Placeholder.parent_object_id field.
#'
#' @return Image object
#'
#' @noRd
Image <- function(
    contentUrl = NULL,
    imageProperties = NULL,
    sourceUrl = NULL,
    placeholder = NULL) {
  structure(
    list(
      "contentUrl" = contentUrl,
      "imageProperties" = imageProperties,
      "sourceUrl" = sourceUrl,
      "placeholder" = placeholder
    ),
    class = c("Image", "list")
  )
}

#' ImageProperties Object
#'
#' @details
#' The properties of the Image.
#'
#' @param cropProperties ([CropProperties])
#'  The crop properties of the image. If not set, the image is not cropped. This property is read-only.
#' @param transparency (number)
#'  The transparency effect of the image. The value should be in the interval \[0.0, 1.0\], where 0 means no effect and 1 means completely transparent. This property is read-only.
#' @param brightness (number)
#'  The brightness effect of the image. The value should be in the interval \[-1.0, 1.0\], where 0 means no effect. This property is read-only.
#' @param contrast (number)
#'  The contrast effect of the image. The value should be in the interval \[-1.0, 1.0\], where 0 means no effect. This property is read-only.
#' @param recolor ([Recolor])
#'  The recolor effect of the image. If not set, the image is not recolored. This property is read-only.
#' @param outline ([Outline])
#'  The outline of the image. If not set, the image has no outline.
#' @param shadow ([Shadow])
#'  The shadow of the image. If not set, the image has no shadow. This property is read-only.
#' @param link ([Link])
#'  The hyperlink destination of the image. If unset, there is no link.
#'
#' @return ImageProperties object
#'
#' @noRd
ImageProperties <- function(
    cropProperties = NULL,
    transparency = NULL,
    brightness = NULL,
    contrast = NULL,
    recolor = NULL,
    outline = NULL,
    shadow = NULL,
    link = NULL) {
  structure(
    list(
      "cropProperties" = cropProperties,
      "transparency" = transparency,
      "brightness" = brightness,
      "contrast" = contrast,
      "recolor" = recolor,
      "outline" = outline,
      "shadow" = shadow,
      "link" = link
    ),
    class = c("ImageProperties", "list")
  )
}

#' CropProperties Object
#'
#' @details
#' The crop properties of an object enclosed in a container. For example, an Image. The crop properties is represented by the offsets of four edges which define a crop rectangle. The offsets are measured in percentage from the corresponding edges of the object's original bounding rectangle towards inside, relative to the object's original dimensions.
#'  - If the offset is in the interval (0, 1), the corresponding edge of crop rectangle is positioned inside of the object's original bounding rectangle.
#'  - If the offset is negative or greater than 1, the corresponding edge of crop rectangle is positioned outside of the object's original bounding rectangle.
#'  - If the left edge of the crop rectangle is on the right side of its right edge, the object will be flipped horizontally.
#'  - If the top edge of the crop rectangle is below its bottom edge, the object will be flipped vertically.
#'  - If all offsets and rotation angle is 0, the object is not cropped. After cropping, the content in the crop rectangle will be stretched to fit its container.
#'
#' @param leftOffset (number)
#'  The offset specifies the left edge of the crop rectangle that is located to the right of the original bounding rectangle left edge, relative to the object's original width.
#' @param rightOffset (number)
#'  The offset specifies the right edge of the crop rectangle that is located to the left of the original bounding rectangle right edge, relative to the object's original width.
#' @param topOffset (number)
#'  The offset specifies the top edge of the crop rectangle that is located below the original bounding rectangle top edge, relative to the object's original height.
#' @param bottomOffset (number)
#'  The offset specifies the bottom edge of the crop rectangle that is located above the original bounding rectangle bottom edge, relative to the object's original height.
#' @param angle (number)
#'  The rotation angle of the crop window around its center, in radians. Rotation angle is applied after the offset.
#'
#' @return CropProperties object
#'
#' @noRd
CropProperties <- function(
    leftOffset = NULL,
    rightOffset = NULL,
    topOffset = NULL,
    bottomOffset = NULL,
    angle = NULL) {
  structure(
    list(
      "leftOffset" = leftOffset,
      "rightOffset" = rightOffset,
      "topOffset" = topOffset,
      "bottomOffset" = bottomOffset,
      "angle" = angle
    ),
    class = c("CropProperties", "list")
  )
}

#' Recolor Object
#'
#' @details
#' A recolor effect applied on an image.
#'
#' @param recolorStops (list of [ColorStop] objects)
#'  The recolor effect is represented by a gradient, which is a list of color stops. The colors in the gradient will replace the corresponding colors at the same position in the color palette and apply to the image. This property is read-only.
#' @param name (string)
#'  The name of the recolor effect. The name is determined from the `recolor_stops` by matching the gradient against the colors in the page's current color scheme. This property is read-only.
#' - `NONE`: No recolor effect. The default value.
#' - `LIGHT1`: A recolor effect that lightens the image using the page's first available color from its color scheme.
#' - `LIGHT2`: A recolor effect that lightens the image using the page's second available color from its color scheme.
#' - `LIGHT3`: A recolor effect that lightens the image using the page's third available color from its color scheme.
#' - `LIGHT4`: A recolor effect that lightens the image using the page's forth available color from its color scheme.
#' - `LIGHT5`: A recolor effect that lightens the image using the page's fifth available color from its color scheme.
#' - `LIGHT6`: A recolor effect that lightens the image using the page's sixth available color from its color scheme.
#' - `LIGHT7`: A recolor effect that lightens the image using the page's seventh available color from its color scheme.
#' - `LIGHT8`: A recolor effect that lightens the image using the page's eighth available color from its color scheme.
#' - `LIGHT9`: A recolor effect that lightens the image using the page's ninth available color from its color scheme.
#' - `LIGHT10`: A recolor effect that lightens the image using the page's tenth available color from its color scheme.
#' - `DARK1`: A recolor effect that darkens the image using the page's first available color from its color scheme.
#' - `DARK2`: A recolor effect that darkens the image using the page's second available color from its color scheme.
#' - `DARK3`: A recolor effect that darkens the image using the page's third available color from its color scheme.
#' - `DARK4`: A recolor effect that darkens the image using the page's fourth available color from its color scheme.
#' - `DARK5`: A recolor effect that darkens the image using the page's fifth available color from its color scheme.
#' - `DARK6`: A recolor effect that darkens the image using the page's sixth available color from its color scheme.
#' - `DARK7`: A recolor effect that darkens the image using the page's seventh available color from its color scheme.
#' - `DARK8`: A recolor effect that darkens the image using the page's eighth available color from its color scheme.
#' - `DARK9`: A recolor effect that darkens the image using the page's ninth available color from its color scheme.
#' - `DARK10`: A recolor effect that darkens the image using the page's tenth available color from its color scheme.
#' - `GRAYSCALE`: A recolor effect that recolors the image to grayscale.
#' - `NEGATIVE`: A recolor effect that recolors the image to negative grayscale.
#' - `SEPIA`: A recolor effect that recolors the image using the sepia color.
#' - `CUSTOM`: Custom recolor effect. Refer to `recolor_stops` for the concrete gradient.
#'
#' @return Recolor object
#'
#' @noRd
Recolor <- function(
    recolorStops = NULL,
    name = NULL) {
  checkmate::assert_choice(name, c("NONE", "LIGHT1", "LIGHT2", "LIGHT3", "LIGHT4", "LIGHT5", "LIGHT6", "LIGHT7", "LIGHT8", "LIGHT9", "LIGHT10", "DARK1", "DARK2", "DARK3", "DARK4", "DARK5", "DARK6", "DARK7", "DARK8", "DARK9", "DARK10", "GRAYSCALE", "NEGATIVE", "SEPIA", "CUSTOM"), null.ok = TRUE)
  structure(
    list(
      "recolorStops" = recolorStops,
      "name" = name
    ),
    class = c("Recolor", "list")
  )
}

#' ColorStop Object
#'
#' @details
#' A color and position in a gradient band.
#'
#' @param color ([OpaqueColor])
#'  The color of the gradient stop.
#' @param alpha (number)
#'  The alpha value of this color in the gradient band. Defaults to 1.0, fully opaque.
#' @param position (number)
#'  The relative position of the color stop in the gradient band measured in percentage. The value should be in the interval \[0.0, 1.0\].
#'
#' @return ColorStop object
#'
#' @noRd
ColorStop <- function(
    color = NULL,
    alpha = NULL,
    position = NULL) {
  structure(
    list(
      "color" = color,
      "alpha" = alpha,
      "position" = position
    ),
    class = c("ColorStop", "list")
  )
}

#' Video Object
#'
#' @details
#' A PageElement kind representing a video.
#'
#' @param url (string)
#'  An URL to a video. The URL is valid as long as the source video exists and sharing settings do not change.
#' @param source (string)
#'  The video source.
#' - `SOURCE_UNSPECIFIED`: The video source is unspecified.
#' - `YOUTUBE`: The video source is YouTube.
#' - `DRIVE`: The video source is Google Drive.
#' @param id (string)
#'  The video source's unique identifier for this video.
#' @param videoProperties ([VideoProperties])
#'  The properties of the video.
#'
#' @return Video object
#'
#' @noRd
Video <- function(
    url = NULL,
    source = NULL,
    id = NULL,
    videoProperties = NULL) {
  checkmate::assert_choice(source, c("SOURCE_UNSPECIFIED", "YOUTUBE", "DRIVE"), null.ok = TRUE)
  structure(
    list(
      "url" = url,
      "source" = source,
      "id" = id,
      "videoProperties" = videoProperties
    ),
    class = c("Video", "list")
  )
}

#' VideoProperties Object
#'
#' @details
#' The properties of the Video.
#'
#' @param outline ([Outline])
#'  The outline of the video. The default outline matches the defaults for new videos created in the Slides editor.
#' @param autoPlay (boolean)
#'  Whether to enable video autoplay when the page is displayed in present mode. Defaults to false.
#' @param start (integer)
#'  The time at which to start playback, measured in seconds from the beginning of the video. If set, the start time should be before the end time. If you set this to a value that exceeds the video's length in seconds, the video will be played from the last second. If not set, the video will be played from the beginning.
#' @param end (integer)
#'  The time at which to end playback, measured in seconds from the beginning of the video. If set, the end time should be after the start time. If not set or if you set this to a value that exceeds the video's length, the video will be played until its end.
#' @param mute (boolean)
#'  Whether to mute the audio during video playback. Defaults to false.
#'
#' @return VideoProperties object
#'
#' @noRd
VideoProperties <- function(
    outline = NULL,
    autoPlay = NULL,
    start = NULL,
    end = NULL,
    mute = NULL) {
  structure(
    list(
      "outline" = outline,
      "autoPlay" = autoPlay,
      "start" = start,
      "end" = end,
      "mute" = mute
    ),
    class = c("VideoProperties", "list")
  )
}

#' Line Object
#'
#' @details
#' A PageElement kind representing a non-connector line, straight connector, curved connector, or bent connector.
#'
#' @param lineProperties ([LineProperties])
#'  The properties of the line.
#' @param lineType (string)
#'  The type of the line.
#' - `TYPE_UNSPECIFIED`: An unspecified line type.
#' - `STRAIGHT_CONNECTOR_1`: Straight connector 1 form. Corresponds to ECMA-376 ST_ShapeType 'straightConnector1'.
#' - `BENT_CONNECTOR_2`: Bent connector 2 form. Corresponds to ECMA-376 ST_ShapeType 'bentConnector2'.
#' - `BENT_CONNECTOR_3`: Bent connector 3 form. Corresponds to ECMA-376 ST_ShapeType 'bentConnector3'.
#' - `BENT_CONNECTOR_4`: Bent connector 4 form. Corresponds to ECMA-376 ST_ShapeType 'bentConnector4'.
#' - `BENT_CONNECTOR_5`: Bent connector 5 form. Corresponds to ECMA-376 ST_ShapeType 'bentConnector5'.
#' - `CURVED_CONNECTOR_2`: Curved connector 2 form. Corresponds to ECMA-376 ST_ShapeType 'curvedConnector2'.
#' - `CURVED_CONNECTOR_3`: Curved connector 3 form. Corresponds to ECMA-376 ST_ShapeType 'curvedConnector3'.
#' - `CURVED_CONNECTOR_4`: Curved connector 4 form. Corresponds to ECMA-376 ST_ShapeType 'curvedConnector4'.
#' - `CURVED_CONNECTOR_5`: Curved connector 5 form. Corresponds to ECMA-376 ST_ShapeType 'curvedConnector5'.
#' - `STRAIGHT_LINE`: Straight line. Corresponds to ECMA-376 ST_ShapeType 'line'. This line type is not a connector.
#' @param lineCategory (string)
#'  The category of the line. It matches the `category` specified in CreateLineRequest, and can be updated with UpdateLineCategoryRequest.
#' - `LINE_CATEGORY_UNSPECIFIED`: Unspecified line category.
#' - `STRAIGHT`: Straight connectors, including straight connector 1.
#' - `BENT`: Bent connectors, including bent connector 2 to 5.
#' - `CURVED`: Curved connectors, including curved connector 2 to 5.
#'
#' @return Line object
#'
#' @noRd
Line <- function(
    lineProperties = NULL,
    lineType = NULL,
    lineCategory = NULL) {
  checkmate::assert_choice(lineType, c("TYPE_UNSPECIFIED", "STRAIGHT_CONNECTOR_1", "BENT_CONNECTOR_2", "BENT_CONNECTOR_3", "BENT_CONNECTOR_4", "BENT_CONNECTOR_5", "CURVED_CONNECTOR_2", "CURVED_CONNECTOR_3", "CURVED_CONNECTOR_4", "CURVED_CONNECTOR_5", "STRAIGHT_LINE"), null.ok = TRUE)
  checkmate::assert_choice(lineCategory, c("LINE_CATEGORY_UNSPECIFIED", "STRAIGHT", "BENT", "CURVED"), null.ok = TRUE)
  structure(
    list(
      "lineProperties" = lineProperties,
      "lineType" = lineType,
      "lineCategory" = lineCategory
    ),
    class = c("Line", "list")
  )
}

#' LineProperties Object
#'
#' @details
#' The properties of the Line. When unset, these fields default to values that match the appearance of new lines created in the Slides editor.
#'
#' @param lineFill ([LineFill])
#'  The fill of the line. The default line fill matches the defaults for new lines created in the Slides editor.
#' @param weight ([Dimension])
#'  The thickness of the line.
#' @param dashStyle (string)
#'  The dash style of the line.
#' - `DASH_STYLE_UNSPECIFIED`: Unspecified dash style.
#' - `SOLID`: Solid line. Corresponds to ECMA-376 ST_PresetLineDashVal value 'solid'. This is the default dash style.
#' - `DOT`: Dotted line. Corresponds to ECMA-376 ST_PresetLineDashVal value 'dot'.
#' - `DASH`: Dashed line. Corresponds to ECMA-376 ST_PresetLineDashVal value 'dash'.
#' - `DASH_DOT`: Alternating dashes and dots. Corresponds to ECMA-376 ST_PresetLineDashVal value 'dashDot'.
#' - `LONG_DASH`: Line with large dashes. Corresponds to ECMA-376 ST_PresetLineDashVal value 'lgDash'.
#' - `LONG_DASH_DOT`: Alternating large dashes and dots. Corresponds to ECMA-376 ST_PresetLineDashVal value 'lgDashDot'.
#' @param startArrow (string)
#'  The style of the arrow at the beginning of the line.
#' - `ARROW_STYLE_UNSPECIFIED`: An unspecified arrow style.
#' - `NONE`: No arrow.
#' - `STEALTH_ARROW`: Arrow with notched back. Corresponds to ECMA-376 ST_LineEndType value 'stealth'.
#' - `FILL_ARROW`: Filled arrow. Corresponds to ECMA-376 ST_LineEndType value 'triangle'.
#' - `FILL_CIRCLE`: Filled circle. Corresponds to ECMA-376 ST_LineEndType value 'oval'.
#' - `FILL_SQUARE`: Filled square.
#' - `FILL_DIAMOND`: Filled diamond. Corresponds to ECMA-376 ST_LineEndType value 'diamond'.
#' - `OPEN_ARROW`: Hollow arrow.
#' - `OPEN_CIRCLE`: Hollow circle.
#' - `OPEN_SQUARE`: Hollow square.
#' - `OPEN_DIAMOND`: Hollow diamond.
#' @param endArrow (string)
#'  The style of the arrow at the end of the line.
#' - `ARROW_STYLE_UNSPECIFIED`: An unspecified arrow style.
#' - `NONE`: No arrow.
#' - `STEALTH_ARROW`: Arrow with notched back. Corresponds to ECMA-376 ST_LineEndType value 'stealth'.
#' - `FILL_ARROW`: Filled arrow. Corresponds to ECMA-376 ST_LineEndType value 'triangle'.
#' - `FILL_CIRCLE`: Filled circle. Corresponds to ECMA-376 ST_LineEndType value 'oval'.
#' - `FILL_SQUARE`: Filled square.
#' - `FILL_DIAMOND`: Filled diamond. Corresponds to ECMA-376 ST_LineEndType value 'diamond'.
#' - `OPEN_ARROW`: Hollow arrow.
#' - `OPEN_CIRCLE`: Hollow circle.
#' - `OPEN_SQUARE`: Hollow square.
#' - `OPEN_DIAMOND`: Hollow diamond.
#' @param link ([Link])
#'  The hyperlink destination of the line. If unset, there is no link.
#' @param startConnection ([LineConnection])
#'  The connection at the beginning of the line. If unset, there is no connection. Only lines with a Type indicating it is a "connector" can have a `start_connection`.
#' @param endConnection ([LineConnection])
#'  The connection at the end of the line. If unset, there is no connection. Only lines with a Type indicating it is a "connector" can have an `end_connection`.
#'
#' @return LineProperties object
#'
#' @noRd
LineProperties <- function(
    lineFill = NULL,
    weight = NULL,
    dashStyle = NULL,
    startArrow = NULL,
    endArrow = NULL,
    link = NULL,
    startConnection = NULL,
    endConnection = NULL) {
  checkmate::assert_choice(dashStyle, c("DASH_STYLE_UNSPECIFIED", "SOLID", "DOT", "DASH", "DASH_DOT", "LONG_DASH", "LONG_DASH_DOT"), null.ok = TRUE)
  checkmate::assert_choice(startArrow, c("ARROW_STYLE_UNSPECIFIED", "NONE", "STEALTH_ARROW", "FILL_ARROW", "FILL_CIRCLE", "FILL_SQUARE", "FILL_DIAMOND", "OPEN_ARROW", "OPEN_CIRCLE", "OPEN_SQUARE", "OPEN_DIAMOND"), null.ok = TRUE)
  checkmate::assert_choice(endArrow, c("ARROW_STYLE_UNSPECIFIED", "NONE", "STEALTH_ARROW", "FILL_ARROW", "FILL_CIRCLE", "FILL_SQUARE", "FILL_DIAMOND", "OPEN_ARROW", "OPEN_CIRCLE", "OPEN_SQUARE", "OPEN_DIAMOND"), null.ok = TRUE)
  structure(
    list(
      "lineFill" = lineFill,
      "weight" = weight,
      "dashStyle" = dashStyle,
      "startArrow" = startArrow,
      "endArrow" = endArrow,
      "link" = link,
      "startConnection" = startConnection,
      "endConnection" = endConnection
    ),
    class = c("LineProperties", "list")
  )
}

#' LineFill Object
#'
#' @details
#' The fill of the line.
#'
#' @param solidFill ([SolidFill])
#'  Solid color fill.
#'
#' @return LineFill object
#'
#' @noRd
LineFill <- function(solidFill = NULL) {
  structure(
    list(
      "solidFill" = solidFill
    ),
    class = c("LineFill", "list")
  )
}

#' LineConnection Object
#'
#' @details
#' The properties for one end of a Line connection.
#'
#' @param connectedObjectId (string)
#'  The object ID of the connected page element. Some page elements, such as groups, tables, and lines do not have connection sites and therefore cannot be connected to a connector line.
#' @param connectionSiteIndex (integer)
#'  The index of the connection site on the connected page element. In most cases, it corresponds to the predefined connection site index from the ECMA-376 standard. More information on those connection sites can be found in the description of the "cnx" attribute in section 20.1.9.9 and Annex H. "Predefined DrawingML Shape and Text Geometries" of "Office Open XML File Formats-Fundamentals and Markup Language Reference", part 1 of [ECMA-376 5th edition](http://www.ecma-international.org/publications/standards/Ecma-376.htm). The position of each connection site can also be viewed from Slides editor.
#'
#' @return LineConnection object
#'
#' @noRd
LineConnection <- function(
    connectedObjectId = NULL,
    connectionSiteIndex = NULL) {
  structure(
    list(
      "connectedObjectId" = connectedObjectId,
      "connectionSiteIndex" = connectionSiteIndex
    ),
    class = c("LineConnection", "list")
  )
}

#' Table Object
#'
#' @details
#' A PageElement kind representing a table.
#'
#' @param rows (integer)
#'  Number of rows in the table.
#' @param columns (integer)
#'  Number of columns in the table.
#' @param tableRows (list of [TableRow] objects)
#'  Properties and contents of each row. Cells that span multiple rows are contained in only one of these rows and have a row_span greater than 1.
#' @param tableColumns (list of [TableColumnProperties] objects)
#'  Properties of each column.
#' @param horizontalBorderRows (list of [TableBorderRow] objects)
#'  Properties of horizontal cell borders. A table's horizontal cell borders are represented as a grid. The grid has one more row than the number of rows in the table and the same number of columns as the table. For example, if the table is 3 x 3, its horizontal borders will be represented as a grid with 4 rows and 3 columns.
#' @param verticalBorderRows (list of [TableBorderRow] objects)
#'  Properties of vertical cell borders. A table's vertical cell borders are represented as a grid. The grid has the same number of rows as the table and one more column than the number of columns in the table. For example, if the table is 3 x 3, its vertical borders will be represented as a grid with 3 rows and 4 columns.
#'
#' @return Table object
#'
#' @noRd
Table <- function(
    rows = NULL,
    columns = NULL,
    tableRows = NULL,
    tableColumns = NULL,
    horizontalBorderRows = NULL,
    verticalBorderRows = NULL) {
  structure(
    list(
      "rows" = rows,
      "columns" = columns,
      "tableRows" = tableRows,
      "tableColumns" = tableColumns,
      "horizontalBorderRows" = horizontalBorderRows,
      "verticalBorderRows" = verticalBorderRows
    ),
    class = c("Table", "list")
  )
}

#' TableRow Object
#'
#' @details
#' Properties and contents of each row in a table.
#'
#' @param rowHeight ([Dimension])
#'  Height of a row.
#' @param tableRowProperties ([TableRowProperties])
#'  Properties of the row.
#' @param tableCells (list of [TableCell] objects)
#'  Properties and contents of each cell. Cells that span multiple columns are represented only once with a column_span greater than 1. As a result, the length of this collection does not always match the number of columns of the entire table.
#'
#' @return TableRow object
#'
#' @noRd
TableRow <- function(
    rowHeight = NULL,
    tableRowProperties = NULL,
    tableCells = NULL) {
  structure(
    list(
      "rowHeight" = rowHeight,
      "tableRowProperties" = tableRowProperties,
      "tableCells" = tableCells
    ),
    class = c("TableRow", "list")
  )
}

#' TableRowProperties Object
#'
#' @details
#' Properties of each row in a table.
#'
#' @param minRowHeight ([Dimension])
#'  Minimum height of the row. The row will be rendered in the Slides editor at a height equal to or greater than this value in order to show all the text in the row's cell(s).
#'
#' @return TableRowProperties object
#'
#' @noRd
TableRowProperties <- function(minRowHeight = NULL) {
  structure(
    list(
      "minRowHeight" = minRowHeight
    ),
    class = c("TableRowProperties", "list")
  )
}

#' TableCell Object
#'
#' @details
#' Properties and contents of each table cell.
#'
#' @param location ([TableCellLocation])
#'  The location of the cell within the table.
#' @param rowSpan (integer)
#'  Row span of the cell.
#' @param columnSpan (integer)
#'  Column span of the cell.
#' @param text ([TextContent])
#'  The text content of the cell.
#' @param tableCellProperties ([TableCellProperties])
#'  The properties of the table cell.
#'
#' @return TableCell object
#'
#' @noRd
TableCell <- function(
    location = NULL,
    rowSpan = NULL,
    columnSpan = NULL,
    text = NULL,
    tableCellProperties = NULL) {
  structure(
    list(
      "location" = location,
      "rowSpan" = rowSpan,
      "columnSpan" = columnSpan,
      "text" = text,
      "tableCellProperties" = tableCellProperties
    ),
    class = c("TableCell", "list")
  )
}

#' TableCellLocation Object
#'
#' @details
#' A location of a single table cell within a table.
#'
#' @param rowIndex (integer)
#'  The 0-based row index.
#' @param columnIndex (integer)
#'  The 0-based column index.
#'
#' @return TableCellLocation object
#'
#' @noRd
TableCellLocation <- function(
    rowIndex = NULL,
    columnIndex = NULL) {
  structure(
    list(
      "rowIndex" = rowIndex,
      "columnIndex" = columnIndex
    ),
    class = c("TableCellLocation", "list")
  )
}

#' TableCellProperties Object
#'
#' @details
#' The properties of the TableCell.
#'
#' @param tableCellBackgroundFill ([TableCellBackgroundFill])
#'  The background fill of the table cell. The default fill matches the fill for newly created table cells in the Slides editor.
#' @param contentAlignment (string)
#'  The alignment of the content in the table cell. The default alignment matches the alignment for newly created table cells in the Slides editor.
#' - `CONTENT_ALIGNMENT_UNSPECIFIED`: An unspecified content alignment. The content alignment is inherited from the parent if it exists.
#' - `CONTENT_ALIGNMENT_UNSUPPORTED`: An unsupported content alignment.
#' - `TOP`: An alignment that aligns the content to the top of the content holder. Corresponds to ECMA-376 ST_TextAnchoringType 't'.
#' - `MIDDLE`: An alignment that aligns the content to the middle of the content holder. Corresponds to ECMA-376 ST_TextAnchoringType 'ctr'.
#' - `BOTTOM`: An alignment that aligns the content to the bottom of the content holder. Corresponds to ECMA-376 ST_TextAnchoringType 'b'.
#'
#' @return TableCellProperties object
#'
#' @noRd
TableCellProperties <- function(
    tableCellBackgroundFill = NULL,
    contentAlignment = NULL) {
  checkmate::assert_choice(contentAlignment, c("CONTENT_ALIGNMENT_UNSPECIFIED", "CONTENT_ALIGNMENT_UNSUPPORTED", "TOP", "MIDDLE", "BOTTOM"), null.ok = TRUE)
  structure(
    list(
      "tableCellBackgroundFill" = tableCellBackgroundFill,
      "contentAlignment" = contentAlignment
    ),
    class = c("TableCellProperties", "list")
  )
}

#' TableCellBackgroundFill Object
#'
#' @details
#' The table cell background fill.
#'
#' @param propertyState (string)
#'  The background fill property state. Updating the fill on a table cell will implicitly update this field to `RENDERED`, unless another value is specified in the same request. To have no fill on a table cell, set this field to `NOT_RENDERED`. In this case, any other fill fields set in the same request will be ignored.
#' - `RENDERED`: If a property's state is RENDERED, then the element has the corresponding property when rendered on a page. If the element is a placeholder shape as determined by the placeholder field, and it inherits from a placeholder shape, the corresponding field may be unset, meaning that the property value is inherited from a parent placeholder. If the element does not inherit, then the field will contain the rendered value. This is the default value.
#' - `NOT_RENDERED`: If a property's state is NOT_RENDERED, then the element does not have the corresponding property when rendered on a page. However, the field may still be set so it can be inherited by child shapes. To remove a property from a rendered element, set its property_state to NOT_RENDERED.
#' - `INHERIT`: If a property's state is INHERIT, then the property state uses the value of corresponding `property_state` field on the parent shape. Elements that do not inherit will never have an INHERIT property state.
#' @param solidFill ([SolidFill])
#'  Solid color fill.
#'
#' @return TableCellBackgroundFill object
#'
#' @noRd
TableCellBackgroundFill <- function(
    propertyState = NULL,
    solidFill = NULL) {
  checkmate::assert_choice(propertyState, c("RENDERED", "NOT_RENDERED", "INHERIT"), null.ok = TRUE)
  structure(
    list(
      "propertyState" = propertyState,
      "solidFill" = solidFill
    ),
    class = c("TableCellBackgroundFill", "list")
  )
}

#' TableColumnProperties Object
#'
#' @details
#' Properties of each column in a table.
#'
#' @param columnWidth ([Dimension])
#'  Width of a column.
#'
#' @return TableColumnProperties object
#'
#' @noRd
TableColumnProperties <- function(columnWidth = NULL) {
  structure(
    list(
      "columnWidth" = columnWidth
    ),
    class = c("TableColumnProperties", "list")
  )
}

#' TableBorderRow Object
#'
#' @details
#' Contents of each border row in a table.
#'
#' @param tableBorderCells (list of [TableBorderCell] objects)
#'  Properties of each border cell. When a border's adjacent table cells are merged, it is not included in the response.
#'
#' @return TableBorderRow object
#'
#' @noRd
TableBorderRow <- function(tableBorderCells = NULL) {
  structure(
    list(
      "tableBorderCells" = tableBorderCells
    ),
    class = c("TableBorderRow", "list")
  )
}

#' TableBorderCell Object
#'
#' @details
#' The properties of each border cell.
#'
#' @param location ([TableCellLocation])
#'  The location of the border within the border table.
#' @param tableBorderProperties ([TableBorderProperties])
#'  The border properties.
#'
#' @return TableBorderCell object
#'
#' @noRd
TableBorderCell <- function(
    location = NULL,
    tableBorderProperties = NULL) {
  structure(
    list(
      "location" = location,
      "tableBorderProperties" = tableBorderProperties
    ),
    class = c("TableBorderCell", "list")
  )
}

#' TableBorderProperties Object
#'
#' @details
#' The border styling properties of the TableBorderCell.
#'
#' @param tableBorderFill ([TableBorderFill])
#'  The fill of the table border.
#' @param weight ([Dimension])
#'  The thickness of the border.
#' @param dashStyle (string)
#'  The dash style of the border.
#' - `DASH_STYLE_UNSPECIFIED`: Unspecified dash style.
#' - `SOLID`: Solid line. Corresponds to ECMA-376 ST_PresetLineDashVal value 'solid'. This is the default dash style.
#' - `DOT`: Dotted line. Corresponds to ECMA-376 ST_PresetLineDashVal value 'dot'.
#' - `DASH`: Dashed line. Corresponds to ECMA-376 ST_PresetLineDashVal value 'dash'.
#' - `DASH_DOT`: Alternating dashes and dots. Corresponds to ECMA-376 ST_PresetLineDashVal value 'dashDot'.
#' - `LONG_DASH`: Line with large dashes. Corresponds to ECMA-376 ST_PresetLineDashVal value 'lgDash'.
#' - `LONG_DASH_DOT`: Alternating large dashes and dots. Corresponds to ECMA-376 ST_PresetLineDashVal value 'lgDashDot'.
#'
#' @return TableBorderProperties object
#'
#' @noRd
TableBorderProperties <- function(
    tableBorderFill = NULL,
    weight = NULL,
    dashStyle = NULL) {
  checkmate::assert_choice(dashStyle, c("DASH_STYLE_UNSPECIFIED", "SOLID", "DOT", "DASH", "DASH_DOT", "LONG_DASH", "LONG_DASH_DOT"), null.ok = TRUE)
  structure(
    list(
      "tableBorderFill" = tableBorderFill,
      "weight" = weight,
      "dashStyle" = dashStyle
    ),
    class = c("TableBorderProperties", "list")
  )
}

#' TableBorderFill Object
#'
#' @details
#' The fill of the border.
#'
#' @param solidFill ([SolidFill])
#'  Solid fill.
#'
#' @return TableBorderFill object
#'
#' @noRd
TableBorderFill <- function(solidFill = NULL) {
  structure(
    list(
      "solidFill" = solidFill
    ),
    class = c("TableBorderFill", "list")
  )
}

#' WordArt Object
#'
#' @details
#' A PageElement kind representing word art.
#'
#' @param renderedText (string)
#'  The text rendered as word art.
#'
#' @return WordArt object
#'
#' @noRd
WordArt <- function(renderedText = NULL) {
  structure(
    list(
      "renderedText" = renderedText
    ),
    class = c("WordArt", "list")
  )
}

#' SheetsChart Object
#'
#' @details
#' A PageElement kind representing a linked chart embedded from Google Sheets.
#'
#' @param spreadsheetId (string)
#'  The ID of the Google Sheets spreadsheet that contains the source chart.
#' @param chartId (integer)
#'  The ID of the specific chart in the Google Sheets spreadsheet that is embedded.
#' @param contentUrl (string)
#'  The URL of an image of the embedded chart, with a default lifetime of 30 minutes. This URL is tagged with the account of the requester. Anyone with the URL effectively accesses the image as the original requester. Access to the image may be lost if the presentation's sharing settings change.
#' @param sheetsChartProperties ([SheetsChartProperties])
#'  The properties of the Sheets chart.
#'
#' @return SheetsChart object
#'
#' @noRd
SheetsChart <- function(
    spreadsheetId = NULL,
    chartId = NULL,
    contentUrl = NULL,
    sheetsChartProperties = NULL) {
  structure(
    list(
      "spreadsheetId" = spreadsheetId,
      "chartId" = chartId,
      "contentUrl" = contentUrl,
      "sheetsChartProperties" = sheetsChartProperties
    ),
    class = c("SheetsChart", "list")
  )
}

#' SheetsChartProperties Object
#'
#' @details
#' The properties of the SheetsChart.
#'
#' @param chartImageProperties ([ImageProperties])
#'  The properties of the embedded chart image.
#'
#' @return SheetsChartProperties object
#'
#' @noRd
SheetsChartProperties <- function(chartImageProperties = NULL) {
  structure(
    list(
      "chartImageProperties" = chartImageProperties
    ),
    class = c("SheetsChartProperties", "list")
  )
}

#' SpeakerSpotlight Object
#'
#' @details
#' A PageElement kind representing a Speaker Spotlight.
#'
#' @param speakerSpotlightProperties ([SpeakerSpotlightProperties])
#'  The properties of the Speaker Spotlight.
#'
#' @return SpeakerSpotlight object
#'
#' @noRd
SpeakerSpotlight <- function(speakerSpotlightProperties = NULL) {
  structure(
    list(
      "speakerSpotlightProperties" = speakerSpotlightProperties
    ),
    class = c("SpeakerSpotlight", "list")
  )
}

#' SpeakerSpotlightProperties Object
#'
#' @details
#' The properties of the SpeakerSpotlight.
#'
#' @param outline ([Outline])
#'  The outline of the Speaker Spotlight. If not set, it has no outline.
#' @param shadow ([Shadow])
#'  The shadow of the Speaker Spotlight. If not set, it has no shadow.
#'
#' @return SpeakerSpotlightProperties object
#'
#' @noRd
SpeakerSpotlightProperties <- function(
    outline = NULL,
    shadow = NULL) {
  structure(
    list(
      "outline" = outline,
      "shadow" = shadow
    ),
    class = c("SpeakerSpotlightProperties", "list")
  )
}

#' SlideProperties Object
#'
#' @details
#' The properties of Page that are only relevant for pages with page_type SLIDE.
#'
#' @param layoutObjectId (string)
#'  The object ID of the layout that this slide is based on. This property is read-only.
#' @param masterObjectId (string)
#'  The object ID of the master that this slide is based on. This property is read-only.
#' @param notesPage ([Page])
#'  The notes page that this slide is associated with. It defines the visual appearance of a notes page when printing or exporting slides with speaker notes. A notes page inherits properties from the notes master. The placeholder shape with type BODY on the notes page contains the speaker notes for this slide. The ID of this shape is identified by the speakerNotesObjectId field. The notes page is read-only except for the text content and styles of the speaker notes shape. This property is read-only.
#' @param isSkipped (boolean)
#'  Whether the slide is skipped in the presentation mode. Defaults to false.
#'
#' @return SlideProperties object
#'
#' @noRd
SlideProperties <- function(
    layoutObjectId = NULL,
    masterObjectId = NULL,
    notesPage = NULL,
    isSkipped = NULL) {
  structure(
    list(
      "layoutObjectId" = layoutObjectId,
      "masterObjectId" = masterObjectId,
      "notesPage" = notesPage,
      "isSkipped" = isSkipped
    ),
    class = c("SlideProperties", "list")
  )
}

#' LayoutProperties Object
#'
#' @details
#' The properties of Page are only relevant for pages with page_type LAYOUT.
#'
#' @param masterObjectId (string)
#'  The object ID of the master that this layout is based on.
#' @param name (string)
#'  The name of the layout.
#' @param displayName (string)
#'  The human-readable name of the layout.
#'
#' @return LayoutProperties object
#'
#' @noRd
LayoutProperties <- function(
    masterObjectId = NULL,
    name = NULL,
    displayName = NULL) {
  structure(
    list(
      "masterObjectId" = masterObjectId,
      "name" = name,
      "displayName" = displayName
    ),
    class = c("LayoutProperties", "list")
  )
}

#' NotesProperties Object
#'
#' @details
#' The properties of Page that are only relevant for pages with page_type NOTES.
#'
#' @param speakerNotesObjectId (string)
#'  The object ID of the shape on this notes page that contains the speaker notes for the corresponding slide. The actual shape may not always exist on the notes page. Inserting text using this object ID will automatically create the shape. In this case, the actual shape may have different object ID. The `GetPresentation` or `GetPage` action will always return the latest object ID.
#'
#' @return NotesProperties object
#'
#' @noRd
NotesProperties <- function(speakerNotesObjectId = NULL) {
  structure(
    list(
      "speakerNotesObjectId" = speakerNotesObjectId
    ),
    class = c("NotesProperties", "list")
  )
}

#' MasterProperties Object
#'
#' @details
#' The properties of Page that are only relevant for pages with page_type MASTER.
#'
#' @param displayName (string)
#'  The human-readable name of the master.
#'
#' @return MasterProperties object
#'
#' @noRd
MasterProperties <- function(displayName = NULL) {
  structure(
    list(
      "displayName" = displayName
    ),
    class = c("MasterProperties", "list")
  )
}

#' PageProperties Object
#'
#' @details
#' The properties of the Page. The page will inherit properties from the parent page. Depending on the page type the hierarchy is defined in either SlideProperties or LayoutProperties.
#'
#' @param pageBackgroundFill ([PageBackgroundFill])
#'  The background fill of the page. If unset, the background fill is inherited from a parent page if it exists. If the page has no parent, then the background fill defaults to the corresponding fill in the Slides editor.
#' @param colorScheme ([ColorScheme])
#'  The color scheme of the page. If unset, the color scheme is inherited from a parent page. If the page has no parent, the color scheme uses a default Slides color scheme, matching the defaults in the Slides editor. Only the concrete colors of the first 12 ThemeColorTypes are editable. In addition, only the color scheme on `Master` pages can be updated. To update the field, a color scheme containing mappings from all the first 12 ThemeColorTypes to their concrete colors must be provided. Colors for the remaining ThemeColorTypes will be ignored.
#'
#' @return PageProperties object
#'
#' @noRd
PageProperties <- function(
    pageBackgroundFill = NULL,
    colorScheme = NULL) {
  structure(
    list(
      "pageBackgroundFill" = pageBackgroundFill,
      "colorScheme" = colorScheme
    ),
    class = c("PageProperties", "list")
  )
}

#' PageBackgroundFill Object
#'
#' @details
#' The page background fill.
#'
#' @param propertyState (string)
#'  The background fill property state. Updating the fill on a page will implicitly update this field to `RENDERED`, unless another value is specified in the same request. To have no fill on a page, set this field to `NOT_RENDERED`. In this case, any other fill fields set in the same request will be ignored.
#' - `RENDERED`: If a property's state is RENDERED, then the element has the corresponding property when rendered on a page. If the element is a placeholder shape as determined by the placeholder field, and it inherits from a placeholder shape, the corresponding field may be unset, meaning that the property value is inherited from a parent placeholder. If the element does not inherit, then the field will contain the rendered value. This is the default value.
#' - `NOT_RENDERED`: If a property's state is NOT_RENDERED, then the element does not have the corresponding property when rendered on a page. However, the field may still be set so it can be inherited by child shapes. To remove a property from a rendered element, set its property_state to NOT_RENDERED.
#' - `INHERIT`: If a property's state is INHERIT, then the property state uses the value of corresponding `property_state` field on the parent shape. Elements that do not inherit will never have an INHERIT property state.
#' @param solidFill ([SolidFill])
#'  Solid color fill.
#' @param stretchedPictureFill ([StretchedPictureFill])
#'  Stretched picture fill.
#'
#' @return PageBackgroundFill object
#'
#' @noRd
PageBackgroundFill <- function(
    propertyState = NULL,
    solidFill = NULL,
    stretchedPictureFill = NULL) {
  checkmate::assert_choice(propertyState, c("RENDERED", "NOT_RENDERED", "INHERIT"), null.ok = TRUE)
  structure(
    list(
      "propertyState" = propertyState,
      "solidFill" = solidFill,
      "stretchedPictureFill" = stretchedPictureFill
    ),
    class = c("PageBackgroundFill", "list")
  )
}

#' StretchedPictureFill Object
#'
#' @details
#' The stretched picture fill. The page or page element is filled entirely with the specified picture. The picture is stretched to fit its container.
#'
#' @param contentUrl (string)
#'  Reading the content_url: An URL to a picture with a default lifetime of 30 minutes. This URL is tagged with the account of the requester. Anyone with the URL effectively accesses the picture as the original requester. Access to the picture may be lost if the presentation's sharing settings change. Writing the content_url: The picture is fetched once at insertion time and a copy is stored for display inside the presentation. Pictures must be less than 50MB in size, cannot exceed 25 megapixels, and must be in one of PNG, JPEG, or GIF format. The provided URL can be at most 2 kB in length.
#' @param size ([Size])
#'  The original size of the picture fill. This field is read-only.
#'
#' @return StretchedPictureFill object
#'
#' @noRd
StretchedPictureFill <- function(
    contentUrl = NULL,
    size = NULL) {
  structure(
    list(
      "contentUrl" = contentUrl,
      "size" = size
    ),
    class = c("StretchedPictureFill", "list")
  )
}

#' ColorScheme Object
#'
#' @details
#' The palette of predefined colors for a page.
#'
#' @param colors (list of [ThemeColorPair] objects)
#'  The ThemeColorType and corresponding concrete color pairs.
#'
#' @return ColorScheme object
#'
#' @noRd
ColorScheme <- function(colors = NULL) {
  structure(
    list(
      "colors" = colors
    ),
    class = c("ColorScheme", "list")
  )
}

#' ThemeColorPair Object
#'
#' @details
#' A pair mapping a theme color type to the concrete color it represents.
#'
#' @param type (string)
#'  The type of the theme color.
#' - `THEME_COLOR_TYPE_UNSPECIFIED`: Unspecified theme color. This value should not be used.
#' - `DARK1`: Represents the first dark color.
#' - `LIGHT1`: Represents the first light color.
#' - `DARK2`: Represents the second dark color.
#' - `LIGHT2`: Represents the second light color.
#' - `ACCENT1`: Represents the first accent color.
#' - `ACCENT2`: Represents the second accent color.
#' - `ACCENT3`: Represents the third accent color.
#' - `ACCENT4`: Represents the fourth accent color.
#' - `ACCENT5`: Represents the fifth accent color.
#' - `ACCENT6`: Represents the sixth accent color.
#' - `HYPERLINK`: Represents the color to use for hyperlinks.
#' - `FOLLOWED_HYPERLINK`: Represents the color to use for visited hyperlinks.
#' - `TEXT1`: Represents the first text color.
#' - `BACKGROUND1`: Represents the first background color.
#' - `TEXT2`: Represents the second text color.
#' - `BACKGROUND2`: Represents the second background color.
#' @param color ([RgbColor])
#'  The concrete color corresponding to the theme color type above.
#'
#' @return ThemeColorPair object
#'
#' @noRd
ThemeColorPair <- function(
    type = NULL,
    color = NULL) {
  checkmate::assert_choice(type, c("THEME_COLOR_TYPE_UNSPECIFIED", "DARK1", "LIGHT1", "DARK2", "LIGHT2", "ACCENT1", "ACCENT2", "ACCENT3", "ACCENT4", "ACCENT5", "ACCENT6", "HYPERLINK", "FOLLOWED_HYPERLINK", "TEXT1", "BACKGROUND1", "TEXT2", "BACKGROUND2"), null.ok = TRUE)
  structure(
    list(
      "type" = type,
      "color" = color
    ),
    class = c("ThemeColorPair", "list")
  )
}

#' BatchUpdatePresentationRequest Object
#'
#' @details
#' Request message for PresentationsService.BatchUpdatePresentation.
#'
#' @param requests (list of [Request] objects)
#'  A list of updates to apply to the presentation.
#' @param writeControl ([WriteControl])
#'  Provides control over how write requests are executed.
#'
#' @return BatchUpdatePresentationRequest object
#'
#' @noRd
BatchUpdatePresentationRequest <- function(
    requests = NULL,
    writeControl = NULL) {
  structure(
    list(
      "requests" = requests,
      "writeControl" = writeControl
    ),
    class = c("BatchUpdatePresentationRequest", "list")
  )
}

#' CreateSlideRequest Object
#'
#' @details
#' Creates a slide.
#'
#' @param objectId (string)
#'  A user-supplied object ID. If you specify an ID, it must be unique among all pages and page elements in the presentation. The ID must start with an alphanumeric character or an underscore (matches regex `[a-zA-Z0-9_]`); remaining characters may include those as well as a hyphen or colon (matches regex `[a-zA-Z0-9_-:]`). The ID length must be between 5 and 50 characters, inclusive. If you don't specify an ID, a unique one is generated.
#' @param insertionIndex (integer)
#'  The optional zero-based index indicating where to insert the slides. If you don't specify an index, the slide is created at the end.
#' @param slideLayoutReference ([LayoutReference])
#'  Layout reference of the slide to be inserted, based on the *current master*, which is one of the following: - The master of the previous slide index. - The master of the first slide, if the insertion_index is zero. - The first master in the presentation, if there are no slides. If the LayoutReference is not found in the current master, a 400 bad request error is returned. If you don't specify a layout reference, the slide uses the predefined `BLANK` layout.
#' @param placeholderIdMappings (list of [LayoutPlaceholderIdMapping] objects)
#'  An optional list of object ID mappings from the placeholder(s) on the layout to the placeholders that are created on the slide from the specified layout. Can only be used when `slide_layout_reference` is specified.
#'
#' @return CreateSlideRequest object
#'
#' @noRd
CreateSlideRequest <- function(
    objectId = NULL,
    insertionIndex = NULL,
    slideLayoutReference = NULL,
    placeholderIdMappings = NULL) {
  structure(
    list(
      "objectId" = objectId,
      "insertionIndex" = insertionIndex,
      "slideLayoutReference" = slideLayoutReference,
      "placeholderIdMappings" = placeholderIdMappings
    ),
    class = c("CreateSlideRequest", "list")
  )
}

#' LayoutReference Object
#'
#' @details
#' Slide layout reference. This may reference either:
#'  - A predefined layout - One of the layouts in the presentation.
#'
#' @param predefinedLayout (string)
#'  Predefined layout.
#' - `PREDEFINED_LAYOUT_UNSPECIFIED`: Unspecified layout.
#' - `BLANK`: Blank layout, with no placeholders.
#' - `CAPTION_ONLY`: Layout with a caption at the bottom.
#' - `TITLE`: Layout with a title and a subtitle.
#' - `TITLE_AND_BODY`: Layout with a title and body.
#' - `TITLE_AND_TWO_COLUMNS`: Layout with a title and two columns.
#' - `TITLE_ONLY`: Layout with only a title.
#' - `SECTION_HEADER`: Layout with a section title.
#' - `SECTION_TITLE_AND_DESCRIPTION`: Layout with a title and subtitle on one side and description on the other.
#' - `ONE_COLUMN_TEXT`: Layout with one title and one body, arranged in a single column.
#' - `MAIN_POINT`: Layout with a main point.
#' - `BIG_NUMBER`: Layout with a big number heading.
#' @param layoutId (string)
#'  Layout ID: the object ID of one of the layouts in the presentation.
#'
#' @return LayoutReference object
#'
#' @noRd
LayoutReference <- function(
    predefinedLayout = NULL,
    layoutId = NULL) {
  checkmate::assert_choice(predefinedLayout, c("PREDEFINED_LAYOUT_UNSPECIFIED", "BLANK", "CAPTION_ONLY", "TITLE", "TITLE_AND_BODY", "TITLE_AND_TWO_COLUMNS", "TITLE_ONLY", "SECTION_HEADER", "SECTION_TITLE_AND_DESCRIPTION", "ONE_COLUMN_TEXT", "MAIN_POINT", "BIG_NUMBER"), null.ok = TRUE)
  structure(
    list(
      "predefinedLayout" = predefinedLayout,
      "layoutId" = layoutId
    ),
    class = c("LayoutReference", "list")
  )
}

#' LayoutPlaceholderIdMapping Object
#'
#' @details
#' The user-specified ID mapping for a placeholder that will be created on a slide from a specified layout.
#'
#' @param layoutPlaceholder ([Placeholder])
#'  The placeholder on a layout that will be applied to a slide. Only type and index are needed. For example, a predefined `TITLE_AND_BODY` layout may usually have a TITLE placeholder with index 0 and a BODY placeholder with index 0.
#' @param layoutPlaceholderObjectId (string)
#'  The object ID of the placeholder on a layout that will be applied to a slide.
#' @param objectId (string)
#'  A user-supplied object ID for the placeholder identified above that to be created onto a slide. If you specify an ID, it must be unique among all pages and page elements in the presentation. The ID must start with an alphanumeric character or an underscore (matches regex `[a-zA-Z0-9_]`); remaining characters may include those as well as a hyphen or colon (matches regex `[a-zA-Z0-9_-:]`). The length of the ID must not be less than 5 or greater than 50. If you don't specify an ID, a unique one is generated.
#'
#' @return LayoutPlaceholderIdMapping object
#'
#' @noRd
LayoutPlaceholderIdMapping <- function(
    layoutPlaceholder = NULL,
    layoutPlaceholderObjectId = NULL,
    objectId = NULL) {
  structure(
    list(
      "layoutPlaceholder" = layoutPlaceholder,
      "layoutPlaceholderObjectId" = layoutPlaceholderObjectId,
      "objectId" = objectId
    ),
    class = c("LayoutPlaceholderIdMapping", "list")
  )
}

#' CreateShapeRequest Object
#'
#' @details
#' Creates a new shape.
#'
#' @param objectId (string)
#'  A user-supplied object ID. If you specify an ID, it must be unique among all pages and page elements in the presentation. The ID must start with an alphanumeric character or an underscore (matches regex `[a-zA-Z0-9_]`); remaining characters may include those as well as a hyphen or colon (matches regex `[a-zA-Z0-9_-:]`). The length of the ID must not be less than 5 or greater than 50. If empty, a unique identifier will be generated.
#' @param elementProperties ([PageElementProperties])
#'  The element properties for the shape.
#' @param shapeType (string)
#'  The shape type.
#' - `TYPE_UNSPECIFIED`: The shape type that is not predefined.
#' - `TEXT_BOX`: Text box shape.
#' - `RECTANGLE`: Rectangle shape. Corresponds to ECMA-376 ST_ShapeType 'rect'.
#' - `ROUND_RECTANGLE`: Round corner rectangle shape. Corresponds to ECMA-376 ST_ShapeType 'roundRect'
#' - `ELLIPSE`: Ellipse shape. Corresponds to ECMA-376 ST_ShapeType 'ellipse'
#' - `ARC`: Curved arc shape. Corresponds to ECMA-376 ST_ShapeType 'arc'
#' - `BENT_ARROW`: Bent arrow shape. Corresponds to ECMA-376 ST_ShapeType 'bentArrow'
#' - `BENT_UP_ARROW`: Bent up arrow shape. Corresponds to ECMA-376 ST_ShapeType 'bentUpArrow'
#' - `BEVEL`: Bevel shape. Corresponds to ECMA-376 ST_ShapeType 'bevel'
#' - `BLOCK_ARC`: Block arc shape. Corresponds to ECMA-376 ST_ShapeType 'blockArc'
#' - `BRACE_PAIR`: Brace pair shape. Corresponds to ECMA-376 ST_ShapeType 'bracePair'
#' - `BRACKET_PAIR`: Bracket pair shape. Corresponds to ECMA-376 ST_ShapeType 'bracketPair'
#' - `CAN`: Can shape. Corresponds to ECMA-376 ST_ShapeType 'can'
#' - `CHEVRON`: Chevron shape. Corresponds to ECMA-376 ST_ShapeType 'chevron'
#' - `CHORD`: Chord shape. Corresponds to ECMA-376 ST_ShapeType 'chord'
#' - `CLOUD`: Cloud shape. Corresponds to ECMA-376 ST_ShapeType 'cloud'
#' - `CORNER`: Corner shape. Corresponds to ECMA-376 ST_ShapeType 'corner'
#' - `CUBE`: Cube shape. Corresponds to ECMA-376 ST_ShapeType 'cube'
#' - `CURVED_DOWN_ARROW`: Curved down arrow shape. Corresponds to ECMA-376 ST_ShapeType 'curvedDownArrow'
#' - `CURVED_LEFT_ARROW`: Curved left arrow shape. Corresponds to ECMA-376 ST_ShapeType 'curvedLeftArrow'
#' - `CURVED_RIGHT_ARROW`: Curved right arrow shape. Corresponds to ECMA-376 ST_ShapeType 'curvedRightArrow'
#' - `CURVED_UP_ARROW`: Curved up arrow shape. Corresponds to ECMA-376 ST_ShapeType 'curvedUpArrow'
#' - `DECAGON`: Decagon shape. Corresponds to ECMA-376 ST_ShapeType 'decagon'
#' - `DIAGONAL_STRIPE`: Diagonal stripe shape. Corresponds to ECMA-376 ST_ShapeType 'diagStripe'
#' - `DIAMOND`: Diamond shape. Corresponds to ECMA-376 ST_ShapeType 'diamond'
#' - `DODECAGON`: Dodecagon shape. Corresponds to ECMA-376 ST_ShapeType 'dodecagon'
#' - `DONUT`: Donut shape. Corresponds to ECMA-376 ST_ShapeType 'donut'
#' - `DOUBLE_WAVE`: Double wave shape. Corresponds to ECMA-376 ST_ShapeType 'doubleWave'
#' - `DOWN_ARROW`: Down arrow shape. Corresponds to ECMA-376 ST_ShapeType 'downArrow'
#' - `DOWN_ARROW_CALLOUT`: Callout down arrow shape. Corresponds to ECMA-376 ST_ShapeType 'downArrowCallout'
#' - `FOLDED_CORNER`: Folded corner shape. Corresponds to ECMA-376 ST_ShapeType 'foldedCorner'
#' - `FRAME`: Frame shape. Corresponds to ECMA-376 ST_ShapeType 'frame'
#' - `HALF_FRAME`: Half frame shape. Corresponds to ECMA-376 ST_ShapeType 'halfFrame'
#' - `HEART`: Heart shape. Corresponds to ECMA-376 ST_ShapeType 'heart'
#' - `HEPTAGON`: Heptagon shape. Corresponds to ECMA-376 ST_ShapeType 'heptagon'
#' - `HEXAGON`: Hexagon shape. Corresponds to ECMA-376 ST_ShapeType 'hexagon'
#' - `HOME_PLATE`: Home plate shape. Corresponds to ECMA-376 ST_ShapeType 'homePlate'
#' - `HORIZONTAL_SCROLL`: Horizontal scroll shape. Corresponds to ECMA-376 ST_ShapeType 'horizontalScroll'
#' - `IRREGULAR_SEAL_1`: Irregular seal 1 shape. Corresponds to ECMA-376 ST_ShapeType 'irregularSeal1'
#' - `IRREGULAR_SEAL_2`: Irregular seal 2 shape. Corresponds to ECMA-376 ST_ShapeType 'irregularSeal2'
#' - `LEFT_ARROW`: Left arrow shape. Corresponds to ECMA-376 ST_ShapeType 'leftArrow'
#' - `LEFT_ARROW_CALLOUT`: Callout left arrow shape. Corresponds to ECMA-376 ST_ShapeType 'leftArrowCallout'
#' - `LEFT_BRACE`: Left brace shape. Corresponds to ECMA-376 ST_ShapeType 'leftBrace'
#' - `LEFT_BRACKET`: Left bracket shape. Corresponds to ECMA-376 ST_ShapeType 'leftBracket'
#' - `LEFT_RIGHT_ARROW`: Left right arrow shape. Corresponds to ECMA-376 ST_ShapeType 'leftRightArrow'
#' - `LEFT_RIGHT_ARROW_CALLOUT`: Callout left right arrow shape. Corresponds to ECMA-376 ST_ShapeType 'leftRightArrowCallout'
#' - `LEFT_RIGHT_UP_ARROW`: Left right up arrow shape. Corresponds to ECMA-376 ST_ShapeType 'leftRightUpArrow'
#' - `LEFT_UP_ARROW`: Left up arrow shape. Corresponds to ECMA-376 ST_ShapeType 'leftUpArrow'
#' - `LIGHTNING_BOLT`: Lightning bolt shape. Corresponds to ECMA-376 ST_ShapeType 'lightningBolt'
#' - `MATH_DIVIDE`: Divide math shape. Corresponds to ECMA-376 ST_ShapeType 'mathDivide'
#' - `MATH_EQUAL`: Equal math shape. Corresponds to ECMA-376 ST_ShapeType 'mathEqual'
#' - `MATH_MINUS`: Minus math shape. Corresponds to ECMA-376 ST_ShapeType 'mathMinus'
#' - `MATH_MULTIPLY`: Multiply math shape. Corresponds to ECMA-376 ST_ShapeType 'mathMultiply'
#' - `MATH_NOT_EQUAL`: Not equal math shape. Corresponds to ECMA-376 ST_ShapeType 'mathNotEqual'
#' - `MATH_PLUS`: Plus math shape. Corresponds to ECMA-376 ST_ShapeType 'mathPlus'
#' - `MOON`: Moon shape. Corresponds to ECMA-376 ST_ShapeType 'moon'
#' - `NO_SMOKING`: No smoking shape. Corresponds to ECMA-376 ST_ShapeType 'noSmoking'
#' - `NOTCHED_RIGHT_ARROW`: Notched right arrow shape. Corresponds to ECMA-376 ST_ShapeType 'notchedRightArrow'
#' - `OCTAGON`: Octagon shape. Corresponds to ECMA-376 ST_ShapeType 'octagon'
#' - `PARALLELOGRAM`: Parallelogram shape. Corresponds to ECMA-376 ST_ShapeType 'parallelogram'
#' - `PENTAGON`: Pentagon shape. Corresponds to ECMA-376 ST_ShapeType 'pentagon'
#' - `PIE`: Pie shape. Corresponds to ECMA-376 ST_ShapeType 'pie'
#' - `PLAQUE`: Plaque shape. Corresponds to ECMA-376 ST_ShapeType 'plaque'
#' - `PLUS`: Plus shape. Corresponds to ECMA-376 ST_ShapeType 'plus'
#' - `QUAD_ARROW`: Quad-arrow shape. Corresponds to ECMA-376 ST_ShapeType 'quadArrow'
#' - `QUAD_ARROW_CALLOUT`: Callout quad-arrow shape. Corresponds to ECMA-376 ST_ShapeType 'quadArrowCallout'
#' - `RIBBON`: Ribbon shape. Corresponds to ECMA-376 ST_ShapeType 'ribbon'
#' - `RIBBON_2`: Ribbon 2 shape. Corresponds to ECMA-376 ST_ShapeType 'ribbon2'
#' - `RIGHT_ARROW`: Right arrow shape. Corresponds to ECMA-376 ST_ShapeType 'rightArrow'
#' - `RIGHT_ARROW_CALLOUT`: Callout right arrow shape. Corresponds to ECMA-376 ST_ShapeType 'rightArrowCallout'
#' - `RIGHT_BRACE`: Right brace shape. Corresponds to ECMA-376 ST_ShapeType 'rightBrace'
#' - `RIGHT_BRACKET`: Right bracket shape. Corresponds to ECMA-376 ST_ShapeType 'rightBracket'
#' - `ROUND_1_RECTANGLE`: One round corner rectangle shape. Corresponds to ECMA-376 ST_ShapeType 'round1Rect'
#' - `ROUND_2_DIAGONAL_RECTANGLE`: Two diagonal round corner rectangle shape. Corresponds to ECMA-376 ST_ShapeType 'round2DiagRect'
#' - `ROUND_2_SAME_RECTANGLE`: Two same-side round corner rectangle shape. Corresponds to ECMA-376 ST_ShapeType 'round2SameRect'
#' - `RIGHT_TRIANGLE`: Right triangle shape. Corresponds to ECMA-376 ST_ShapeType 'rtTriangle'
#' - `SMILEY_FACE`: Smiley face shape. Corresponds to ECMA-376 ST_ShapeType 'smileyFace'
#' - `SNIP_1_RECTANGLE`: One snip corner rectangle shape. Corresponds to ECMA-376 ST_ShapeType 'snip1Rect'
#' - `SNIP_2_DIAGONAL_RECTANGLE`: Two diagonal snip corner rectangle shape. Corresponds to ECMA-376 ST_ShapeType 'snip2DiagRect'
#' - `SNIP_2_SAME_RECTANGLE`: Two same-side snip corner rectangle shape. Corresponds to ECMA-376 ST_ShapeType 'snip2SameRect'
#' - `SNIP_ROUND_RECTANGLE`: One snip one round corner rectangle shape. Corresponds to ECMA-376 ST_ShapeType 'snipRoundRect'
#' - `STAR_10`: Ten pointed star shape. Corresponds to ECMA-376 ST_ShapeType 'star10'
#' - `STAR_12`: Twelve pointed star shape. Corresponds to ECMA-376 ST_ShapeType 'star12'
#' - `STAR_16`: Sixteen pointed star shape. Corresponds to ECMA-376 ST_ShapeType 'star16'
#' - `STAR_24`: Twenty four pointed star shape. Corresponds to ECMA-376 ST_ShapeType 'star24'
#' - `STAR_32`: Thirty two pointed star shape. Corresponds to ECMA-376 ST_ShapeType 'star32'
#' - `STAR_4`: Four pointed star shape. Corresponds to ECMA-376 ST_ShapeType 'star4'
#' - `STAR_5`: Five pointed star shape. Corresponds to ECMA-376 ST_ShapeType 'star5'
#' - `STAR_6`: Six pointed star shape. Corresponds to ECMA-376 ST_ShapeType 'star6'
#' - `STAR_7`: Seven pointed star shape. Corresponds to ECMA-376 ST_ShapeType 'star7'
#' - `STAR_8`: Eight pointed star shape. Corresponds to ECMA-376 ST_ShapeType 'star8'
#' - `STRIPED_RIGHT_ARROW`: Striped right arrow shape. Corresponds to ECMA-376 ST_ShapeType 'stripedRightArrow'
#' - `SUN`: Sun shape. Corresponds to ECMA-376 ST_ShapeType 'sun'
#' - `TRAPEZOID`: Trapezoid shape. Corresponds to ECMA-376 ST_ShapeType 'trapezoid'
#' - `TRIANGLE`: Triangle shape. Corresponds to ECMA-376 ST_ShapeType 'triangle'
#' - `UP_ARROW`: Up arrow shape. Corresponds to ECMA-376 ST_ShapeType 'upArrow'
#' - `UP_ARROW_CALLOUT`: Callout up arrow shape. Corresponds to ECMA-376 ST_ShapeType 'upArrowCallout'
#' - `UP_DOWN_ARROW`: Up down arrow shape. Corresponds to ECMA-376 ST_ShapeType 'upDownArrow'
#' - `UTURN_ARROW`: U-turn arrow shape. Corresponds to ECMA-376 ST_ShapeType 'uturnArrow'
#' - `VERTICAL_SCROLL`: Vertical scroll shape. Corresponds to ECMA-376 ST_ShapeType 'verticalScroll'
#' - `WAVE`: Wave shape. Corresponds to ECMA-376 ST_ShapeType 'wave'
#' - `WEDGE_ELLIPSE_CALLOUT`: Callout wedge ellipse shape. Corresponds to ECMA-376 ST_ShapeType 'wedgeEllipseCallout'
#' - `WEDGE_RECTANGLE_CALLOUT`: Callout wedge rectangle shape. Corresponds to ECMA-376 ST_ShapeType 'wedgeRectCallout'
#' - `WEDGE_ROUND_RECTANGLE_CALLOUT`: Callout wedge round rectangle shape. Corresponds to ECMA-376 ST_ShapeType 'wedgeRoundRectCallout'
#' - `FLOW_CHART_ALTERNATE_PROCESS`: Alternate process flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartAlternateProcess'
#' - `FLOW_CHART_COLLATE`: Collate flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartCollate'
#' - `FLOW_CHART_CONNECTOR`: Connector flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartConnector'
#' - `FLOW_CHART_DECISION`: Decision flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartDecision'
#' - `FLOW_CHART_DELAY`: Delay flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartDelay'
#' - `FLOW_CHART_DISPLAY`: Display flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartDisplay'
#' - `FLOW_CHART_DOCUMENT`: Document flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartDocument'
#' - `FLOW_CHART_EXTRACT`: Extract flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartExtract'
#' - `FLOW_CHART_INPUT_OUTPUT`: Input output flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartInputOutput'
#' - `FLOW_CHART_INTERNAL_STORAGE`: Internal storage flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartInternalStorage'
#' - `FLOW_CHART_MAGNETIC_DISK`: Magnetic disk flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartMagneticDisk'
#' - `FLOW_CHART_MAGNETIC_DRUM`: Magnetic drum flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartMagneticDrum'
#' - `FLOW_CHART_MAGNETIC_TAPE`: Magnetic tape flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartMagneticTape'
#' - `FLOW_CHART_MANUAL_INPUT`: Manual input flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartManualInput'
#' - `FLOW_CHART_MANUAL_OPERATION`: Manual operation flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartManualOperation'
#' - `FLOW_CHART_MERGE`: Merge flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartMerge'
#' - `FLOW_CHART_MULTIDOCUMENT`: Multi-document flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartMultidocument'
#' - `FLOW_CHART_OFFLINE_STORAGE`: Offline storage flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartOfflineStorage'
#' - `FLOW_CHART_OFFPAGE_CONNECTOR`: Off-page connector flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartOffpageConnector'
#' - `FLOW_CHART_ONLINE_STORAGE`: Online storage flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartOnlineStorage'
#' - `FLOW_CHART_OR`: Or flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartOr'
#' - `FLOW_CHART_PREDEFINED_PROCESS`: Predefined process flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartPredefinedProcess'
#' - `FLOW_CHART_PREPARATION`: Preparation flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartPreparation'
#' - `FLOW_CHART_PROCESS`: Process flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartProcess'
#' - `FLOW_CHART_PUNCHED_CARD`: Punched card flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartPunchedCard'
#' - `FLOW_CHART_PUNCHED_TAPE`: Punched tape flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartPunchedTape'
#' - `FLOW_CHART_SORT`: Sort flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartSort'
#' - `FLOW_CHART_SUMMING_JUNCTION`: Summing junction flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartSummingJunction'
#' - `FLOW_CHART_TERMINATOR`: Terminator flow shape. Corresponds to ECMA-376 ST_ShapeType 'flowChartTerminator'
#' - `ARROW_EAST`: East arrow shape.
#' - `ARROW_NORTH_EAST`: Northeast arrow shape.
#' - `ARROW_NORTH`: North arrow shape.
#' - `SPEECH`: Speech shape.
#' - `STARBURST`: Star burst shape.
#' - `TEARDROP`: Teardrop shape. Corresponds to ECMA-376 ST_ShapeType 'teardrop'
#' - `ELLIPSE_RIBBON`: Ellipse ribbon shape. Corresponds to ECMA-376 ST_ShapeType 'ellipseRibbon'
#' - `ELLIPSE_RIBBON_2`: Ellipse ribbon 2 shape. Corresponds to ECMA-376 ST_ShapeType 'ellipseRibbon2'
#' - `CLOUD_CALLOUT`: Callout cloud shape. Corresponds to ECMA-376 ST_ShapeType 'cloudCallout'
#' - `CUSTOM`: Custom shape.
#'
#' @return CreateShapeRequest object
#'
#' @noRd
CreateShapeRequest <- function(
    objectId = NULL,
    elementProperties = NULL,
    shapeType = NULL) {
  checkmate::assert_choice(shapeType, c("TYPE_UNSPECIFIED", "TEXT_BOX", "RECTANGLE", "ROUND_RECTANGLE", "ELLIPSE", "ARC", "BENT_ARROW", "BENT_UP_ARROW", "BEVEL", "BLOCK_ARC", "BRACE_PAIR", "BRACKET_PAIR", "CAN", "CHEVRON", "CHORD", "CLOUD", "CORNER", "CUBE", "CURVED_DOWN_ARROW", "CURVED_LEFT_ARROW", "CURVED_RIGHT_ARROW", "CURVED_UP_ARROW", "DECAGON", "DIAGONAL_STRIPE", "DIAMOND", "DODECAGON", "DONUT", "DOUBLE_WAVE", "DOWN_ARROW", "DOWN_ARROW_CALLOUT", "FOLDED_CORNER", "FRAME", "HALF_FRAME", "HEART", "HEPTAGON", "HEXAGON", "HOME_PLATE", "HORIZONTAL_SCROLL", "IRREGULAR_SEAL_1", "IRREGULAR_SEAL_2", "LEFT_ARROW", "LEFT_ARROW_CALLOUT", "LEFT_BRACE", "LEFT_BRACKET", "LEFT_RIGHT_ARROW", "LEFT_RIGHT_ARROW_CALLOUT", "LEFT_RIGHT_UP_ARROW", "LEFT_UP_ARROW", "LIGHTNING_BOLT", "MATH_DIVIDE", "MATH_EQUAL", "MATH_MINUS", "MATH_MULTIPLY", "MATH_NOT_EQUAL", "MATH_PLUS", "MOON", "NO_SMOKING", "NOTCHED_RIGHT_ARROW", "OCTAGON", "PARALLELOGRAM", "PENTAGON", "PIE", "PLAQUE", "PLUS", "QUAD_ARROW", "QUAD_ARROW_CALLOUT", "RIBBON", "RIBBON_2", "RIGHT_ARROW", "RIGHT_ARROW_CALLOUT", "RIGHT_BRACE", "RIGHT_BRACKET", "ROUND_1_RECTANGLE", "ROUND_2_DIAGONAL_RECTANGLE", "ROUND_2_SAME_RECTANGLE", "RIGHT_TRIANGLE", "SMILEY_FACE", "SNIP_1_RECTANGLE", "SNIP_2_DIAGONAL_RECTANGLE", "SNIP_2_SAME_RECTANGLE", "SNIP_ROUND_RECTANGLE", "STAR_10", "STAR_12", "STAR_16", "STAR_24", "STAR_32", "STAR_4", "STAR_5", "STAR_6", "STAR_7", "STAR_8", "STRIPED_RIGHT_ARROW", "SUN", "TRAPEZOID", "TRIANGLE", "UP_ARROW", "UP_ARROW_CALLOUT", "UP_DOWN_ARROW", "UTURN_ARROW", "VERTICAL_SCROLL", "WAVE", "WEDGE_ELLIPSE_CALLOUT", "WEDGE_RECTANGLE_CALLOUT", "WEDGE_ROUND_RECTANGLE_CALLOUT", "FLOW_CHART_ALTERNATE_PROCESS", "FLOW_CHART_COLLATE", "FLOW_CHART_CONNECTOR", "FLOW_CHART_DECISION", "FLOW_CHART_DELAY", "FLOW_CHART_DISPLAY", "FLOW_CHART_DOCUMENT", "FLOW_CHART_EXTRACT", "FLOW_CHART_INPUT_OUTPUT", "FLOW_CHART_INTERNAL_STORAGE", "FLOW_CHART_MAGNETIC_DISK", "FLOW_CHART_MAGNETIC_DRUM", "FLOW_CHART_MAGNETIC_TAPE", "FLOW_CHART_MANUAL_INPUT", "FLOW_CHART_MANUAL_OPERATION", "FLOW_CHART_MERGE", "FLOW_CHART_MULTIDOCUMENT", "FLOW_CHART_OFFLINE_STORAGE", "FLOW_CHART_OFFPAGE_CONNECTOR", "FLOW_CHART_ONLINE_STORAGE", "FLOW_CHART_OR", "FLOW_CHART_PREDEFINED_PROCESS", "FLOW_CHART_PREPARATION", "FLOW_CHART_PROCESS", "FLOW_CHART_PUNCHED_CARD", "FLOW_CHART_PUNCHED_TAPE", "FLOW_CHART_SORT", "FLOW_CHART_SUMMING_JUNCTION", "FLOW_CHART_TERMINATOR", "ARROW_EAST", "ARROW_NORTH_EAST", "ARROW_NORTH", "SPEECH", "STARBURST", "TEARDROP", "ELLIPSE_RIBBON", "ELLIPSE_RIBBON_2", "CLOUD_CALLOUT", "CUSTOM"), null.ok = TRUE)
  structure(
    list(
      "objectId" = objectId,
      "elementProperties" = elementProperties,
      "shapeType" = shapeType
    ),
    class = c("CreateShapeRequest", "list")
  )
}

#' PageElementProperties Object
#'
#' @details
#' Common properties for a page element. Note: When you initially create a PageElement, the API may modify the values of both `size` and `transform`, but the visual size will be unchanged.
#'
#' @param pageObjectId (string)
#'  The object ID of the page where the element is located.
#' @param size ([Size])
#'  The size of the element.
#' @param transform ([AffineTransform])
#'  The transform for the element.
#'
#' @return PageElementProperties object
#'
#' @noRd
PageElementProperties <- function(
    pageObjectId = NULL,
    size = NULL,
    transform = NULL) {
  structure(
    list(
      "pageObjectId" = pageObjectId,
      "size" = size,
      "transform" = transform
    ),
    class = c("PageElementProperties", "list")
  )
}

#' CreateTableRequest Object
#'
#' @details
#' Creates a new table.
#'
#' @param objectId (string)
#'  A user-supplied object ID. If you specify an ID, it must be unique among all pages and page elements in the presentation. The ID must start with an alphanumeric character or an underscore (matches regex `[a-zA-Z0-9_]`); remaining characters may include those as well as a hyphen or colon (matches regex `[a-zA-Z0-9_-:]`). The length of the ID must not be less than 5 or greater than 50. If you don't specify an ID, a unique one is generated.
#' @param elementProperties ([PageElementProperties])
#'  The element properties for the table. The table will be created at the provided size, subject to a minimum size. If no size is provided, the table will be automatically sized. Table transforms must have a scale of 1 and no shear components. If no transform is provided, the table will be centered on the page.
#' @param rows (integer)
#'  Number of rows in the table.
#' @param columns (integer)
#'  Number of columns in the table.
#'
#' @return CreateTableRequest object
#'
#' @noRd
CreateTableRequest <- function(
    objectId = NULL,
    elementProperties = NULL,
    rows = NULL,
    columns = NULL) {
  structure(
    list(
      "objectId" = objectId,
      "elementProperties" = elementProperties,
      "rows" = rows,
      "columns" = columns
    ),
    class = c("CreateTableRequest", "list")
  )
}

#' InsertTextRequest Object
#'
#' @details
#' Inserts text into a shape or a table cell.
#'
#' @param objectId (string)
#'  The object ID of the shape or table where the text will be inserted.
#' @param cellLocation ([TableCellLocation])
#'  The optional table cell location if the text is to be inserted into a table cell. If present, the object_id must refer to a table.
#' @param text (string)
#'  The text to be inserted. Inserting a newline character will implicitly create a new ParagraphMarker at that index. The paragraph style of the new paragraph will be copied from the paragraph at the current insertion index, including lists and bullets. Text styles for inserted text will be determined automatically, generally preserving the styling of neighboring text. In most cases, the text will be added to the TextRun that exists at the insertion index. Some control characters (U+0000-U+0008, U+000C-U+001F) and characters from the Unicode Basic Multilingual Plane Private Use Area (U+E000-U+F8FF) will be stripped out of the inserted text.
#' @param insertionIndex (integer)
#'  The index where the text will be inserted, in Unicode code units, based on TextElement indexes. The index is zero-based and is computed from the start of the string. The index may be adjusted to prevent insertions inside Unicode grapheme clusters. In these cases, the text will be inserted immediately after the grapheme cluster.
#'
#' @return InsertTextRequest object
#'
#' @noRd
InsertTextRequest <- function(
    objectId = NULL,
    cellLocation = NULL,
    text = NULL,
    insertionIndex = NULL) {
  structure(
    list(
      "objectId" = objectId,
      "cellLocation" = cellLocation,
      "text" = text,
      "insertionIndex" = insertionIndex
    ),
    class = c("InsertTextRequest", "list")
  )
}

#' InsertTableRowsRequest Object
#'
#' @details
#' Inserts rows into a table.
#'
#' @param tableObjectId (string)
#'  The table to insert rows into.
#' @param cellLocation ([TableCellLocation])
#'  The reference table cell location from which rows will be inserted. A new row will be inserted above (or below) the row where the reference cell is. If the reference cell is a merged cell, a new row will be inserted above (or below) the merged cell.
#' @param insertBelow (boolean)
#'  Whether to insert new rows below the reference cell location. - `True`: insert below the cell. - `False`: insert above the cell.
#' @param number (integer)
#'  The number of rows to be inserted. Maximum 20 per request.
#'
#' @return InsertTableRowsRequest object
#'
#' @noRd
InsertTableRowsRequest <- function(
    tableObjectId = NULL,
    cellLocation = NULL,
    insertBelow = NULL,
    number = NULL) {
  structure(
    list(
      "tableObjectId" = tableObjectId,
      "cellLocation" = cellLocation,
      "insertBelow" = insertBelow,
      "number" = number
    ),
    class = c("InsertTableRowsRequest", "list")
  )
}

#' InsertTableColumnsRequest Object
#'
#' @details
#' Inserts columns into a table. Other columns in the table will be resized to fit the new column.
#'
#' @param tableObjectId (string)
#'  The table to insert columns into.
#' @param cellLocation ([TableCellLocation])
#'  The reference table cell location from which columns will be inserted. A new column will be inserted to the left (or right) of the column where the reference cell is. If the reference cell is a merged cell, a new column will be inserted to the left (or right) of the merged cell.
#' @param insertRight (boolean)
#'  Whether to insert new columns to the right of the reference cell location. - `True`: insert to the right. - `False`: insert to the left.
#' @param number (integer)
#'  The number of columns to be inserted. Maximum 20 per request.
#'
#' @return InsertTableColumnsRequest object
#'
#' @noRd
InsertTableColumnsRequest <- function(
    tableObjectId = NULL,
    cellLocation = NULL,
    insertRight = NULL,
    number = NULL) {
  structure(
    list(
      "tableObjectId" = tableObjectId,
      "cellLocation" = cellLocation,
      "insertRight" = insertRight,
      "number" = number
    ),
    class = c("InsertTableColumnsRequest", "list")
  )
}

#' DeleteTableRowRequest Object
#'
#' @details
#' Deletes a row from a table.
#'
#' @param tableObjectId (string)
#'  The table to delete rows from.
#' @param cellLocation ([TableCellLocation])
#'  The reference table cell location from which a row will be deleted. The row this cell spans will be deleted. If this is a merged cell, multiple rows will be deleted. If no rows remain in the table after this deletion, the whole table is deleted.
#'
#' @return DeleteTableRowRequest object
#'
#' @noRd
DeleteTableRowRequest <- function(
    tableObjectId = NULL,
    cellLocation = NULL) {
  structure(
    list(
      "tableObjectId" = tableObjectId,
      "cellLocation" = cellLocation
    ),
    class = c("DeleteTableRowRequest", "list")
  )
}

#' DeleteTableColumnRequest Object
#'
#' @details
#' Deletes a column from a table.
#'
#' @param tableObjectId (string)
#'  The table to delete columns from.
#' @param cellLocation ([TableCellLocation])
#'  The reference table cell location from which a column will be deleted. The column this cell spans will be deleted. If this is a merged cell, multiple columns will be deleted. If no columns remain in the table after this deletion, the whole table is deleted.
#'
#' @return DeleteTableColumnRequest object
#'
#' @noRd
DeleteTableColumnRequest <- function(
    tableObjectId = NULL,
    cellLocation = NULL) {
  structure(
    list(
      "tableObjectId" = tableObjectId,
      "cellLocation" = cellLocation
    ),
    class = c("DeleteTableColumnRequest", "list")
  )
}

#' ReplaceAllTextRequest Object
#'
#' @details
#' Replaces all instances of text matching a criteria with replace text.
#'
#' @param replaceText (string)
#'  The text that will replace the matched text.
#' @param pageObjectIds (list of [string] objects)
#'  If non-empty, limits the matches to page elements only on the given pages. Returns a 400 bad request error if given the page object ID of a notes master, or if a page with that object ID doesn't exist in the presentation.
#' @param containsText ([SubstringMatchCriteria])
#'  Finds text in a shape matching this substring.
#'
#' @return ReplaceAllTextRequest object
#'
#' @noRd
ReplaceAllTextRequest <- function(
    replaceText = NULL,
    pageObjectIds = NULL,
    containsText = NULL) {
  structure(
    list(
      "replaceText" = replaceText,
      "pageObjectIds" = pageObjectIds,
      "containsText" = containsText
    ),
    class = c("ReplaceAllTextRequest", "list")
  )
}

#' SubstringMatchCriteria Object
#'
#' @details
#' A criteria that matches a specific string of text in a shape or table.
#'
#' @param text (string)
#'  The text to search for in the shape or table.
#' @param matchCase (boolean)
#'  Indicates whether the search should respect case: - `True`: the search is case sensitive. - `False`: the search is case insensitive.
#'
#' @return SubstringMatchCriteria object
#'
#' @noRd
SubstringMatchCriteria <- function(
    text = NULL,
    matchCase = NULL) {
  structure(
    list(
      "text" = text,
      "matchCase" = matchCase
    ),
    class = c("SubstringMatchCriteria", "list")
  )
}

#' DeleteObjectRequest Object
#'
#' @details
#' Deletes an object, either pages or page elements, from the presentation.
#'
#' @param objectId (string)
#'  The object ID of the page or page element to delete. If after a delete operation a group contains only 1 or no page elements, the group is also deleted. If a placeholder is deleted on a layout, any empty inheriting placeholders are also deleted.
#'
#' @return DeleteObjectRequest object
#'
#' @noRd
DeleteObjectRequest <- function(objectId = NULL) {
  structure(
    list(
      "objectId" = objectId
    ),
    class = c("DeleteObjectRequest", "list")
  )
}

#' UpdatePageElementTransformRequest Object
#'
#' @details
#' Updates the transform of a page element. Updating the transform of a group will change the absolute transform of the page elements in that group, which can change their visual appearance. See the documentation for PageElement.transform for more details.
#'
#' @param objectId (string)
#'  The object ID of the page element to update.
#' @param transform ([AffineTransform])
#'  The input transform matrix used to update the page element.
#' @param applyMode (string)
#'  The apply mode of the transform update.
#' - `APPLY_MODE_UNSPECIFIED`: Unspecified mode.
#' - `RELATIVE`: Applies the new AffineTransform matrix to the existing one, and replaces the existing one with the resulting concatenation.
#' - `ABSOLUTE`: Replaces the existing AffineTransform matrix with the new one.
#'
#' @return UpdatePageElementTransformRequest object
#'
#' @noRd
UpdatePageElementTransformRequest <- function(
    objectId = NULL,
    transform = NULL,
    applyMode = NULL) {
  checkmate::assert_choice(applyMode, c("APPLY_MODE_UNSPECIFIED", "RELATIVE", "ABSOLUTE"), null.ok = TRUE)
  structure(
    list(
      "objectId" = objectId,
      "transform" = transform,
      "applyMode" = applyMode
    ),
    class = c("UpdatePageElementTransformRequest", "list")
  )
}

#' UpdateSlidesPositionRequest Object
#'
#' @details
#' Updates the position of slides in the presentation.
#'
#' @param slideObjectIds (list of [string] objects)
#'  The IDs of the slides in the presentation that should be moved. The slides in this list must be in existing presentation order, without duplicates.
#' @param insertionIndex (integer)
#'  The index where the slides should be inserted, based on the slide arrangement before the move takes place. Must be between zero and the number of slides in the presentation, inclusive.
#'
#' @return UpdateSlidesPositionRequest object
#'
#' @noRd
UpdateSlidesPositionRequest <- function(
    slideObjectIds = NULL,
    insertionIndex = NULL) {
  structure(
    list(
      "slideObjectIds" = slideObjectIds,
      "insertionIndex" = insertionIndex
    ),
    class = c("UpdateSlidesPositionRequest", "list")
  )
}

#' DeleteTextRequest Object
#'
#' @details
#' Deletes text from a shape or a table cell.
#'
#' @param objectId (string)
#'  The object ID of the shape or table from which the text will be deleted.
#' @param cellLocation ([TableCellLocation])
#'  The optional table cell location if the text is to be deleted from a table cell. If present, the object_id must refer to a table.
#' @param textRange ([Range])
#'  The range of text to delete, based on TextElement indexes. There is always an implicit newline character at the end of a shape's or table cell's text that cannot be deleted. `Range.Type.ALL` will use the correct bounds, but care must be taken when specifying explicit bounds for range types `FROM_START_INDEX` and `FIXED_RANGE`. For example, if the text is "ABC", followed by an implicit newline, then the maximum value is 2 for `text_range.start_index` and 3 for `text_range.end_index`. Deleting text that crosses a paragraph boundary may result in changes to paragraph styles and lists as the two paragraphs are merged. Ranges that include only one code unit of a surrogate pair are expanded to include both code units.
#'
#' @return DeleteTextRequest object
#'
#' @noRd
DeleteTextRequest <- function(
    objectId = NULL,
    cellLocation = NULL,
    textRange = NULL) {
  structure(
    list(
      "objectId" = objectId,
      "cellLocation" = cellLocation,
      "textRange" = textRange
    ),
    class = c("DeleteTextRequest", "list")
  )
}

#' Range Object
#'
#' @details
#' Specifies a contiguous range of an indexed collection, such as characters in text.
#'
#' @param startIndex (integer)
#'  The optional zero-based index of the beginning of the collection. Required for `FIXED_RANGE` and `FROM_START_INDEX` ranges.
#' @param endIndex (integer)
#'  The optional zero-based index of the end of the collection. Required for `FIXED_RANGE` ranges.
#' @param type (string)
#'  The type of range.
#' - `RANGE_TYPE_UNSPECIFIED`: Unspecified range type. This value must not be used.
#' - `FIXED_RANGE`: A fixed range. Both the `start_index` and `end_index` must be specified.
#' - `FROM_START_INDEX`: Starts the range at `start_index` and continues until the end of the collection. The `end_index` must not be specified.
#' - `ALL`: Sets the range to be the whole length of the collection. Both the `start_index` and the `end_index` must not be specified.
#'
#' @return Range object
#'
#' @noRd
Range <- function(
    startIndex = NULL,
    endIndex = NULL,
    type = NULL) {
  checkmate::assert_choice(type, c("RANGE_TYPE_UNSPECIFIED", "FIXED_RANGE", "FROM_START_INDEX", "ALL"), null.ok = TRUE)
  structure(
    list(
      "startIndex" = startIndex,
      "endIndex" = endIndex,
      "type" = type
    ),
    class = c("Range", "list")
  )
}

#' CreateImageRequest Object
#'
#' @details
#' Creates an image.
#'
#' @param objectId (string)
#'  A user-supplied object ID. If you specify an ID, it must be unique among all pages and page elements in the presentation. The ID must start with an alphanumeric character or an underscore (matches regex `[a-zA-Z0-9_]`); remaining characters may include those as well as a hyphen or colon (matches regex `[a-zA-Z0-9_-:]`). The length of the ID must not be less than 5 or greater than 50. If you don't specify an ID, a unique one is generated.
#' @param elementProperties ([PageElementProperties])
#'  The element properties for the image. When the aspect ratio of the provided size does not match the image aspect ratio, the image is scaled and centered with respect to the size in order to maintain the aspect ratio. The provided transform is applied after this operation. The PageElementProperties.size property is optional. If you don't specify the size, the default size of the image is used. The PageElementProperties.transform property is optional. If you don't specify a transform, the image will be placed at the top-left corner of the page.
#' @param url (string)
#'  The image URL. The image is fetched once at insertion time and a copy is stored for display inside the presentation. Images must be less than 50 MB in size, can't exceed 25 megapixels, and must be in one of PNG, JPEG, or GIF formats. The provided URL must be publicly accessible and up to 2 KB in length. The URL is saved with the image, and exposed through the Image.source_url field.
#'
#' @return CreateImageRequest object
#'
#' @noRd
CreateImageRequest <- function(
    objectId = NULL,
    elementProperties = NULL,
    url = NULL) {
  structure(
    list(
      "objectId" = objectId,
      "elementProperties" = elementProperties,
      "url" = url
    ),
    class = c("CreateImageRequest", "list")
  )
}

#' CreateVideoRequest Object
#'
#' @details
#' Creates a video. NOTE: Creating a video from Google Drive requires that the requesting app have at least one of the drive, drive.readonly, or drive.file OAuth scopes.
#'
#' @param objectId (string)
#'  A user-supplied object ID. If you specify an ID, it must be unique among all pages and page elements in the presentation. The ID must start with an alphanumeric character or an underscore (matches regex `[a-zA-Z0-9_]`); remaining characters may include those as well as a hyphen or colon (matches regex `[a-zA-Z0-9_-:]`). The length of the ID must not be less than 5 or greater than 50. If you don't specify an ID, a unique one is generated.
#' @param elementProperties ([PageElementProperties])
#'  The element properties for the video. The PageElementProperties.size property is optional. If you don't specify a size, a default size is chosen by the server. The PageElementProperties.transform property is optional. The transform must not have shear components. If you don't specify a transform, the video will be placed at the top left corner of the page.
#' @param source (string)
#'  The video source.
#' - `SOURCE_UNSPECIFIED`: The video source is unspecified.
#' - `YOUTUBE`: The video source is YouTube.
#' - `DRIVE`: The video source is Google Drive.
#' @param id (string)
#'  The video source's unique identifier for this video. e.g. For YouTube video https://www.youtube.com/watch?v=7U3axjORYZ0, the ID is 7U3axjORYZ0. For a Google Drive video https://drive.google.com/file/d/1xCgQLFTJi5_Xl8DgW_lcUYq5e-q6Hi5Q the ID is 1xCgQLFTJi5_Xl8DgW_lcUYq5e-q6Hi5Q. To access a Google Drive video file, you might need to add a resource key to the HTTP header for a subset of old files. For more information, see [Access link-shared files using resource keys](https://developers.google.com/drive/api/v3/resource-keys).
#'
#' @return CreateVideoRequest object
#'
#' @noRd
CreateVideoRequest <- function(
    objectId = NULL,
    elementProperties = NULL,
    source = NULL,
    id = NULL) {
  checkmate::assert_choice(source, c("SOURCE_UNSPECIFIED", "YOUTUBE", "DRIVE"), null.ok = TRUE)
  structure(
    list(
      "objectId" = objectId,
      "elementProperties" = elementProperties,
      "source" = source,
      "id" = id
    ),
    class = c("CreateVideoRequest", "list")
  )
}

#' CreateSheetsChartRequest Object
#'
#' @details
#' Creates an embedded Google Sheets chart. NOTE: Chart creation requires at least one of the spreadsheets.readonly, spreadsheets, drive.readonly, drive.file, or drive OAuth scopes.
#'
#' @param objectId (string)
#'  A user-supplied object ID. If specified, the ID must be unique among all pages and page elements in the presentation. The ID should start with a word character \[a-zA-Z0-9_\] and then followed by any number of the following characters \[a-zA-Z0-9_-:\]. The length of the ID should not be less than 5 or greater than 50. If empty, a unique identifier will be generated.
#' @param elementProperties ([PageElementProperties])
#'  The element properties for the chart. When the aspect ratio of the provided size does not match the chart aspect ratio, the chart is scaled and centered with respect to the size in order to maintain aspect ratio. The provided transform is applied after this operation.
#' @param spreadsheetId (string)
#'  The ID of the Google Sheets spreadsheet that contains the chart. You might need to add a resource key to the HTTP header for a subset of old files. For more information, see [Access link-shared files using resource keys](https://developers.google.com/drive/api/v3/resource-keys).
#' @param chartId (integer)
#'  The ID of the specific chart in the Google Sheets spreadsheet.
#' @param linkingMode (string)
#'  The mode with which the chart is linked to the source spreadsheet. When not specified, the chart will be an image that is not linked.
#' - `NOT_LINKED_IMAGE`: The chart is not associated with the source spreadsheet and cannot be updated. A chart that is not linked will be inserted as an image.
#' - `LINKED`: Linking the chart allows it to be updated, and other collaborators will see a link to the spreadsheet.
#'
#' @return CreateSheetsChartRequest object
#'
#' @noRd
CreateSheetsChartRequest <- function(
    objectId = NULL,
    elementProperties = NULL,
    spreadsheetId = NULL,
    chartId = NULL,
    linkingMode = NULL) {
  checkmate::assert_choice(linkingMode, c("NOT_LINKED_IMAGE", "LINKED"), null.ok = TRUE)
  structure(
    list(
      "objectId" = objectId,
      "elementProperties" = elementProperties,
      "spreadsheetId" = spreadsheetId,
      "chartId" = chartId,
      "linkingMode" = linkingMode
    ),
    class = c("CreateSheetsChartRequest", "list")
  )
}

#' CreateLineRequest Object
#'
#' @details
#' Creates a line.
#'
#' @param objectId (string)
#'  A user-supplied object ID. If you specify an ID, it must be unique among all pages and page elements in the presentation. The ID must start with an alphanumeric character or an underscore (matches regex `[a-zA-Z0-9_]`); remaining characters may include those as well as a hyphen or colon (matches regex `[a-zA-Z0-9_-:]`). The length of the ID must not be less than 5 or greater than 50. If you don't specify an ID, a unique one is generated.
#' @param elementProperties ([PageElementProperties])
#'  The element properties for the line.
#' @param lineCategory (string)
#'  The category of the line to be created. *Deprecated*: use `category` instead. The exact line type created is determined based on the category and how it's routed to connect to other page elements. If you specify both a `category` and a `line_category`, the `category` takes precedence.
#' - `STRAIGHT`: Straight connectors, including straight connector 1. The is the default category when one is not specified.
#' - `BENT`: Bent connectors, including bent connector 2 to 5.
#' - `CURVED`: Curved connectors, including curved connector 2 to 5.
#' @param category (string)
#'  The category of the line to be created. The exact line type created is determined based on the category and how it's routed to connect to other page elements. If you specify both a `category` and a `line_category`, the `category` takes precedence. If you do not specify a value for `category`, but specify a value for `line_category`, then the specified `line_category` value is used. If you do not specify either, then STRAIGHT is used.
#' - `LINE_CATEGORY_UNSPECIFIED`: Unspecified line category.
#' - `STRAIGHT`: Straight connectors, including straight connector 1.
#' - `BENT`: Bent connectors, including bent connector 2 to 5.
#' - `CURVED`: Curved connectors, including curved connector 2 to 5.
#'
#' @return CreateLineRequest object
#'
#' @noRd
CreateLineRequest <- function(
    objectId = NULL,
    elementProperties = NULL,
    lineCategory = NULL,
    category = NULL) {
  checkmate::assert_choice(lineCategory, c("STRAIGHT", "BENT", "CURVED"), null.ok = TRUE)
  checkmate::assert_choice(category, c("LINE_CATEGORY_UNSPECIFIED", "STRAIGHT", "BENT", "CURVED"), null.ok = TRUE)
  structure(
    list(
      "objectId" = objectId,
      "elementProperties" = elementProperties,
      "lineCategory" = lineCategory,
      "category" = category
    ),
    class = c("CreateLineRequest", "list")
  )
}

#' RefreshSheetsChartRequest Object
#'
#' @details
#' Refreshes an embedded Google Sheets chart by replacing it with the latest version of the chart from Google Sheets. NOTE: Refreshing charts requires at least one of the spreadsheets.readonly, spreadsheets, drive.readonly, or drive OAuth scopes.
#'
#' @param objectId (string)
#'  The object ID of the chart to refresh.
#'
#' @return RefreshSheetsChartRequest object
#'
#' @noRd
RefreshSheetsChartRequest <- function(objectId = NULL) {
  structure(
    list(
      "objectId" = objectId
    ),
    class = c("RefreshSheetsChartRequest", "list")
  )
}

#' UpdateShapePropertiesRequest Object
#'
#' @details
#' Update the properties of a Shape.
#'
#' @param objectId (string)
#'  The object ID of the shape the updates are applied to.
#' @param shapeProperties ([ShapeProperties])
#'  The shape properties to update.
#' @param fields (string)
#'  The fields that should be updated. At least one field must be specified. The root `shapeProperties` is implied and should not be specified. A single `"*"` can be used as short-hand for listing every field. For example to update the shape background solid fill color, set `fields` to `"shapeBackgroundFill.solidFill.color"`. To reset a property to its default value, include its field name in the field mask but leave the field itself unset.
#'
#' @return UpdateShapePropertiesRequest object
#'
#' @noRd
UpdateShapePropertiesRequest <- function(
    objectId = NULL,
    shapeProperties = NULL,
    fields = NULL) {
  structure(
    list(
      "objectId" = objectId,
      "shapeProperties" = shapeProperties,
      "fields" = fields
    ),
    class = c("UpdateShapePropertiesRequest", "list")
  )
}

#' UpdateImagePropertiesRequest Object
#'
#' @details
#' Update the properties of an Image.
#'
#' @param objectId (string)
#'  The object ID of the image the updates are applied to.
#' @param imageProperties ([ImageProperties])
#'  The image properties to update.
#' @param fields (string)
#'  The fields that should be updated. At least one field must be specified. The root `imageProperties` is implied and should not be specified. A single `"*"` can be used as short-hand for listing every field. For example to update the image outline color, set `fields` to `"outline.outlineFill.solidFill.color"`. To reset a property to its default value, include its field name in the field mask but leave the field itself unset.
#'
#' @return UpdateImagePropertiesRequest object
#'
#' @noRd
UpdateImagePropertiesRequest <- function(
    objectId = NULL,
    imageProperties = NULL,
    fields = NULL) {
  structure(
    list(
      "objectId" = objectId,
      "imageProperties" = imageProperties,
      "fields" = fields
    ),
    class = c("UpdateImagePropertiesRequest", "list")
  )
}

#' UpdateVideoPropertiesRequest Object
#'
#' @details
#' Update the properties of a Video.
#'
#' @param objectId (string)
#'  The object ID of the video the updates are applied to.
#' @param videoProperties ([VideoProperties])
#'  The video properties to update.
#' @param fields (string)
#'  The fields that should be updated. At least one field must be specified. The root `videoProperties` is implied and should not be specified. A single `"*"` can be used as short-hand for listing every field. For example to update the video outline color, set `fields` to `"outline.outlineFill.solidFill.color"`. To reset a property to its default value, include its field name in the field mask but leave the field itself unset.
#'
#' @return UpdateVideoPropertiesRequest object
#'
#' @noRd
UpdateVideoPropertiesRequest <- function(
    objectId = NULL,
    videoProperties = NULL,
    fields = NULL) {
  structure(
    list(
      "objectId" = objectId,
      "videoProperties" = videoProperties,
      "fields" = fields
    ),
    class = c("UpdateVideoPropertiesRequest", "list")
  )
}

#' UpdatePagePropertiesRequest Object
#'
#' @details
#' Updates the properties of a Page.
#'
#' @param objectId (string)
#'  The object ID of the page the update is applied to.
#' @param pageProperties ([PageProperties])
#'  The page properties to update.
#' @param fields (string)
#'  The fields that should be updated. At least one field must be specified. The root `pageProperties` is implied and should not be specified. A single `"*"` can be used as short-hand for listing every field. For example to update the page background solid fill color, set `fields` to `"pageBackgroundFill.solidFill.color"`. To reset a property to its default value, include its field name in the field mask but leave the field itself unset.
#'
#' @return UpdatePagePropertiesRequest object
#'
#' @noRd
UpdatePagePropertiesRequest <- function(
    objectId = NULL,
    pageProperties = NULL,
    fields = NULL) {
  structure(
    list(
      "objectId" = objectId,
      "pageProperties" = pageProperties,
      "fields" = fields
    ),
    class = c("UpdatePagePropertiesRequest", "list")
  )
}

#' UpdateTableCellPropertiesRequest Object
#'
#' @details
#' Update the properties of a TableCell.
#'
#' @param objectId (string)
#'  The object ID of the table.
#' @param tableRange ([TableRange])
#'  The table range representing the subset of the table to which the updates are applied. If a table range is not specified, the updates will apply to the entire table.
#' @param tableCellProperties ([TableCellProperties])
#'  The table cell properties to update.
#' @param fields (string)
#'  The fields that should be updated. At least one field must be specified. The root `tableCellProperties` is implied and should not be specified. A single `"*"` can be used as short-hand for listing every field. For example to update the table cell background solid fill color, set `fields` to `"tableCellBackgroundFill.solidFill.color"`. To reset a property to its default value, include its field name in the field mask but leave the field itself unset.
#'
#' @return UpdateTableCellPropertiesRequest object
#'
#' @noRd
UpdateTableCellPropertiesRequest <- function(
    objectId = NULL,
    tableRange = NULL,
    tableCellProperties = NULL,
    fields = NULL) {
  structure(
    list(
      "objectId" = objectId,
      "tableRange" = tableRange,
      "tableCellProperties" = tableCellProperties,
      "fields" = fields
    ),
    class = c("UpdateTableCellPropertiesRequest", "list")
  )
}

#' TableRange Object
#'
#' @details
#' A table range represents a reference to a subset of a table. It's important to note that the cells specified by a table range do not necessarily form a rectangle. For example, let's say we have a 3 x 3 table where all the cells of the last row are merged together. The table looks like this: \[ \] A table range with location = (0, 0), row span = 3 and column span = 2 specifies the following cells: x x \[ x x x \]
#'
#' @param location ([TableCellLocation])
#'  The starting location of the table range.
#' @param rowSpan (integer)
#'  The row span of the table range.
#' @param columnSpan (integer)
#'  The column span of the table range.
#'
#' @return TableRange object
#'
#' @noRd
TableRange <- function(
    location = NULL,
    rowSpan = NULL,
    columnSpan = NULL) {
  structure(
    list(
      "location" = location,
      "rowSpan" = rowSpan,
      "columnSpan" = columnSpan
    ),
    class = c("TableRange", "list")
  )
}

#' UpdateLinePropertiesRequest Object
#'
#' @details
#' Updates the properties of a Line.
#'
#' @param objectId (string)
#'  The object ID of the line the update is applied to.
#' @param lineProperties ([LineProperties])
#'  The line properties to update.
#' @param fields (string)
#'  The fields that should be updated. At least one field must be specified. The root `lineProperties` is implied and should not be specified. A single `"*"` can be used as short-hand for listing every field. For example to update the line solid fill color, set `fields` to `"lineFill.solidFill.color"`. To reset a property to its default value, include its field name in the field mask but leave the field itself unset.
#'
#' @return UpdateLinePropertiesRequest object
#'
#' @noRd
UpdateLinePropertiesRequest <- function(
    objectId = NULL,
    lineProperties = NULL,
    fields = NULL) {
  structure(
    list(
      "objectId" = objectId,
      "lineProperties" = lineProperties,
      "fields" = fields
    ),
    class = c("UpdateLinePropertiesRequest", "list")
  )
}

#' CreateParagraphBulletsRequest Object
#'
#' @details
#' Creates bullets for all of the paragraphs that overlap with the given text index range. The nesting level of each paragraph will be determined by counting leading tabs in front of each paragraph. To avoid excess space between the bullet and the corresponding paragraph, these leading tabs are removed by this request. This may change the indices of parts of the text. If the paragraph immediately before paragraphs being updated is in a list with a matching preset, the paragraphs being updated are added to that preceding list.
#'
#' @param objectId (string)
#'  The object ID of the shape or table containing the text to add bullets to.
#' @param cellLocation ([TableCellLocation])
#'  The optional table cell location if the text to be modified is in a table cell. If present, the object_id must refer to a table.
#' @param textRange ([Range])
#'  The range of text to apply the bullet presets to, based on TextElement indexes.
#' @param bulletPreset (string)
#'  The kinds of bullet glyphs to be used. Defaults to the `BULLET_DISC_CIRCLE_SQUARE` preset.
#' - `BULLET_DISC_CIRCLE_SQUARE`: A bulleted list with a `DISC`, `CIRCLE` and `SQUARE` bullet glyph for the first 3 list nesting levels.
#' - `BULLET_DIAMONDX_ARROW3D_SQUARE`: A bulleted list with a `DIAMONDX`, `ARROW3D` and `SQUARE` bullet glyph for the first 3 list nesting levels.
#' - `BULLET_CHECKBOX`: A bulleted list with `CHECKBOX` bullet glyphs for all list nesting levels.
#' - `BULLET_ARROW_DIAMOND_DISC`: A bulleted list with a `ARROW`, `DIAMOND` and `DISC` bullet glyph for the first 3 list nesting levels.
#' - `BULLET_STAR_CIRCLE_SQUARE`: A bulleted list with a `STAR`, `CIRCLE` and `SQUARE` bullet glyph for the first 3 list nesting levels.
#' - `BULLET_ARROW3D_CIRCLE_SQUARE`: A bulleted list with a `ARROW3D`, `CIRCLE` and `SQUARE` bullet glyph for the first 3 list nesting levels.
#' - `BULLET_LEFTTRIANGLE_DIAMOND_DISC`: A bulleted list with a `LEFTTRIANGLE`, `DIAMOND` and `DISC` bullet glyph for the first 3 list nesting levels.
#' - `BULLET_DIAMONDX_HOLLOWDIAMOND_SQUARE`: A bulleted list with a `DIAMONDX`, `HOLLOWDIAMOND` and `SQUARE` bullet glyph for the first 3 list nesting levels.
#' - `BULLET_DIAMOND_CIRCLE_SQUARE`: A bulleted list with a `DIAMOND`, `CIRCLE` and `SQUARE` bullet glyph for the first 3 list nesting levels.
#' - `NUMBERED_DIGIT_ALPHA_ROMAN`: A numbered list with `DIGIT`, `ALPHA` and `ROMAN` numeric glyphs for the first 3 list nesting levels, followed by periods.
#' - `NUMBERED_DIGIT_ALPHA_ROMAN_PARENS`: A numbered list with `DIGIT`, `ALPHA` and `ROMAN` numeric glyphs for the first 3 list nesting levels, followed by parenthesis.
#' - `NUMBERED_DIGIT_NESTED`: A numbered list with `DIGIT` numeric glyphs separated by periods, where each nesting level uses the previous nesting level's glyph as a prefix. For example: '1.', '1.1.', '2.', '2.2.'.
#' - `NUMBERED_UPPERALPHA_ALPHA_ROMAN`: A numbered list with `UPPERALPHA`, `ALPHA` and `ROMAN` numeric glyphs for the first 3 list nesting levels, followed by periods.
#' - `NUMBERED_UPPERROMAN_UPPERALPHA_DIGIT`: A numbered list with `UPPERROMAN`, `UPPERALPHA` and `DIGIT` numeric glyphs for the first 3 list nesting levels, followed by periods.
#' - `NUMBERED_ZERODIGIT_ALPHA_ROMAN`: A numbered list with `ZERODIGIT`, `ALPHA` and `ROMAN` numeric glyphs for the first 3 list nesting levels, followed by periods.
#'
#' @return CreateParagraphBulletsRequest object
#'
#' @noRd
CreateParagraphBulletsRequest <- function(
    objectId = NULL,
    cellLocation = NULL,
    textRange = NULL,
    bulletPreset = NULL) {
  checkmate::assert_choice(bulletPreset, c("BULLET_DISC_CIRCLE_SQUARE", "BULLET_DIAMONDX_ARROW3D_SQUARE", "BULLET_CHECKBOX", "BULLET_ARROW_DIAMOND_DISC", "BULLET_STAR_CIRCLE_SQUARE", "BULLET_ARROW3D_CIRCLE_SQUARE", "BULLET_LEFTTRIANGLE_DIAMOND_DISC", "BULLET_DIAMONDX_HOLLOWDIAMOND_SQUARE", "BULLET_DIAMOND_CIRCLE_SQUARE", "NUMBERED_DIGIT_ALPHA_ROMAN", "NUMBERED_DIGIT_ALPHA_ROMAN_PARENS", "NUMBERED_DIGIT_NESTED", "NUMBERED_UPPERALPHA_ALPHA_ROMAN", "NUMBERED_UPPERROMAN_UPPERALPHA_DIGIT", "NUMBERED_ZERODIGIT_ALPHA_ROMAN"), null.ok = TRUE)
  structure(
    list(
      "objectId" = objectId,
      "cellLocation" = cellLocation,
      "textRange" = textRange,
      "bulletPreset" = bulletPreset
    ),
    class = c("CreateParagraphBulletsRequest", "list")
  )
}

#' ReplaceAllShapesWithImageRequest Object
#'
#' @details
#' Replaces all shapes that match the given criteria with the provided image. The images replacing the shapes are rectangular after being inserted into the presentation and do not take on the forms of the shapes.
#'
#' @param containsText ([SubstringMatchCriteria])
#'  If set, this request will replace all of the shapes that contain the given text.
#' @param imageUrl (string)
#'  The image URL. The image is fetched once at insertion time and a copy is stored for display inside the presentation. Images must be less than 50MB in size, cannot exceed 25 megapixels, and must be in one of PNG, JPEG, or GIF format. The provided URL can be at most 2 kB in length. The URL itself is saved with the image, and exposed via the Image.source_url field.
#' @param replaceMethod (string)
#'  The replace method. *Deprecated*: use `image_replace_method` instead. If you specify both a `replace_method` and an `image_replace_method`, the `image_replace_method` takes precedence.
#' - `CENTER_INSIDE`: Scales and centers the image to fit within the bounds of the original shape and maintains the image's aspect ratio. The rendered size of the image may be smaller than the size of the shape. This is the default method when one is not specified.
#' - `CENTER_CROP`: Scales and centers the image to fill the bounds of the original shape. The image may be cropped in order to fill the shape. The rendered size of the image will be the same as that of the original shape.
#' @param imageReplaceMethod (string)
#'  The image replace method. If you specify both a `replace_method` and an `image_replace_method`, the `image_replace_method` takes precedence. If you do not specify a value for `image_replace_method`, but specify a value for `replace_method`, then the specified `replace_method` value is used. If you do not specify either, then CENTER_INSIDE is used.
#' - `IMAGE_REPLACE_METHOD_UNSPECIFIED`: Unspecified image replace method. This value must not be used.
#' - `CENTER_INSIDE`: Scales and centers the image to fit within the bounds of the original shape and maintains the image's aspect ratio. The rendered size of the image may be smaller than the size of the shape. This is the default method when one is not specified.
#' - `CENTER_CROP`: Scales and centers the image to fill the bounds of the original shape. The image may be cropped in order to fill the shape. The rendered size of the image will be the same as the original shape.
#' @param pageObjectIds (list of [string] objects)
#'  If non-empty, limits the matches to page elements only on the given pages. Returns a 400 bad request error if given the page object ID of a notes page or a notes master, or if a page with that object ID doesn't exist in the presentation.
#'
#' @return ReplaceAllShapesWithImageRequest object
#'
#' @noRd
ReplaceAllShapesWithImageRequest <- function(
    containsText = NULL,
    imageUrl = NULL,
    replaceMethod = NULL,
    imageReplaceMethod = NULL,
    pageObjectIds = NULL) {
  checkmate::assert_choice(replaceMethod, c("CENTER_INSIDE", "CENTER_CROP"), null.ok = TRUE)
  checkmate::assert_choice(imageReplaceMethod, c("IMAGE_REPLACE_METHOD_UNSPECIFIED", "CENTER_INSIDE", "CENTER_CROP"), null.ok = TRUE)
  structure(
    list(
      "containsText" = containsText,
      "imageUrl" = imageUrl,
      "replaceMethod" = replaceMethod,
      "imageReplaceMethod" = imageReplaceMethod,
      "pageObjectIds" = pageObjectIds
    ),
    class = c("ReplaceAllShapesWithImageRequest", "list")
  )
}

#' DuplicateObjectRequest Object
#'
#' @details
#' Duplicates a slide or page element. When duplicating a slide, the duplicate slide will be created immediately following the specified slide. When duplicating a page element, the duplicate will be placed on the same page at the same position as the original.
#'
#' @param objectId (string)
#'  The ID of the object to duplicate.
#' @param objectIds (named list of [string] objects)
#'  The object being duplicated may contain other objects, for example when duplicating a slide or a group page element. This map defines how the IDs of duplicated objects are generated: the keys are the IDs of the original objects and its values are the IDs that will be assigned to the corresponding duplicate object. The ID of the source object's duplicate may be specified in this map as well, using the same value of the `object_id` field as a key and the newly desired ID as the value. All keys must correspond to existing IDs in the presentation. All values must be unique in the presentation and must start with an alphanumeric character or an underscore (matches regex `[a-zA-Z0-9_]`); remaining characters may include those as well as a hyphen or colon (matches regex `[a-zA-Z0-9_-:]`). The length of the new ID must not be less than 5 or greater than 50. If any IDs of source objects are omitted from the map, a new random ID will be assigned. If the map is empty or unset, all duplicate objects will receive a new random ID.
#'
#' @return DuplicateObjectRequest object
#'
#' @noRd
DuplicateObjectRequest <- function(
    objectId = NULL,
    objectIds = NULL) {
  structure(
    list(
      "objectId" = objectId,
      "objectIds" = objectIds
    ),
    class = c("DuplicateObjectRequest", "list")
  )
}

#' UpdateTextStyleRequest Object
#'
#' @details
#' Update the styling of text in a Shape or Table.
#'
#' @param objectId (string)
#'  The object ID of the shape or table with the text to be styled.
#' @param cellLocation ([TableCellLocation])
#'  The location of the cell in the table containing the text to style. If `object_id` refers to a table, `cell_location` must have a value. Otherwise, it must not.
#' @param style ([TextStyle])
#'  The style(s) to set on the text. If the value for a particular style matches that of the parent, that style will be set to inherit. Certain text style changes may cause other changes meant to mirror the behavior of the Slides editor. See the documentation of TextStyle for more information.
#' @param textRange ([Range])
#'  The range of text to style. The range may be extended to include adjacent newlines. If the range fully contains a paragraph belonging to a list, the paragraph's bullet is also updated with the matching text style.
#' @param fields (string)
#'  The fields that should be updated. At least one field must be specified. The root `style` is implied and should not be specified. A single `"*"` can be used as short-hand for listing every field. For example, to update the text style to bold, set `fields` to `"bold"`. To reset a property to its default value, include its field name in the field mask but leave the field itself unset.
#'
#' @return UpdateTextStyleRequest object
#'
#' @noRd
UpdateTextStyleRequest <- function(
    objectId = NULL,
    cellLocation = NULL,
    style = NULL,
    textRange = NULL,
    fields = NULL) {
  structure(
    list(
      "objectId" = objectId,
      "cellLocation" = cellLocation,
      "style" = style,
      "textRange" = textRange,
      "fields" = fields
    ),
    class = c("UpdateTextStyleRequest", "list")
  )
}

#' ReplaceAllShapesWithSheetsChartRequest Object
#'
#' @details
#' Replaces all shapes that match the given criteria with the provided Google Sheets chart. The chart will be scaled and centered to fit within the bounds of the original shape. NOTE: Replacing shapes with a chart requires at least one of the spreadsheets.readonly, spreadsheets, drive.readonly, or drive OAuth scopes.
#'
#' @param containsText ([SubstringMatchCriteria])
#'  The criteria that the shapes must match in order to be replaced. The request will replace all of the shapes that contain the given text.
#' @param spreadsheetId (string)
#'  The ID of the Google Sheets spreadsheet that contains the chart.
#' @param chartId (integer)
#'  The ID of the specific chart in the Google Sheets spreadsheet.
#' @param linkingMode (string)
#'  The mode with which the chart is linked to the source spreadsheet. When not specified, the chart will be an image that is not linked.
#' - `NOT_LINKED_IMAGE`: The chart is not associated with the source spreadsheet and cannot be updated. A chart that is not linked will be inserted as an image.
#' - `LINKED`: Linking the chart allows it to be updated, and other collaborators will see a link to the spreadsheet.
#' @param pageObjectIds (list of [string] objects)
#'  If non-empty, limits the matches to page elements only on the given pages. Returns a 400 bad request error if given the page object ID of a notes page or a notes master, or if a page with that object ID doesn't exist in the presentation.
#'
#' @return ReplaceAllShapesWithSheetsChartRequest object
#'
#' @noRd
ReplaceAllShapesWithSheetsChartRequest <- function(
    containsText = NULL,
    spreadsheetId = NULL,
    chartId = NULL,
    linkingMode = NULL,
    pageObjectIds = NULL) {
  checkmate::assert_choice(linkingMode, c("NOT_LINKED_IMAGE", "LINKED"), null.ok = TRUE)
  structure(
    list(
      "containsText" = containsText,
      "spreadsheetId" = spreadsheetId,
      "chartId" = chartId,
      "linkingMode" = linkingMode,
      "pageObjectIds" = pageObjectIds
    ),
    class = c("ReplaceAllShapesWithSheetsChartRequest", "list")
  )
}

#' DeleteParagraphBulletsRequest Object
#'
#' @details
#' Deletes bullets from all of the paragraphs that overlap with the given text index range. The nesting level of each paragraph will be visually preserved by adding indent to the start of the corresponding paragraph.
#'
#' @param objectId (string)
#'  The object ID of the shape or table containing the text to delete bullets from.
#' @param cellLocation ([TableCellLocation])
#'  The optional table cell location if the text to be modified is in a table cell. If present, the object_id must refer to a table.
#' @param textRange ([Range])
#'  The range of text to delete bullets from, based on TextElement indexes.
#'
#' @return DeleteParagraphBulletsRequest object
#'
#' @noRd
DeleteParagraphBulletsRequest <- function(
    objectId = NULL,
    cellLocation = NULL,
    textRange = NULL) {
  structure(
    list(
      "objectId" = objectId,
      "cellLocation" = cellLocation,
      "textRange" = textRange
    ),
    class = c("DeleteParagraphBulletsRequest", "list")
  )
}

#' UpdateParagraphStyleRequest Object
#'
#' @details
#' Updates the styling for all of the paragraphs within a Shape or Table that overlap with the given text index range.
#'
#' @param objectId (string)
#'  The object ID of the shape or table with the text to be styled.
#' @param cellLocation ([TableCellLocation])
#'  The location of the cell in the table containing the paragraph(s) to style. If `object_id` refers to a table, `cell_location` must have a value. Otherwise, it must not.
#' @param style ([ParagraphStyle])
#'  The paragraph's style.
#' @param textRange ([Range])
#'  The range of text containing the paragraph(s) to style.
#' @param fields (string)
#'  The fields that should be updated. At least one field must be specified. The root `style` is implied and should not be specified. A single `"*"` can be used as short-hand for listing every field. For example, to update the paragraph alignment, set `fields` to `"alignment"`. To reset a property to its default value, include its field name in the field mask but leave the field itself unset.
#'
#' @return UpdateParagraphStyleRequest object
#'
#' @noRd
UpdateParagraphStyleRequest <- function(
    objectId = NULL,
    cellLocation = NULL,
    style = NULL,
    textRange = NULL,
    fields = NULL) {
  structure(
    list(
      "objectId" = objectId,
      "cellLocation" = cellLocation,
      "style" = style,
      "textRange" = textRange,
      "fields" = fields
    ),
    class = c("UpdateParagraphStyleRequest", "list")
  )
}

#' UpdateTableBorderPropertiesRequest Object
#'
#' @details
#' Updates the properties of the table borders in a Table.
#'
#' @param objectId (string)
#'  The object ID of the table.
#' @param tableRange ([TableRange])
#'  The table range representing the subset of the table to which the updates are applied. If a table range is not specified, the updates will apply to the entire table.
#' @param borderPosition (string)
#'  The border position in the table range the updates should apply to. If a border position is not specified, the updates will apply to all borders in the table range.
#' - `ALL`: All borders in the range.
#' - `BOTTOM`: Borders at the bottom of the range.
#' - `INNER`: Borders on the inside of the range.
#' - `INNER_HORIZONTAL`: Horizontal borders on the inside of the range.
#' - `INNER_VERTICAL`: Vertical borders on the inside of the range.
#' - `LEFT`: Borders at the left of the range.
#' - `OUTER`: Borders along the outside of the range.
#' - `RIGHT`: Borders at the right of the range.
#' - `TOP`: Borders at the top of the range.
#' @param tableBorderProperties ([TableBorderProperties])
#'  The table border properties to update.
#' @param fields (string)
#'  The fields that should be updated. At least one field must be specified. The root `tableBorderProperties` is implied and should not be specified. A single `"*"` can be used as short-hand for listing every field. For example to update the table border solid fill color, set `fields` to `"tableBorderFill.solidFill.color"`. To reset a property to its default value, include its field name in the field mask but leave the field itself unset.
#'
#' @return UpdateTableBorderPropertiesRequest object
#'
#' @noRd
UpdateTableBorderPropertiesRequest <- function(
    objectId = NULL,
    tableRange = NULL,
    borderPosition = NULL,
    tableBorderProperties = NULL,
    fields = NULL) {
  checkmate::assert_choice(borderPosition, c("ALL", "BOTTOM", "INNER", "INNER_HORIZONTAL", "INNER_VERTICAL", "LEFT", "OUTER", "RIGHT", "TOP"), null.ok = TRUE)
  structure(
    list(
      "objectId" = objectId,
      "tableRange" = tableRange,
      "borderPosition" = borderPosition,
      "tableBorderProperties" = tableBorderProperties,
      "fields" = fields
    ),
    class = c("UpdateTableBorderPropertiesRequest", "list")
  )
}

#' UpdateTableColumnPropertiesRequest Object
#'
#' @details
#' Updates the properties of a Table column.
#'
#' @param objectId (string)
#'  The object ID of the table.
#' @param columnIndices (list of [integer] objects)
#'  The list of zero-based indices specifying which columns to update. If no indices are provided, all columns in the table will be updated.
#' @param tableColumnProperties ([TableColumnProperties])
#'  The table column properties to update. If the value of `table_column_properties#column_width` in the request is less than 406,400 EMU (32 points), a 400 bad request error is returned.
#' @param fields (string)
#'  The fields that should be updated. At least one field must be specified. The root `tableColumnProperties` is implied and should not be specified. A single `"*"` can be used as short-hand for listing every field. For example to update the column width, set `fields` to `"column_width"`. If '"column_width"' is included in the field mask but the property is left unset, the column width will default to 406,400 EMU (32 points).
#'
#' @return UpdateTableColumnPropertiesRequest object
#'
#' @noRd
UpdateTableColumnPropertiesRequest <- function(
    objectId = NULL,
    columnIndices = NULL,
    tableColumnProperties = NULL,
    fields = NULL) {
  structure(
    list(
      "objectId" = objectId,
      "columnIndices" = columnIndices,
      "tableColumnProperties" = tableColumnProperties,
      "fields" = fields
    ),
    class = c("UpdateTableColumnPropertiesRequest", "list")
  )
}

#' UpdateTableRowPropertiesRequest Object
#'
#' @details
#' Updates the properties of a Table row.
#'
#' @param objectId (string)
#'  The object ID of the table.
#' @param rowIndices (list of [integer] objects)
#'  The list of zero-based indices specifying which rows to update. If no indices are provided, all rows in the table will be updated.
#' @param tableRowProperties ([TableRowProperties])
#'  The table row properties to update.
#' @param fields (string)
#'  The fields that should be updated. At least one field must be specified. The root `tableRowProperties` is implied and should not be specified. A single `"*"` can be used as short-hand for listing every field. For example to update the minimum row height, set `fields` to `"min_row_height"`. If '"min_row_height"' is included in the field mask but the property is left unset, the minimum row height will default to 0.
#'
#' @return UpdateTableRowPropertiesRequest object
#'
#' @noRd
UpdateTableRowPropertiesRequest <- function(
    objectId = NULL,
    rowIndices = NULL,
    tableRowProperties = NULL,
    fields = NULL) {
  structure(
    list(
      "objectId" = objectId,
      "rowIndices" = rowIndices,
      "tableRowProperties" = tableRowProperties,
      "fields" = fields
    ),
    class = c("UpdateTableRowPropertiesRequest", "list")
  )
}

#' MergeTableCellsRequest Object
#'
#' @details
#' Merges cells in a Table.
#'
#' @param objectId (string)
#'  The object ID of the table.
#' @param tableRange ([TableRange])
#'  The table range specifying which cells of the table to merge. Any text in the cells being merged will be concatenated and stored in the upper-left ("head") cell of the range. If the range is non-rectangular (which can occur in some cases where the range covers cells that are already merged), a 400 bad request error is returned.
#'
#' @return MergeTableCellsRequest object
#'
#' @noRd
MergeTableCellsRequest <- function(
    objectId = NULL,
    tableRange = NULL) {
  structure(
    list(
      "objectId" = objectId,
      "tableRange" = tableRange
    ),
    class = c("MergeTableCellsRequest", "list")
  )
}

#' UnmergeTableCellsRequest Object
#'
#' @details
#' Unmerges cells in a Table.
#'
#' @param objectId (string)
#'  The object ID of the table.
#' @param tableRange ([TableRange])
#'  The table range specifying which cells of the table to unmerge. All merged cells in this range will be unmerged, and cells that are already unmerged will not be affected. If the range has no merged cells, the request will do nothing. If there is text in any of the merged cells, the text will remain in the upper-left ("head") cell of the resulting block of unmerged cells.
#'
#' @return UnmergeTableCellsRequest object
#'
#' @noRd
UnmergeTableCellsRequest <- function(
    objectId = NULL,
    tableRange = NULL) {
  structure(
    list(
      "objectId" = objectId,
      "tableRange" = tableRange
    ),
    class = c("UnmergeTableCellsRequest", "list")
  )
}

#' GroupObjectsRequest Object
#'
#' @details
#' Groups objects to create an object group. For example, groups PageElements to create a Group on the same page as all the children.
#'
#' @param groupObjectId (string)
#'  A user-supplied object ID for the group to be created. If you specify an ID, it must be unique among all pages and page elements in the presentation. The ID must start with an alphanumeric character or an underscore (matches regex `[a-zA-Z0-9_]`); remaining characters may include those as well as a hyphen or colon (matches regex `[a-zA-Z0-9_-:]`). The length of the ID must not be less than 5 or greater than 50. If you don't specify an ID, a unique one is generated.
#' @param childrenObjectIds (list of [string] objects)
#'  The object IDs of the objects to group. Only page elements can be grouped. There should be at least two page elements on the same page that are not already in another group. Some page elements, such as videos, tables and placeholders cannot be grouped.
#'
#' @return GroupObjectsRequest object
#'
#' @noRd
GroupObjectsRequest <- function(
    groupObjectId = NULL,
    childrenObjectIds = NULL) {
  structure(
    list(
      "groupObjectId" = groupObjectId,
      "childrenObjectIds" = childrenObjectIds
    ),
    class = c("GroupObjectsRequest", "list")
  )
}

#' UngroupObjectsRequest Object
#'
#' @details
#' Ungroups objects, such as groups.
#'
#' @param objectIds (list of [string] objects)
#'  The object IDs of the objects to ungroup. Only groups that are not inside other groups can be ungrouped. All the groups should be on the same page. The group itself is deleted. The visual sizes and positions of all the children are preserved.
#'
#' @return UngroupObjectsRequest object
#'
#' @noRd
UngroupObjectsRequest <- function(objectIds = NULL) {
  structure(
    list(
      "objectIds" = objectIds
    ),
    class = c("UngroupObjectsRequest", "list")
  )
}

#' UpdatePageElementAltTextRequest Object
#'
#' @details
#' Updates the alt text title and/or description of a page element.
#'
#' @param objectId (string)
#'  The object ID of the page element the updates are applied to.
#' @param title (string)
#'  The updated alt text title of the page element. If unset the existing value will be maintained. The title is exposed to screen readers and other accessibility interfaces. Only use human readable values related to the content of the page element.
#' @param description (string)
#'  The updated alt text description of the page element. If unset the existing value will be maintained. The description is exposed to screen readers and other accessibility interfaces. Only use human readable values related to the content of the page element.
#'
#' @return UpdatePageElementAltTextRequest object
#'
#' @noRd
UpdatePageElementAltTextRequest <- function(
    objectId = NULL,
    title = NULL,
    description = NULL) {
  structure(
    list(
      "objectId" = objectId,
      "title" = title,
      "description" = description
    ),
    class = c("UpdatePageElementAltTextRequest", "list")
  )
}

#' ReplaceImageRequest Object
#'
#' @details
#' Replaces an existing image with a new image. Replacing an image removes some image effects from the existing image.
#'
#' @param imageObjectId (string)
#'  The ID of the existing image that will be replaced. The ID can be retrieved from the response of a get request.
#' @param url (string)
#'  The image URL. The image is fetched once at insertion time and a copy is stored for display inside the presentation. Images must be less than 50MB, cannot exceed 25 megapixels, and must be in PNG, JPEG, or GIF format. The provided URL can't surpass 2 KB in length. The URL is saved with the image, and exposed through the Image.source_url field.
#' @param imageReplaceMethod (string)
#'  The replacement method.
#' - `IMAGE_REPLACE_METHOD_UNSPECIFIED`: Unspecified image replace method. This value must not be used.
#' - `CENTER_INSIDE`: Scales and centers the image to fit within the bounds of the original shape and maintains the image's aspect ratio. The rendered size of the image may be smaller than the size of the shape. This is the default method when one is not specified.
#' - `CENTER_CROP`: Scales and centers the image to fill the bounds of the original shape. The image may be cropped in order to fill the shape. The rendered size of the image will be the same as the original shape.
#'
#' @return ReplaceImageRequest object
#'
#' @noRd
ReplaceImageRequest <- function(
    imageObjectId = NULL,
    url = NULL,
    imageReplaceMethod = NULL) {
  checkmate::assert_choice(imageReplaceMethod, c("IMAGE_REPLACE_METHOD_UNSPECIFIED", "CENTER_INSIDE", "CENTER_CROP"), null.ok = TRUE)
  structure(
    list(
      "imageObjectId" = imageObjectId,
      "url" = url,
      "imageReplaceMethod" = imageReplaceMethod
    ),
    class = c("ReplaceImageRequest", "list")
  )
}

#' UpdateSlidePropertiesRequest Object
#'
#' @details
#' Updates the properties of a Slide.
#'
#' @param objectId (string)
#'  The object ID of the slide the update is applied to.
#' @param slideProperties ([SlideProperties])
#'  The slide properties to update.
#' @param fields (string)
#'  The fields that should be updated. At least one field must be specified. The root 'slideProperties' is implied and should not be specified. A single `"*"` can be used as short-hand for listing every field. For example to update whether a slide is skipped, set `fields` to `"isSkipped"`. To reset a property to its default value, include its field name in the field mask but leave the field itself unset.
#'
#' @return UpdateSlidePropertiesRequest object
#'
#' @noRd
UpdateSlidePropertiesRequest <- function(
    objectId = NULL,
    slideProperties = NULL,
    fields = NULL) {
  structure(
    list(
      "objectId" = objectId,
      "slideProperties" = slideProperties,
      "fields" = fields
    ),
    class = c("UpdateSlidePropertiesRequest", "list")
  )
}

#' UpdatePageElementsZOrderRequest Object
#'
#' @details
#' Updates the Z-order of page elements. Z-order is an ordering of the elements on the page from back to front. The page element in the front may cover the elements that are behind it.
#'
#' @param pageElementObjectIds (list of [string] objects)
#'  The object IDs of the page elements to update. All the page elements must be on the same page and must not be grouped.
#' @param operation (string)
#'  The Z-order operation to apply on the page elements. When applying the operation on multiple page elements, the relative Z-orders within these page elements before the operation is maintained.
#' - `Z_ORDER_OPERATION_UNSPECIFIED`: Unspecified operation.
#' - `BRING_TO_FRONT`: Brings the page elements to the front of the page.
#' - `BRING_FORWARD`: Brings the page elements forward on the page by one element relative to the forwardmost one in the specified page elements.
#' - `SEND_BACKWARD`: Sends the page elements backward on the page by one element relative to the furthest behind one in the specified page elements.
#' - `SEND_TO_BACK`: Sends the page elements to the back of the page.
#'
#' @return UpdatePageElementsZOrderRequest object
#'
#' @noRd
UpdatePageElementsZOrderRequest <- function(
    pageElementObjectIds = NULL,
    operation = NULL) {
  checkmate::assert_choice(operation, c("Z_ORDER_OPERATION_UNSPECIFIED", "BRING_TO_FRONT", "BRING_FORWARD", "SEND_BACKWARD", "SEND_TO_BACK"), null.ok = TRUE)
  structure(
    list(
      "pageElementObjectIds" = pageElementObjectIds,
      "operation" = operation
    ),
    class = c("UpdatePageElementsZOrderRequest", "list")
  )
}

#' UpdateLineCategoryRequest Object
#'
#' @details
#' Updates the category of a line.
#'
#' @param objectId (string)
#'  The object ID of the line the update is applied to. Only a line with a category indicating it is a "connector" can be updated. The line may be rerouted after updating its category.
#' @param lineCategory (string)
#'  The line category to update to. The exact line type is determined based on the category to update to and how it's routed to connect to other page elements.
#' - `LINE_CATEGORY_UNSPECIFIED`: Unspecified line category.
#' - `STRAIGHT`: Straight connectors, including straight connector 1.
#' - `BENT`: Bent connectors, including bent connector 2 to 5.
#' - `CURVED`: Curved connectors, including curved connector 2 to 5.
#'
#' @return UpdateLineCategoryRequest object
#'
#' @noRd
UpdateLineCategoryRequest <- function(
    objectId = NULL,
    lineCategory = NULL) {
  checkmate::assert_choice(lineCategory, c("LINE_CATEGORY_UNSPECIFIED", "STRAIGHT", "BENT", "CURVED"), null.ok = TRUE)
  structure(
    list(
      "objectId" = objectId,
      "lineCategory" = lineCategory
    ),
    class = c("UpdateLineCategoryRequest", "list")
  )
}

#' RerouteLineRequest Object
#'
#' @details
#' Reroutes a line such that it's connected at the two closest connection sites on the connected page elements.
#'
#' @param objectId (string)
#'  The object ID of the line to reroute. Only a line with a category indicating it is a "connector" can be rerouted. The start and end connections of the line must be on different page elements.
#'
#' @return RerouteLineRequest object
#'
#' @noRd
RerouteLineRequest <- function(objectId = NULL) {
  structure(
    list(
      "objectId" = objectId
    ),
    class = c("RerouteLineRequest", "list")
  )
}

#' WriteControl Object
#'
#' @details
#' Provides control over how write requests are executed.
#'
#' @param requiredRevisionId (string)
#'  The revision ID of the presentation required for the write request. If specified and the required revision ID doesn't match the presentation's current revision ID, the request is not processed and returns a 400 bad request error. When a required revision ID is returned in a response, it indicates the revision ID of the document after the request was applied.
#'
#' @return WriteControl object
#'
#' @noRd
WriteControl <- function(requiredRevisionId = NULL) {
  structure(
    list(
      "requiredRevisionId" = requiredRevisionId
    ),
    class = c("WriteControl", "list")
  )
}

#' BatchUpdatePresentationResponse Object
#'
#' @details
#' Response message from a batch update.
#'
#' @param presentationId (string)
#'  The presentation the updates were applied to.
#' @param replies (list of [Response] objects)
#'  The reply of the updates. This maps 1:1 with the updates, although replies to some requests may be empty.
#' @param writeControl ([WriteControl])
#'  The updated write control after applying the request.
#'
#' @return BatchUpdatePresentationResponse object
#'
#' @noRd
BatchUpdatePresentationResponse <- function(
    presentationId = NULL,
    replies = NULL,
    writeControl = NULL) {
  structure(
    list(
      "presentationId" = presentationId,
      "replies" = replies,
      "writeControl" = writeControl
    ),
    class = c("BatchUpdatePresentationResponse", "list")
  )
}

#' Response Object
#'
#' @details
#' A single response from an update.
#'
#' @param createSlide ([CreateSlideResponse])
#'  The result of creating a slide.
#' @param createShape ([CreateShapeResponse])
#'  The result of creating a shape.
#' @param createTable ([CreateTableResponse])
#'  The result of creating a table.
#' @param replaceAllText ([ReplaceAllTextResponse])
#'  The result of replacing text.
#' @param createImage ([CreateImageResponse])
#'  The result of creating an image.
#' @param createVideo ([CreateVideoResponse])
#'  The result of creating a video.
#' @param createSheetsChart ([CreateSheetsChartResponse])
#'  The result of creating a Google Sheets chart.
#' @param createLine ([CreateLineResponse])
#'  The result of creating a line.
#' @param replaceAllShapesWithImage ([ReplaceAllShapesWithImageResponse])
#'  The result of replacing all shapes matching some criteria with an image.
#' @param duplicateObject ([DuplicateObjectResponse])
#'  The result of duplicating an object.
#' @param replaceAllShapesWithSheetsChart ([ReplaceAllShapesWithSheetsChartResponse])
#'  The result of replacing all shapes matching some criteria with a Google Sheets chart.
#' @param groupObjects ([GroupObjectsResponse])
#'  The result of grouping objects.
#'
#' @return Response object
#'
#' @noRd
Response <- function(
    createSlide = NULL,
    createShape = NULL,
    createTable = NULL,
    replaceAllText = NULL,
    createImage = NULL,
    createVideo = NULL,
    createSheetsChart = NULL,
    createLine = NULL,
    replaceAllShapesWithImage = NULL,
    duplicateObject = NULL,
    replaceAllShapesWithSheetsChart = NULL,
    groupObjects = NULL) {
  structure(
    list(
      "createSlide" = createSlide,
      "createShape" = createShape,
      "createTable" = createTable,
      "replaceAllText" = replaceAllText,
      "createImage" = createImage,
      "createVideo" = createVideo,
      "createSheetsChart" = createSheetsChart,
      "createLine" = createLine,
      "replaceAllShapesWithImage" = replaceAllShapesWithImage,
      "duplicateObject" = duplicateObject,
      "replaceAllShapesWithSheetsChart" = replaceAllShapesWithSheetsChart,
      "groupObjects" = groupObjects
    ),
    class = c("Response", "list")
  )
}

#' CreateSlideResponse Object
#'
#' @details
#' The result of creating a slide.
#'
#' @param objectId (string)
#'  The object ID of the created slide.
#'
#' @return CreateSlideResponse object
#'
#' @noRd
CreateSlideResponse <- function(objectId = NULL) {
  structure(
    list(
      "objectId" = objectId
    ),
    class = c("CreateSlideResponse", "list")
  )
}

#' CreateShapeResponse Object
#'
#' @details
#' The result of creating a shape.
#'
#' @param objectId (string)
#'  The object ID of the created shape.
#'
#' @return CreateShapeResponse object
#'
#' @noRd
CreateShapeResponse <- function(objectId = NULL) {
  structure(
    list(
      "objectId" = objectId
    ),
    class = c("CreateShapeResponse", "list")
  )
}

#' CreateTableResponse Object
#'
#' @details
#' The result of creating a table.
#'
#' @param objectId (string)
#'  The object ID of the created table.
#'
#' @return CreateTableResponse object
#'
#' @noRd
CreateTableResponse <- function(objectId = NULL) {
  structure(
    list(
      "objectId" = objectId
    ),
    class = c("CreateTableResponse", "list")
  )
}

#' ReplaceAllTextResponse Object
#'
#' @details
#' The result of replacing text.
#'
#' @param occurrencesChanged (integer)
#'  The number of occurrences changed by replacing all text.
#'
#' @return ReplaceAllTextResponse object
#'
#' @noRd
ReplaceAllTextResponse <- function(occurrencesChanged = NULL) {
  structure(
    list(
      "occurrencesChanged" = occurrencesChanged
    ),
    class = c("ReplaceAllTextResponse", "list")
  )
}

#' CreateImageResponse Object
#'
#' @details
#' The result of creating an image.
#'
#' @param objectId (string)
#'  The object ID of the created image.
#'
#' @return CreateImageResponse object
#'
#' @noRd
CreateImageResponse <- function(objectId = NULL) {
  structure(
    list(
      "objectId" = objectId
    ),
    class = c("CreateImageResponse", "list")
  )
}

#' CreateVideoResponse Object
#'
#' @details
#' The result of creating a video.
#'
#' @param objectId (string)
#'  The object ID of the created video.
#'
#' @return CreateVideoResponse object
#'
#' @noRd
CreateVideoResponse <- function(objectId = NULL) {
  structure(
    list(
      "objectId" = objectId
    ),
    class = c("CreateVideoResponse", "list")
  )
}

#' CreateSheetsChartResponse Object
#'
#' @details
#' The result of creating an embedded Google Sheets chart.
#'
#' @param objectId (string)
#'  The object ID of the created chart.
#'
#' @return CreateSheetsChartResponse object
#'
#' @noRd
CreateSheetsChartResponse <- function(objectId = NULL) {
  structure(
    list(
      "objectId" = objectId
    ),
    class = c("CreateSheetsChartResponse", "list")
  )
}

#' CreateLineResponse Object
#'
#' @details
#' The result of creating a line.
#'
#' @param objectId (string)
#'  The object ID of the created line.
#'
#' @return CreateLineResponse object
#'
#' @noRd
CreateLineResponse <- function(objectId = NULL) {
  structure(
    list(
      "objectId" = objectId
    ),
    class = c("CreateLineResponse", "list")
  )
}

#' ReplaceAllShapesWithImageResponse Object
#'
#' @details
#' The result of replacing shapes with an image.
#'
#' @param occurrencesChanged (integer)
#'  The number of shapes replaced with images.
#'
#' @return ReplaceAllShapesWithImageResponse object
#'
#' @noRd
ReplaceAllShapesWithImageResponse <- function(occurrencesChanged = NULL) {
  structure(
    list(
      "occurrencesChanged" = occurrencesChanged
    ),
    class = c("ReplaceAllShapesWithImageResponse", "list")
  )
}

#' DuplicateObjectResponse Object
#'
#' @details
#' The response of duplicating an object.
#'
#' @param objectId (string)
#'  The ID of the new duplicate object.
#'
#' @return DuplicateObjectResponse object
#'
#' @noRd
DuplicateObjectResponse <- function(objectId = NULL) {
  structure(
    list(
      "objectId" = objectId
    ),
    class = c("DuplicateObjectResponse", "list")
  )
}

#' ReplaceAllShapesWithSheetsChartResponse Object
#'
#' @details
#' The result of replacing shapes with a Google Sheets chart.
#'
#' @param occurrencesChanged (integer)
#'  The number of shapes replaced with charts.
#'
#' @return ReplaceAllShapesWithSheetsChartResponse object
#'
#' @noRd
ReplaceAllShapesWithSheetsChartResponse <- function(occurrencesChanged = NULL) {
  structure(
    list(
      "occurrencesChanged" = occurrencesChanged
    ),
    class = c("ReplaceAllShapesWithSheetsChartResponse", "list")
  )
}

#' GroupObjectsResponse Object
#'
#' @details
#' The result of grouping objects.
#'
#' @param objectId (string)
#'  The object ID of the created group.
#'
#' @return GroupObjectsResponse object
#'
#' @noRd
GroupObjectsResponse <- function(objectId = NULL) {
  structure(
    list(
      "objectId" = objectId
    ),
    class = c("GroupObjectsResponse", "list")
  )
}


#' Thumbnail Object
#'
#' @details
#' The thumbnail of a page.
#'
#' @param width (integer)
#'  The positive width in pixels of the thumbnail image.
#' @param height (integer)
#'  The positive height in pixels of the thumbnail image.
#' @param contentUrl (string)
#'  The content URL of the thumbnail image. The URL to the image has a default lifetime of 30 minutes. This URL is tagged with the account of the requester. Anyone with the URL effectively accesses the image as the original requester. Access to the image may be lost if the presentation's sharing settings change. The mime type of the thumbnail image is the same as specified in the `GetPageThumbnailRequest`.
#'
#' @return Thumbnail object
#'
#' @noRd


Thumbnail <- function(
    width = NULL,
    height = NULL,
    contentUrl = NULL) {
  structure(
    list(
      "width" = width,
      "height" = height,
      "contentUrl" = contentUrl
    ),
    class = c("Thumbnail", "list")
  )
}
