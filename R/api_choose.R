#' Choose Slides presentation
#'
#' Opens a webpage for a user to authenticate with Google and select a presentation. This
#' presentation is then authorised for use with ladder.
#'
#' @return A presentation id
#'
#' @export
#'
#' @examplesIf interactive()
#' \donttest{
#' id <- choose_slides()
#' }
choose_slides <- function() {
  request_url <- "http://localhost:1410/index.html"
  auth_slide_id <- NULL

  server <- httpuv::startServer(
    host = "127.0.0.1",
    port = 1410,
    app = list(
      call = function(req) {
        if (nchar(req$QUERY_STRING)) {
          auth_slide_id <<- sub("?slides=", "", req$QUERY_STRING, fixed = TRUE)
        } else {
          picker_page()
        }
      }
    )
  )
  on.exit(httpuv::stopServer(server))

  message("Waiting for authentication in browser...")
  message("Press Esc/Ctrl + C to abort")
  httr::BROWSE(request_url)
  while (is.null(auth_slide_id)) {
    httpuv::service()
    Sys.sleep(0.001)
  }
  httpuv::service() # to send text back to browser

  if (identical(auth_slide_id, NA)) {
    stop("Presentation authorisation failed.", call. = FALSE)
  }

  message("Presentation authorisation complete.")
  auth_slide_id
}


picker_page <- function() {
  # Refresh token here otherwise Picker API fails
  ladder_token()$auth_token$refresh()

  token <- ladder_token()
  CLIENT_ID <- token$auth_token$client$id
  # Google Picker API only Key
  API_KEY <- paste("AIzaSyAyLt5QNsDtC73", "fbV7ayndchq5iEzyy-k", sep = "_")
  APP_ID <- "1073903696751"
  TOKEN <- token$auth_token$credentials$access_token

  # Convert logo to Base64
  logo_path <- "man/figures/logo.svg"
  logo_base64 <- base64enc::dataURI(file = logo_path, mime = "image/svg+xml")

  body <- gluestick(
    r"--(
<!DOCTYPE html>
<html>
<head>
  <title>Choose Slides for ladder</title>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Bootswatch Flatly Theme -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.1/dist/flatly/bootstrap.min.css">
  <style>
    .container {
      max-width: 800px;
      padding: 2rem;
    }
    .logo-container {
      margin-bottom: 2rem;
      text-align: center;
    }
    .logo {
      max-width: 150px;
      height: auto;
    }
    .btn-primary {
      margin-top: 1rem;
    }
    #content {
      margin-top: 2rem;
      padding: 1rem;
      background-color: #f8f9fa;
      border-radius: 0.25rem;
    }
    .card {
      margin-top: 2rem;
      box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="card">
      <div class="card-body">
        <div class="logo-container">
          <img src="{{logo_base64}}" alt="ladder logo" class="logo">
          <h2 class="mt-3">Choose Slides for ladder</h2>
          <p class="text-muted">Select a Google Slides presentation to use with ladder</p>
        </div>

        <div class="d-grid gap-2">
          <button id="authorize_button" onclick="handleAuthClick()" class="btn btn-primary">Choose Presentation</button>
        </div>

        <div class="alert alert-success mt-3" role="alert" id="status-container" style="display: none;">
          <pre id="content" style="white-space: pre-wrap;"></pre>
        </div>
      </div>
    </div>
  </div>

  <script type="text/javascript">
    // Authorization scopes required by the API; multiple scopes can be
    // included, separated by spaces.
    const SCOPES = 'https://www.googleapis.com/auth/drive.file https://www.googleapis.com/auth/presentations.currentonly';

    // client ID and API key from the Developer Console

    const API_KEY = '{{API_KEY}}';
    const APP_ID = '{{APP_ID}}';
    const RAT = '{{TOKEN}}';

    let tokenClient;
    let accessToken = RAT;

    let accessToken2 = RAT;
    let pickerInited = false;
    let gisInited = false;


    document.getElementById('authorize_button').style.visibility = 'hidden';

    /**
     * Callback after api.js is loaded.
     */
    function gapiLoaded() {
      gapi.load('client:picker', initializePicker);
    }

    /**
     * Callback after the API client is loaded. Loads the
     * discovery doc to initialize the API.
     */
    async function initializePicker() {
      await gapi.client.load('https://www.googleapis.com/discovery/v1/apis/drive/v3/rest');
      pickerInited = true;
      maybeEnableButtons();
    }

    /**
     * Enables user interaction after all libraries are loaded.
     */
    function maybeEnableButtons() {
      if (pickerInited) {
        document.getElementById('authorize_button').style.visibility = 'visible';
      }
    }

    /**
     *  Sign in the user upon button click.
     */
    function handleAuthClick() {
      createPicker();
    }

    //  Create and render a Picker object for searching presentations
    function createPicker() {
      accessToken = RAT;
      const view = new google.picker.View(google.picker.ViewId.PRESENTATIONS);
      const picker = new google.picker.PickerBuilder()
          .setDeveloperKey(API_KEY)
          .setAppId(APP_ID)
          .setOAuthToken(accessToken)
          .addView(view)
          .setCallback(pickerCallback)
          .build();
      picker.setVisible(true);
    }

    /**
     * Displays the file details of the user's selection.
     * @param {object} data - Containers the user selection from the picker
     */
    async function pickerCallback(data) {
      if (data.action === google.picker.Action.PICKED) {
        const document = data[google.picker.Response.DOCUMENTS][0];
        const fileId = document[google.picker.Document.ID];
        const fileURL = document[google.picker.Document.URL];
        let text = `ladder authorised to use\n ${fileURL}\n`;

        console.log(fileId);
        console.log(fileURL);

 // set container with status-container id display visible
        document.getElementById('status-container').style.display = 'block';
        window.document.getElementById('content').innerText = text;

        var xmlhttp = new XMLHttpRequest();   // new HttpRequest instance
        var theUrl = "response?slides=" + fileId;
        xmlhttp.open("GET", theUrl);
        xmlhttp.send();
      }
    }
  </script>
  <script async defer src="https://apis.google.com/js/api.js" onload="gapiLoaded()"></script>
</body>
</html>
)--"
  )

  # return
  list(
    status = 200L,
    headers = list(
      "Content-Type" = "text/html"
    ),
    body = body
  )
}
