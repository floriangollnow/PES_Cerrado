# mapbiomas soy area and deforestation plus protected areas and indiginous lands

library(raster)
library(rasterVis)
library(sf)
library(tidyverse)
library(rmapshaper)
library(nngeo)
library(ggpattern)
library(scales)
# directories
raster_dir <- "/Users/floriangollnow/Dropbox/ZDC_project/PaperRachael/Data/Mapbiomas"
out <- '/Users/floriangollnow/Dropbox/ZDC_project/PaperRachael/Data'
#spatial data
boundary <- as_Spatial(read_sf (file.path(out, "cerrado_border","limite_cerrado_wgs84.shp")))
munis <- read_sf (file.path(out, "municipalities_cerrado_biome","municipalities_cerrado_biome_wgs84.shp"))
munis <- st_transform(munis, crs = 4326)
states <- read_rds (file.path(out, "ibge","StatesBR_WGS84.rds"))
pa <- read_sf (file.path(out, "conservation_units_cerrado_biome","conservation_units_cerrado_biome_wgs84.shp")) %>% mutate(Designation="PA") %>% dplyr::select (Designation)
ind <- read_sf (file.path(out, "indigeneous_area_cerrado_biome","indigeneous_area_cerrado_biome_wgs84.shp"))%>% mutate(Designation="Indigenous") %>% dplyr::select(Designation)
pa_ind <- rbind (pa , ind) %>% st_transform(munis, crs = 4326)
cerrado <- read_sf (file.path(out, "cerrado_border","limite_cerrado_wgs84.shp"))
cerrado <- cerrado %>% st_transform(crs = 4326)
# clean and simplify shapes
munis <- munis %>% ms_simplify()
states <- states %>% ms_simplify()
pa_ind <- pa_ind %>% ms_simplify()
pa_ind <- pa_ind %>%  nngeo::st_remove_holes()
pa_ind <- pa_ind %>%  st_make_valid()
pa_ind <- pa_ind%>%  group_by (Designation) %>% summarise(designation=first(Designation)) %>% st_cast () 
pa_ind <- pa_ind %>%  nngeo::st_remove_holes()
pa_ind <- pa_ind %>% mutate(Designation= factor(Designation))
bb <- st_bbox(munis)

#Matopiba region
matop <- read_rds ( file.path(out, "Matopiba","Matopiba_WGS84.rds"))
matop <- matop %>% mutate(Matopiba="")

#read raster
main_lu <- raster(file.path(raster_dir,"mapbiomas_FFSS_GAEZapt_Cerrado_1000_v5.tif"))
#reclassify raster to keep soy only
main_lu <- reclassify(main_lu, rcl=matrix(c(0,NA,1,NA,2,NA,3,NA,4,NA,5,1,6,NA,7,NA,8,NA,9,NA),byrow = T, ncol = 2 ))
# mask raster to cerrado only
main_lum <- mask(main_lu, boundary)
main_lu <-main_lum

# prepare for plotting with GGPLOT
main_lu.coord<- xyFromCell(main_lu, seq_len(ncell(main_lu)))
main_lu.df <- as.data.frame(getValues(main_lu))
names(main_lu.df)<-"value"
main_lu.df$value <- factor(main_lu.df$value, levels = c("1"))# convert to factor for ggplot
main_lu.df1 <- cbind(main_lu.coord, main_lu.df)

## crop state names for GGPLOT
states_cropped <- st_crop(states, bb)
states_cropped <- states_cropped %>% filter (State_abb!="ES", State_abb!="RO")

gg_lu <- ggplot() +
  geom_sf (data=cerrado, fill="grey92", color=NA)+
  geom_tile(data=main_lu.df1,  aes(x,y, fill = value)) +
  scale_fill_manual(values = c("1"="#c59ff4"), na.value=NA, name = "LUC", labels = c( "Soy"), na.translate=FALSE)+
    geom_sf(data=states,color = "black", fill = NA, size=0.5, lty="longdash")+
  geom_sf_pattern(data = pa_ind,
                  aes(
                    pattern_type = Designation
                  ),
                  pattern  = 'magick',
                  pattern_fill = "black",
                  pattern_scale = 1,
                   fill=NA,
                  alpha=0.5,
                  pattern_key_scale_factor =3)+
  scale_pattern_type_discrete(choices = c("left30", "horizontal"),
                            label=c("Indigenous", "PA"))+
  geom_sf(data=matop, color="white", fill = NA, size=1.6)+
  geom_sf(data=matop, aes(lty=Matopiba), color="#FF6700",fill = NA, size=1.2)+#"#7570b3"#5e3c99
  geom_sf_label(data=states_cropped, aes(label = State_abb),nudge_x = c(0,0,0,0,0,0,0,-1.8,0,-1.2,0,0,0,0), nudge_y = c(0,0,0,0,0,0,0,0.8,0,-1.5,0,0,0,0),alpha=0.6)+
  coord_sf(xlim = c(bb[1], bb[3]), ylim = c(bb[2], bb[4]), expand = FALSE)+
  theme_bw()+
  theme(legend.position = "right", axis.title.x=element_blank(),axis.title.y=element_blank())# ,legend.box="vertical", legend.box="vertical",
#gg_lu

write_rds(gg_lu, file.path(out,"ggplots","gg_lu10.rds"))
ggsave(file.path(out,"gg_lu_test10.png"))
