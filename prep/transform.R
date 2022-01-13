library(tidyverse)
library(sf)
dir_shape <- "/Users/floriangollnow/Dropbox/PaperRachael/Data/cerrado_border/"

cerrado <- read_sf (file.path(dir_shape, "limite_cerrado.shp"))
plot (cerrado)
cerrado_wgs84 <- cerrado %>% st_transform(crs=4327)
write_sf (cerrado_wgs84, file.path(dir_shape, "limite_cerrado_wgs84.shp"))


dir_shape <- "/Users/floriangollnow/Dropbox/PaperRachael/Data/states_cerrado_biome"

cerrado <- read_sf (file.path(dir_shape, "states_cerrado_biome.shp"))
plot (cerrado)
cerrado_wgs84 <- cerrado %>% st_transform(crs=4327)
write_sf (cerrado_wgs84, file.path(dir_shape, "states_cerrado_biome_wgs84.shp"))


dir_shape <- "/Users/floriangollnow/Dropbox/PaperRachael/Data/municipalities_cerrado_biome"

cerrado <- read_sf (file.path(dir_shape, "municipalities_cerrado_biome.shp"))
cerrado
#plot (cerrado)
cerrado_wgs84 <- cerrado %>% st_transform(crs=4327)
write_sf (cerrado_wgs84, file.path(dir_shape, "municipalities_cerrado_biome_wgs84.shp"))


hydrography_cerrado_biome


dir_shape <- "/Users/floriangollnow/Dropbox/PaperRachael/Data/hydrography_cerrado_biome"

cerrado <- read_sf (file.path(dir_shape, "hydrography_cerrado_biome.shp"))
cerrado
#plot (cerrado)
cerrado_wgs84 <- cerrado %>% st_transform(crs=4327)
write_sf (cerrado_wgs84, file.path(dir_shape, "hydrography_cerrado_biome_wgs84.shp"))


dir_shape <- "/Users/floriangollnow/Dropbox/PaperRachael/Data/conservation_units_cerrado_biome"

cerrado <- read_sf (file.path(dir_shape, "conservation_units_cerrado_biome.shp"))
cerrado
#plot (cerrado)
cerrado_wgs84 <- cerrado %>% st_transform(crs=4327)
write_sf (cerrado_wgs84, file.path(dir_shape, "conservation_units_cerrado_biome_wgs84.shp"))



dir_shape <- "/Users/floriangollnow/Dropbox/PaperRachael/Data/indigeneous_area_cerrado_biome"

cerrado <- read_sf (file.path(dir_shape, "indigeneous_area_cerrado_biome.shp"))
cerrado
#plot (cerrado)
cerrado_wgs84 <- cerrado %>% st_transform(crs=4327)
write_sf (cerrado_wgs84, file.path(dir_shape, "indigeneous_area_cerrado_biome_wgs84.shp"))

#extract state boundaries from shape
dir_shape <- "/Users/floriangollnow/Dropbox/PaperRachael/Data/ibge"

br_mu <- read_rds (file.path(dir_shape, "BRMUE250GC_all_biomes_WGS84.rds")) 
br_mu<- br_mu %>% mutate (state_uf = str_sub(CD_GEOCMU,start = 0,end=2))
br_mu$state_uf
br_st <- br_mu %>% group_by(State_abb) %>% summarise(State = first(State),
                                                     state_uf = first(state_uf))
write_rds (br_st, file.path(dir_shape, "StatesBR_WGS84.rds"))
ggplot()+geom_sf(data=br_st, aes(fill=state_uf))

