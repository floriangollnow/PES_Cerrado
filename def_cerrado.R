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

#deforestaion<- raster ()
deforestation<- read_sf(file.path (out, "yearly_deforestation_2002_2019_cerrado_biome", "yearly_deforestation_2000_2019_cerrado_biome.shp"))
deforestation <-  deforestation %>% st_transform(crs=4327)
deforestation <- deforestation %>% group_by(year, main_class) %>%  summarise (area_km=sum(area_km))
deforestation_s <- deforestation %>% ms_simplify()
write_rds (deforestation_s,file.path (out, "yearly_deforestation_2002_2019_cerrado_biome", "yearly_deforestation_2000_2019_cerrado_biome_simplified.rds" ))

ggplot() +
  geom_sf(data=deforestation_s, aes (fill=year),color=NA) +
  #geom_sf(data=pa_ind, aes (color=Designation ),alpha=0.7) +
  #scale_color_manual (values=c("Indiginous"="#d8b365", "PA"="#5ab4ac"))+
  geom_sf(data=states, color = "white", fill = NA, size=1) +
  geom_sf(data=munis,color = "white", fill = NA, size=0.3) +
  coord_sf(xlim = c(bb[1], bb[3]), ylim = c(bb[2], bb[4]), expand = FALSE)+
  theme (legend.position = "top")
