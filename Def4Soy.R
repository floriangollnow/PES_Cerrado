#mapbiomas soy area and soy deforestation plus protected areas and indiginous lands

library(raster)
library(rasterVis)
library(sf)
library(tidyverse)
library(rmapshaper)
library(ggpattern)
# directories
raster_dir <- "/Users/floriangollnow/Dropbox/ZDC_project/PaperRachael/Data/Mapbiomas"
out <- '/Users/floriangollnow/Dropbox/ZDC_project/PaperRachael/Data'
#spatial
cerrado <- read_sf (file.path(out, "cerrado_border","limite_cerrado_wgs84.shp"))
cerrado <- cerrado %>% st_transform(crs = 4326)
boundary <- as_Spatial(cerrado)
munis <- read_sf (file.path(out, "municipalities_cerrado_biome","municipalities_cerrado_biome_wgs84.shp"))
munis <- munis %>% st_transform(crs = 4326)
states <- read_rds (file.path(out, "ibge","StatesBR_WGS84.rds"))
# simplify spatial data for plotting
munis <- munis %>% ms_simplify()
states <- states %>% ms_simplify()
bb <- st_bbox(munis)
# read Mapbiomas shape
matop <- read_rds ( file.path(out, "Matopiba","Matopiba_WGS84.rds"))
matop <- matop %>% mutate(Matopiba="")

# read raster data
# soy deforestation
main_lu <- raster(file.path(raster_dir,"mapbiomas_SDEF_Cerrado_500_v5.tif"))
# lu
soy_suit <- raster (file.path(raster_dir,"mapbiomas_FFSS_GAEZapt_Cerrado_1000_v5.tif"))
#//1 Forest, 2 Suitable Forest, 3 Pasture, 4Crop,8 grassland, 9 water, 5 soy , 6 soy-def 00-10,7 soy-def 11-18 

# reclassify lu data
soy_suit <- reclassify(soy_suit, rcl=matrix(c(0,NA, 1,4, 2,5, 3,3, 4,NA, 5,1, 6,NA, 7,NA, 8,NA, 9,NA),byrow = T, ncol = 2 ))
main_lu <- reclassify(main_lu, rcl=matrix(c(0,NA,1,2,2,2),byrow = T, ncol = 2 ))
main_lu<- aggregate(main_lu,4,fun=max)# aggregate soy-defroestation data, to increas visibility
main_lum <- mask(main_lu, boundary)
main_lu <-main_lum
# mask rasters to Cerrado area
main_lu <- mask(main_lu, boundary)
soy_suit <- mask(soy_suit, boundary)
# resample data to same resolution
main_lu<- resample( main_lu,soy_suit, method='ngb')
extent(main_lu)== extent(soy_suit)

#combine  soy deforestation and soy suit, highlighting soy-deforestation by larger pixel size
fq1 <- function(x, y){ 
   ifelse(!is.na(y), y,x)}
fq1(test1, test2)
main_lu <- overlay(x=soy_suit, y=main_lu, fun=fq1)

# prepare data for ggplot
main_lu.coord<- xyFromCell(main_lu, seq_len(ncell(main_lu)))
main_lu.df <- as.data.frame(getValues(main_lu))
names(main_lu.df)<-"value"
main_lu.df$value <- factor(main_lu.df$value, levels = c("1","2","3","4","5"))
main_lu.df1 <- cbind(main_lu.coord, main_lu.df)

##crop state names
states_cropped <- st_crop(states, bb)
states_cropped <- states_cropped %>% filter (State_abb!="ES", State_abb!="RO")

gg_lu <- ggplot() +
  geom_sf (data=cerrado, fill="grey90", color=NA)+
  geom_tile(data=main_lu.df1,  aes(x,y, fill = value)) +
  scale_fill_manual(values = c("1"="#c59ff4", "2"="#d01c8b", "3"="#FFFFB2","4"="#7fbc41", "5"="#129912" ), na.value=NA,# c("1"="#c59ff4", "2"="#e66101")"#f1b6da"
                    name = "LUCC", labels = c("Soy", "Soy-\nDeforestation","Pasture" , "Forest", "Soy-suitable\nForest"), na.translate=FALSE)+
  geom_sf(data=states,color = "black", fill = NA, size=0.5, lty="longdash")+
  geom_sf(data=matop, color="white", fill = NA, size=1.6)+
  geom_sf(data=matop, aes(lty=Matopiba), color="#FF6700",fill = NA, size=1.2)+#"#7570b3"#5e3c99
  geom_sf_label(data=states_cropped, aes(label = State_abb),nudge_x = c(0,0,0,0,0,0,0,-1.8,0,-1.2,0,0,0,0), nudge_y = c(0,0,0,0,0,0,0,0.8,0,-1.5,0,0,0,0),alpha=0.6)+
  coord_sf(xlim = c(bb[1], bb[3]), ylim = c(bb[2], bb[4]), expand = FALSE)+
  theme_bw()+
  theme(legend.position = "right", axis.title.x=element_blank(),axis.title.y=element_blank())# ,legend.box="vertical", legend.box="vertical",
#gg_lu

write_rds(gg_lu, file.path(out,"ggplots","gg_soydef10.rds"))
ggsave(file.path(out,"gg_soydef_test10.png"))


