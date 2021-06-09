library(raster)
library(tmap)
library(mapview)


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




#set directory folder
dirI3 <- "E:/Google Drive/GIS/drone/campus/P4M/flight_06_07_21/ortho/out"
multi2 <- stack(paste0(dirI3, "/June_7_transparent_reflectance_blue.tif"),
                paste0(dirI3, "/June_7_transparent_reflectance_green.tif"),
                paste0(dirI3, "/June_7_transparent_reflectance_red.tif"),
                paste0(dirI3, "/June_7_transparent_reflectance_red edge.tif"),
                paste0(dirI3, "/June_7_transparent_reflectance_nir.tif"))
plotRGB(multi2, r=3,g=2,b=1, scale=0.13)
plot(multi2[[1]])




#export images

stackC <- stack("e://Google Drive/GIS/drone/campus/P4M/flight_05_03_21/ortho/odm_orthophotoRGB.tif")


#buckthorn crop

extentB <- extent(466520,466635,4767390,4767500)
multi2c <- crop(multi2,extentB)
stackCc <- crop(stackC, extentB)
multi1c <- crop(multi1,extentB)

plotRGB(stackCc,r=3,g=2,b=1)


plotRGB(multi1c, r=3,g=2,b=1, scale=0.13)

plot(multi2c[[1]])
plotRGB(multi2c, r=3,g=2,b=1, scale=0.13, stretch="hist")
multi2c@nrows*multi2c@ncols
multi1c@nrows*multi1c@ncols

viewRGB(multi2c, r=3,g=2,b=1)
help(viewRGB)

tm_shape(multi1c)+
  tm_rgb(r=3,g=2,b=1,
         max.value=0.13)
