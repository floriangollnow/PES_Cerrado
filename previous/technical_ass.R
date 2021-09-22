library(tidyverse)
library(sf)
library (ggplot2)
library (ggpub)
library(wesanderson)
library(rmapshaper)

out <- '/Users/floriangollnow/Dropbox/PaperRachael/Data/'

tech <- read_rds ( file.path(out, "sidra/technical_ass_2017.rds"))

t_tech <- tech %>% filter(`Origem da orientação técnica recebida`=="Total") %>% rename(Valor_total = Valor) %>% select (`Município (Código)`,Valor_total )
r_tech <- tech %>% filter (`Origem da orientação técnica recebida`=="Recebe") %>% rename(Valor_rec = Valor)%>% select (`Município (Código)`,Valor_rec)
r_tech <- r_tech %>% left_join(t_tech)
r_tech <- r_tech %>% mutate (technical_ass = (Valor_rec/Valor_total)*100)

munis <- read_sf(file.path (out, "municipalities_cerrado_biome","municipalities_cerrado_biome_wgs84.shp"))
states <- read_rds (file.path(out, "ibge","StatesBR_WGS84.rds"))
munis <- munis %>% ms_simplify()
states <- states %>% ms_simplify()

matop <- read_rds ( file.path(out, "Matopiba","Matopiba_WGS84.rds"))
matop <- matop %>% mutate(Matopiba="")


munis_tech_p <- munis %>% left_join(r_tech, by = c("cd_geocmu"="Município (Código)") )

bb <- st_bbox(munis_tech_p)

gg_tech<- ggplot ()+
  geom_sf(data=munis_tech_p, aes(fill=technical_ass) ,color=NA)+
  geom_sf(data=states, color = "grey60", fill = NA, size=0.5)+
  scale_fill_viridis_c( name="Technical assistance\nin % farms")+
  geom_sf(data=matop, aes(color=Matopiba), fill = NA, size=0.7, show.legend = 'line')+
  coord_sf(xlim = c(bb[1], bb[3]), ylim = c(bb[2], bb[4]), expand = FALSE) +
  theme_bw()+
  theme(legend.position = "top", axis.title.x=element_blank(),axis.title.y=element_blank())+
  guides(fill = guide_colorbar(order = 1),col = guide_legend(order = 2))# ,legend.box="vertical"

gg_tech

write_rds(gg_tech, file.path(out,"ggplots","gg_tech.rds"))

ggsave (file.path(out, "map_technical_assistance.png"))




ggplot(mpg, aes(displ, hwy, col = cyl)) + 
  geom_point(size = 2,aes(shape = factor(cyl))) + 
  theme(legend.box.margin = margin(0.3,0.3,0.3,0.3,"cm"),legend.background = element_rect(color = "yellow")) + 
  guides(shape = guide_legend(title = "cyl")) + scale_shape_discrete(labels = c("a","b","c","d")) + 
  theme(legend.position = "bottom") + 
  guides(shape = guide_legend(order = 2),col = guide_legend(order = 1))

matop <- read_rds ( file.path(out, "Matopiba","Matopiba_WGS84.rds"))
matop <- matop %>% mutate(Matopiba="")

munis_zdc_p <- munis %>% left_join(trase_2018_zdc, by = c("cd_geocmu"="GEOCODE") )

bb <- st_bbox(munis_zdc_p)

gg_zdc<- ggplot ()+
  geom_sf(data=munis_zdc_p, aes(fill=ZDC_perc),color=NA)+
  geom_sf(data=states, color = "grey60", fill = NA, size=0.5)+
  geom_sf(data=matop, aes(color=Matopiba), fill = NA, size=0.7, show.legend = 'line')+
  scale_fill_viridis_c( name="ZDC market share %")+
  coord_sf(xlim = c(bb[1], bb[3]), ylim = c(bb[2], bb[4]), expand = FALSE) +
  theme_bw()+
  theme(legend.position = "top", axis.title.x=element_blank(),axis.title.y=element_blank())+
  guides(fill = guide_legend(order = 2),col = guide_legend(order = 1))# ,legend.box="vertical"
gg_zdc
write_rds(gg_zdc, file.path(out,"ggplots","gg_zdc.rds"))

ggsave (file.path(out, "map_ZDC.png"))



