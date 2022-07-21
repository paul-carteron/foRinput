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

   gis_db_path <- Sys.getenv("FORINPUT_SRC_FOLDER")

   liste_bdd <- get_liste_db()[c(4, 7, 12, 26, 28)]
   lapply(liste_bdd, load_from_ign, num_dep, gis_db_path)
}

