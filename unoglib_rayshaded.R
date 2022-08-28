### Create a 3D Map of the UN Library & Archives Geneva ####


# Install Packages if not Installed
packages <- c("lidR", "rayshader", "here", "raster", "whitebox")
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


library(lidR)
library(rayshader)
library(here)
library(raster)
library(whitebox)


# The below las files are from a Geneva gov site and were open access.
# Read multiple las files into R at once then save a combined file.
my_LAS <- lidR::readLAS(files = c("LIDAR_data/2499_1119.las", "LIDAR_data/2499_1120.las", "LIDAR_data/2500_1119.las", "LIDAR_data/2500_1120.las"), select="X,Y,Z")
avgX = mean(my_LAS$X) # With the current LAS data set it's 2499833.14959348
avgY = mean(my_LAS$Y) # With the current LAS data set it's 1120016.31805795
UNOGLib <- clip_rectangle(my_LAS, avgX - 20 , avgY + 80 , avgX + 130, avgY + 230)
writeLAS(UNOGLib, "wbfile.las")

whitebox::wbt_lidar_tin_gridding("wbfile.las",
                                 output = here::here("output.tif"),
                                 resolution = 1, verbose_mode = TRUE,
                                 exclude_cls = '3,4,5,7,13,14,15,16,18')
output = raster::raster("output.tif")
dem_grid = raster_to_matrix(output)
z_exaggeration = 1

dem_grid %>%
  sphere_shade() %>%
  plot_3d(dem_grid, zscale=1/z_exaggeration)

# If you want to a file for 3D printing...
 save_3dprint("your_stl_file.stl")
 save_3dprint(filename = paste0("exports/unoglib_rayshaded",format(Sys.time(), "%Y-%m-%d_%H.%M.%OS"),".stl"))


render_highquality() # To create a nice plot which then can be saved.
# An angle I like:
# Lookfrom: c(403.49, 141.48, 188.72) LookAt: c(72.54, -24.64, 102.78) Focal Dist: 0.000 Env Rotation: 0.00


# Another image saving option:
# ----------------------------
# Execute the below after you have rotated the model
# in the image viewer to the desired angle.
rgl::rgl.snapshot(filename = paste0("exports/unoglib_rayshaded",format(Sys.time(), "%Y-%m-%d_%H.%M.%OS"),".png"),
             fmt="png")
