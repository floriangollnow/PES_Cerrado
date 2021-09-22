# family farms

#average income
library(tidyverse)
library(sf)
library (ggplot2)
library (ggpub)
library(wesanderson)
library(rmapshaper)

out <- '/Users/floriangollnow/Dropbox/PaperRachael/Data'

farms <- read_rds ( file.path(out, "sidra/family_farms_2017.rds"))
t_farms <- farms %>% filter(Tipologia=="Total") %>% rename(Valor_total = Valor) %>% select (`Município (Código)`,Valor_total )
f_farms <- farms %>% filter (Tipologia=="Agricultura familiar - sim") %>% rename(Valor_fam = Valor)%>% select (`Município (Código)`,Valor_fam )
f_farms <- f_farms %>% left_join(t_farms)
f_farms <- f_farms %>% mutate (fam_perc = (Valor_fam/Valor_total)*100)

mean_ffarms <- f_farms %>% summarise(meanff = median(fam_perc,na.rm=TRUE))

munis <- read_sf (file.path(out, "municipalities_cerrado_biome","municipalities_cerrado_biome_wgs84.shp"))
munis <- munis %>% ms_simplify()

munis_f_farms <- munis %>% left_join(f_farms, by = c("cd_geocmu"="Município (Código)") )

pal <- wes_palette("Zissou1", 100, type = "continuous")
gg<- ggplot ()+
  geom_sf(data=munis_f_farms, aes(fill=fam_perc))+
  scale_fill_gradientn(colours = pal, name="Family farms %")+
  theme_bw()
gg
ggsave (file.path(out, "map_fam_farm.png"))
