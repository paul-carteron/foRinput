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
download_vector_data <- function(shape, project_name, wd){

   communes <- get_wfs(shape,
                       apikey = "administratif",
                       layer_name = "LIMITES_ADMINISTRATIVES_EXPRESS.LATEST:commune",
                       filename = file.path(wd, project_name, "project", "vector",
                                            "communes", "communes"))

   chf_lieu <- get_wfs(communes,
                       apikey = "administratif",
                       layer_name = "LIMITES_ADMINISTRATIVES_EXPRESS.LATEST:chflieu_commune",
                       file.path(wd, project_name, "project", "vector",
                                 "chef_lieu", "chef_lieu"))
}
