#' Create situation map
#'
#' @param shape Object of class `sf`
#' @param project_name Name of project, for example the name of the forest
#' @param wd Working directory where the project is
#' @param scan Can be "scan25" or "scan100"
#'
#' @importFrom stars read_stars
#' @importFrom sf st_cast read_sf
#' @importFrom tmap tm_shape tm_rgb tm_add_legend tm_layout tm_polygons tm_lines tmap_save
#'
#' @return map and create pdf
#' @export
#'
situation_map <- function(shape, project_name, wd, scan = "scan25"){

   # limite administrative

   communes_filepath <- file.path(wd, project_name, "project", "vector",
                                  "communes")
   scan_filepath <- file.path(wd, project_name, "project", "raster", scan)

   if(length(list.files(communes_filepath)) == 0){
      download_vector_data(shape, project_name, wd)
   }

   communes <- read_sf(list.files(communes_filepath, pattern = "shp", full.names = TRUE))
   lines <- st_cast(communes, "MULTILINESTRING")

   if(length(list.files(scan_filepath)) == 0){
      download_scan(shape, project_name, wd)
   }

   scan <- read_stars(list.files(scan_filepath, pattern = "tif", full.names = TRUE))

   map <- tm_shape(scan)+
      tm_rgb()+
   tm_shape(shape)+
      tm_polygons(alpha = 0.6,
                  col = "firebrick",
                  lwd = 3, border.col = "black")+
   tm_shape(lines)+
      tm_lines(lty = 2, col = "red", lwd = 3)+
   tm_add_legend(type = "line",
                 labels = " Limite de commune",
                 lwd  = 3,
                 lty = 2,
                 col = "red",
                 title = "~ Legende ~ ")+
   tm_add_legend(type = "fill",
                 labels = "  Propriete",
                 col = "firebrick",
                 border.lwd = 3, border.col = "black",alpha = 0.6)+
   tm_layout(legend.bg.color = "white",
             legend.bg.alpha = 0.8,
             legend.title.size = 1.2,
             legend.text.size = 1,
             legend.title.fontface = "bold")

   tmap_save(map, file.path(wd, project_name, "output", "map", "situation_map.pdf"))

}
