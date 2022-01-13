# average income
library(tidyverse)
library(sf)
library (ggplot2)
library (ggpubr)
library(rmapshaper)
# directory 
out <- '/Users/floriangollnow/Dropbox/ZDC_project/PaperRachael/Data/'
# read downloaded income data
income <- read_rds ( file.path(out, "sidra/mean_income_2010.rds"))
# read spatial data
munis <- read_sf (file.path(out, "municipalities_cerrado_biome","municipalities_cerrado_biome_wgs84.shp"))%>% st_transform(munis, crs = 4326)
states <- read_rds (file.path(out, "ibge","StatesBR_WGS84.rds"))%>% st_transform(munis, crs = 4326)
# simplify spatial data for plotting
munis <- munis %>% ms_simplify()
states <- states %>% ms_simplify()
# combine income data and shape
munis_income <- munis %>% left_join(income, by = c("cd_geocmu"="Município (Código)") )
bb <- st_bbox(munis_income)

# read Matopiba region
matop <- read_rds ( file.path(out, "Matopiba","Matopiba_WGS84.rds"))%>% st_transform(munis, crs = 4326) %>% ms_simplify()
matop <- matop %>% mutate(Matopiba="")

gg_income<- ggplot ()+
  geom_sf(data=munis_income, aes(fill=Valor/1000),color=NA)+
  geom_sf(data=states, color = "black", fill = NA, size=0.5, lty="longdash")+#color = "grey60", fill = NA, size=0.5)+
  geom_sf(data=matop, color="white", fill = NA, size=1.6)+
  geom_sf(data=matop, aes(color=Matopiba), fill = NA, size=1.2, show.legend = 'line')+
  scale_color_manual (values="#FF6700")+
  scale_fill_stepsn(name="Mean monthly income\nin 1000 BRL", colors= c("#e0ecf4", "#9ebcda", "#8c96c6", "#8c6bb1","#88419d","#810f7c"),
                    breaks=c(0,1,2,3,4,5,6), limit=c(0,6))+
  coord_sf(xlim = c(bb[1], bb[3]), ylim = c(bb[2], bb[4]), expand = FALSE)+
  theme_bw()+
  theme(legend.position = "top", axis.title.x=element_blank(),axis.title.y=element_blank())# ,legend.box="vertical"
gg_income
write_rds(gg_income, file.path(out,"ggplots","gg_income.rds"))
ggsave (file.path(out, "map_income.png"))


