
# combine all maps 
library(tidyverse)
library(sf)
library(ggpubr)

plot.dir  <- "/Users/floriangollnow/Dropbox/ZDC_project/PaperRachael/Data/ggplots" 
dir(plot.dir)
# read saved ggplots
gg1<-read_rds(file.path(plot.dir, "gg_lu10.rds"))
gg2 <- read_rds( file.path(plot.dir,"gg_soydef10.rds"))
gg3<-read_rds(file.path(plot.dir, "gg_zdc.rds"))
gg4<-read_rds(file.path(plot.dir, "gg_income.rds") )  

gg6<-read_rds(file.path(plot.dir, "gg_title.rds") )   
gg7a<-read_rds(file.path(plot.dir,"gg_soyarea.rds"))
gg7b<-read_rds(file.path(plot.dir,"gg_soy_farm_size.rds"))

gg8 <- read_rds(file.path(plot.dir, "gg_rents.rds"))

gg9<-read_rds(file.path(plot.dir, "gg_world.rds"))
gg10 <- gg9+theme(plot.margin = unit(c(0,0,0,0), "lines"))

g1a <- gg1+ annotation_custom(ggplotGrob(gg10), ymin = -2, ymax = -7, xmin = -41, xmax = -37)

gga1 <- ggarrange(gg2,g1a,
          ncol=2,
          widths =c(1,0.981),
          labels=c("a","b"))
ggsave  (file.path  (plot.dir, "panel_1_large_LULC.png"), width = 10.8*5, height = 9*3, scale = 0.25)
ggsave  (file.path  ("ggplots", "panel_1_large_maps.png"), width = 10.8*5, height = 9*3, scale = 0.25, plot=gga1)

#
#a ZDC
#b rents
#c soy area
#d title
#e soy farm size #gg8
#f income
g <- ggarrange(gg3,gg8,gg7a,gg6,gg7b, 
               gg4+guides(
  fill = guide_colorsteps(order = 1)),
          ncol=3, 
          nrow=2,
          labels=c("a","b","c","d","e","f"))
ggsave  (file.path  (plot.dir, "panel_2_small_maps.png"), width = 10.8*5, height = 10.8*4.5, scale = 0.25, plot=g)
ggsave  (file.path  ("ggplots", "panel_2_small_maps.png"), width = 10.8*5, height = 10.8*4.5, scale = 0.25, plot = g)


