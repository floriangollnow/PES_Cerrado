
# combine all maps 
library(tidyverse)
library(ggpubr)

plot.dir  <- "/Users/floriangollnow/Dropbox/PaperRachael/Data/ggplots" 
dir(plot.dir)

gg1<-read_rds(file.path(plot.dir, "gg_lu.rds"))#""#"gg_income.rds"
#gg2<-read_rds(file.path(plot.dir, "gg_soy.rds"))#"gg_soy.rds"
#gg1<-read_rds(file.path(plot.dir, "gg_zdc.rds"))
gg3<-read_rds(file.path(plot.dir, "gg_zdc.rds"))
gg4<-read_rds(file.path(plot.dir, "gg_income.rds") )  
gg5<-read_rds(file.path(plot.dir, "gg_gini.rds") )               
gg6<-read_rds(file.path(plot.dir, "gg_title.rds") )   
#gg7<-read_rds(file.path(plot.dir, "gg_tech.rds") )
gg7<-read_rds(file.path(plot.dir, "gg_soyfarms.rds"))
gg8 <- read_rds(file.path(plot.dir, "gg_rents.rds"))
gg9<-read_rds(file.path(plot.dir, "gg_world.rds"))
gg10 <- gg9+theme(plot.margin = unit(c(0,0,0,0), "lines"))
#ggarrange(gg1,gg2,gg3,gg4,gg5,gg6,gg7,gg8,ncol=2,nrow=4, align = "h", labels=c("a","b","c","d","e","f","g","h"))
#ggsave  (file.path  (plot.dir, "combined.png"), width = 10.8*2.8, height = 11.5*6, scale = 0.25)
# ggarrange(gg1,
#           ggarrange(gg3,gg4,gg5,ncol=3, labels=c("b","c","d")),
#           ggarrange(gg6,gg7,gg8,ncol=3, labels=c("e","f","g")),
#           nrow=3,
#           labels=("a"),
#           heights = c(1,0.5,0.5))
# ggsave  (file.path  (plot.dir, "combined_test.png"), width = 10.8*5, height = 11.5*6, scale = 0.25)

ggarrange(gg1, ggarrange (gg10, nrow=3),
          ncol=2,
          widths =c(1,0.3),
          labels=c("a","b"))
ggsave  (file.path  (plot.dir, "panel_1_large_LULC.png"), width = 10.8*3, height = 9*3, scale = 0.25)

ggarrange(gg3,gg8,gg7,gg6,gg4,gg5,
          ncol=3, 
          nrow=2,
          labels=c("a","b","c","d","e","f"))
ggsave  (file.path  (plot.dir, "panel_2_small_maps.png"), width = 10.8*5, height = 10.8*5, scale = 0.25)



# ggarrange(ggarrange(gg1,gg2,ncol = 2, labels=c("a","b")),
#           ggarrange(gg3,gg4,gg5,ncol=3, labels=c("c","d","e")),
#           ggarrange(gg6,gg7,gg8,ncol=3, labels=c("f","g","h")),
#           nrow=3)
# ggsave  (file.path  (plot.dir, "combined_test3.png"), width = 10.8*4, height = 11.5*6, scale = 0.25)
