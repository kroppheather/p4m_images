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

stackC <- stack("e:/Google Drive/GIS/drone/campus/P4M/flight_05_03_21/ortho/odm_orthophotoRGB.tif")
stackR <- stack("e:/Google Drive/GIS/drone/campus/P4M/flight_05_03_21/ortho/odm_orthophoto.tif")
stackS <- stack("e:/Google Drive/GIS/drone/campus/P4M/flight_05_03_21/ortho/odm_orthophoto_sun.tif")


#set directory folder
dirI2 <- "E:/Google Drive/GIS/drone/campus/P4M/flight_05_19_21/ortho/out"
multi1 <- stack(paste0(dirI2, "/05_19_21_transparent_reflectance_blue.tif"),
                paste0(dirI2, "/05_19_21_transparent_reflectance_green.tif"),
                paste0(dirI2, "/05_19_21_transparent_reflectance_red.tif"),
                paste0(dirI2, "/05_19_21_transparent_reflectance_red edge.tif"),
                paste0(dirI2, "/05_19_21_transparent_reflectance_nir.tif"))

#set directory folder
dirI3 <- "E:/Google Drive/GIS/drone/campus/P4M/flight_06_07_21/ortho/out"
multi2 <- stack(paste0(dirI3, "/June_7_transparent_reflectance_blue.tif"),
                paste0(dirI3, "/June_7_transparent_reflectance_green.tif"),
                paste0(dirI3, "/June_7_transparent_reflectance_red.tif"),
                paste0(dirI3, "/June_7_transparent_reflectance_red edge.tif"),
                paste0(dirI3, "/June_7_transparent_reflectance_nir.tif"))

#set directory folder
dirI4 <- "E:/Google Drive/GIS/drone/campus/P4M/flight_6_10_21/ortho/out"
multi3 <- stack(paste0(dirI4, "/06_10_transparent_reflectance_blue.tif"),
                paste0(dirI4, "/06_10_transparent_reflectance_green.tif"),
                paste0(dirI4, "/06_10_transparent_reflectance_red.tif"),
                paste0(dirI4, "/06_10_transparent_reflectance_red edge.tif"),
                paste0(dirI4, "/06_10_transparent_reflectance_nir.tif"))

plotRGB(multi3, r=3,g=2,b=1, scale=0.25, stretch="lin")
plotRGB(multi3, r=5,g=3,b=2, scale=0.35, stretch="lin")


plot(stackR)
plot(stackS)
library(mapview)

ndvi <- (stackR[[5]]-stackR[[3]])/(stackR[[5]]+stackR[[3]])
ndviS <- (stackS[[5]]-stackS[[3]])/(stackS[[5]]+stackS[[3]])
plotRGB(stackC, r=3,g=2,b=1, stretch="lin")

plot(stackR[[1]])

plot(ndvi)
plot(ndviS)





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





plot(multi2[[1]])





#buckthorn crop

extentB <- extent(466520,466610,4767390,4767480)
multi2c <- crop(multi2,extentB)
stackCc <- crop(stackC, extentB)
multi1c <- crop(multi1,extentB)
multi3c <- crop(multi3,extentB)


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

plotRGB(multi2c,r=3,g=2,b=1, scale=0.13, maxpixels=multi2c@ncols*multi2c@nrows)

png("e:\\Google Drive\\GIS\\drone\\campus\\mapping\\June7_map.png",
    width=10,height=10,units="in",res=300)
plotRGB(multi2c,r=3,g=2,b=1, scale=0.13, maxpixels=multi2c@ncols*multi2c@nrows)

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

plot(multi2c)
plotRGB(multi2c,r=5,g=3,b=2, scale=0.35, maxpixels=multi2c@ncols*multi2c@nrows)

png("e:\\Google Drive\\GIS\\drone\\campus\\mapping\\June7_map_false.png",
    width=10,height=10,units="in",res=300)
plotRGB(multi2c,r=5,g=3,b=2, scale=0.35, maxpixels=multi2c@ncols*multi2c@nrows)

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


#full June 10
png("e:\\Google Drive\\GIS\\drone\\campus\\mapping\\June10_full_map_false.png",
    width=10,height=10,units="in",res=300)
plotRGB(multi3,r=5,g=3,b=2, scale=0.35, maxpixels=multi3@ncols*multi3@nrows, stretch="lin")

dev.off()

#full June 10
png("e:\\Google Drive\\GIS\\drone\\campus\\mapping\\June10_full_map_true.png",
    width=10,height=10,units="in",res=300)
plotRGB(multi3,r=3,g=2,b=1, scale=0.3, maxpixels=multi3@ncols*multi3@nrows, stretch="lin")

dev.off()

png("e:\\Google Drive\\GIS\\drone\\campus\\mapping\\June10_map_false.png",
    width=10,height=10,units="in",res=300)
plotRGB(multi3c,r=5,g=3,b=2, scale=0.35, maxpixels=multi3c@ncols*multi3c@nrows)

arrows(466535,4767400,466550,4767400, code=0, lwd=4)
text(466535,4767397, "0 m", cex=1.5)
text(466550,4767397, "15 m", cex=1.5)

