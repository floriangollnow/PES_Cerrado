
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

soy_a <- read_rds ( file.path(out, "sidra/soy_area_colhida_2017.rds"))
soy_a_w <- soy_a %>% pivot_wider(id_cols=c(`Município (Código)`:Ano, `Unidade de Medida`), names_from = `Produtos da lavoura temporária`, values_from = Valor)
soy_a_w <- soy_a_w %>% replace_na(list ("Soja em grão"=0, "Sementes de soja (produzidas para plantio)"=0))
soy_a_w <- soy_a_w %>%  mutate (soy_perc = ((`Soja em grão`+`Sementes de soja (produzidas para plantio)`)/Total)*100)

munis <- read_sf (file.path(out, "municipalities_cerrado_biome","municipalities_cerrado_biome_wgs84.shp")) %>% st_transform(crs= 4326)
states <- read_rds (file.path(out, "ibge","StatesBR_WGS84.rds"))%>% st_transform(crs= 4326)

munis <- munis %>% ms_simplify()
states <- states %>% ms_simplify()
matop <- read_rds ( file.path(out, "Matopiba","Matopiba_WGS84.rds"))%>% st_transform(crs= 4326)
matop <- matop %>% mutate(Matopiba="")
munis_soy_p <- munis %>% left_join(soy_a_w, by = c("cd_geocmu"="Município (Código)") )

bb <- st_bbox(munis_soy_p)
gg_soy_area<- ggplot ()+
  geom_sf(data=munis_soy_p, aes(fill=soy_perc), color=NA)+
  geom_sf(data=states, color = "black", fill = NA, size=0.5, lty="longdash")+#color = "grey60", fill = NA, size=0.5)+
  geom_sf(data=matop, color="white", fill = NA, size=1.6)+
  geom_sf(data=matop, aes(color=Matopiba), fill = NA, size=1.2, show.legend = 'line')+
  scale_color_manual (values="#FF6700")+
  #scale_fill_viridis_c( name="Soy area\nin %", limits=c(0,100))+
  #scale_fill_viridis_b( name="Soy area\nin %", limits=c(0,100), option = "D")+
  scale_fill_stepsn(name="Soy area\nin %", colors= c("#edf8fb", "#9ebcda", "#8c6bb1", "#6e016b"), breaks=seq(0,100, by=25), limit=c(0,100))+
  coord_sf(xlim = c(bb[1], bb[3]), ylim = c(bb[2], bb[4]), expand = FALSE) +
  theme_bw()+
  theme(legend.position = "top", axis.title.x=element_blank(),axis.title.y=element_blank())+
  guides(fill = guide_colorbar(order = 1),col = guide_legend(order = 2))# ,legend.box="vertical"
  gg_soy_area
write_rds(gg_soy_area, file.path(out,"ggplots","gg_soyarea.rds"))
ggsave (file.path(out, "map_soyarea.png"))


## mean size of soy farme
soy_a_f_tb <- read_rds( file.path(out, "sidra/soy_area_colhida_nfarms_2017.rds"))

soy_f_1 <- soy_a_f_tb %>% filter (grepl("Número", Variável))
soy_a_1 <- soy_a_f_tb %>% filter (grepl("Área", Variável))

soy_f_1_w <- soy_f_1 %>% pivot_wider(id_cols=c(`Município (Código)`:Ano, `Unidade de Medida`), names_from = `Produtos da lavoura temporária`, values_from = Valor)
soy_a_1_w <- soy_a_1 %>% pivot_wider(id_cols=c(`Município (Código)`:Ano, `Unidade de Medida`), names_from = `Produtos da lavoura temporária`, values_from = Valor)


soy_f_1_w_s <- soy_f_1_w %>% rowwise() %>% mutate (soy_farms = sum(c(`Soja em grão`,`Sementes de soja (produzidas para plantio)`), na.rm=TRUE))
soy_f_1_w_s  <- soy_f_1_w_s %>% select (c('Município (Código)', 'soy_farms'))

soy_a_1_w_s <- soy_a_1_w %>% rowwise () %>% mutate (soy_area = sum(c (`Soja em grão`,`Sementes de soja (produzidas para plantio)`), na.rm=TRUE))
soy_a_1_w_s <- soy_a_1_w_s %>% select (c('Município (Código)', 'soy_area'))

soy_farm_size <- soy_a_1_w_s %>% full_join(soy_f_1_w_s)
soy_farm_size <- soy_farm_size %>% mutate(meansize = soy_area/soy_farms)
View(soy_farm_size)

munis <- read_sf (file.path(out, "municipalities_cerrado_biome","municipalities_cerrado_biome_wgs84.shp"))%>% st_transform(crs= 4326)
states <- read_rds (file.path(out, "ibge","StatesBR_WGS84.rds"))%>% st_transform(crs= 4326)

munis <- munis %>% ms_simplify()
states <- states %>% ms_simplify()
matop <- read_rds ( file.path(out, "Matopiba","Matopiba_WGS84.rds"))%>% st_transform(crs= 4326) %>% ms_simplify()
matop <- matop %>% mutate(Matopiba="")
munis_soy_farm_size <- munis %>% left_join(soy_farm_size, by = c("cd_geocmu"="Município (Código)") )

bb <- st_bbox(munis_soy_p)
gg_soy_farm_size<- ggplot ()+
  geom_sf(data=munis_soy_farm_size, aes(fill=meansize/1000), color=NA)+
  geom_sf(data=states, color = "black", fill = NA, size=0.5, lty="longdash")+#color = "grey60", fill = NA, size=0.5)+
  geom_sf(data=matop, color="white", fill = NA, size=1.6)+
  geom_sf(data=matop, aes(color=Matopiba), fill = NA, size=1.2, show.legend = 'line')+
  scale_color_manual (values="#FF6700")+
  scale_fill_stepsn(name="Soy area by farm\nin kha", colors= c("#edf8fb", "#bfd3e6", "#9ebcda", "#8c96c6","#8c6bb1","#88419d","#6e016b"),
                    breaks=seq(0,7, by=1), limit=c(0,7))+
  
  #scale_fill_viridis_c( name="Soy area by farm\nin kha")+ #, trans = "log10"
  coord_sf(xlim = c(bb[1], bb[3]), ylim = c(bb[2], bb[4]), expand = FALSE) +
  theme_bw()+
  theme(legend.position = "top", axis.title.x=element_blank(),axis.title.y=element_blank())+
  guides(fill = guide_colorbar(order = 1),col = guide_legend(order = 2))# ,legend.box="vertical"
gg_soy_farm_size
write_rds(gg_soy_farm_size, file.path(out,"ggplots","gg_soy_farm_size.rds"))
ggsave (file.path(out, "map_soy_farm_size.png"))
