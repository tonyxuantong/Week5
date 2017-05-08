library(raster)
getwd()
# Prepare separate folders for landsat data.
dir.create("Landsat1970")
dir.create("Landsat1980")

# Download and extract the data into the folders.
download.file('https://www.dropbox.com/s/i1ylsft80ox6a32/LC81970242014109-SC20141230042441.tar.gz', destfile = '1970.tar.gz', method = 'auto')
untar("LC81970242014109-SC20141230042441.tar.gz", list = FALSE, exdir ="Landsat1970")
download.file('https://www.dropbox.com/s/akb9oyye3ee92h3/LT51980241990098-SC20150107121947.tar.gz', destfile = '1980.tar.gz', method = 'auto')
untar("LT51980241990098-SC20150107121947.tar.gz", list = FALSE, exdir ="Landsat1980")

# When passed without arguments, list.files() returns a character vector, listing the content of the working directory.
list.files("Landsat1970")
list.files("Landsat1980")
list.files("Landsat1970",pattern = glob2rx('*.tif'))
list.files("Landsat1980",pattern = glob2rx('*.tif'))

Landsat1970A3 <- raster('Landsat1970/LC81970242014109LGN00_sr_band3.tif')
Landsat1970A3
Landsat1970A4 <- raster('Landsat1970/LC81970242014109LGN00_sr_band4.tif')
Landsat1970A4
Landsat1980B4 <- raster('Landsat1980/LT51980241990098KIS00_sr_band4.tif')
Landsat1980B4
Landsat1980B5 <- raster('Landsat1980/LT51980241990098KIS00_sr_band5.tif')
Landsat1980B5
plot(Landsat1980B1)

# Calculate 1970 ndvi
ndvi1970 <- (Landsat1970A4 - Landsat1970A3) / (Landsat1970A4 + Landsat1970A3)
# Plot and save 1970 ndvi in jpeg format
jpeg('ndvi1970.jpg')
plot(ndvi1970)
dev.off()

# Calculate 1980 ndvi
ndvi1980 <- (Landsat1980B5 - Landsat1980B4) / (Landsat1980B5 + Landsat1980B4)
# Plot and save 1970 ndvi in jpeg format
jpeg('ndvi1980.jpg')
plot(ndvi1980)
dev.off()

# plot(ndvi1970)
# e <- drawExtent(show=TRUE)

# ndvi1980_crop <- crop(ndvi1980, e)
# jpeg('ndvi1980_crop.jpg')
# plot(ndvi1980_crop)
# dev.off()

# Calculate the difference between 1980 and 1970 ndvi
intersect(ndvi1980, ndvi1970)
ndvidiff <- ndvi1980-ndvi1970
# Plot and save ndvi difference graph in jpeg format
jpeg('ndvidiff.jpg')
plot(ndvidiff)
dev.off()

