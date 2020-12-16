



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

ggarrange(gg1,gg2,gg3,gg4,gg5,gg6,gg7,gg8,ncol=2,nrow=4, align = "h", labels=c("a","b","c","d","e","f","g","h"))
ggsave  (file.path  (plot.dir, "combined.png"), width = 10.8*2.8, height = 11.5*6, scale = 0.25)


# main land use in 2019 (MapBiomas v5) + Indigenous and protected areas (IBGE)
# soy areas in 2019 (MapBiomas v5) + Indigenous and protected areas (IBGE)
# ZDC (ZDC in 2018 of all companies that pledged to eliminate deforestation, Trase 25)
# mean monthly income 2010 (censo demographico 2010)
# gini coeficient 2010 (censo demograpico 2010)
# % land owned (other categories included - censo agropecuaria 2017)
## [1] "Total"                                                            
## [2] "Proprietário(a)" <- owned!
## [3] "Concessionário(a) ou assentado(a) aguardando titulação definitiva"
## [4] "Arrendatário(a)"
## [5] "Parceiro(a)"
## [6] "Comodatário(a)"
## [7] "Ocupante"
## [8] "Produtor sem área"
# % of farms that received technical assistance (censo agropecuaria 2017))
# global overview

