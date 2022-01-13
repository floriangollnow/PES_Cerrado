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
pa <- read_sf (file.path(out, "conservation_units_cerrado_biome","conservation_units_cerrado_biome_wgs84.shp")) %>% mutate(Designation="PA") %>% select (Designation)
ind <- read_sf (file.path(out, "indigeneous_area_cerrado_biome","indigeneous_area_cerrado_biome_wgs84.shp"))%>% mutate(Designation="Indiginous") %>% select(Designation)
pa_ind <- rbind (pa , ind)

munis <- munis %>% ms_simplify()
states <- states %>% ms_simplify()
bb <- st_bbox(munis)

#deforestationsoy <- raster()



# soy
soy <- raster(file.path(raster_dir,"MapBiomas_soy2019_cerrado_500_v5.tif"))
#soy<- aggregate(soy,1000,max)
soym <- mask(soy, boundary)

soy <-soym
#plot(soym)
soy.coord<- xyFromCell(soy, seq_len(ncell(soy)))
soy.df <- as.data.frame(getValues(soy))
names(soy.df)<-"value"
soy.df$value <- factor(soy.df$value, levels = c("1","0"))
soy.df1 <- cbind(soy.coord, soy.df)

gg_soy<-ggplot() +
  geom_tile(data=soy.df1 ,  aes(x,y, fill = value)) +
  scale_fill_manual(values = c("#c59ff4", "#e5f5e0"), na.value=NA,na.translate = F,
                      name = "LUC", labels = c("Soy", "Other"))+
  geom_sf(data=states, color = "white", fill = NA, size=0.5) +
  #geom_sf(data=munis,color = "white", fill = NA, size=0.1) +
  geom_sf(data=pa_ind, aes (color=Designation ),alpha=0.5) +
  scale_color_manual (values=c("Indiginous"="#d8b365", "PA"="#5ab4ac"))+
  coord_sf(xlim = c(bb[1], bb[3]), ylim = c(bb[2], bb[4]), expand = FALSE)+
  theme(legend.position = "top",legend.box="vertical", axis.title.x=element_blank(),axis.title.y=element_blank())
write_rds(gg_soy, file.path(out,"ggplots","gg_soy.rds"))

gg_soy



