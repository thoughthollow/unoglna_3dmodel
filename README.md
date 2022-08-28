# unoglna_3dmodel
Make a 3D model of the UNOG Library &amp; Archives building

## Aims
This project aims to experiment with 3D modelling of geography in R.

So far, a successful albeit simple model of the UNOG Library & Archives has been created using LIDAR data (see **LIDAR_unog3dmap.R**).

![*UNOG Library in 3D*](exports/LIDAR_unog2022-08-09_18.14.01.png)


A less successful attempt using just the rayvista package has also been developed, however without building height data (see **rayvista_unog3dmap.R**).

![rayvista render of UNOG](exports/unog2022-08-08_22.53.35.png)



Recently I've successfully used the [rayshader](https://github.com/tylermorganwall/rayshader) package to create some images. Examples below:

![*unoglib_rayshaded.R* example](exports/UNOGlib_rayshay_HQ.png)

**unoglib_rayshaded.R** example

![*readSTL_ThenViewWith_RGL* example](exports/unoglib_redrgl2022-08-26_08.30.53.png)

**readSTL_ThenViewWith_RGL.R** example

![*zoomedGVA.R* example](exports/zoomedGVA2022-08-27_13.14.32.stl.png)

**zoomedGVA.R** example



I hope to eventually combine LIDAR and OpenStreetMap data in order to create a more aesthetically pleasing model.
