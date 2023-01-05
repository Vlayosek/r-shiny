

# PAQUETES A UTILIZAR -----------------------------------------------------


## INSTALACIÓN -------------------------------------------------------------
## Instalación de paquetes a utilizar en el Capítulo 2

#install.packages("tidyverse")
#install.packages("readxl")
#install.packages("openxlsx")
#install.packages("lubridate")
#install.packages("magrittr")


## CARGA DE PAQUETES -------------------------------------------------------
## Cargando paquetes a utilizar en el Capítulo 2

library(tidyverse)
library(readxl)
library(openxlsx)
library(magrittr)


## Visualizar los paquetes que contiene tidyverse
tidyverse::tidyverse_packages()



# IMPORTAR DATOS ----------------------------------------------------------

## CSV FILE ------------------------------------------------------------
## Importando archivos .csv
## únicamente especificando nombre de archivo, escribo la ruta
## realizo asignación para guardar el archivo en un objeto llamado ventas_2022
library(readr)
ventas_2022 <- read_delim("datos/sri_ventas_2022.csv", 
                          delim = "|")
view(ventas_2022)


## XLS o XLSX FILE ---------------------------------------------------------
## importar desde Excel
## Podemos especificar el nombre del archivo, hoja y skip
## Guardo el archivo en un objeto llamado encuesta
library(readxl)
encuesta <- read_excel("datos/encuesta.xlsx",
                       sheet = "enc1", skip=2)
view(encuesta)

library(openxlsx)
encuesta2 <- read.xlsx("datos/encuesta.xlsx")

## exportar archivo a excel
encuesta2 <- write.xlsx(encuesta2,
                        "datos/encuesta2.xlsx")



# ESTRUCTURAS DE DATOS ----------------------------------------------------

## VECTORES ----------------------------------------------------------------
## vector de dimensión 1
x <- 4
is.vector(x)

## creando vectores con concatenar c()
y <- c(11, 13, 15, 20)
y
is.vector(y)

## creando vectores de tipo caracter, elementos en comillas
z <- c("1", "5", "11", "14")
z
is.vector(z)

## operaciones entre vectores de misma dimensión
w <- c(2, 5, 6, 8)
w
y + 2*w - 3

## función para conocer la longitud de los vectores
length(x)
length(y)

## indexación para extraer elementos
w       # reviso los elementos que contiene el vector
w[2]    # extraigo el segundo elemento del vector w
w[-3]   # imprimo el vector w, excepto su tercer elemento

## guardo en un objeto el nuevo vector
w <- w[-3]   # guardo el vector sin su tercer elemento
w


## DATA.FRAMES -------------------------------------------------------------

## crear un data.frame con vectores previamente creados
nombres <- c("Marcela Cox", "Luis Vargas", "David Mieles")
edades <- c(24,32,27)
seguro <- factor(c("IESS", "BMI", "IESS"))

## guardo el data.frame en el objeto pacientes
pacientes <- data.frame(nombres, edades, seguro)
pacientes

## cambiar el nombre de las columnas del data.frame desde su creación
pacientes2 <- data.frame(N1=nombres, N2=edades, seguro)
pacientes2    

## cambiar nombres de columnas de data.frame existente
names(pacientes2) <- c("Name", "Age", "Insurance")
pacientes2

## extraer la edad de David Mieles
pacientes[3,2]

## extraer toda la información de David Mieles
pacientes[3,]

## extraer todos los nombres de los pacientes 
pacientes[,1]

## para extraer una columna entera también se lo puede hacer con $
## consultar los valores de la columna de nombres
pacientes$nombres

## conocer la media de las edades de los pacientes
mean(pacientes$edades)

## podemos ordenar los elementos de vectores
pacientes$edades
order(pacientes$edades)

## podemos ordenar los elementos de la columna de un data.frame
pacientes[order(edades),]


## FUNCIONES BÁSICAS -------------------------------------------------------

## estructura de ventas_2022
str(pacientes)

## nombres de columnas de ventas_2022
colnames(pacientes)

## Visualización de las primeras observaciones
head(pacientes)
head(pacientes, n=1)

## Visualización de las 2 últimas observaciones
tail(pacientes)
tail(pacientes, n=2)

## Total de la edades de los pacientes
sum(pacientes$edades)

## paciente más joven
min(pacientes$edades)

## paciente de mayor edad
max(pacientes$edades)

## Resumen de la variable No_Alumnos
summary(pacientes)


## PRÁCTICA 2.1 ------------------------------------------------------------

## 1. Revise la estructura del conjunto de datos `ventas_2022`. Asegúrese 
## que el objeto haya sido cargado previamente en Environment.


## 2. Revise los nombres de las variables del conjunto de datos `ventas_2022`


## 3. Visualice las primeras 10 observaciones.


