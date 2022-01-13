# plotting rent data
library(raster)
library(rasterVis)
library(sf)
library(tidyverse)
library(rmapshaper)
library (terra)
#directoreies
raster_dir <- "/Users/floriangollnow/Dropbox/ZDC_project/PaperRachael/Data/Port Cost Assesment/"
out <- '/Users/floriangollnow/Dropbox/ZDC_project/PaperRachael/Data'
#spatial
boundary <- (read_sf (file.path(out, "cerrado_border","limite_cerrado_wgs84.shp")))
munis <- read_sf (file.path(out, "municipalities_cerrado_biome","municipalities_cerrado_biome_wgs84.shp"))%>% st_transform(crs= 4326)
states <- read_rds (file.path(out, "ibge","StatesBR_WGS84.rds"))#%>% st_transform(crs= 9001)
mask_file <- read_rds(file.path (raster_dir , "mask_file.rds")) %>% filter (mask==0) %>% st_zm ()
# simplify for plotting
munis <- munis %>% ms_simplify()
states <- states %>% ms_simplify()
mask_file <- mask_file%>% ms_simplify()
bb <- st_bbox(munis)
# reading Matopiba 
matop <- read_rds ( file.path(out, "Matopiba","Matopiba_WGS84.rds"))%>% st_transform(crs= 9001)
matop <- matop %>% mutate(Matopiba="")

#reading rent dataset
rents_terr <- rast (file.path(raster_dir,"rent.tif"))
# transforming projection to mask the rent raster for the cerrado only
boundary_trans <- boundary %>% st_transform  (crs=crs(rents_terr))
mask_file_trans <- mask_file %>% st_transform ( crs=crs(rents_terr))
mask_file_trans <- mask_file_trans %>% st_crop(st_bbox(boundary_trans))
# mask rents to the cerrado only
rents_terr <-  terra::crop (rents_terr, extent(boundary_trans))
rents_m1<- terra::mask(rents_terr, vect(boundary_trans))
rents_m2<- terra::mask(rents_m1, vect(mask_file))

rents_m <- rents_m2
# aggregate data for plotting
rents_m <- terra::aggregate(rents_m,2, fun=mean)
rents_m_p <- projectRaster (rents_m, crs=crs(boundary))
# convert vpixel values to ha
rents_ha <-(rents_m/6.25)-870
rents_ha[rents_ha<0] <- 0
plot(rents_ha)
plot (boundary, add=TRUE)
# reproject to plot projection
rents_ha <- terra::project (rents_ha, "epsg:4326")

# prepare raster data for ggplot
rents.coord<- xyFromCell(rents_ha, seq_len(ncell(rents_ha)))
rents.df <- as.data.frame(terra::values(rents_ha))
names(rents.df)<-"value"
rents.df1 <- cbind(rents.coord, rents.df)

gg_rents <- ggplot() +
  geom_sf(data=munis, color = NA, fill = "grey50", size=0.5)+
  geom_tile(data=rents.df1,  aes(x,y, fill = value)) +
  scale_fill_stepsn(name="Soy estimated profit\nin US$/ha",
                    colors= c("#f7fcfd", "#e0ecf4", "#bfd3e6", "#9ebcda","#8c96c6","#8c6bb1","#88419d","#6e016b"),
                    breaks=seq(0,800, by=200), limit=c(0,800), na.value = NA)+
  geom_sf(data=states, color = "black", fill = NA, size=0.5, lty="longdash")+#color = "grey60", fill = NA, size=0.5)+
  geom_sf(data=matop, color="white", fill = NA, size=1.6)+
  geom_sf(data=matop, aes(color=Matopiba), fill = NA, size=1.2, show.legend = 'line')+
  scale_color_manual (values="#FF6700")+
  coord_sf(xlim = c(bb[1], bb[3]), ylim = c(bb[2], bb[4]), expand = FALSE) +
  theme_bw()+
  theme(legend.position = "top", axis.title.x=element_blank(),axis.title.y=element_blank())+
  guides(fill = guide_colorbar(order = 1),col = guide_legend(order = 2))# ,legend.box="vertical"

gg_rents
write_rds(gg_rents, file.path(out,"ggplots","gg_rents.rds"))
ggsave (file.path(out, "map_rents.png"))
