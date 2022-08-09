library(lidR) # if issues then run: devtools::install_github("Jean-Romain/lidR", dependencies=TRUE)
library(rgl) # if issues then install from github.
library(viridis) # for the grenn/blue colour palatte.


### Code is fairly basic but it works.


##################
my_LAS <- lidR::readLAS(files = c("LIDAR_data/2499_1119.las", "LIDAR_data/2499_1120.las", "LIDAR_data/2500_1119.las", "LIDAR_data/2500_1120.las"), select="X,Y,Z")

lidR::plot(my_LAS,
           color = "Z",
           bg = "white",
           pal = viridis(256),
           breaks = "equal")

rgl.snapshot(filename = paste0("exports/LIDAR_unog",format(Sys.time(), "%Y-%m-%d_%H.%M.%OS"),".png"),
             fmt="png")

# When ready, close the viewer with: "rgl::rgl.close()"

####################
# LIDR package instructions here: https://github.com/r-lidar/lidR
# Some stuff on 3D maps and R: https://blog.revolutionanalytics.com/2018/09/raytracer.html
# Get Geo-coordinates for UNOG: https://www.gps-coordinates.net/gps-coordinates-converter
#
#
# Get Swiss open LIDAR data from here: https://www.swisstopo.admin.ch/en/geodata/height/surface3d.html


###------------------###
# Clipping the LAS data

avgX = mean(my_LAS$X) # With the current LAS data set it's 2499833.14959348
avgY = mean(my_LAS$Y) # With the current LAS data set it's 1120016.31805795
LAS_CIRplot = clip_circle(my_LAS, avgX, avgY, 1000)
LAS_RECplot = clip_rectangle(my_LAS, avgX - 20 - 500 , avgY + 80 - 500, avgX + 130 + 500, avgY + 230 + 500)
UNOGLibrary_closeup <- clip_rectangle(my_LAS, avgX - 20 , avgY + 80 , avgX + 130, avgY + 230)


plot(UNOGLibrary_closeup,
     pal = viridis(256),
     bg = "white",
     breaks = "equal")

rgl.snapshot(filename = paste0("exports/LIDAR_unog",format(Sys.time(), "%Y-%m-%d_%H.%M.%OS"),".png"),
             fmt="png")