## 4. Visualice las 8 últimas observaciones.


## 5. Efectúe un resumen de estadísticas básicas.


## 6. Extraiga las 100 primeras observaciones que 
## muestre las columnas de la provincia, cantón y las ventas.


## 7. Extraiga toda la columna del total de ventas


## 8. Extraiga toda la información de la observación 55.



# TIPOS DE DATOS ----------------------------------------------------------

## DATOS NUMÉRICOS --------------------------------------------------------

## clase de un vector de 1 elemento
class(5)

## clase de la columna edades del dataset pacientes
class(pacientes$edades)

## vector de tipo caracter
class(z)

## as.numeric()
## cambio de clase caracter a numérico con as.numeric()
class(as.numeric(z))

## parse_number()
## cambio de clase caracter a numérico con parse_number()
class(parse_number(z))

## resolviendo problemas de agrupación con parse_number()
parse_number("6'789,56", 
             locale = locale(grouping_mark = "'",
                             decimal_mark = ","))

## eliminar otros caracteres no numéricos
parse_number("$100")
parse_number("20%")
parse_number("It cost $123.45")
parse_number("$123.456.789", locale = locale(grouping_mark = "."))


## CADENA DE CARACTERES ----------------------------------------------------

## Para convertir datos a tipo caracter usamos la función as.character():
pacientes
class(pacientes$seguro)

## convertir de factor a tipo caracter
pacientes$seguro <- as.character(pacientes$seguro)
class(pacientes$seguro)

## Convertimos un dato tipo fecha a tipo caracter:
## consultamos la función now() y su clase
lubridate::now()
class(lubridate::now())

## convertimos a tipo caracter
as.character(lubridate::now())


## FACTORES ----------------------------------------------------------------

## creamos una variable que registra meses
fc1 <- c("Dic", "Abr", "Ene", "Mar")
class(fc1)

## defino la lista de niveles válidos
niveles_meses <- c("Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic")

## con la función factor() creo el factor
y1 <- factor(fc1, levels = niveles_meses)
class(y1)

## para acceder a los niveles del factor
levels(y1)


## FECHAS Y HORAS ----------------------------------------------------------

## parse_datetime()
## Dato de fecha-hora
fecha1 <- "2010-10-01T2010"
parse_datetime(fecha1)

## parse_datetime()
## Si se omite la hora, será determinada como medianoche.
fecha2 <- "20101010"
parse_datetime(fecha2)

## parse_date() asume aaaa-mm-dd o aaaa/mm/dd.
fecha3 <- "2010-10-01"
parse_date(fecha3)

## parse_time() espera la hh:mm:ss, los segundos y el especificador am/pm son opcionales
parse_time("01:10 am")
parse_time("20:10:01")

## Para obtener la fecha o fecha-hora actual 
today()
now()

## DESDE CADENAS DE CARACTERES
ymd("2017-01-31")
ymd("20170131")
mdy("01-31-2017")
mdy("01312017")
dmy("31-01-2017")
dmy("31012017")
mdy_hm("01/31/2017 08:01")
ymd_hms("2017-01-31 20:11:59")

## DESDE COMPONENTES INDIVIDUALES
ejemplo <- data.frame(anio= c(1994, 1992, 1987),
                      dia= c(21, 02, 15),
                      mes= c(02, 04, 05),
                      hora= c(20, 14, 09),
                      minuto= c(45, 30, 15))
ejemplo

## make_date() para crear fecha
## forma fecha que contiene dia, mes y anio
make_date(ejemplo$anio, ejemplo$mes, ejemplo$dia)

## make_datetime() para crear fecha-hora
# forma fecha-hora
make_datetime(ejemplo$anio, ejemplo$mes, ejemplo$dia, ejemplo$hora, ejemplo$minuto)

## DESDE OTROS TIPOS
as_datetime(today())
as_date(now())


## PRÁCTICA 2.2 --------------------------------------------------------------

## EJERCICIO 1:

## Modificar el tipo de dato de las variables:
## "VENTAS_NETAS_TARIFA_12"


## "VENTAS_NETAS_TARIFA_0"


## "EXPORTACIONES"


## "COMPRAS_NETAS_TARIFA_12"


## "COMPRAS_NETAS_TARIFA_0"


## "IMPORTACIONES"


## "COMPRAS_RISE"




## EJERCICIO 2:
## 2. Crear una nueva columna con la función 
## `dplyr::mutate()` que indique la fecha en 
## el formato (YYYY-MM-DD).





## EJERCICIO 3:
## 3. Convertir los meses en un vector tipo factor y modificar los niveles al nombre abreviado de cada mes




# DATOS RELACIONALES CON DPLYR --------------------------------------------

