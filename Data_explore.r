library(raster)
library(tmap)
library(mapview)
library(sf)


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

extentB <- extent(466520,466610,4767390,4767480)
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

outdir <- "E:/Google Drive/GIS/drone/campus/mapping"
plot(stackCc[[1]])
plotRGB(stackCc,r=3,g=2,b=1)

arrows(466535,4767475,466550,4767475, code=0, lwd=4)
text(466535,4767473, "0 m", cex=1.5)
text(466550,4767473, "15 m", cex=1.5)

arrows(466525,4767465,466525,4767473, lwd=3)
text(466525,4767475, "N", cex=1.5)

study <- st_polygon(list(rbind(c(466540.7, 4767442),
                               c(466546.1, 4767448),
                               c( 466543.9, 4767456),
                               c(466558, 4767462), 
                               c(466585.2, 4767414),
                               c(466562.1,4767397),
                               c(466540.7, 4767442))))

st_area(study)

png("e:\\Google Drive\\GIS\\drone\\campus\\mapping\\May3_map.png",
    width=10,height=10,units="in",res=300)
  plotRGB(stackCc,r=3,g=2,b=1, maxpixels=stackCc@ncols*stackCc@nrows)
  
  arrows(466535,4767400,466550,4767400, code=0, lwd=4)
  text(466535,4767397, "0 m", cex=1.5)
  text(466550,4767397, "15 m", cex=1.5)
  
  arrows(466525,4767397,466525,4767405, lwd=3)
  text(466525,4767408, "N", cex=1.5)
  
  plot(study,add=TRUE, col=NA, border="#B8860B", lwd=3)
  
  text(466590,4767400, "study bounds ", cex=1.5, col="#B8860B")
  text(466590,4767395, "(1450 m2)", cex=1.5,col="#B8860B")
  
  text(466545,4767475, "May 3, 2021", cex=2)

dev.off()



png("e:\\Google Drive\\GIS\\drone\\campus\\mapping\\June7_map.png",
    width=10,height=10,units="in",res=300)
plotRGB(multi2c,r=3,g=2,b=1, maxpixels=multi2c@ncols*multi2c@nrows)

arrows(466535,4767400,466550,4767400, code=0, lwd=4)
text(466535,4767397, "0 m", cex=1.5)
text(466550,4767397, "15 m", cex=1.5)

arrows(466525,4767397,466525,4767405, lwd=3)
text(466525,4767408, "N", cex=1.5)

plot(study,add=TRUE, col=NA, border="#B8860B", lwd=3)

text(466590,4767400, "study bounds ", cex=1.5, col="#B8860B")
text(466590,4767395, "(1450 m2)", cex=1.5,col="#B8860B")

text(466545,4767475, "June 7, 2021", cex=2)

dev.off()
