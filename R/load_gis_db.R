#' Wrapper around load_from_ign to download all needed database at the right source folder
#'
#' @param num_dep character corresponding to a department number. "Outre-mer"
#' departement are not supported for the moment
#'
#' @return  all database extract to src_folder
#' @export
#'
#' @examples
#' \dontrun{
#' download_gis_db("29")
#' }
load_gis_db <- function(num_dep = "75"){
   match.arg(num_dep,
             foRinput::liste_dep)

   val <- Sys.getenv("FORINPUT_SRC_FOLDER")

   if (identical(val, "")) {
      val <- Sys.getenv("HOME")
   }

   gis_db_path <- file.path(val, "GIS_database")
   dep_path <- file.path(gis_db_path, num_dep)

   if (dir.exists(dep_path)){
      return(message("GIS_Database for ", num_dep," is already download at : \n",
                     dep_path))
   }else{
      dir.create(dep_path, showWarnings = FALSE)
      message("GIS_Database for ", num_dep," is set at : \n",
              dep_path)
   }

   liste_bdd <- get_liste_db()[c(4, 7, 12, 26, 28)]
   invisible(lapply(liste_bdd, load_from_ign, num_dep, dep_path))
}