# Creamos data frames
df_1 <- data.frame(Nombre= c('Belén', 'Noé', 'Salvador', 'Anne', 'Pablo', 'Rafaela', 'Victoria'),
                   Edad = c(22,18,21,26,25,23,21),
                   Ciudad= factor(c('Gye', 'Uio', 'Cue', 'Gye', 'Cue', 'Uio', 'Cue')) )

df_1

df_2 <- data.frame(
    A= c('Ana', 'Belén','Jose', 'Anne', 'Luis'), 
    B= c(100,200,300,200,250),
    C= c('Soltera','Soltera','Casado','Divorciada','Soltero'))

df_2


## MUTATING JOINS ----------------------------------------------------------

## inner_join: deja las observaciones cuyas claves coinciden en ambos df 
df_1 %>% inner_join(df_2, by = c("Nombre"="A"))

## left_join: realiza el match con todas las claves del conjunto de la izquierda
df_1 %>% left_join(df_2, by = c("Nombre"="A"))

## right_join: realiza el match con las claves del conjunto de la derecha
df_1 %>% right_join(df_2, by = c("Nombre"="A"))

## full_join: mantiene los datos de ambos conjuntos de datos
df_1 %>% full_join(df_2, by = c("Nombre"="A"))

## para sacar duplicados del data frame
df_1 %>% filter(duplicated(Nombre))
## para sacar no duplicados del data frame
df_1 %>% filter(!duplicated(Nombre))


## FILTERING JOINS ---------------------------------------------------------
## Muestra las observaciones del conjunto de la izquierda que tiene coincidencias
df_1 %>% semi_join(df_2, by = c("Nombre"="A"))

## Muestra las observaciones del conjunto de la izquierda que no tiene coincidencias
df_1 %>% anti_join(df_2, by = c("Nombre"="A"))


## SET OPERATIONS ----------------------------------------------------------

## Creamos otro data frame
df_3 <- data.frame(Nombre= c('Belén', 'Noé', 'María', 'Anne', 'Pablo'),
                   Edad = c(22,18,21,26,25),
                   Ciudad= factor(c('Cue', 'Uio', 'Cue', 'Gye', 'Cue')))

df_3

## devuelve las obseervaciones comunes entre x e y
intersect(df_1, df_3)

## devuelve las observaciones únicas en x e y
union(df_1, df_3)

## devuelve las observaciones en x pero diferentes de y
setdiff(df_1, df_3)


## PRÁCTICA 2.3 --------------------------------------------------------------

## EJERCICIO 1:

#### Ejercicio propuesto: ¿Qué join necesitamos realizar en nuestros 
# datos? Efectúalo.

## Cargue a R, la hoja `ciiu_1level` del archivo denominado `CIIU.xls`.


## ¿Qué join necesitamos realizar en nuestros datos `ventas`? Efectúelo.







# DATOS ORDENADOS CON TIDYR -----------------------------------------------

library(datos)


## ORDENAR A LO ANCHO ------------------------------------------------------

tabla2

# cuando una observación aparece en múltiples filas uso pivot_wider()
tabla2 %>%
    pivot_wider(names_from = tipo, values_from = cuenta)


## ORDENAR A LO LARGO ------------------------------------------------------

tabla4a

# cuando una observación aparece en múltiples columnas uso pivot_longer()
tabla4a %>%
    pivot_longer(cols = c(`1999`, `2000`), 
                 names_to = "anio", 
                 values_to = "casos")


## PRÁCTICA 2.4 ------------------------------------------------------------


## 1. ¿Qué tipo de pivoteo aplicarías al conjunto de datos `ventas` 
## para que éste sea un data.frame ordenado? 



## ¿Por qué?




## 2. Corrija el conjunto de datos y guárdelo en un nuevo objeto llamado `tidy_ventas`




# TRANSFORMACIÓN DE DATOS CON DPLYR -----------------------------------------

## RENAME() ------------------------------------------------------------
## Cambiamos el nombre de las variables en el data set profesores2
ventas <- ventas %>% rename(anio=ANIO,
                            mes=MES,
                            provincia=PROVINCIA,
                            canton=CANTON,
                            VN_tar12=VENTAS_NETAS_TARIFA_12,
                            VN_tar0=VENTAS_NETAS_TARIFA_0,
                            CN_tar12=COMPRAS_ENTAS_TARIFA_12,
                            CN_tar0=COMPRAS_NETAS_TARIFA_0,
                            fecha=Fecha,
                            sector= DESCRIPCION)

colnames(ventas)


## SELECT() ------------------------------------------------------------
## Selecciono las variables que deseo de tidy_ventas:
tidy_ventas %>% 
    select(ANIO, MES, PROVINCIA, CANTON, DESCRIPCION, transaccion, monto) %>% 
    view()

tidy_ventas <- tidy_ventas %>% 
    select(ANIO, MES, PROVINCIA, CANTON, DESCRIPCION, transaccion, monto)

