library(raster)
library(tmap)


#set directory folder
dirI <- "C:/Users/hkropp/Google Drive/GIS/drone/campus/P4M/flight_05_03_21"

#read in sample images
rgbs <- stack(paste0(dirI,"/DJI_0810.jpg"))
#single band
blue <- raster(paste0(dirI,"/DJI_0811.tif"))
green <- raster(paste0(dirI,"/DJI_0812.tif"))
red <- raster(paste0(dirI,"/DJI_0813.tif"))
redE <- raster(paste0(dirI,"/DJI_0814.tif"))
NIR <- raster(paste0(dirI,"/DJI_0815.tif"))

#view images
plotRGB(rgbs)
plot(blue)
plot(green)
plot(red)
plot(redE)
plot(NIR)

stackC <- stack("C:/Users/hkropp/Google Drive/GIS/drone/campus/P4M/flight_05_03_21/ortho/odm_orthophotoRGB.tif")
stackR <- stack("C:/Users/hkropp/Google Drive/GIS/drone/campus/P4M/flight_05_03_21/ortho/odm_orthophoto.tif")
stackS <- stack("C:/Users/hkropp/Google Drive/GIS/drone/campus/P4M/flight_05_03_21/ortho/odm_orthophoto_sun.tif")
plot(stackR)
plot(stackS)
library(mapview)

ndvi <- (stackR[[5]]-stackR[[3]])/(stackR[[5]]+stackR[[3]])
ndviS <- (stackS[[5]]-stackS[[3]])/(stackS[[5]]+stackS[[3]])
plotRGB(stackC, r=3,g=2,b=1, stretch="lin")

plot(stackR[[1]])

plot(ndvi)
plot(ndviS)





#set directory folder
dirI2 <- "E:/Google Drive/GIS/drone/campus/P4M/flight_05_19_21/ortho/out"
multi1 <- stack(paste0(dirI2, "/05_19_21_transparent_reflectance_blue.tif"),
                paste0(dirI2, "/05_19_21_transparent_reflectance_green.tif"),
                paste0(dirI2, "/05_19_21_transparent_reflectance_red.tif"),
                paste0(dirI2, "/05_19_21_transparent_reflectance_red edge.tif"),
                paste0(dirI2, "/05_19_21_transparent_reflectance_nir.tif"))
plotRGB(multi1, r=3,g=2,b=1, scale=0.13)
plot(multi1)

ndvi <- (multi1[[5]]-multi1[[3]])/(multi1[[5]]+multi1[[3]])

plot(ndvi)

tm_shape(ndvi)+
  tm_raster(title="NDVI",
    n=8,
    style="fisher",
    palette="-viridis")+
  tm_layout(legend.outside = TRUE)