arrows(466525,4767397,466525,4767405, lwd=3)
text(466525,4767408, "N", cex=1.5)

plot(study,add=TRUE, col=NA, border="#B8860B", lwd=3)

text(466590,4767400, "study bounds ", cex=1.5, col="#B8860B")
text(466590,4767395, "(1450 m2)", cex=1.5,col="#B8860B")

text(466545,4767475, "June 10, 2021", cex=2)

dev.off()


png("e:\\Google Drive\\GIS\\drone\\campus\\mapping\\June10_map.png",
    width=10,height=10,units="in",res=300)
plotRGB(multi3c,r=3,g=2,b=1, scale=0.13, maxpixels=multi3c@ncols*multi3c@nrows)

arrows(466535,4767400,466550,4767400, code=0, lwd=4)
text(466535,4767397, "0 m", cex=1.5)
text(466550,4767397, "15 m", cex=1.5)

arrows(466525,4767397,466525,4767405, lwd=3)
text(466525,4767408, "N", cex=1.5)

plot(study,add=TRUE, col=NA, border="#B8860B", lwd=3)

text(466590,4767400, "study bounds ", cex=1.5, col="#B8860B")
text(466590,4767395, "(1450 m2)", cex=1.5,col="#B8860B")

text(466545,4767475, "June 10, 2021", cex=2)

dev.off()



#compare reflectance maps between odm from buckthorn flights

odmB1 <- stack("E:\\Google Drive\\GIS\\drone\\campus\\P4M\\orthos\\ODM\\odm_buckthorn_pt1.tif")

plot(odmB1)

pix4d <- stack("K:\\Environmental_Studies\\hkropp\\GIS\\drone\\campus\\P4M\\flight_6_25_21_buckthorn_p1\\ortho\\6_25_21_buckthorn_part1\\4_index\\reflectance\\6_25_21_buckthorn_part1_transparent_reflectance_blue.tif",
               "K:\\Environmental_Studies\\hkropp\\GIS\\drone\\campus\\P4M\\flight_6_25_21_buckthorn_p1\\ortho\\6_25_21_buckthorn_part1\\4_index\\reflectance\\6_25_21_buckthorn_part1_transparent_reflectance_green.tif",
               "K:\\Environmental_Studies\\hkropp\\GIS\\drone\\campus\\P4M\\flight_6_25_21_buckthorn_p1\\ortho\\6_25_21_buckthorn_part1\\4_index\\reflectance\\6_25_21_buckthorn_part1_transparent_reflectance_red.tif",
               "K:\\Environmental_Studies\\hkropp\\GIS\\drone\\campus\\P4M\\flight_6_25_21_buckthorn_p1\\ortho\\6_25_21_buckthorn_part1\\4_index\\reflectance\\6_25_21_buckthorn_part1_transparent_reflectance_red edge.tif",
               "K:\\Environmental_Studies\\hkropp\\GIS\\drone\\campus\\P4M\\flight_6_25_21_buckthorn_p1\\ortho\\6_25_21_buckthorn_part1\\4_index\\reflectance\\6_25_21_buckthorn_part1_transparent_reflectance_nir.tif")

plot(pix4d)

plot(pix4d[[5]]+pix4d[[3]])
plot( (pix4d[[5]]-pix4d[[3]])/(pix4d[[5]]+pix4d[[3]]))

NDVI4D <- (pix4d[[5]]-pix4d[[3]])/(pix4d[[5]]+pix4d[[3]])
plot(NDVI4D)

NDVIODM <- (odmB1[[5]] - odmB1[[3]])/(odmB1[[5]] + odmB1[[3]])
  
  
  plot(NDVIODM)
  
plot(NDVIODM)

#reproject to match NDVI

NDVIODMP <- projectRaster(NDVIODM,NDVI4D)

NDVIDiff <- NDVIODMP - NDVI4D
plot(NDVIDiff)

plot(NDVIODMP)


dome.ref <- stack("K:\\Environmental_Studies\\hkropp\\GIS\\drone\\Dome\\maps\\07_29_21_dome_transparent_reflectance_blue.tif",
                  "K:\\Environmental_Studies\\hkropp\\GIS\\drone\\Dome\\maps\\07_29_21_dome_transparent_reflectance_green.tif",
                  "K:\\Environmental_Studies\\hkropp\\GIS\\drone\\Dome\\maps\\07_29_21_dome_transparent_reflectance_red.tif",
                  "K:\\Environmental_Studies\\hkropp\\GIS\\drone\\Dome\\maps\\07_29_21_dome_transparent_reflectance_red edge.tif",
                  "K:\\Environmental_Studies\\hkropp\\GIS\\drone\\Dome\\maps\\07_29_21_dome_transparent_reflectance_nir.tif")
plot(dome.ref)

plotRGB(dome.ref, r=3,g=2,b=1, scale=0.1)

ndvi.dome <- (dome.ref[[5]]-dome.ref[[3]])/(dome.ref[[5]]+dome.ref[[3]])
plot(ndvi.dome)
viewRGB(dome.ref, quantiles=c(0.01,1))

mapview(ndvi.dome)


dome.test <- stack("E:/Google Drive/GIS/drone/Dome/agi/test.tif")
plot(dome.test)
