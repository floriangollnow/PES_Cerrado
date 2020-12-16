#mapbiomas soy area and deforestation plus protected areas and indiginous lands

library(raster)
library(rasterVis)
library(sf)
library(tidyverse)
library(rmapshaper)

raster_dir <- "/Users/floriangollnow/Dropbox/PaperRachael/Data/Mapbiomas"
out <- '/Users/floriangollnow/Dropbox/PaperRachael/Data'
#spatial
boundary <- as_Spatial(read_sf (file.path(out, "cerrado_border","limite_cerrado_wgs84.shp")))
munis <- read_sf (file.path(out, "municipalities_cerrado_biome","municipalities_cerrado_biome_wgs84.shp"))
states <- read_rds (file.path(out, "ibge","StatesBR_WGS84.rds"))
#pa <- read_sf (file.path(out, "conservation_units_cerrado_biome","conservation_units_cerrado_biome_wgs84.shp")) %>% mutate(Designation="PA") %>% select (Designation)
#ind <- read_sf (file.path(out, "indigeneous_area_cerrado_biome","indigeneous_area_cerrado_biome_wgs84.shp"))%>% mutate(Designation="Indiginous") %>% select(Designation)
#pa_ind <- rbind (pa , ind)
munis <- munis %>% ms_simplify()
states <- states %>% ms_simplify()
bb <- st_bbox(munis)

#deforestaion<- raster ()
#deforestationsoy <- raster()
#main_lu
main_lu <- raster(file.path(raster_dir,"MapBiomas_remap_cerrado_500_v5.tif"))

#main_lu<- aggregate(main_lu,max)
main_lum <- mask(main_lu, boundary)

main_lu <-main_lum
#plot(soym)
main_lu.coord<- xyFromCell(main_lu, seq_len(ncell(main_lu)))
main_lu.df <- as.data.frame(getValues(main_lu))
names(main_lu.df)<-"value"
main_lu.df$value <- factor(main_lu.df$value, levels = c("1","2","3","4","6"))
main_lu.df1 <- cbind(main_lu.coord, main_lu.df)

gg_lu <- ggplot() +
  geom_tile(data=main_lu.df1,  aes(x,y, fill = value)) +
  scale_fill_manual(values = c("1"="#129912", "2"="#B8AF4F", "3"="#E974ED", "4"="#FFFFB2", "6"="#D5D5E5"), na.value=NA, 
                      name = "LUC", labels = c("Forest", "Grassland", "Cropland", "Pasture", "Other"))+
  geom_sf(data=states, color = "white", fill = NA, size=0.5) +
  #geom_sf(data=munis,color = "white", fill = NA, size=0.1) +
  #geom_sf(data=pa_ind, aes (color=Designation ),alpha=0.5) +
  #scale_color_manual (values=c("Indiginous"="#d8b365", "PA"="#5ab4ac"))+
  coord_sf(xlim = c(bb[1], bb[3]), ylim = c(bb[2], bb[4]), expand = FALSE)+
  theme(legend.position = "top", legend.box="vertical",axis.title.x=element_blank(),axis.title.y=element_blank())

write_rds(gg_lu, file.path(out,"ggplots","gg_lu.rds"))
#gg_lu
#1 Forest 
#2 Grassland
#3 Croplands
#4 Pasture
#5 Water
#6 Other
