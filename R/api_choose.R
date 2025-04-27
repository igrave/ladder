#' Choose Slides presentation
#'
#' Opens a webpage for a user to authenticate with Google and select a presentation. This
#' presentation is then authorised for use with ladder.
#' @param presentation A string containing the presentation link/URL or the presentation ID.
#' @return A presentation id
#'
#' @export
#'
#' @examplesIf interactive()
#' id <- choose_slides()
choose_slides <- function(presentation = NULL) {
  request_url <- "http://localhost:1410/index.html"
  auth_slide_id <- NULL

  # Refresh token here otherwise Picker API fails
  ladder_token()$auth_token$refresh()

  file_id <- extract_id(presentation)

  server <- httpuv::startServer(
    host = "127.0.0.1",
    port = 1410,
    app = list(
      call = function(req) {
        if (nchar(req$QUERY_STRING)) {
          auth_slide_id <<- sub("?slides=", "", req$QUERY_STRING, fixed = TRUE)
        } else {
          picker_page(file_id)
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


picker_page <- function(file_id = "") {
  ladder_token <- ladder_token()
  logo_path <- system.file("help/figures/logo.svg", package = "ladder")

  body <- gluestick(
    src = list(
      API_KEY = paste("AIzaSyAyLt5QNsDtC73", "fbV7ayndchq5iEzyy-k", sep = "_"), # Google Picker API only Key
      APP_ID = "1073903696751",
      TOKEN = ladder_token$auth_token$credentials$access_token,
      SVG_LOGO = paste(readLines(logo_path), collapse = "\n"),
      FILE_ID = file_id
    ),
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
          <div class="logo">{{SVG_LOGO}}</div>
          <h2 class="mt-3">Choose Slides for ladder</h2>
          <p class="text-muted">Select a Google Slides presentation to use with ladder</p>
        </div>

        <div class="d-grid gap-2">
          <button id="authorize_button" onclick="handleAuthClick()" class="btn btn-primary">Choose Presentation</button>
          <div id="response"></div>
        </div>



      </div>
    </div>
  </div>

  <script type="text/javascript">
    // Authorization scopes required by the API; multiple scopes can be
    // included, separated by spaces.
    const SCOPES = 'https://www.googleapis.com/auth/drive.file' +
      ' https://www.googleapis.com/auth/presentations.currentonly';

    // client ID and API key from the Developer Console

    const API_KEY = '{{API_KEY}}';
    const APP_ID = '{{APP_ID}}';
    const RAT = '{{TOKEN}}';


    const FILE_ID = '{{FILE_ID}}';

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
      let view = new google.picker.DocsView(google.picker.ViewId.PRESENTATIONS)
          .setMode(google.picker.DocsViewMode.LIST);

      if (FILE_ID !== "") {
        view = view.setFileIds(FILE_ID);
      }

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
        const fileName = document[google.picker.Document.NAME];
        const iconURL = document[google.picker.Document.ICON_URL];
        let text = `ladder authorised to use\n ${fileURL}\n`;


        let response_content = `
        <div class="alert alert-primary mt-3" role="alert">
          <h4 class="alert-heading">Authorisation successful</h4>
          <p>
            <img src="${iconURL}" alt="Google Slides" class="img-fluid" style="max-width: 50px;">
            ${fileName}
            <a href="${fileURL}" target="_blank">[Link]</a>
          </p>
          <p class="mb-0">Please close this window and return to R.</p>
        `;
        window.document.getElementById('response').innerHTML = response_content;

        // hide authorize_button
        window.document.getElementById('authorize_button').style.display = 'none';

        // send fileId to R
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