## Deselecciono las variables que no deseo de ventas
ventas %>% 
    select(mes, provincia, canton, VN_tar12, VN_tar0, EXPORTACIONES, CN_tar12, CN_tar0, IMPORTACIONES, COMPRAS_RISE, -anio,-CODIGO_SECTOR_N1,-TOTAL_COMPRAS,-TOTAL_VENTAS) %>% 
    view()

## Modifico el conjunto de datos ventas
ventas <- ventas %>% 
    select(mes, provincia, canton, VN_tar12, VN_tar0, EXPORTACIONES, CN_tar12, CN_tar0, IMPORTACIONES, COMPRAS_RISE, -anio,-CODIGO_SECTOR_N1,-TOTAL_COMPRAS,-TOTAL_VENTAS)

str(ventas)

## FILTER() ----------------------------------------------------------------
## Filtrar observaciones
## Delimitar a las transacciones cuyo monto sea diferente de cero
tidy_ventas %>% 
    filter(monto != 0) %>% 
    view()

## Elimínelas del conjunto de datos
tidy_ventas <- tidy_ventas %>% 
    filter(monto != 0)

## Delimitar tidy_ventas a las exportaciones e importaciones

unique(tidy_ventas$transaccion)

tidy_ventas %>% 
    filter(transaccion %in% c("EXPORTACIONES", "IMPORTACIONES")) %>% 
    view()

## Delimitar tidy_ventas a las exportaciones e importaciones
## de la provincia del Pichincha

unique(ventas$provincia)

tidy_ventas %>% 
    filter((transaccion %in% c("EXPORTACIONES", "IMPORTACIONES")) & 
               PROVINCIA=="PICHINCHA") %>% 
    view()


## Delimitar tidy_ventas a las exportaciones e importaciones
## de la provincia del Pichincha
## cuyos montos sean mayores a $600.000

tidy_ventas %>% 
    filter((transaccion %in% c("EXPORTACIONES", "IMPORTACIONES")) & 
               PROVINCIA=="PICHINCHA" &
               monto > 600000) %>% 
    view()


## MUTATE() ----------------------------------------------------------------
## Vamos a agregar dos columnas que contengan el total de compras y ventas
ventas %>% mutate(TOTAL_COMPRAS=round(CN_tar12+CN_tar0+IMPORTACIONES+COMPRAS_RISE,2),
                  TOTAL_VENTAS=round(VN_tar0+VN_tar12,2)) %>% 
    view()


ventas <- ventas %>% mutate(TOTAL_COMPRAS=round(CN_tar12+CN_tar0+IMPORTACIONES+COMPRAS_RISE,2),
                            TOTAL_VENTAS=round(VN_tar0+VN_tar12,2))


## configurar valores muy altos
# getOption("scipen")
# options(scipen=3)

## Vamos a agregar una columna que contenga los montos del IVA
## de acuerdo a las transacciones
tidy_ventas %>% 
    mutate(IVA = case_when(transaccion=="COMPRAS_ENTAS_TARIFA_12" ~ round((monto*0.12),2),
                           transaccion=="VENTAS_NETAS_TARIFA_12" ~ round((monto*0.12),2),
                           TRUE ~ 0)) %>%
    view()

tidy_ventas <- tidy_ventas %>% 
    mutate(IVA = case_when(transaccion=="COMPRAS_ENTAS_TARIFA_12" ~ round((monto*0.12),2),
                           transaccion=="VENTAS_NETAS_TARIFA_12" ~ round((monto*0.12),2),
                           TRUE ~ 0))


## SUMMARISE() -------------------------------------------------------------
## Indicador: Total de Compras y Ventas con tarifa 0%
ventas %>% 
    summarise("Total de Ventas" = sum(VN_tar0),
              "Total de Compras" = sum(CN_tar0)) %>% 
    view()

## Indicador: Total de Compras y Ventas con tarifa 0% de Enero
ventas %>%
    filter(mes=="Ene") %>% 
    summarise("Total de Ventas" = sum(VN_tar0),
              "Total de Compras" = sum(CN_tar0)) %>% 
    view()


## GROUP_BY() --------------------------------------------------------------
## Indicador: Compras y Ventas promedio mensuales con tarifa 0\%
ventas %>%
    group_by(mes) %>% 
    summarise("Ventas Promedio" = mean(VN_tar0),
              "Compras Promedio" = mean(CN_tar0)) %>% 
    view()

## Indicador: Compras y Ventas promedio mensuales con tarifa 0\% 
## de las provincias de Pichincha y Guayas
ventas %>%
    filter(provincia==c("PICHINCHA", "GUAYAS")) %>% 
    group_by(mes, provincia) %>% 
    summarise("Ventas Promedio" = mean(VN_tar0),
              "Compras Promedio" = mean(CN_tar0)) %>% 
    view()






