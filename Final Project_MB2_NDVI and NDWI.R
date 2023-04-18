library(raster)
library(rgdal)
library(sp)
library(ggplot2)
library(dtplyr)
library(lattice)
library(rasterVis)
library(tidyverse)


setwd("J:/R project/LC08_L2SP_136045_20181231_31.12.2018") 
getwd()
#raster layer creation
visible_red_2018=raster("J:/R project/LC08_L2SP_136045_20181231_31.12.2018/LC08_L2SP_136045_20181231_20200830_02_T1_SR_B4.TIF")
visible_red_2018
near_infrared_2018=raster("J:/R project/LC08_L2SP_136045_20181231_31.12.2018/LC08_L2SP_136045_20181231_20200830_02_T1_SR_B5.TIF")
near_infrared_2018
#ndvi calculation
ndvi_2018= (near_infrared_2018-visible_red_2018)/(near_infrared_2018+visible_red_2018)
plot(ndvi_2018)
#Save output
writeRaster(ndvi_2018,"NDVI2018_output",format="GTIFF",type="INT2U",overwrite=TRUE)
setwd("J:/R project/LC08_L2SP_136045_20131217_12.17.2013")
getwd()
visible_red_2013=raster("J:/R project/LC08_L2SP_136045_20131217_12.17.2013/LC08_L2SP_136045_20131217_20200912_02_T1_SR_B4.TIF")
near_infrared_2013=raster("J:/R project/LC08_L2SP_136045_20131217_12.17.2013/LC08_L2SP_136045_20131217_20200912_02_T1_SR_B5.TIF")
ndvi_2013= (near_infrared_2013-visible_red_2013)/(near_infrared_2013+visible_red_2013)
plot(ndvi_2013)
writeRaster(ndvi_2013,"NDVI2013_output",format="GTIFF", type="INT2U", overwrite=TRUE)
setwd("J:/R project/LC08_L2SP_136045_20221226_26.12.2022")
getwd()
visible_red_2022=raster("J:/R project/LC08_L2SP_136045_20221226_26.12.2022/LC08_L2SP_136045_20221226_20230103_02_T1_SR_B4.TIF")
near_infrared_2022=raster("J:/R project/LC08_L2SP_136045_20221226_26.12.2022/LC08_L2SP_136045_20221226_20230103_02_T1_SR_B5.TIF")
ndvi_2022= (near_infrared_2022-visible_red_2022)/(near_infrared_2022+visible_red_2022)
plot(ndvi_2022)
writeRaster(ndvi_2022,"NDVI2022_output",format="GTIFF", type="INT2U", overwrite=TRUE)
setwd("J:/R project/NDVI")
list.files()
#Creating new raster layers
r= raster("NDVI2013_output.tif")
r
r1=raster("NDVI2018_output.tif")
r1
r2=raster("NDVI2022_output.tif")
r2
#Reprojecting newly created rasters
r1_rprj <- projectRaster(r1, crs= crs(r))
r2_rprj <- projectRaster(r2, crs = crs(r))
#Resampling newly created rasters
r1_rsmp <- resample(r1_rprj,r,method= "bilinear")
r2_rsmp <- resample(r2_rprj,r, method="bilinear")
#Stacking the rasters
st<- stack(r,r1_rsmp,r2_rsmp)
crs(st)
st
STT <- stack(mget(rep("st")))
names(STT)
#plotting NDVI for different years
plot(STT)
writeRaster(STT,"NDVI_TS_output",format="GTIFF", type="INT2U", overwrite=TRUE)
# NDWI 
setwd("J:/R project/LC08_L2SP_136045_20131217_12.17.2013")
getwd()
NIR_2013 = raster("J:/R project/LC08_L2SP_136045_20131217_12.17.2013/LC08_L2SP_136045_20131217_20200912_02_T1_SR_B5.TIF")
SWIR_2013 = raster("J:/R project/LC08_L2SP_136045_20131217_12.17.2013/LC08_L2SP_136045_20131217_20200912_02_T1_SR_B6.TIF")
#NDWI Calculation
NDWI_2013=(NIR_2013-SWIR_2013)/(NIR_2013+SWIR_2013)
plot(NDWI_2013)
#Save Output
writeRaster(NDWI_2013,"NDWI_2013_output",format="GTIFF", type="INT2U", overwrite=TRUE)

setwd("J:/R project/LC08_L2SP_136045_20181231_31.12.2018")
getwd()
NIR_2018 = raster("J:/R project/LC08_L2SP_136045_20181231_31.12.2018/LC08_L2SP_136045_20181231_20200830_02_T1_SR_B5.TIF")
SWIR_2018 = raster("J:/R project/LC08_L2SP_136045_20181231_31.12.2018/LC08_L2SP_136045_20181231_20200830_02_T1_SR_B6.TIF")
NDWI_2018 = (NIR_2018-SWIR_2018)/(NIR_2018+SWIR_2018)
plot(NDWI_2018)
writeRaster(NDWI_2018,"NDWI_2018_output",format="GTIFF", type="INT2U", overwrite=TRUE)
setwd("J:/R project/LC08_L2SP_136045_20221226_26.12.2022")
getwd()
NIR_2022 = raster("J:/R project/LC08_L2SP_136045_20221226_26.12.2022/LC08_L2SP_136045_20221226_20230103_02_T1_SR_B5.TIF")
SWIR_2022 = raster("J:/R project/LC08_L2SP_136045_20221226_26.12.2022/LC08_L2SP_136045_20221226_20230103_02_T1_SR_B6.TIF")
NDWI_2022 = (NIR_2022-SWIR_2022)/(NIR_2022+SWIR_2022)
plot(NDWI_2022)

writeRaster(NDWI_2022,"NDWI_2022_output",format="GTIFF", type="INT2U", overwrite=TRUE)

setwd("J:/R project/NDWI")
list.files()
#Creating new raster layer of NDWI
w= raster("NDWI_2013_output.tif")
w
w1=raster("NDWI_2018_output.tif")
w1
w2 =raster("NDWI_2022_output.tif")
w2
#Reprojecting newly created rasters
w1_rprj <- projectRaster(w1, crs= crs(w)) 
w2_rprj <- projectRaster(w2, crs = crs(w))
#Resampling newly created rasters
w1_rsmp <- resample(w1_rprj,w,method= "bilinear") #resampling
w2_rsmp <- resample(w2_rprj,w, method="bilinear")
#Raster stacking
st_w <- stack(w,w1_rsmp,w2_rsmp) 
crs(st_w)
st_w
STT_W <- stack(mget(rep("st_w")))
names(STT_W)
#Plotting NDWI for different years
plot(STT_W)

writeRaster(STT_W,"NDWI_TS_output",format="GTIFF", type="INT2U", overwrite=TRUE)
