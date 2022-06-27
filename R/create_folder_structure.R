#' Check and create folder structure
#'
#' @param project_name Name of project, for example the name of the forest
#' @param wd Working directory where the project is
#'
#' @return create and check folder structure
#' @export
#'
create_folder_structure <- function(project_name, wd){
   dir.create(file.path(wd, project_name), showWarnings = FALSE)

   dir.create(file.path(wd, project_name, "project"), showWarnings = FALSE)
   dir.create(file.path(wd, project_name, "project", "vector"), showWarnings = FALSE)
   dir.create(file.path(wd, project_name, "project", "vector", "communes"), showWarnings = FALSE)
   dir.create(file.path(wd, project_name, "project", "vector", "chef_lieu"), showWarnings = FALSE)

   dir.create(file.path(wd, project_name, "project", "raster"), showWarnings = FALSE)
   dir.create(file.path(wd, project_name, "project", "raster", "scan25"), showWarnings = FALSE)
   dir.create(file.path(wd, project_name, "project", "raster", "scan100"), showWarnings = FALSE)

   dir.create(file.path(wd, project_name, "general"), showWarnings = FALSE)

   dir.create(file.path(wd, project_name, "output"), showWarnings = FALSE)
   dir.create(file.path(wd, project_name, "output", "map"), showWarnings = FALSE)

}
