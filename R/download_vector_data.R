#' download_vector_data
#'
#' @param shape Object of class `sf`
#' @param project_name Name of project, for example the name of the forest
#' @param wd Working directory where the project is
#'
#' @importFrom happign get_wfs
#'
#' @return .shp
#' @export
#'
#'
download_vector_data <- function(shape, project_name, wd){

   # wd <- "C:/Users/PAUL/Desktop/Codes R"
   # project_name <- "forest_test"

   communes <- get_wfs(shape,
                       apikey = "administratif",
                       layer_name = "LIMITES_ADMINISTRATIVES_EXPRESS.LATEST:commune",
                       filename = file.path(wd, project_name, "project", "vector",
                                            "communes", "communes"))

   communes <- get_wfs(shape,
                       apikey = "topographie",
                       layer_name = "BDTOPO_V3:commune",
                       filename = file.path(wd, project_name, "project", "vector",
                                            "communes", "communes2"))



   chf_lieu <- get_wfs(communes,
                       apikey = "administratif",
                       layer_name = "LIMITES_ADMINISTRATIVES_EXPRESS.LATEST:chflieu_commune",
                       file.path(wd, project_name, "project", "vector",
                                 "chef_lieu", "chef_lieu"))
}
