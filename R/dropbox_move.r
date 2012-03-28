#' Move files within Dropbox
#'
#' Allows users to move files or folders inside the dropbox storage.
#' @param cred Specifies an object of class DropboxCredentials with Dropobox specific credentials.
#' @param from_path Specifies the file or folder to be copied from relative to root.
#' @param to_path Specifies a destination path, including the new name for the file or folder, relative to root.
#' @param curl If using in a loop, call getCurlHandle() first and pass
#'  the returned value in here (avoids unnecessary footprint)
#' @param ... optional additional curl options (debugging tools mostly).
#' @seealso dropbox_copy dropbox_create_folder
#' @param verbose default is FALSE. Set to true to receive full outcome.
#' @seealso related: \code{\link{dropbox_copy}}
#' @return Message on successful completion or error.
#' @export dropbox_move
#' @examples \dontrun{
#' dropbox_move(db_cred, '/data.csv', 'data/data.csv')
#'}
dropbox_move <- function(cred, from_path = NULL, to_path = NULL,
    verbose = FALSE, curl = getCurlHandle(), ...) {
    if (!is(cred, "DropboxCredentials") || missing(cred))
        stop("Invalid or missing Dropbox credentials. ?dropbox_auth for more information.", call.= FALSE)

                                                        # Note: to_path needs a leading / because root is 'dropbox'
    if (is.null(from_path)) {
        stop("Did not specify full path for source",
            call. = F)
    }

     if (!exists.in.dropbox(cred, to_path, is_dir = TRUE,..., curl = getCurlHandle())) {
        stop("Destination is not a valid folder", call. = FALSE)
    }
    if (!(exists.in.dropbox(cred, path = from_path,..., curl = getCurlHandle()))) {
        stop("File or folder does not exist", call. = FALSE)
    }
    if (!(exists.in.dropbox(cred, path = to_path, is_dir = TRUE,..., curl = getCurlHandle()))) {
        stop("Destination does not exist or isn't a folder",
            call. = FALSE)
    }
  from_path <- basename(from_path)
    if (!grepl("/$", to_path)) {
        to_path <- paste(to_path, "/", sep = "")
    }
      if (!grepl("^/", to_path)) {
        to_path <- paste("/", to_path, sep = "")
    }
    to_path <- paste(to_path, from_path, sep = "")

    move <- fromJSON(OAuthRequest(cred, "https://api.dropbox.com/1/fileops/move",
        list(root = "dropbox", from_path = from_path, to_path = to_path),
        "POST"), ..., curl = curl)
    if (is.character(move)) {
        stop(move[[1]], call. = FALSE)
    }
    if (verbose) {
        return(move)
    } else {
        if (is.list(move)) {
            cat("File succcessfully moved to", move$path, "on",
                move$modified)
        }
    }
}
# API documentation:
#
#
#
#   https://www.dropbox.com/developers/reference/api#fileops-move
