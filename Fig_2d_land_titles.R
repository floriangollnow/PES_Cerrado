# land tenure
library(tidyverse)
library(sf)
library (ggplot2)
library (ggpubr)
library(rmapshaper)
library(viridis)
# set directory
out <- '/Users/floriangollnow/Dropbox/ZDC_project/PaperRachael/Data'
# read land tenure data
land <- read_rds ( file.path(out, "sidra/land_tenure_2017.rds"))
# filter land tenure data to calculate share of Percent of agricultural 
# establishments that are rented or occupied without definitive title or where land is owned by a partnership or corporation

land_t <- land %>% filter(`Condição do produtor em relação às terras`=="Total") %>% rename(Valor_total = Valor) %>% select (`Município (Código)`,Valor_total )
land_p <- land %>% filter (`Condição do produtor em relação às terras`=="Ocupante" |
                             `Condição do produtor em relação às terras`=="Arrendatário(a)"|
                             `Condição do produtor em relação às terras`=="Concessionário(a) ou assentado(a) aguardando titulação definitiva")
land_p <- land_p %>%  group_by(`Município (Código)`) %>% summarise(Valor_p=sum(Valor, na.rm=TRUE))
land_p <- land_p %>% left_join(land_t)
land_p <- land_p %>% mutate (land_p_perc = (Valor_p/Valor_total)*100)

# reading spatial data
munis <- read_sf (file.path(out, "municipalities_cerrado_biome","municipalities_cerrado_biome_wgs84.shp")) %>% st_transform(crs=4326)
states <- read_rds (file.path(out, "ibge","StatesBR_WGS84.rds"))%>% st_transform(crs=4326)
# simoplifying spatial data for ggplot
munis <- munis %>% ms_simplify()
states <- states %>% ms_simplify()
matop <- read_rds ( file.path(out, "Matopiba","Matopiba_WGS84.rds"))%>% st_transform(crs=4326)
matop <- matop %>% mutate(Matopiba="") %>% ms_simplify()
# joining land tenure data and spatial data
munis_land_p <- munis %>% left_join(land_p, by = c("cd_geocmu"="Município (Código)") )

bb <- st_bbox(munis_land_p)

gg_title<- ggplot ()+
  geom_sf(data=munis_land_p, aes(fill=land_p_perc), color=NA)+
  geom_sf(data=states, color = "black", fill = NA, size=0.5, lty="longdash")+
  geom_sf(data=matop, color="white", fill = NA, size=1.6)+
  geom_sf(data=matop, aes(color=Matopiba), fill = NA, size=1.2, show.legend = 'line')+
  scale_color_manual (values="#FF6700")+
  scale_fill_stepsn(name="Properties without formal \nland title or rented %", 
                    colors= c("#edf8fb", "#9ebcda", "#8c6bb1", "#6e016b"), 
                    breaks=seq(0,20, by=5), limit=c(0,20), labels=c("0","5","10","15", ">=20"))+
  coord_sf(xlim = c(bb[1], bb[3]), ylim = c(bb[2], bb[4]), expand = FALSE) +
  theme_bw()+
  theme(legend.position = "top", axis.title.x=element_blank(),axis.title.y=element_blank())+
  guides(fill = guide_colorbar(order = 1),col = guide_legend(order = 2))# ,legend.box="vertical"
  gg_title
write_rds(gg_title, file.path(out,"ggplots","gg_title.rds"))
ggsave (file.path(out, "map_title.png"))


# Land tenure classification
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
