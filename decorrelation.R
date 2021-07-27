install.packages("raster")
install.packages("rgdal")
library(raster)
imge <- stack("E:/Google Drive/GIS/drone/campus/P4M/flight_05_03_21/ortho/odm_orthophotoRGB.tif")

#function from: https://gist.github.com/fickse/82faf625242f6843249774f1545d7958
dc_stretch <- function(r){
  
  # r must be a >= 3 band raster
  
  # determine eigenspace
  pc <- princomp(r[])
  
  # get inverse rotation matrix
  R0 <- solve(pc$loadings)
  
  # 'stretch' values in pc space, then transform back to RGB space
  fun <- function(x){(x-min(x))/(max(x)-min(x))*255}
  scp  <- apply(predict(pc), 2, function(x) scale(ecdf(x)(x), scale = FALSE))
  scpt <- scp %*% R0
  r[] <- apply(scpt, 2, fun)
  r
  
}

# example


dc <- dc_stretch(imge)
plotRGB(dc)
plotRGB(imge)
