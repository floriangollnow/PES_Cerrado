#mapbiomas soy area and deforestation plus protected areas and indiginous lands
## change to binned 
library(raster)
library(rasterVis)
library(sf)
library(tidyverse)
library(rmapshaper)

raster_dir <- "/Users/floriangollnow/Dropbox/PaperRachael/Data/Port Cost Assesment/"
out <- '/Users/floriangollnow/Dropbox/PaperRachael/Data'
#spatial
boundary <- (read_sf (file.path(out, "cerrado_border","limite_cerrado_wgs84.shp")))
munis <- read_sf (file.path(out, "municipalities_cerrado_biome","municipalities_cerrado_biome_wgs84.shp"))
states <- read_rds (file.path(out, "ibge","StatesBR_WGS84.rds"))
mask_file <- read_rds(file.path (raster_dir , "mask_file.rds")) %>% filter (mask==0) %>% st_zm ()
#pa <- read_sf (file.path(out, "conservation_units_cerrado_biome","conservation_units_cerrado_biome_wgs84.shp")) %>% mutate(Designation="PA") %>% dplyr::select (Designation)
#ind <- read_sf (file.path(out, "indigeneous_area_cerrado_biome","indigeneous_area_cerrado_biome_wgs84.shp"))%>% mutate(Designation="Indigenous") %>% dplyr::select(Designation)
#pa_ind <- rbind (pa , ind)
munis <- munis %>% ms_simplify()
states <- states %>% ms_simplify()
mask_file <- mask_file%>% ms_simplify()
bb <- st_bbox(munis)

matop <- read_rds ( file.path(out, "Matopiba","Matopiba_WGS84.rds"))
matop <- matop %>% mutate(Matopiba="")

#main_lu
rents <- raster(file.path(raster_dir,"rent.tif"))

boundary_trans <- boundary %>% st_transform  (crs=st_crs(rents))
mask_file_trans <- mask_file %>% st_transform ( crs=st_crs(rents))
mask_file_trans <- mask_file_trans %>% st_crop(st_bbox(boundary_trans))
#main_lu<- aggregate(main_lu,max)
rents <-  crop (rents, extent(boundary_trans))
rents_m1<- raster::mask(rents, boundary_trans)
rents_m2<- raster::mask(rents_m1, mask_file)

rents_m <- rents_m2

rents_m <- raster::aggregate(rents_m,2, fun=mean)
rents_m_p <- projectRaster (rents_m, crs=crs(boundary))
#convert to ha
rents_ha <-(rents_m_p/6.25)-870
rents_ha[rents_ha<0] <- 0
plot(rents_ha)
plot (boundary, add=TRUE)
#plot(soym)
rents.coord<- xyFromCell(rents_ha, seq_len(ncell(rents_ha)))
rents.df <- as.data.frame(getValues(rents_ha))
names(rents.df)<-"value"
rents.df1 <- cbind(rents.coord, rents.df)

gg_rents <- ggplot() +
  geom_sf(data=munis, color = NA, fill = "grey50", size=0.5)+
  geom_tile(data=rents.df1,  aes(x,y, fill = value)) +
  scale_fill_viridis_c( name="Soy estimated profit\nin US$/ha", na.value = NA)+
  geom_sf(data=states, color = "grey60", fill = NA, size=0.5)+
  geom_sf(data=matop, aes(color=Matopiba), fill = NA, size=0.7, show.legend = 'line')+
  coord_sf(xlim = c(bb[1], bb[3]), ylim = c(bb[2], bb[4]), expand = FALSE) +
  theme_bw()+
  theme(legend.position = "top", axis.title.x=element_blank(),axis.title.y=element_blank())+
  guides(fill = guide_colorbar(order = 1),col = guide_legend(order = 2))# ,legend.box="vertical"

gg_rents
write_rds(gg_rents, file.path(out,"ggplots","gg_rents.rds"))
ggsave (file.path(out, "map_rents.png"))



gg_rents <- ggplot() +
  geom_tile(data=rents.df1,  aes(x,y, fill = value)) +
  scale_fill_viridis_c(trans='log2', name="Soy estimated profit\nin US$/ha", na.value = NA)+
  geom_sf(data=states, color = "grey60", fill = NA, size=0.5)+
  geom_sf(data=matop, aes(color=Matopiba), fill = NA, size=0.7, show.legend = 'line')+
  coord_sf(xlim = c(bb[1], bb[3]), ylim = c(bb[2], bb[4]), expand = FALSE) +
  theme_bw()+
  theme(legend.position = "top", axis.title.x=element_blank(),axis.title.y=element_blank())+
  guides(fill = guide_colorbar(order = 1),col = guide_legend(order = 2))# ,legend.box="vertical"

gg_rents
ggsave (file.path(out, "map_log_rents.png"))
write_rds(gg_rents, file.path(out,"ggplots","gg_log_rents.rds"))
#ggsave (file.path(out, "map_log_rents.png"))


#test
test1 <- "https://www.dropbox.com/sh/23pfg0s0scg8avv/AABH27kyktl3ihrzOOJGXaCDa?dl=0"
test2<- "https://www.dropbox.com/sh/23pfg0s0scg8avv/AABH27kyktl3ihrzOOJGXaCDa?dl=0"
test3 <- "https://www.dropbox.com/sh/23pfg0s0scg8avv/AABH27kyktl3ihrzOOJGXaCDa?dl=0"
test4 <- "https://www.dropbox.com/sh/23pfg0s0scg8avv/AABH27kyktl3ihrzOOJGXaCDa?dl=0"
test1==test4
