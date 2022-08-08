library(rayshader) # May need to install directly from github
library(rayvista) # May need to install directly from github
# if there are issues with long or lat values, then try installing the elevatr package from github:
# remotes::install_github("jhollist/elevatr")
library(rayrender) # May need to install directly from github

unog_lat <- 46.2257106
unog_long <- 6.1407874

unog3dmap <- rayvista::plot_3d_vista(
  ### Defines the bounding box of the map (center, radius and shape)
  lat = unog_lat, long = unog_long, radius = 800, baseshape = "hex",
  ### Rotation in z-axis and azimuth and zoom
  theta = 60, phi = 70, zoom = 1,
  ### Scale of exaggeration of elevations
  zscale = 5,
  ### Detail of the map
  overlay_detail = 17,
  ### Size of the canvas for the map
  windowsize = 500,
)

render_snapshot(filename = paste0("unog",format(Sys.time(), "%Y-%m-%d_%H.%M.%OS")))
# when you're ready, use this to close the render window: " rgl::rgl.close() "
