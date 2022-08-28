### Create a 3D Map of Geneva, zoomed in near the Palais des Nations ####


# Install Packages if not Installed
packages <- c("lidR", "rayshader", "here", "raster", "whitebox", "tidyverse")
installed_packages <- packages %in% rownames(installed.packages())
if (any(installed_packages == FALSE)){
  install.packages(packages[!installed_packages])
  whitebox::install_whitebox()
  whitebox::wbt_init()
  rm(packages, installed_packages)
}
# If you experience any errors with rayshader, than try to install the development version:
# devtools::install_github("tylermorganwall/rayshader")
#
# If that doesn't work then try the same for rayrender
# devtools::install_github("tylermorganwall/rayrender")
# For rayrender though, I had more luck installing it from CRAN.

library(tidyverse)
library(lidR)
library(rayshader)
library(here)
library(raster)
library(whitebox)

# The below las files are from a Geneva gov site and were open access.
# Read multiple las files into R at once then save a combined file.
my_LAS <- lidR::readLAS(files = c("LIDAR_data/2499_1119.las", "LIDAR_data/2499_1120.las", "LIDAR_data/2500_1119.las", "LIDAR_data/2500_1120.las"), select="X,Y,Z")
writeLAS(my_LAS, "zoomedGVA.las")

# Convert the .las file to a format rayshader can handle.
whitebox::wbt_lidar_tin_gridding("zoomedGVA.las",
                                 output = here::here("zoomedGVA.tif"),
                                 resolution = 1, verbose_mode = TRUE,
                                 exclude_cls = '3,4,5,7,13,14,15,16,18')

# Rasterise the tif file then convert to matrix.
output = raster::raster("zoomedGVA.tif")
dem_grid = raster_to_matrix(output)
z_exaggeration = 1

# Plot the data!
dem_grid %>%
  sphere_shade(texture = "bw") %>%
  plot_3d(dem_grid, zscale=1/z_exaggeration,
          water = TRUE, waterdepth = 373, wateralpha = 0.5, watercolor = "lightblue",
          waterlinecolor = "white", waterlinealpha = 0.5
          )

# Set a camera angle if you like.
render_camera(theta=45,phi=45,fov=60,zoom=0.8) # Use no args to get current position.

# Get a high quality image file - WARNING it takes a very long time to render! (30 min?)
render_highquality(filename = paste0("exports/zoomedGVA",format(Sys.time(), "%Y-%m-%d_%H.%M.%OS"),".stl"), lightdirection = 45, lightaltitude=10)



### Other code... ###

# If you want to a file for 3D printing...
save_3dprint("exports/zoomedGVA.stl")
save_3dprint(filename = paste0("exports/unoglib_rayshaded",format(Sys.time(), "%Y-%m-%d_%H.%M.%OS"),".stl"))


# An angle I like:
# Lookfrom: c(403.49, 141.48, 188.72) LookAt: c(72.54, -24.64, 102.78) Focal Dist: 0.000 Env Rotation: 0.00


# Another image saving option:
# ----------------------------
# Execute the below after you have rotated the model
# in the image viewer to the desired angle.
rgl::rgl.snapshot(filename = paste0("exports/unoglib_rayshaded",format(Sys.time(), "%Y-%m-%d_%H.%M.%OS"),".png"),
                  fmt="png")
