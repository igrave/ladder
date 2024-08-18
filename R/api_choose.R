#' Choose Slides presentation
#'
#' Opens a webpage for a user to authenticate with Google and select a presentation.
#' This presentation is then authorised for use with ladder.
#'
#' @return A presentation id
#'
#' @export
#'
#' @examplesIf interactive()
#' \donttest{
#'   id <- choose_slides()
#' }
choose_slides <- function() {
  request_url <- "http://127.0.0.1:1083/index.html"
  auth_slide_id <- NULL

  server <- httpuv::startServer(
    host = "127.0.0.1", port = 1083,
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
  CLIENT_ID <- '1073903696751-e5c51669nkid25bk0gjng5evspeakp7r.apps.googleusercontent.com'
  # Google Picker API only Key
  API_KEY <- paste("AIzaSyAyLt5QNsDtC73", "fbV7ayndchq5iEzyy-k", sep = "_")
  APP_ID <- '1073903696751'

  body <- gluestick(
    r"--(
<!DOCTYPE html>
<html>
<head>
  <title>Choose Slides for ladder</title>
  <meta charset="utf-8" />
</head>
<body>
<p>Choose Slides for ladder</p>

<!--Add buttons to initiate auth sequence and sign out-->
<button id="authorize_button" onclick="handleAuthClick()">Authorize</button>
<button id="signout_button" onclick="handleSignoutClick()">Sign Out</button>

<pre id="content" style="white-space: pre-wrap;"></pre>

<script type="text/javascript">
  /* exported gapiLoaded */
  /* exported gisLoaded */
  /* exported handleAuthClick */
  /* exported handleSignoutClick */

  // Authorization scopes required by the API; multiple scopes can be
  // included, separated by spaces.
  const SCOPES = 'https://www.googleapis.com/auth/drive.file https://www.googleapis.com/auth/presentations.currentonly';

  // client ID and API key from the Developer Console
  const CLIENT_ID = '{{CLIENT_ID}}';
  const API_KEY = '{{API_KEY}}';
  const APP_ID = '{{APP_ID}}';

  let tokenClient;
  let accessToken;
  let pickerInited = false;
  let gisInited = false;


  document.getElementById('authorize_button').style.visibility = 'hidden';
  document.getElementById('signout_button').style.visibility = 'hidden';

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
   * Callback after Google Identity Services are loaded.
   */
  function gisLoaded() {
    tokenClient = google.accounts.oauth2.initTokenClient({
      client_id: CLIENT_ID,
      scope: SCOPES,
      callback: '', // defined later
    });
    gisInited = true;
    maybeEnableButtons();
  }

  /**
   * Enables user interaction after all libraries are loaded.
   */
  function maybeEnableButtons() {
    if (pickerInited && gisInited) {
      document.getElementById('authorize_button').style.visibility = 'visible';
    }
  }

  /**
   *  Sign in the user upon button click.
   */
  function handleAuthClick() {
    tokenClient.callback = async (response) => {
      if (response.error !== undefined) {
        throw (response);
      }
      accessToken = response.access_token;
      document.getElementById('signout_button').style.visibility = 'visible';
      document.getElementById('authorize_button').innerText = 'Refresh';
      await createPicker();
    };

    if (accessToken === null) {
      // Prompt the user to select a Google Account and ask for consent to share their data
      // when establishing a new session.
      tokenClient.requestAccessToken({prompt: 'consent'});
    } else {
      // Skip display of account chooser and consent dialog for an existing session.
      tokenClient.requestAccessToken({prompt: ''});
    }
  }

  /**
   *  Sign out the user upon button click.
   */
  function handleSignoutClick() {
    if (accessToken) {
      accessToken = null;
      google.accounts.oauth2.revoke(accessToken);
      document.getElementById('content').innerText = '';
      document.getElementById('authorize_button').innerText = 'Authorize';
      document.getElementById('signout_button').style.visibility = 'hidden';
    }
  }

  //  Create and render a Picker object for searching presentations
  function createPicker() {
    const view = new google.picker.View(google.picker.ViewId.PRESENTATIONS);
    const picker = new google.picker.PickerBuilder()
        //.enableFeature(google.picker.Feature.NAV_HIDDEN)
        //.enableFeature(google.picker.Feature.MULTISELECT_ENABLED)
        .setDeveloperKey(API_KEY)
        .setAppId(APP_ID)
        .setOAuthToken(accessToken)
        .addView(view)
        //.addView(new google.picker.DocsUploadView())
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
      const res = await gapi.client.drive.files.get({
        'fileId': fileId,
        'fields': '*',
      });

      //text += `Drive API response for first document: \n${JSON.stringify(res.result, null, 2)}\n`;
      window.document.getElementById('content').innerText = text;

      var xmlhttp = new XMLHttpRequest();   // new HttpRequest instance
      var theUrl = "/response?slides=" + fileId;
      xmlhttp.open("GET", theUrl);
      xmlhttp.send();
    }
  }
</script>
<script async defer src="https://apis.google.com/js/api.js" onload="gapiLoaded()"></script>
<script async defer src="https://accounts.google.com/gsi/client" onload="gisLoaded()"></script>
</body>
</html>

)--")

  # return
  list(
    status = 200L,
    headers = list(
      'Content-Type' = 'text/html'
    ),
    body = body
  )
}
