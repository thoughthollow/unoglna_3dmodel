### Import an STL file into R and play around with it using the RGL package ###

# Code taken and modified from here:
# https://github.com/srvanderplas/shoe3d-Eryn/blob/3adc6e14275172c0d770707807158eb0c8c324d2/vignettes/stl_files.Rmd

# I'm very new to STL files so I'm unsure on a lot of the below, but it works.
# I've gutted nearly everything from the above github repo script,
# and it seems to work fine, so just send the STL to trangles3d() to plot it.
# ...
# If there is an issue then try using scale() before plotting e.g.:
# stl_centered <- scale(stl, center = T, scale = F)

library(rgl)
stl <- readSTL("C:/Users/tait/Documents/R/Projects/unoglna_3dmodel/exports/unoglib_rayshaded2022-08-26_04.25.06.stl", ascii = F, plot = F)
# You can plot straight away by adding the arg "plot = T" above,
# but note that it'll be assigned as an RGL object instead of a matrix.
# Add colour to the above plot with the arg 'col="red"' for example.



### Plotting with rgl::triangles3d after reading in the STL ###
open3d()
rgl::triangles3d(stl, aspect = "iso", col = "firebrick2")
