library(tidyverse)
library(sf)
library (ggplot2)
library (ggpubr)
library(wesanderson)
library(rmapshaper)

out <- '/Users/floriangollnow/Dropbox/PaperRachael/Data/'

gini <- read_rds ( file.path(out, "sidra/gini_2010.rds"))
states_cerr <- read_sf (file.path(out, "states_cerrado_biome","states_cerrado_biome_wgs84.shp"))
states <- read_rds (file.path(out, "ibge","StatesBR_WGS84.rds"))
states_cerr <- states_cerr %>% ms_simplify()
states <- states %>% ms_simplify()

matop <- read_rds ( file.path(out, "Matopiba","Matopiba_WGS84.rds"))
matop <- matop %>% mutate(Matopiba="")

states_cerr_gini <- states_cerr %>% left_join(gini, by = c("CD_GEOCUF"="Unidade da Federação (Código)") )

bb <- st_bbox(states_cerr_gini)
gg_gini<- ggplot ()+
  geom_sf(data=states_cerr_gini, aes(fill=Valor),color=NA)+
  geom_sf(data=states, color = "grey60", fill = NA, size=0.5)+
  geom_sf(data=matop, aes(color=Matopiba), fill = NA, size=0.7, show.legend = 'line')+
  scale_fill_viridis_c( name="Gini index", limits=c(0.45,0.6),
                        breaks= c(0.45,0.5,0.55,0.6),labels=c(".45",".50",".55",".60"))+
  coord_sf(xlim = c(bb[1], bb[3]), ylim = c(bb[2], bb[4]), expand = FALSE)+
  theme_bw()+
  theme(legend.position = "top", axis.title.x=element_blank(),axis.title.y=element_blank())+
  guides(fill = guide_colorbar(order = 1),col = guide_legend(order = 2))# ,legend.box="vertical"

gg_gini

write_rds(gg_gini, file.path(out,"ggplots","gg_gini.rds"))

ggsave (file.path(out, "map_gini.png"))

