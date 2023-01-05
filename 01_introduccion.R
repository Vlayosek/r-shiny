
# CAPÍTULO 1: INTRODUCCIÓN A RSTUDIO

# ENTENDIENDO RSTUDIO -----------------------------------------------------

## Puedo incluir código directo desde la consola
## 8*4
## print("mi nombre es Linda")

## 1. Para ejecutar 1 línea de código a la vez:
## Pulse Ctrl+Enter sobre la línea de código (Atajo)
## O Puede presionar "Run" sobre la línea de código
4*8
print("mi nombre es Linda")

## 2. Para ejecutar varias líneas de código a la vez:
## Seleccione todas las líneas y pulse Ctrl+Enter
## O Puede presionar "Run" sobre las líneas de código seleccionadas
4*8
print("mi nombre es Linda")

## 3. Para ejecutar todo el documento:
## Pulse Ctrl+Shift+Enter
## Puede presionar "Run"


# TRABAJANDO CON PAQUETES -------------------------------------------------

# 1. Para instalar un paquete
install.packages("tidyverse")

# 2. Para cargar un paquete
library(tidyverse)


## Paquete para actualizar R. Si actualiza R debe hacerlo en la Gui y volver a instalar RStudio
# install.packages("installr")
# library(installr)
# updateR()



# GENERALIDADES ----------------------------------------------------------

## 1. CALCULADORA ----------------------------------------------------------

## Sumas
3 + 2 

## Restas
5 - 1 

## Multiplicación
4 * 7

## División
(6 + 8) / 2 

## Potencia
3^4     


## 2. ASIGNACIÓN -----------------------------------------------------------

## crear una variable de nombre mi_var
mi_var <- 6

# imprime el valor guardado en la variable
mi_var

## ejercicio
## crea las variables
manzanas <- 4
naranjas <- 5

## realiza la operación
manzanas + naranjas


## 3. FUNCIONES ------------------------------------------------------------

## guardamos la suma de los números en una variable
ejercicio <- 2+3+4+5+6
ejercicio

## dividimos el resultado para el número de niños
ejercicio / 5

?mean
## calcular el promedio de un conjunto de datos
mean(c(2,3,4,5,6))



# PRÀCTICA 1----------------------------------------------------------------

## Crea un proyecto en tu computadora denominado "Curso_R".
## En el nuevo proyecto crea un script denominado "practica1".

## En el script: 1. Crea una variable, asígnale el valor de 20.



## En el script: 2. Crea otra variable, asígnale el valor de 3.



## En el script: 3. Crea otra variable que contenga la resta de la primera y segunda variable que creaste y elévala al cuadrado.



## En el script: 4. Imprime el resultado.

