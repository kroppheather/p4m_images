####################Set file paths before running ####################

#file path with raw flight images, unsorted 
fileDir <- "K:\\Environmental_Studies\\hkropp\\GIS\\drone\\campus\\P4M\\flight_6_18_21_p1\\raw"


#file path to save the sorted flight images
#must contain a folder called multi and a folder called rgb
fileOut <- "K:\\Environmental_Studies\\hkropp\\GIS\\drone\\campus\\P4M\\flight_6_18_21_p1"




#########################Does not need to change ##############################

### multispectral images ###
#get file names for all files ending in .tif
#just file names  for copying
filesM <- list.files(fileDir, pattern="\\.TIF")
#original file
#file names with the file path
filesMf <- list.files(fileDir, pattern="\\.TIF",full.names = TRUE)

### rgb true color ###
#jpg file names
filesJ <- list.files(fileDir, pattern="\\.JPG")
#jpg file names with paths
filesJf <- list.files(fileDir, pattern="\\.JPG",full.names = TRUE)

file.copy(filesMf,
          paste0(fileOut,"\\multi\\",filesM))

file.copy(filesJf,
          paste0(fileOut,"\\rgb\\",filesJ))



