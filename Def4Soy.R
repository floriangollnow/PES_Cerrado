#mapbiomas soy area and soy deforestation plus protected areas and indiginous lands

library(raster)
library(rasterVis)
library(sf)
library(tidyverse)
library(rmapshaper)
#install.packages("remotes")
#remotes::install_github("coolbutuseless/ggpattern")
library(ggpattern)
raster_dir <- "/Users/floriangollnow/Dropbox/PaperRachael/Data/Mapbiomas"
out <- '/Users/floriangollnow/Dropbox/PaperRachael/Data'
#spatial
boundary <- as_Spatial(read_sf (file.path(out, "cerrado_border","limite_cerrado_wgs84.shp")))
munis <- read_sf (file.path(out, "municipalities_cerrado_biome","municipalities_cerrado_biome_wgs84.shp"))
states <- read_rds (file.path(out, "ibge","StatesBR_WGS84.rds"))
pa <- read_sf (file.path(out, "conservation_units_cerrado_biome","conservation_units_cerrado_biome_wgs84.shp")) %>% mutate(Designation="PA") %>% dplyr::select (Designation)
ind <- read_sf (file.path(out, "indigeneous_area_cerrado_biome","indigeneous_area_cerrado_biome_wgs84.shp"))%>% mutate(Designation="Indigenous") %>% dplyr::select(Designation)
pa_ind <- rbind (pa , ind)
munis <- munis %>% ms_simplify()
states <- states %>% ms_simplify()
pa_ind <- pa_ind %>% ms_simplify()
bb <- st_bbox(munis)


matop <- read_rds ( file.path(out, "Matopiba","Matopiba_WGS84.rds"))
#matop <- matop %>% ms_simplify()
matop <- matop %>% mutate(Matopiba="")
#munis_land_p <- munis %>% left_join(land_p, by = c("cd_geocmu"="Município (Código)") )

#deforestaion<- raster ()
#deforestationsoy <- raster()
#main_lu
main_lu <- raster(file.path(raster_dir,"mapbiomas_SoyDeforestation_1000_v5.tif"))

main_lu<- aggregate(main_lu,5,fun=max)
main_lum <- mask(main_lu, boundary)

main_lu <-main_lum
#plot(soym)
main_lu.coord<- xyFromCell(main_lu, seq_len(ncell(main_lu)))
main_lu.df <- as.data.frame(getValues(main_lu))
names(main_lu.df)<-"value"
main_lu.df$value <- factor(main_lu.df$value, levels = c("1","2"))
main_lu.df1 <- cbind(main_lu.coord, main_lu.df)

##crop state names
states_cropped <- st_crop(states, bb)
states_cropped <- states_cropped %>% filter (State_abb!="ES", State_abb!="RO")

gg_lu <- ggplot() +
  geom_tile(data=main_lu.df1,  aes(x,y, fill = value)) +
  scale_fill_manual(values = c("1"="#bababa", "2"="#ca0020"), na.value=NA,# c("1"="#c59ff4", "2"="#e66101")
                    name = "LULCC", labels = c("Soy", "Soy-\nDeforestation"), na.translate=FALSE)+
  geom_sf(data=states,color = "black", fill = NA, size=0.5, lty="longdash")+
  #geom_sf(data=pa_ind, aes (color=Designation ),alpha=0.5) +
  #scale_color_manual  (values=c("Indigenous"="#fdb863" , "PA"="#e66101"))+#"#fc8d62", "#e78ac3"
  geom_sf(data=matop, aes(lty=Matopiba), color="#5e3c99",fill = NA, size=1)+#"#7570b3"
  geom_sf(data=sf::st_point_on_surface(states_cropped),colour = "white",alpha=0.5, size = 10)+
  geom_sf_text(data=states_cropped, aes(label = State_abb),fun.geometry = st_point_on_surface)+
  coord_sf(xlim = c(bb[1], bb[3]), ylim = c(bb[2], bb[4]), expand = FALSE)+
  theme_bw()+
  theme(legend.position = "right", axis.title.x=element_blank(),axis.title.y=element_blank())# ,legend.box="vertical", legend.box="vertical",


write_rds(gg_lu, file.path(out,"ggplots","gg_soydef.rds"))
ggsave(file.path(out,"gg_soydef_test.png"))
#gg_lu
#1 Forest 
#2 Grassland
#3 Croplands
#4 Pasture
#5 Water
#6 Other

# geom_sf_pattern(data=pa_ind, aes (pattern_type=Designation), 
#                 pattern= 'magick',
#                 pattern_fill         = 'black',
#                 pattern_aspect_ratio = 1.75,
#                 fill                 = 'white',
#                 colour               = 'black')+
# #scale_pattern_manual(values  = ggpattern::magick_pattern_names) +
#scale_pattern_manual(values=c("Indigenous"="#fc8d62", "PA"="#e78ac3")) +


p <- ggplot(diamonds, aes(x, y)) +
  xlim(4, 10) + ylim(4, 10) +
  geom_bin2d_pattern(
    aes(pattern_type = ..density..),
    pattern       = 'magick',
    pattern_scale = 3,
    pattern_fill  = 'black',
    bins          = 6,
    fill          = 'white',
    colour        = 'black',
    size          = 0.5
  ) +
  theme_bw(18) +
  theme(legend.position = 'none') +
  scale_pattern_type_continuous(choices = ggpattern::magick_pattern_intensity_names[15:21]) +
  labs(
    title = "ggpattern::geom_bin2d_pattern()",
    subtitle = "pattern = 'magick'"
  )

p


library(maps)

crimes <- data.frame(state = tolower(rownames(USArrests)), USArrests)
crimesm <- reshape2::melt(crimes, id = 1)

states_map <- map_data("state")

p <- ggplot(crimes, aes(map_id = state)) +
  geom_map_pattern(
    map = states_map,
    aes(
      pattern_type = state
    ),
    pattern              = 'magick',
    pattern_fill         = 'black',
    pattern_aspect_ratio = 1.75,
    fill                 = 'white',
    colour               = 'black'
  ) +
  expand_limits(x = states_map$long, y = states_map$lat) +
  coord_map() +
  theme_bw(18) +
  labs(title = "ggpattern::geom_map_pattern()") +
  labs(
    title = "ggpattern::geom_map_pattern()",
    subtitle = "pattern = 'magick'"
  ) +
  scale_pattern_type_discrete(choices = ggpattern::magick_pattern_stripe_names) +
  theme(legend.position = 'none')

p

