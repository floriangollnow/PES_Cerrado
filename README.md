
# PES Cerrado
Replication code for maps in: [___R.D. Garrett, J. Grabs, F. Cammelli, F. Gollnow, S.A. Levy. Should payments for environmental services be used to implement zero-deforestation supply chain policies? The case of soy in the Brazilian Cerrado___](https://doi.org/10.1016/j.worlddev.2022.105814)

## Code author   
Florian Gollnow

## Description   
### Data     
- IBGE data was downloaded from [sidra](https://sidra.ibge.gov.br/home/pms/brasil) ('1_sidra_data_download.R')   
- Trade data was derived from [trase.earth](https://www.trase.earth/) and prepared in [Gollnow et al. 2022 preprint](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=4006677)  
- Mapbiomas LU-data can be found [here](https://mapbiomas.org/) and was prepared separately in [Goggle Earth Engine](https://earthengine.google.com/) (GEE, '0_GEE_Mapbiomas_LU.js')  
- Rent data was prepared by Rodrigo et al. (in prep)   
- Spatial admin data was derived from [IBGE](https://geoftp.ibge.gov.br/) and [MMA](https://www.gov.br/icmbio/pt-br/servicos/geoprocessamento/mapa-tematico-e-dados-geoestatisticos-das-unidades-de-conservacao-federais)   

#### Maps
- maps were made for each indicator (e.g. Fig_2f_income.R) and saved as an rds file    
- all maps were combined in '3_combine_maps.R'       

![LULC](ggplots/panel_1_large_maps.png)
![Indicators](ggplots/panel_2_small_maps.png)
