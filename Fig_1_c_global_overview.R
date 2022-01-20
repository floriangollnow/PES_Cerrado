# preparing global inset map
library(raster)
library(rasterVis)
library(sf)
library(tidyverse)
library(rmapshaper)
library("rnaturalearth")
library("rnaturalearthdata")
out <- '/Users/floriangollnow/Dropbox/ZDC_project/PaperRachael/Data'
#spatial
boundary <- read_sf (file.path(out, "cerrado_border","limite_cerrado_wgs84.shp"))
munis <- read_sf (file.path(out, "municipalities_cerrado_biome","municipalities_cerrado_biome_wgs84.shp"))

world <- ne_countries(scale = "medium", returnclass = "sf")
class(world)
world <- world %>% st_transform(crs = "+proj=laea +lat_0=-10 +lon_0=-70 +x_0=0 +y_0=0 +a=6370997 +b=6370997 +units=m +no_defs ")
bb <- st_bbox(world)

boundary <- boundary %>%  st_transform (crs = "+proj=laea +lat_0=-10 +lon_0=-70 +x_0=0 +y_0=0 +a=6370997 +b=6370997 +units=m +no_defs ")
bb_st <- st_as_sfc(st_bbox(boundary))
gg_world<- ggplot() +
  geom_sf(data=world)+
  geom_sf(data=bb_st, fill=NA, color="red", size=1) +
  theme_minimal()
gg_world
write_rds(gg_world, file.path(out,"ggplots","gg_world.rds"))
