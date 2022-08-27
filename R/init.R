#' @export
#' @importFrom utils menu
#'
.onAttach <- function(libname, pkgname) {

   home_folder <- Sys.getenv("HOME")
   gis_db_path <- suppressWarnings(normalizePath(file.path(home_folder, "GIS_database")))

   if (!dir.exists(gis_db_path)){
      dir.create(gis_db_path, showWarnings = F)
   }

   packageStartupMessage("GIS_Database is set at : ",  gis_db_path)
   packageStartupMessage("To change default folder change 'HOME' environnement variable in .Renviron",
                         "\nFor that, use usethis::edit_r_environ() and restart R session.")

}

