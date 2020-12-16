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

munis <- read_sf (file.path(out, "municipalities_cerrado_biome","municipalities_cerrado_biome_wgs84.shp"))
states <- read_rds (file.path(out, "ibge","StatesBR_WGS84.rds"))
munis <- munis %>% ms_simplify()
states <- states %>% ms_simplify()

munis_tech_p <- munis %>% left_join(r_tech, by = c("cd_geocmu"="Município (Código)") )

bb <- st_bbox(munis_tech_p)

gg_tech<- ggplot ()+
  geom_sf(data=munis_tech_p, aes(fill=technical_ass) ,color=NA)+
  geom_sf(data=states, color = "white", fill = NA, size=0.5)+
  scale_fill_viridis_c( name="Technical assitance in % farms")+
  coord_sf(xlim = c(bb[1], bb[3]), ylim = c(bb[2], bb[4]), expand = FALSE) +
  theme(legend.position = "top", axis.title.x=element_blank(),axis.title.y=element_blank())

gg_tech

write_rds(gg_tech, file.path(out,"ggplots","gg_tech.rds"))

ggsave (file.path(out, "map_technical_assistance.png"))
