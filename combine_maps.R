
# combine all maps 
library(tidyverse)
library(ggpubr)

plot.dir  <- "/Users/floriangollnow/Dropbox/PaperRachael/Data/ggplots" 
dir(plot.dir)

gg1<-read_rds(file.path(plot.dir, "gg_lu.rds"))#""#"gg_income.rds"
gg2<-read_rds(file.path(plot.dir, "gg_soy.rds"))#"gg_soy.rds"
gg3<-read_rds(file.path(plot.dir, "gg_zdc.rds"))
gg4<-read_rds(file.path(plot.dir, "gg_income.rds") )  
gg5<-read_rds(file.path(plot.dir, "gg_gini.rds") )               
gg6<-read_rds(file.path(plot.dir, "gg_title.rds") )   
gg7<-read_rds(file.path(plot.dir, "gg_tech.rds") )
gg8<-read_rds(file.path(plot.dir, "gg_world.rds"))

#ggarrange(gg1,gg2,gg3,gg4,gg5,gg6,gg7,gg8,ncol=2,nrow=4, align = "h", labels=c("a","b","c","d","e","f","g","h"))
#ggsave  (file.path  (plot.dir, "combined.png"), width = 10.8*2.8, height = 11.5*6, scale = 0.25)

ggarrange(ggarrange(gg1,gg2,ncol = 2, labels=c("a","b")),
          ggarrange(gg3,gg4,gg5,ncol=3, labels=c("c","d","e")),
          ggarrange(gg6,gg7,gg8,ncol=3, labels=c("f","g","h")),
          nrow=3)
ggsave  (file.path  (plot.dir, "combined_test3.png"), width = 10.8*4, height = 11.5*6, scale = 0.25)
