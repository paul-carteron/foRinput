#' @export
#' @importFrom utils menu
#'
.onAttach <- function(libname, pkgname) {

   val <- Sys.getenv("FORINPUT_SRC_FOLDER")

   if (identical(val, "")) {
      val <- Sys.getenv("HOME")
   }

   gis_db_path <- suppressWarnings(normalizePath(file.path(val, "GIS_database")))
   packageStartupMessage(
         "GIS_Database is set at : ", val,
         "\nTo change it, use usethis::edit_r_environ(), ",
         "add line below and restart R session.\n",
         "FORINPUT_SRC_FOLDER='C:/your/path'")

   if (!dir.exists(gis_db_path)){
         dir.create(gis_db_path, showWarnings = F)
      }

}
