
# PAQUETES A UTILIZAR -----------------------------------------------------
## INSTALACIÓN -------------------------------------------------------------
## Instalación de paquetes a utilizar en el Capítulo 3

## install.packages("modeest")
## install.packages("fdth")

## CARGA DE PAQUETES -------------------------------------------------------
## Cargando paquetes a utilizar en el Capítulo 2

library(tidyverse)
library(magrittr)
library(modeest)
library(fdth)


## para leer los archivos .RDS
ventas <- read_rds("datos/ventas.rds")
tidy_ventas <- read_rds("datos/tidy_ventas.rds")

## configurar valores muy altos
# getOption("scipen")
# options(scipen=3)


# Estadística Descriptiva Univariada --------------------------------------

## Medidas de tendencia central --------------------------------------------

## Media aritmética
mean(ventas$TOTAL_VENTAS, na.rm = TRUE)

## Media acotada
mean(ventas$TOTAL_VENTAS, na.rm = TRUE, trim=0.01)

## Mediana
median(ventas$TOTAL_VENTAS, na.rm = TRUE)

## Cargar paquete modeest
library(modeest)

## Moda
mlv(ventas$TOTAL_VENTAS)


## Medidas de posición --------------------------------------------

## Mínimo
min(ventas$TOTAL_VENTAS, na.rm = TRUE)

## Máximo
max(ventas$TOTAL_VENTAS, na.rm = TRUE)

## Cuartiles
quantile(ventas$TOTAL_VENTAS, probs = c(0.25, 0.50, 0.75))

## Deciles
quantile(ventas$TOTAL_VENTAS, probs = seq(from = 0.1, to = 1, by = 0.1))

## Centil 22% y 67%
quantile(ventas$TOTAL_VENTAS, probs = c(0.22, 0.67))



## Medidas de dispersión --------------------------------------------

## Varianza
var(ventas$TOTAL_VENTAS, na.rm = TRUE)

## Desviación Estándar
sd(ventas$TOTAL_VENTAS, na.rm = TRUE)

## Rango Intercuartil
IQR(ventas$TOTAL_VENTAS, na.rm = TRUE)

quantile(ventas$TOTAL_VENTAS, probs = 0.75)-quantile(ventas$TOTAL_VENTAS, probs = 0.25)

## Rango
diff(range(ventas$TOTAL_VENTAS, na.rm = TRUE))

max(ventas$TOTAL_VENTAS)-min(ventas$TOTAL_VENTAS)



## Frecuencias -------------------------------------------------------------

## Frecuencias absolutas de observaciones por provincia
table(ventas$provincia) %>% view()

## Frecuencias relativas de observaciones por provincia
prop.table(table(ventas$provincia)) %>% view()

round(prop.table(table(ventas$provincia)),2) %>% view()



## Distribuciones de frecuencias -------------------------------------------

## Obtenga la distribucíon de transacciones según las ventas totales de ventas que 
## inicie en $0$, finalice en $1800000000$ y el ancho de cada 
## intervalo sea $150000000$
library(fdth)
dist <- fdt(ventas$TOTAL_VENTAS, start = 0, end = 1800000000, h = 150000000)
dist %>% view()

## Filtramos conjunto de datos ventas
## Eliminamos las transacciones sin provincia
ventas %>% 
    filter(provincia!="ND") %>% 
    view()

ventas <- ventas %>% 
    filter(provincia!="ND")

## Filtramos conjunto de datos ventas
## Eliminamos las transacciones mayores a 900'000,000
ventas %>% 
    filter(TOTAL_VENTAS<900000000) %>% 
    view()

ventas <- ventas %>% 
    filter(TOTAL_VENTAS<900000000)

## Filtramos conjunto de datos ventas
## Eliminamos las transacciones cuyas ventas y compras == 0
ventas %>%
    filter(TOTAL_COMPRAS!=0 | TOTAL_VENTAS!=0) %>% 
    view()

