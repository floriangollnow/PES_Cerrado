#average income
library(tidyverse)
library(sf)
library (ggplot2)
library (ggpubr)
library(wesanderson)
library(rmapshaper)

out <- '/Users/floriangollnow/Dropbox/PaperRachael/Data/'

income <- read_rds ( file.path(out, "sidra/mean_income_2010.rds"))
munis <- read_sf (file.path(out, "municipalities_cerrado_biome","municipalities_cerrado_biome_wgs84.shp"))
states <- read_rds (file.path(out, "ibge","StatesBR_WGS84.rds"))
munis <- munis %>% ms_simplify()
states <- states %>% ms_simplify()

munis_income <- munis %>% left_join(income, by = c("cd_geocmu"="Município (Código)") )
bb <- st_bbox(munis_income)
matop <- read_rds ( file.path(out, "Matopiba","Matopiba_WGS84.rds"))
matop <- matop %>% mutate(Matopiba="")
gg_income<- ggplot ()+
  geom_sf(data=munis_income, aes(fill=Valor/1000),color=NA)+
  geom_sf(data=states, color = "grey60", fill = NA, size=0.5)+
  geom_sf(data=matop, aes(color=Matopiba), fill = NA, size=0.7, show.legend = 'line')+
  scale_fill_viridis_c( name="Mean monthly income\nin 1000 BRL")+
  coord_sf(xlim = c(bb[1], bb[3]), ylim = c(bb[2], bb[4]), expand = FALSE)+
  theme_bw()+
  theme(legend.position = "top", axis.title.x=element_blank(),axis.title.y=element_blank())# ,legend.box="vertical"
gg_income
write_rds(gg_income, file.path(out,"ggplots","gg_income.rds"))
ggsave (file.path(out, "map_income.png"))


