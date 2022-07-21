#' @export
#' @importFrom utils menu
#'
.onAttach <- function(libname, pkgname) {

   src_folder <- Sys.getenv("FORINPUT_SRC_FOLDER")
   home_folder <- Sys.getenv("HOME")

   if (src_folder != "" & src_folder != home_folder){
      gis_db_path <- file.path(src_folder, "GIS_database")

      dir.create(gis_db_path, showWarnings = F)
      packageStartupMessage("GIS_Database is set at : ",  gis_db_path)

   }else{
      gis_db_path <- file.path(home_folder, "GIS_database")

      if (dir.exists(gis_db_path)){
         packageStartupMessage("GIS_Database is set at : ", gis_db_path)
      }else{

         default_choice <- function(gis_db_path, home_folder){
            dir.create(gis_db_path, showWarnings = F)
            Sys.setenv("FORINPUT_SRC_FOLDER" = home_folder)
            packageStartupMessage("GIS_Database is set at : ", gis_db_path)
         }

         switch(menu(title = paste0("This is your first use of foRinput.\n",
                                   "What options do you want for",
                                   " the source data directory ?"),
                     choices = c(paste("Use default :", home_folder),
                                 "Select a different folder")),
                default_choice(gis_db_path, home_folder),
                packageStartupMessage(
                   paste0("Set the path of your source folder in .Renviron as environment variable :\n",
                          "FORINPUT_SRC_FOLDER='C:/your/path'\n",
                          "For that, use usethis::edit_r_environ() and restart R session.")))
      }
   }
}

