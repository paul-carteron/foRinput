#' download scan25 and scan100
#'
#' @param shape Object of class `sf`
#' @param project_name Name of project, for example the name of the forest
#' @param wd Working directory where the project is
#' @param personal_key key from you're personnal IGN webservice account
#'
#' @importFrom sf st_as_sfc st_bbox st_buffer st_distance
#' @importFrom happign get_wms_raster
#' @importFrom magrittr %>%
#'
#' @return .tif
#' @export
#'
download_scan <- function(shape,
                          project_name,
                          wd,
                          personal_key = "slz53dkjac05e9r547kmzarv"){

   chf_lieu_filepath <- file.path(wd, project_name, "project", "vector", "chef_lieu")
   scan_filepath <- file.path(wd, project_name, "project", "raster")

   if(length(list.files(chf_lieu_filepath)) == 0){
      download_vector_data(shape, project_name, wd)
   }

   chf_lieu <- read_sf(list.files(chf_lieu_filepath, pattern = "shp", full.names = TRUE))

   buffer_dist <- st_distance(shape, chf_lieu) %>%
      min() %>%
      as.numeric()

   bbox <- shape %>%
      st_buffer(buffer_dist, buffer_dist + 1/15 * buffer_dist) %>%
      st_bbox() %>%
      st_as_sfc()

   scan25 <- get_wms_raster(bbox,
                            apikey = personal_key,
                            layer_name = "SCAN25TOUR_PYR-JPEG_WLD_WM",
                            resolution = 1,
                            filename = file.path(scan_filepath, "scan25", "scan_25"))

   scan100 <- get_wms_raster(bbox,
                            apikey = personal_key,
                            layer_name = "SCAN100_PYR-JPEG_WLD_WM",
                            resolution = 2,
                            filename = file.path(scan_filepath, "scan100", "scan100"))

}