ventas <- ventas %>%
    filter(TOTAL_COMPRAS!=0 | TOTAL_VENTAS!=0)

## Obtenga la distribucíon de transacciones según las ventas totales de ventas que 
## inicie en $0$, finalice en $1800000000$ con 10 intervalos
dist <- fdt(ventas$TOTAL_VENTAS, k=4)
dist %>% view()


# Estadística Descriptiva Multivariada ------------------------------------


## Tabla de contingencia ---------------------------------------------------

tablacont <- ventas %>%
    filter(provincia=="PICHINCHA" | provincia=="GUAYAS" | provincia== "AZUAY")


## Tabla de contingencia - Meses
table(tablacont$provincia, tablacont$mes)

## Tabla de contingencia – Con los márgenes
tb_tablacont <- table(tablacont$provincia, tablacont$mes)
tb_tablacont

addmargins(tb_tablacont)

## Tabla de contingencia - Porcentajes
tb_tablacont_rel <- prop.table(tb_tablacont)
addmargins(tb_tablacont_rel)*100


## Gráfico de interacción --------------------------------------------------

## Pre-selecciono mi data ventas
graf_int <- ventas %>% 
    filter(sector=="ACTIVIDADES FINANCIERAS Y DE SEGUROS." | 
               sector=="INDUSTRIAS MANUFACTURERAS." | 
               sector=="COMERCIO AL POR MAYOR Y AL POR MENOR; REPARACIÓN DE VEHÍCULOS AUTOMOTORES Y MOTOCICLETAS.")

## Gráfico de interacción
with(graf_int,
     interaction.plot(mes, sector, TOTAL_VENTAS))

## Modifico valores de columna sector para modificar leyenda
graf_int <- graf_int %>% 
    mutate(sector2 = case_when(sector=="ACTIVIDADES FINANCIERAS Y DE SEGUROS." ~ "Act. Financieras y Seguros",
                               sector=="INDUSTRIAS MANUFACTURERAS." ~ "Ind. Manufactureras",
                               sector=="COMERCIO AL POR MAYOR Y AL POR MENOR; REPARACIÓN DE VEHÍCULOS AUTOMOTORES Y MOTOCICLETAS." ~ "Comercio al por mayor y menor"))

## Gráfico de interacción con estética mejorada
colors()
with(graf_int,
     interaction.plot(mes, sector2, TOTAL_VENTAS,
                      xlab = "2022", 
                      ylab = "Promedio de ventas tarifa 12%",
                      trace.label = "Sector económico",
                      col = c("tomato3", "violetred", "turquoise"),
                      lwd = 3,
                      legend = T),
     legend(xjust = 1, yjust = 1)
)


## Coeficiente de Correlación de Pearson -----------------------------------

## Correlacion
cor(ventas$TOTAL_VENTAS, ventas$TOTAL_COMPRAS)


## Gráfico de dispersión ---------------------------------------------------

## Explorar variables
ggplot(ventas, aes(TOTAL_VENTAS, TOTAL_COMPRAS)) +
    geom_point()


## Matriz de Correlación ---------------------------------------------------

## Matriz que resume la correlación de varias variables numéricas
## Deselecciono Total de ventas, Total de Compras y Compras RISE
matrix_cor <- ventas %>%
    select(-TOTAL_VENTAS, -TOTAL_COMPRAS, -COMPRAS_RISE) %>% 
    select_if(is.numeric) %>% cor()

round(matrix_cor, 2) %>% view()

## GRáficas de matriz de correlación, sólo columnas numéricas
## Mapa de Calor
heatmap(matrix_cor, col = gray(seq(1, 0, length = 16)))

# Activar paquete GGally
library(GGally)
# Pre-selección de data, solo variables numericas
correl <- ventas %>%
    select(-TOTAL_VENTAS, -TOTAL_COMPRAS, -COMPRAS_RISE)

# Sólo columnas numéricas
ggscatmat(correl)



