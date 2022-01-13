
#preprocess rents data
library(sf)
library(raster)
library(tidyverse)
library(rmapshaper)

dir_rents <- "/Users/floriangollnow/Dropbox/SESYNC GIS Database/dinamica/rent/2014"
dir_agri <- "/Users/floriangollnow/Dropbox/SESYNC GIS Database/agricultural Data"
dir_muni <- "/Users/floriangollnow/Dropbox/SESYNC GIS Database/Admin/EqualArea"

raster_dir <- "/Users/floriangollnow/Dropbox/PaperRachael/Data/Port Cost Assesment/"

dir(dir_rents)
rent <- raster(file.path(dir_rents,"rent.tif"))

dir(dir_muni)
muni <- read_sf(file.path(dir_muni, "level2.shp"))
muniBR <- muni %>% filter (str_detect(Identifier, "BR"))

#ggplot(muni , aes (fill=ID))+geom_sf()

dir(di_agri)
agri <- read.csv (file.path (dir_agri, "agriData_fg.csv"))
agri14 <- agri %>%  filter (year==2014)

muniBR <- muniBR %>% left_join(agri14, by=c("Identifier"="yannID."))
muniBR <- muniBR %>% mutate (mask= case_when(is.na(soyYield)~1, 
                                             TRUE~0))
write_rds(muniBR, file.path (raster_dir , "mask_file.rds")) 

# muniBR_simple <- muniBR %>% ms_simplify()
# ggplot (muniBR_simple, aes (fill=mask))+geom_sf()
# 
# ## crop rents to brazil
# rentBR <- crop (rent, extent(muniBR))
# plot(rentBR)
# 
# #
# mask_muniBR <- muniBR %>% filter (mask==0) %>% st_zm () %>% as_Spatial()
# rentBR_mask <- raster::mask(rentBR, mask_muniBR,filename=file.path(raster_dir, "rent14_masked.tif"))
# 
# writeRaster (rentBR_mask, filename=file.path(raster_dir, "rent14_masked.tif"))



