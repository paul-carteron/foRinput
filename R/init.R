#'
#' @export
#'
.onAttach <- function(libname, pkgname) {
   rel_dir <- file.path("~/", "GIS_Database")
   abs_dir <- path.expand(rel_dir)

   if (dir.exists(rel_dir)){
      packageStartupMessage("GIS_Database already exits at : \n",  abs_dir)
   }else{
      dir.create(rel_dir, showWarnings = FALSE)
      packageStartupMessage("GIS_Database is created exits at : \n", abs_dir)
   }
}
