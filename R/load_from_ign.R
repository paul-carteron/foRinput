#' Wrapper function to download some IGN database
#'
#' @param db_ign character corresponding to the name of the database. Can be one of
#' `"bdalti"`, `"bdforet"`, `"bdtopo"`, `"parcellaire-express"`, `"rgealti"`.
#' @param num_dep character corresponding to a department number.
#' @param src_folder source folder where data are stored.
#'
#' @return All data extract to src_folder
#' @export
#'
#' @importFrom xml2 read_html xml_attrs xml_find_all
#' @importFrom archive archive_extract archive
#' @importFrom utils download.file
#'
#' @examples
#' \dontrun{
#'
#' # create src_folder
#' my_dir <- file.path(getwd(), "general")
#' dir.create(my_dir)
#'
#' # download data
#' load_from_ign(db_ign = "bdalti",
#'               num_dep = "75",
#'               src_folder = my_dir)
#'
#' # delete src_folder because it is only an example
#' unlink(basename(my_dir), recursive = TRUE)
#'
#' }
load_from_ign <- function(db_ign = "bdtopo",
                          num_dep = "75",
                          src_folder = src_folder){

   # allow for longer than 1min download
   default <- getOption("timeout")
   options(timeout = 3600)
   on.exit(options(timeout = default))

   # arg check
   match.arg(db_ign,
             get_liste_db()[c(4, 7, 12, 26, 28)])

   url <- get_path(db_ign)
   ressource <- get_ressources_list(url)
   ressource <- ressource[grep(paste0("D0", num_dep), ressource)]

   detect_last_ressources <- function(ressource_list, pattern){
      pattern <- toupper(gsub("-","_", pattern))
      res <- rev(ressource_list[grep(pattern, ressource_list)])[1]
      return(res)
   }

   if (db_ign == "bdalti"){
      bdalti <- detect_last_ressources(ressource, db_ign)
      courbe <- detect_last_ressources(ressource, "COURBE")
      ressources <- c(bdalti, courbe)
   }else if (db_ign == "rgealti"){
      rgealti0_1 <- detect_last_ressources(ressource, "0_1")
      rgealti0_5 <- detect_last_ressources(ressource, "0_5")
      ressources <- c(rgealti0_1, rgealti0_5)
   }else{
      ressources <- detect_last_ressources(ressource, db_ign)
   }

   urls <- paste(url, ressources, sep = "/")
   invisible(lapply(urls, download_7z, src_folder))
}

#' retrieve list of ressources from an url
#' @param url url to scrap.
#' @param xpath name of the node.
#' @noRd
get_ressources_list <- function(url, xpath = ".//a"){
   ressources <- read_html(url) %>%
      xml_find_all(xpath)%>%
      xml_attrs() %>%
      unlist() %>%
      as.character()
   return(ressources)
}

#' find the path of the last folder
#' @param db_ign character corresponding to the name of the database. Can be one of
#' `"bdalti"`, `"bdforet"`, `"bdtopo"`, `"parcellaire-express"`, `"rgealti"`.
#' @noRd
get_path <- function(db_ign = "bdtopo"){

   base_url <- "https://files.opendatarchives.fr/professionnels.ign.fr"
   last_maj <- ""

   if (db_ign == "bdforet"){
      last_maj <- "BDFORET_V2"
   }else if(db_ign == "bdtopo"){
      last_maj <- "latest"
   }else if(db_ign == "parcellaire-express"){
      url <- paste(base_url, db_ign, sep = "/")
      liste_db <- get_ressources_list(url)
      last_maj <- rev(liste_db[grep("DEPT", liste_db)])[1]
   }

   url <- paste(base_url, db_ign, last_maj, sep = "/")
   return(url)
}

#' wrapper function to get all base db name
#' @noRd
get_liste_db <- function(){

   url <- "https://files.opendatarchives.fr/professionnels.ign.fr"
   liste_db <- get_ressources_list(url)

   liste_db <- liste_db[grep("/", liste_db)]
   liste_db <- gsub("/", "", liste_db[-1])
   return(liste_db)
}

#' retrieve list of ressources from an url
#' @param url url of the data to download.
#' @param src_folder source folder where data are stored.
#' @param db_ign character corresponding to the name of the database. Can be one of
#' `"bdalti"`, `"bdforet"`, `"bdtopo"`, `"parcellaire-express"`, `"rgealti"`.
#' @export
download_7z <- function(url, src_folder, db_ign){

   destfile <- tempfile(fileext = ".7z", tmpdir = tempdir(check = TRUE))

   suppressMessages(download.file(url,
                                  destfile,
                                  mode = "wb",
                                  quiet = F))

   #Extraction de la donnée de la donnée
   zip <- archive(destfile)
   archive_extract(destfile, src_folder)

   message("Data are downloaded at :\n",
           path.expand(src_folder), "\n")
}


