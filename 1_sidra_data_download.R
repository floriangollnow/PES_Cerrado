#data download  sidra:
library(sidrar)
library(tidyverse)
#directory
out <- '/Users/floriangollnow/Dropbox/PaperRachael/Data/sidra'

#income ----
info_sidra(4009, wb=FALSE)
income_mean <- get_sidra(4009,variable = 878, period = c("2010"), geo="City", classific =c("c1", "c11339"), category = list(6795, 31635))
income_mean <-income_mean %>%  as_tibble ()%>%  select (`Município (Código)`, `Município`, Ano,  `Unidade de Medida`, Valor)

write_rds (income_mean, file.path(out, "mean_income_2010.rds"))
# soy yield (kg/ha)
yield_kg_ha <- get_sidra(1612,variable = 112, period = c("2014-2019"), geo="City", classific =c("c81"), category = list(2713))

names(yield_kg_ha)

yield_kg_ha<-yield_kg_ha %>%  as_tibble ()%>%  select (`Município (Código)`, `Município`, Ano, `Produto das lavouras temporárias`, `Unidade de Medida`, Valor)

write_rds (yield_kg_ha, file.path(out, "yield_kg_ha_2014_2019.rds"))

# soy production (tons) ----
info_sidra(1612, wb=FALSE)
prod_tons <- get_sidra(1612,variable = 214, period = c("2014-2019"), geo="City", classific =c("c81"), category = list(2713))
names(prod_tons)

prod_tons<-prod_tons %>%  as_tibble ()%>%  select (`Município (Código)`, `Município`, Ano,`Produto das lavouras temporárias`  ,`Unidade de Medida`, Valor)

write_rds (prod_tons, file.path(out, "prod_tons_soy_2014_2019.rds"))


# family farms -----
info_sidra(6778, wb=FALSE)
family_farms <- get_sidra(6778,variable = 183, period = c("2017"), geo="City", 
                          classific= c("c829", "c220"), 
                          category = list(c("46304","46303"),c(as.character (c(111543:111558,41139, 40645 )))))

family_farms<-family_farms %>%  as_tibble ()%>%  select (`Município (Código)`, `Município`, Ano,`Tipologia` ,`Unidade de Medida`, Valor)

write_rds (family_farms, file.path(out, "family_farms_2017.rds"))


# land tenure -----
land_tenure <- get_sidra(6778,variable = 183, period = c("2017"), geo="City", 
                          classific= "c218", 
                          category = "all")
unique( land_tenure$`Condição do produtor em relação às terras`)
land_tenure<-land_tenure%>%  as_tibble ()%>%  select (`Município (Código)`, `Município`, Ano,`Condição do produtor em relação às terras` ,`Unidade de Medida`, Valor)
write_rds (land_tenure, file.path(out, "land_tenure_2017.rds"))
## update to farms with definite land title!

# soy farms ------
info_sidra(6957, wb=FALSE) # produces error - downloaded from webside!
soy_f <- read_csv(file.path(out, "sidra_download/tabela6957_tot_soja.csv"),skip = 5,n_max = I(5561-6), col_types = "cccccdcdc")

# soy colhida area ---- 
#https://apisidra.ibge.gov.br/values/t/6957/n6/all/v/10089/p/all/c829/46302/c226/4896,111689,113869/c218/46502/c12517/113601/d/v10089%200
soy_a <- get_sidra(api = "/t/6957/n6/all/v/10089/p/all/c829/46302/c226/4896,111689,113869/c218/46502/c12517/113601/d/v10089%200")
soy_a_tb <- as_tibble(soy_a) %>% select (`Município (Código)`, `Município`, `Ano`, `Produtos da lavoura temporária (Código)`, 
                                      `Produtos da lavoura temporária`,`Unidade de Medida`, Valor) 
write_rds (soy_a_tb, file.path(out, "soy_area_colhida_2017.rds"))
# soy area and number of farms ====
# https://apisidra.ibge.gov.br/values/t/6957/n6/all/v/10084,10089/p/all/c829/46302/c226/4896,111689,113869/c218/46502/c12517/113601/d/v10089%200
soy_a_f <- get_sidra(api = "/t/6957/n6/all/v/10084,10089/p/all/c829/46302/c226/4896,111689,113869/c218/46502/c12517/113601/d/v10089%200")
soy_a_f_tb <- as_tibble(soy_a_f) %>% select (`Município (Código)`, `Município`, `Variável (Código)`, `Variável` , `Ano`, `Produtos da lavoura temporária (Código)`, 
                                         `Produtos da lavoura temporária`,`Unidade de Medida`, Valor) 

write_rds (soy_a_f_tb, file.path(out, "soy_area_colhida_nfarms_2017.rds"))


#soy_f <- soy_f %>% replace_na(list(`Soja em grão`=0))
write_rds (soy_f, file.path(out, "soy_farms_2017.rds"))
## update to soy area as percentage of agicultural areas (excl. pasture?)

# gini coefficient
# Tabela 1722 - Índice de Gini da distribuição do rendimento nominal mensal das pessoas de 10 anos ou mais de idade, com rendimento, por situação do domicílio e sexo (Vide Notas)
info_sidra(1722, wb=FALSE)$geo[1] # 1167 #155 #2906
gini <- get_sidra(1722,variable = 880, period = c("2010"), geo="State", 
                  classific= "c1", 
                  category = list(6795))

gini<- gini%>%  as_tibble ()%>%  select (`Unidade da Federação (Código)`, `Unidade da Federação`, Ano,`Unidade de Medida`, Valor)
write_rds (gini, file.path(out, "gini_2010.rds"))

  
#technical assitance : 
# 6844
info_sidra(6844)
technical_ass <- get_sidra(6844,variable = 183, period = c("2017"), geo="City", 
                  classific= "c12567", 
                  category = list(c(41151, 113111, 113559))) # 3 total, recebe, nao recebe

technical_ass<- technical_ass%>%  as_tibble ()%>%  select (`Município (Código)`, `Município`, Ano,`Origem da orientação técnica recebida`, `Unidade de Medida`, Valor)
write_rds (technical_ass, file.path(out, "technical_ass_2017.rds"))

  
#Tabela 6754 


  