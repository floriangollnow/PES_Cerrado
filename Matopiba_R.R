

library(tidyverse)
library(sf)
library (ggplot2)
library (ggpub)
library(wesanderson)
library(rmapshaper)
library(viridis)

out <- '/Users/floriangollnow/Dropbox/PaperRachael/Data'

#munis <- read_sf (file.path(out, "municipalities_cerrado_biome","municipalities_cerrado_biome_wgs84.shp"))
states <- read_rds (file.path(out, "ibge","StatesBR_WGS84.rds"))
boundary <-read_sf (file.path(out, "cerrado_border","limite_cerrado_wgs84.shp"))
#munis <- munis %>% ms_simplify()
states <- states %>% ms_simplify()

StatesM <-states %>% filter(State=="Bahia"|State=="Maranhão"|State=="Tocantins"|State=="Piauí")

ggplot(StatesM)+geom_sf(aes(state_uf))+geom_sf(data=boundary)

Matop <- StatesM %>% st_intersection(boundary) %>%  st_union() %>% st_as_sf() %>% mutate(Matopiba="Matopiba")




ggplot(Matop)+geom_sf(aes(Matopiba))
write_rds (Matop, file.path(out, "Matopiba","Matopiba_WGS84.rds"))

