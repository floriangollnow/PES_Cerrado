# tenure

#average income
library(tidyverse)
library(sf)
library (ggplot2)
library (ggpub)
library(wesanderson)
library(rmapshaper)
library(viridis)

out <- '/Users/floriangollnow/Dropbox/PaperRachael/Data'
# Proprietário(a) Owner
# Concessionaire or settler awaiting final title
# leesee
# partner
#?

land <- read_rds ( file.path(out, "sidra/land_tenure_2017.rds"))
unique(land$`Condição do produtor em relação às terras`)

land_t <- land %>% filter(`Condição do produtor em relação às terras`=="Total") %>% rename(Valor_total = Valor) %>% select (`Município (Código)`,Valor_total )
land_p <- land %>% filter (`Condição do produtor em relação às terras`=="Proprietário(a)") %>% rename(Valor_p = Valor)%>% select (`Município (Código)`,Valor_p )
land_p <- land_p %>% left_join(land_t)
land_p <- land_p %>% mutate (land_p_perc = (Valor_p/Valor_total)*100)

munis <- read_sf (file.path(out, "municipalities_cerrado_biome","municipalities_cerrado_biome_wgs84.shp"))
states <- read_rds (file.path(out, "ibge","StatesBR_WGS84.rds"))
munis <- munis %>% ms_simplify()
states <- states %>% ms_simplify()

munis_land_p <- munis %>% left_join(land_p, by = c("cd_geocmu"="Município (Código)") )

bb <- st_bbox(munis_land_p)
gg_title<- ggplot ()+
  geom_sf(data=munis_land_p, aes(fill=land_p_perc), color=NA)+
  geom_sf(data=states, color = "white", fill = NA, size=0.5)+
  scale_fill_viridis_c( name="Land owned in %")+
  coord_sf(xlim = c(bb[1], bb[3]), ylim = c(bb[2], bb[4]), expand = FALSE) +
  theme(legend.position = "top", axis.title.x=element_blank(),axis.title.y=element_blank())
gg_title
write_rds(gg_title, file.path(out,"ggplots","gg_title.rds"))
ggsave (file.path(out, "map_title.png"))

