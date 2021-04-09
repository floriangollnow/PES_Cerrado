# tenure

#average income
library(tidyverse)
library(sf)
library (ggplot2)
library (ggpubr)
library(wesanderson)
library(rmapshaper)
library(viridis)

out <- '/Users/floriangollnow/Dropbox/PaperRachael/Data'
# Proprietário(a) Owner
# Concessionaire or settler awaiting final title
# leesee
# partner
#?
# PORT
# Proprietário(a)
# S # Concessionário(a) ou assentado(a) aguardando titulação definitiva
# S # Arrendatário(a)
# Parceiro(a)
# Comodatário(a)
# S # Ocupante
# Produtor sem área
##ENGL.
# Owner
# S # Concessionaire or settler awaiting final title 
# S # Lessee 
# Partner
# Commodator
# S # Occupant 
# Producer without area 


## tbd. update to definite land title instead of owners only!
land <- read_rds ( file.path(out, "sidra/land_tenure_2017.rds"))

land_t <- land %>% filter(`Condição do produtor em relação às terras`=="Total") %>% rename(Valor_total = Valor) %>% select (`Município (Código)`,Valor_total )
#land_p <- land %>% filter (`Condição do produtor em relação às terras`=="Proprietário(a)" |`Condição do produtor em relação às terras`=="Concessionário(a) ou assentado(a) aguardando titulação definitiva")
#land_p <- land %>% filter (`Condição do produtor em relação às terras`=="Ocupante" |`Condição do produtor em relação às terras`=="Produtor sem área")#|`Condição do produtor em relação às terras`=="Concessionário(a) ou assentado(a) aguardando titulação definitiva")
land_p <- land %>% filter (`Condição do produtor em relação às terras`=="Ocupante" |
                             `Condição do produtor em relação às terras`=="Arrendatário(a)"|
                             `Condição do produtor em relação às terras`=="Concessionário(a) ou assentado(a) aguardando titulação definitiva")
land_p <- land_p %>%  group_by(`Município (Código)`) %>% summarise(Valor_p=sum(Valor, na.rm=TRUE))

land_p <- land_p %>% left_join(land_t)
land_p <- land_p %>% mutate (land_p_perc = (Valor_p/Valor_total)*100)

munis <- read_sf (file.path(out, "municipalities_cerrado_biome","municipalities_cerrado_biome_wgs84.shp"))
states <- read_rds (file.path(out, "ibge","StatesBR_WGS84.rds"))

munis <- munis %>% ms_simplify()
states <- states %>% ms_simplify()
matop <- read_rds ( file.path(out, "Matopiba","Matopiba_WGS84.rds"))
matop <- matop %>% mutate(Matopiba="")
munis_land_p <- munis %>% left_join(land_p, by = c("cd_geocmu"="Município (Código)") )

munis_land_p <- munis_land_p %>% mutate(land_p_perc10 =if_else(land_p_perc >= 20,20, land_p_perc))
bb <- st_bbox(munis_land_p)

gg_title<- ggplot ()+
  geom_sf(data=munis_land_p, aes(fill=land_p_perc10), color=NA)+
  geom_sf(data=states, color = "grey60", fill = NA, size=0.5)+
  geom_sf(data=matop, aes(color=Matopiba), fill = NA, size=0.7, show.legend = 'line')+
  scale_fill_viridis_c(name="Properties without formal \nland title or rented %", limits=c(0,20),
                       breaks= c(0,5,10,15,20),labels=c("0","5","10","15", ">=20"))+
  #scale_fill_binned(breaks=c(0,1,5,10,20,40,100),type="viridis",  name="Farms ocupied or\nproducers without land in %")+
  coord_sf(xlim = c(bb[1], bb[3]), ylim = c(bb[2], bb[4]), expand = FALSE) +
  theme_bw()+
  theme(legend.position = "top", axis.title.x=element_blank(),axis.title.y=element_blank())+
  guides(fill = guide_colorbar(order = 1),col = guide_legend(order = 2))# ,legend.box="vertical"
  gg_title
write_rds(gg_title, file.path(out,"ggplots","gg_title.rds"))
ggsave (file.path(out, "map_title.png"))
  
