library(raster)

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
