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
download_gis_db <- function(num_dep = "75"){
   match.arg(num_dep,
             foRinput::liste_dep)

   dep_dir_rel <- file.path("~/", "GIS_Database", num_dep)
   dep_dir_abs <- path.expand(dep_dir_rel)

   if (dir.exists(dep_dir_rel)){
      return(message("GIS_Database for ", num_dep," already exits at : \n",
             dep_dir_abs))
   }else{
      dir.create(dep_dir_rel, showWarnings = FALSE)
      message("GIS_Database for ", num_dep," is created exits at : \n",
             dep_dir_abs)

      liste_bdd <- get_liste_db()[c(4, 7, 12, 26, 28)]
      lapply(liste_bdd, load_from_ign, num_dep, dep_dir_rel)
   }

}

