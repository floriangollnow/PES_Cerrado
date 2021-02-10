

# mean yield in tons
library(tidyverse)
out <- '/Users/floriangollnow/Dropbox/PaperRachael/Data'
muni <- read_sf (file.path(out, "municipalities_cerrado_biome","municipalities_cerrado_biome_wgs84.shp"))


# soy yield (kg/ha)

yield_kgha <- read_rds ( file.path(out, "sidra/yield_kg_ha_2014_2019.rds")) %>% 
  filter(Ano==2019) %>% select(`Município (Código)`, `Unidade de Medida`, Valor)
munis_yield  <-  muni %>%  left_join(yield_kgha, by=c("cd_geocmu"="Município (Código)"))
mean_yield <-mean(munis_yield$Valor, na.rm = TRUE) 




# mean prices 2014-2019

out_dir <- ("/Users/floriangollnow/Dropbox/ZDC_project/DATA/Prices")
prices<- read_rds( file.path(out_dir, "Soy_PricesR.rds")) %>% filter(year>=2014) 



#exchangerate
dir_exch<-"/Users/floriangollnow/Dropbox/ZDC_project/DATA/ExchangeRates"

exc <- read_rds (file.path(dir_exch,"exchangeRates.rds"))

prices_US<- prices %>% left_join(exc) %>% mutate(Soy_USD = MeanBRL*Mean_BRL_USD)

prices_US_mean <- prices_US %>% summarise(SoyUSD_mean=mean(Soy_USD, na.rm=TRUE))

prices_US_mean *(1000/60)

