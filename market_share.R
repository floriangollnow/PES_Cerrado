#ZDC market share
library(tidyverse)
library(sf)
out <- "/Users/floriangollnow/Dropbox/ZDC_project/Data/TraseData2015/bulk_download2/Brazil_Soy_2.5.0_pc/Brazil_Soy_25_cnpj"

trase<- read_rds(file.path (out, "trase_25_cnpj.rds"))
trase_2018 <- trase %>% filter(YEAR==2018)
trase_2018_t <- trase_2018 %>% group_by(GEOCODE) %>% summarise(SoyT = sum(SOY_EQUIVALENT_TONNES, na.rm = TRUE))
trase_2018_zdc <-  trase_2018 %>% filter(G_ZDC==TRUE)%>% group_by(GEOCODE) %>% summarise(SoyT_ZDC = sum(SOY_EQUIVALENT_TONNES, na.rm = TRUE))

trase_2018_zdc <- trase_2018_zdc %>% full_join(trase_2018_t) %>% replace_na(list(SoyT_ZDC=0)) 
trase_2018_zdc <- trase_2018_zdc %>% mutate(ZDC_perc = (SoyT_ZDC/SoyT)*100)

#mapping
out <- '/Users/floriangollnow/Dropbox/PaperRachael/Data/'
munis <- read_sf (file.path(out, "municipalities_cerrado_biome","municipalities_cerrado_biome_wgs84.shp"))
states <- read_rds (file.path(out, "ibge","StatesBR_WGS84.rds"))
munis <- munis %>% ms_simplify()
states <- states %>% ms_simplify()

munis_zdc_p <- munis %>% left_join(trase_2018_zdc, by = c("cd_geocmu"="GEOCODE") )

bb <- st_bbox(munis_zdc_p)

gg_zdc<- ggplot ()+
  geom_sf(data=munis_zdc_p, aes(fill=ZDC_perc),color=NA)+
  geom_sf(data=states, color = "white", fill = NA, size=0.5)+
  scale_fill_viridis_c( name="ZDC market share %")+
  coord_sf(xlim = c(bb[1], bb[3]), ylim = c(bb[2], bb[4]), expand = FALSE) +
  theme(legend.position = "top", axis.title.x=element_blank(),axis.title.y=element_blank())
gg_zdc
write_rds(gg_zdc, file.path(out,"ggplots","gg_zdc.rds"))
ggsave (file.path(out, "map_title.png"))

ggsave (file.path(out, "map_ZDC.png"))
