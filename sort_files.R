fileDir <- "C:\\Users\\hkropp\\Google Drive\\GIS\\drone\\campus\\P4M\\flight_6_10_21\\raw\\100FPLAN"

filesM <- list.files(fileDir, pattern="\\.TIF")
filesMf <- list.files(fileDir, pattern="\\.TIF",full.names = TRUE)
filesJ <- list.files(fileDir, pattern="\\.JPG")
filesJf <- list.files(fileDir, pattern="\\.JPG",full.names = TRUE)

file.copy(filesMf,
          paste0("C:\\Users\\hkropp\\Google Drive\\GIS\\drone\\campus\\P4M\\flight_6_10_21\\multi\\",filesM))

file.copy(filesJf,
          paste0("C:\\Users\\hkropp\\Google Drive\\GIS\\drone\\campus\\P4M\\flight_6_10_21\\rgb\\",filesJ))
