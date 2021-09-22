# tenure

#average income
library(tidyverse)
library(sf)
library (ggplot2)
library (ggpubr)
library(wesanderson)
library(rmapshaper)
library(viridis)

out <- '/Users/floriangollnow/Dropbox/ZDC_project/PaperRachael/Data'
# Proprietário(a) Owner
# Concessionaire or settler awaiting final title
# leesee
# partner
#?

soy_f <- read_rds ( file.path(out, "sidra/soy_farms_2017.rds"))
unique(soy_f$`Soja em grão`)

soy_f_p <- soy_f %>% mutate (soy_est_perc = (`Soja em grão`/Total)*100)

munis <- read_sf (file.path(out, "municipalities_cerrado_biome","municipalities_cerrado_biome_wgs84.shp"))%>% st_transform(munis, crs = 4326)
states <- read_rds (file.path(out, "ibge","StatesBR_WGS84.rds"))%>% st_transform(munis, crs = 4326)

munis <- munis %>% ms_simplify()
states <- states %>% ms_simplify()
matop <- read_rds ( file.path(out, "Matopiba","Matopiba_WGS84.rds"))%>% st_transform(munis, crs = 4326) %>% ms_simplify()
matop <- matop %>% mutate(Matopiba="")
munis_soy_p <- munis %>% left_join(soy_f_p, by = c("cd_geocmu"="Cód.") )

bb <- st_bbox(munis_soy_p)
gg_soyfarms<- ggplot ()+
  geom_sf(data=munis_soy_p, aes(fill=soy_est_perc), color=NA)+
  geom_sf(data=states, color = "black", fill = NA, size=0.5, lty="longdash")+#color = "grey60", fill = NA, size=0.5)+
  geom_sf(data=matop, color="white", fill = NA, size=1.6)+
  geom_sf(data=matop, aes(color=Matopiba), fill = NA, size=1.2, show.legend = 'line')+
  scale_color_manual (values="#a65628")+
  scale_fill_stepsn(name="Soy farms\nin %", colors= c("#edf8fb", "#9ebcda", "#8c6bb1", "#6e016b"), breaks=seq(0,100, by=25), limit=c(0,100))+
  
# scale_fill_viridis_c( name="Soy farms\nin %", limits=c(0,100))+
  coord_sf(xlim = c(bb[1], bb[3]), ylim = c(bb[2], bb[4]), expand = FALSE) +
  theme_bw()+
  theme(legend.position = "top", axis.title.x=element_blank(),axis.title.y=element_blank())+
  guides(fill = guide_colorbar(order = 1),col = guide_legend(order = 2))# ,legend.box="vertical"
  gg_soyfarms
write_rds(gg_soyfarms, file.path(out,"ggplots","gg_soyfarms.rds"))
ggsave (file.path(out, "map_soyfarms.png"))
  
