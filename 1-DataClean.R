# INSTALACION Y CARGA DE PAQUETES ---------------------------------------------

## INSTALACIÓN DE PAQUETES
install.packages("tidyverse")
install.packages("readxl")
install.packages("openxlsx")
install.packages("lubridate")
install.packages("magrittr")
install.packages("dplyr")

## CARGA DE PAQUETES
library(tidyverse)
library(readxl)
library(openxlsx)
library(magrittr)
library(readr)
library(stringr)
library(dplyr)

# IMPORTACION DE DATA ---------------------------------------------------------
# Cargo mi DS que es sobre un listado de ciudades y su densidad
density_2022 <- read_delim("data/ListOfCitiesForDensity11.csv", 
                          delim = ",")

## Limpio mi Ds ya que la primera columna esta vacia
densidadCityDs <- density_2022[-1,]

## Creo un nuevo archivo como respaldo del ds cargado previamente
densidadCityDs2 <- write.xlsx(densidadCityDs,
                        "data/densidadCityDs2.xlsx")

densidadCityDs2 <- read_xlsx("data/densidadCityDs2.xlsx")

## CARGO MAS DS para cualquier emergencia
#contenedor20223t <- read_excel("data/apg_contededor20p20223t.xlsx")
#toneladasImpXAgencia <- read_excel("data/apg_tonimpexpagencias20223t.xlsx")
#trasnAreo20223t <- read_delim("data/dgac_transporteaereo_2022octubre.csv", 
#                           delim = ",")

#rm(contenedor20223t)

# ver el objeto ds
view(densidadCityDs)

## Cambio nombre a las columnas de ingles a español
densidadCityDs <- densidadCityDs %>% rename(PUESTO=Rank,
                                            CIUDAD=City,
                            POBLACION=Population,
                            AREA_X_KM2=`Area KM2`,
                           AREA_X_M2= `Area   M2`,
                            DENSIDAD_X_KM2=`Density KM2`,
                            DENSIDAD_X_M2=`Density  M2`,
                            PAIS=Country,
                           ANIO=Year)

## Selecciono los campos mas relevantes

densidadCityDs <- densidadCityDs %>% 
  select(PUESTO,CIUDAD,POBLACION,AREA_X_KM2,DENSIDAD_X_KM2,PAIS,ANIO)

densidad_2022_backup$PAIS <- as.character(densidad_2022_backup$PAIS)

## Elimino tambien la columna ANIO
densidad_2022_backup <- select(densidad_2022_backup, -ANIO)

#Deliminara las transacciones cuya Area x Km sea diferente de cero
densidad_2022_backup <- densidad_2022_backup %>% 
  filter(AREA_X_KM2 != 0)
