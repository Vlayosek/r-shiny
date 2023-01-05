

# PAQUETES A UTILIZAR -----------------------------------------------------


## INSTALACIÓN -------------------------------------------------------------
## Instalación de paquetes a utilizar en el Capítulo 4



## CARGA DE PAQUETES -------------------------------------------------------
## Cargando paquetes a utilizar en el Capítulo 4

library(tidyverse)
library(magrittr)
library(plotly)
library(cowplot)

options(scipen = 4)


# CREACIÓN DE GRÁFICOS -------------------------------------------------

## DATA ------------------------------------------------------------
## Elegimos la Data
ventas %>% ggplot()


## ESTÉTICA ----------------------------------------------------------------
## Especificamos las variables con aes()
ventas %>% ggplot(aes(x=TOTAL_VENTAS, y=TOTAL_COMPRAS))


## GEOMETRÍAS --------------------------------------------------------------
## Definimos el tipo de gráfico con geom_
## En este caso tenemos un gráfico de barras
ventas %>% ggplot(aes(x=TOTAL_VENTAS, 
                      y=TOTAL_COMPRAS)) +
    geom_point()


## FACETAS -----------------------------------------------------------------
## facet_grid()

## facet_grid(. ~ var1) ordena por columnas
ventas %>%
    filter(mes=="Ene" | mes=="Feb" | mes=="Mar" | mes=="Abr") %>% 
    ggplot(aes(x=TOTAL_VENTAS, 
                      y=TOTAL_COMPRAS)) +
    geom_point() +
    facet_grid(.~mes)

## facet_grid(var1 ~ .) ordena por filas
ventas %>%
    filter(mes=="Ene" | mes=="Feb" | mes=="Mar" | mes=="Abr") %>% 
    ggplot(aes(x=TOTAL_VENTAS, 
               y=TOTAL_COMPRAS)) +
    geom_point() +
    facet_grid(mes~.)

## facet_grid(var1 ~ var2) compara dos variable categóricas
## v1 por filas, v2 por columnas
ventas %>% 
    filter((mes=="Ene" | mes=="Feb" | mes=="Mar" | mes=="Abr") &
               (provincia=="PICHINCHA" | provincia=="GUAYAS" | provincia=="AZUAY")) %>% 
    ggplot(aes(x=TOTAL_VENTAS, 
                      y=TOTAL_COMPRAS)) +
    geom_point() +
    facet_grid(provincia~mes)

## facet_wrap()
ventas %>%
    filter(mes=="Ene" | mes=="Feb" | mes=="Mar" | mes=="Abr") %>% 
    ggplot(aes(x=TOTAL_VENTAS, 
               y=TOTAL_COMPRAS)) +
    geom_point() +
    facet_wrap(~mes)


## PRÁCTICA 4.1 --------------------------------------------------------------

## Replique el siguiente gráfico

ventas %>% ggplot(aes(x=EXPORTACIONES, y=IMPORTACIONES)) +
    geom_point()

ventas %>% 
    filter(canton=="GUAYAQUIL" | canton=="QUITO" | canton=="CUENCA") %>% 
    ggplot(aes(x=EXPORTACIONES, y=IMPORTACIONES)) +
    geom_point() +
    facet_wrap(~canton)


## MÁS ESTÉTICAS -------------------------------------------------------

## más de 1 geometría, 1 gráfico de puntos y un gráfico
## de líneas suavizadas
ventas %>% 
    filter((mes=="Ene" |
                mes=="Feb" |
                mes=="Mar" |
                mes=="Abr") &
               (provincia=="PICHINCHA" |
                    provincia=="GUAYAS" |
                    provincia=="AZUAY")) %>% 
    ggplot(aes(x = TOTAL_VENTAS, 
               y = TOTAL_COMPRAS)) +
    geom_point() +
    geom_smooth()

## introducir más variables en el gráfico de puntos
ventas %>% 
    filter((mes=="Ene" |
                mes=="Feb" |
                mes=="Mar" |
                mes=="Abr") &
               (provincia=="PICHINCHA" |
                    provincia=="GUAYAS" |
                    provincia=="AZUAY")) %>% 
    ggplot(aes(x = TOTAL_VENTAS,
               y = TOTAL_COMPRAS)) +
    geom_point(aes(color = provincia,
                   shape = mes)) +
    geom_smooth()


## TRANSFORMACIONES ESTADÍSTICAS -------------------------------------------
## diferencias entre datos que pertenecen a la data y 
## datos transformados

## hacemos una selección de los datos
## analizaremos el cantón ESMERALDAS 
esmeraldas <- ventas %>% filter(canton=="ESMERALDAS")

## graficamos geom_point, geom_line() y geom_smooth
## geom_smooth a diferencia de los otros transforma los datos
esmeraldas %>% 
    ggplot(aes(x=TOTAL_COMPRAS, y=TOTAL_VENTAS)) +
    geom_point() + 
    geom_line() +
    geom_smooth()

## --Cada geom_ tiene un stat por default--
## Si incluimos 'stat' en el geom_ podemos transformar nuestros datos
## observamos el gráfico de puntos
esmeraldas %>% 
    ggplot(aes(x=TOTAL_COMPRAS, y=TOTAL_VENTAS)) +
    geom_point()

## agregamos un stat de identity y no pasa nada porque 
## geom_point es una gráfica que muestra los datos tal cual
## y el identity trabaja con el geom_point
esmeraldas %>% 
    ggplot(aes(x=TOTAL_COMPRAS, y=TOTAL_VENTAS)) +
    geom_point(stat = "identity")

## agregando un stat de smooth a geom_point
esmeraldas %>% 
    ggplot(aes(x=TOTAL_COMPRAS, y=TOTAL_VENTAS)) +
    geom_point(stat = "smooth")

## agregando un stat de identity a geom_smooth no realiza transformación de datos
esmeraldas %>% 
    ggplot(aes(x=TOTAL_COMPRAS, y=TOTAL_VENTAS)) +
    geom_smooth(stat = "identity")

## --Cada stat tiene un geom_ por default--
## Gráfico de barras usando geom_bar()
## transacciones EXPORTACIONES mayores a 5'000,000
ventas %>% 
    filter(EXPORTACIONES>5000000) %>% 
    ggplot(aes(x = provincia)) +
    geom_bar()

## el mismo gráfico con stat_count()
ventas %>% 
    filter(EXPORTACIONES>5000000) %>% 
    ggplot(aes(x = provincia)) +
    stat_count()

## Muestra un gráfico de barras de proporciones, 
## en lugar de un recuento
## especificar en el eje y = stat(prop) y group=1
ventas %>% 
    filter(EXPORTACIONES>5000000) %>% 
    ggplot(aes(x = provincia,
               y = stat(prop),
               group = 1)) +
    stat_count()

## Usar `stat_summary()` para resumir los valores
## de $y$ para cada valor único de $x$,
ventas %>% 
    filter(EXPORTACIONES>5000000) %>%  
    ggplot(aes(x = provincia,
               y = TOTAL_VENTAS)) +
    geom_jitter(alpha=0.5,  
               size=3,
               color="orchid4") +
    stat_summary(fun.min = min, 
                 fun.max = max,
                 fun=median, 
                 size=1, 
                 color="rosybrown2")


## COORDENADAS Y ESCALAS ---------------------------------------------------
## coord_flip
ventas %>% 
    filter(EXPORTACIONES>5000000) %>%  
    ggplot(aes(x = provincia,
               y = TOTAL_VENTAS)) +
    geom_boxplot()

## coord_flip
ventas %>% 
    filter(EXPORTACIONES>5000000) %>%  
    ggplot(aes(x = provincia,
               y = TOTAL_VENTAS)) +
    geom_boxplot() +
    coord_flip()

## coord_polar
ventas %>% 
    filter(EXPORTACIONES>5000000) %>% 
    ggplot(aes(x = provincia)) +
    geom_bar()

## coord_polar
ventas %>% 
    filter(EXPORTACIONES>5000000) %>% 
    ggplot(aes(x = provincia)) +
    geom_bar() +
    coord_polar()


## TEMAS -----------------------------------------------------------------

## temas predeterminados
ventas %>% 
    filter(EXPORTACIONES>5000000) %>% 
    ggplot(aes(x=TOTAL_COMPRAS, 
               y=TOTAL_VENTAS)) +
    geom_point() +
    theme_classic()

`theme_grey()`
`theme_bw()`
`theme_light()`
`theme_dark()`
`theme_classic()`
`theme_void()`

## color al gráfico
ventas %>% 
    filter(EXPORTACIONES>5000000) %>% 
    ggplot(aes(x=TOTAL_COMPRAS, 
               y=TOTAL_VENTAS,
               color = provincia)) +
    geom_point() +
    theme_classic()

library(RColorBrewer)
colors()
display.brewer.all()

ventas %>% 
    filter(EXPORTACIONES>5000000) %>% 
    ggplot(aes(x=TOTAL_COMPRAS, 
               y=TOTAL_VENTAS,
               color = provincia)) +
    geom_point() +
    scale_color_brewer(palette = "Paired")

## etiquetas de títulos con labs()
ventas %>% 
    filter(EXPORTACIONES>5000000) %>% 
    ggplot(aes(x=TOTAL_COMPRAS, 
               y=TOTAL_VENTAS,
               color = provincia)) +
    geom_point() +
    scale_color_brewer(palette = "Paired") +
    labs(x = "Total de Compras",
         y = "Total de Ventas",
         title = "Total de Compras vs Total de Ventas",
         subtitle = "Exportaciones mayores a USD 5'000,000",
         caption = "Fuente: https://www.sri.gob.ec/datasets",
         color = "Provincia")

## escalas y coordenadas
## cambiar escala a millones y etiquetas
grafico <- ventas %>% 
    filter(EXPORTACIONES>5000000) %>% 
    ggplot(aes(x=TOTAL_COMPRAS/1000000, 
               y=TOTAL_VENTAS/1000000,
               color = provincia)) +
    geom_point() +
    scale_color_brewer(palette = "Paired") +
    labs(x = "Total de Compras (en millones)",
         y = "Total de Ventas (en millones)",
         title = "Total de Compras vs Total de Ventas",
         subtitle = "Exportaciones mayores a USD 5'000,000",
         caption = "Fuente: https://www.sri.gob.ec/datasets",
         color = "Provincia")

grafico

## escalas y coordenadas
## cambiar escala de puntos con size y cambiar etiqueta
grafico <- ventas %>% 
    filter(EXPORTACIONES>5000000) %>% 
    ggplot(aes(x=TOTAL_COMPRAS/1000000, 
               y=TOTAL_VENTAS/1000000,
               color = provincia,
               size = EXPORTACIONES/1000000)) +
    geom_point() +
    scale_color_brewer(palette = "Paired") +
    labs(x = "Total de Compras (en millones)",
         y = "Total de Ventas (en millones)",
         title = "Total de Compras vs Total de Ventas",
         subtitle = "Exportaciones mayores a USD 5'000,000",
         caption = "Fuente: https://www.sri.gob.ec/datasets",
         color = "Provincia",
         size = "Exportaciones")

grafico

## cambiar escala de puntos con scale_size() y alpha
grafico <- ventas %>% 
    filter(EXPORTACIONES>5000000) %>% 
    ggplot(aes(x=TOTAL_COMPRAS/1000000, 
               y=TOTAL_VENTAS/1000000,
               color = provincia,
               size = EXPORTACIONES/1000000)) +
    geom_point(alpha=0.5) +
    scale_color_brewer(palette = "Paired") +
    scale_size(                                      #modifica la escala de la variable exportaciones
        breaks = floor(seq(1, 800, length.out = 5)), #los límites del 1 al 800, lo divide en 5 grupos
        limits = c(1, 800),                          #los límites de los valores
        range = c(2, 25),                            #radio de los puntos
        labels = function(x) {                       #para la redacción en la leyenda
            paste0("$", x, "M")                 
        }) +
    labs(x = "Total de Compras (en millones)",
         y = "Total de Ventas (en millones)",
         title = "Total de Compras vs Total de Ventas",
         subtitle = "Exportaciones mayores a USD 5'000,000",
         caption = "Fuente: https://www.sri.gob.ec/datasets",
         color = "Provincia",
         size = "Exportaciones")

grafico

## modificar leyendas con theme()
grafico +
    theme(legend.position = "bottom",                            #posición de las leyendas en la parte inferior
          legend.box = "vertical",                               #se acomodaron la leyenda de equipos y salarios de forma vertical
          legend.background = element_blank(),                   #fondo de las leyendas
          legend.key = element_rect(fill = "grey92",
                                    color = "grey92"))            #key es la base de las geometrías de las leyendas

## modificar formatos de textos con theme()
grafico +
    theme(legend.position = "bottom",                            #posición de las leyendas en la parte inferior
          legend.box = "vertical",                               #se acomodaron la leyenda de equipos y salarios de forma vertical
          legend.background = element_blank(),                   #fondo de las leyendas
          legend.key = element_rect(fill = "grey92",
                                    color = "grey92"),           #key es la base de las geometrías de las leyendas
          text = element_text(colour = "grey45",
                              size = 13),
          plot.title = element_text(face = "bold",
                                    size = 20,
                                    colour = "grey30"),                  #formato del título del gráfico
          plot.subtitle = element_text(size = 18,
                                       colour = "grey40"),               #formato del subtítulo del gráfico
          plot.caption = element_text(size = 10),
          axis.text = element_text(color = "grey40"))


## modificar ejes y paneles con theme()
grafico +
    theme(legend.position = "bottom",                            #posición de las leyendas en la parte inferior
          legend.box = "vertical",                               #se acomodaron la leyenda de equipos y salarios de forma vertical
          legend.background = element_blank(),                   #fondo de las leyendas
          legend.key = element_rect(fill = "grey92",
                                    color = "grey92"),           #key es la base de las geometrías de las leyendas
          text = element_text(colour = "grey45",
                              size = 13),
          plot.title = element_text(face = "bold",
                                    size = 20,
                                    colour = "grey30"),                  #formato del título del gráfico
          plot.subtitle = element_text(size = 18,
                                       colour = "grey40"),               #formato del subtítulo del gráfico
          plot.caption = element_text(size = 10),
          axis.text = element_text(color = "grey40"),
          plot.background = element_rect(fill = "grey92"),        #fondo de todo el gráfico
          panel.grid.minor = element_blank())


## para guardar el gráfico
## 1. guardar el gráfico en un objeto
grafico1 <- grafico +
    theme(legend.position = "bottom",                            
          legend.box = "vertical",                               
          legend.background = element_blank(),                   
          legend.key = element_rect(fill = "grey92",
                                    color = "grey92"),           
          text = element_text(colour = "grey45",
                              size = 13),
          plot.title = element_text(face = "bold",
                                    size = 20,
                                    colour = "grey30"),                  
          plot.subtitle = element_text(size = 18,
                                       colour = "grey40"),               
          plot.caption = element_text(size = 10),
          axis.text = element_text(color = "grey40"),
          plot.background = element_rect(fill = "grey92"),       
          panel.grid.minor = element_blank())


ggsave(filename = "img/grafico1.png",
       plot = grafico1,
       units = "cm",
       width = 35,
       height = 20)



# ANÁLISIS EXPLORATORIO DE DATOS ------------------------------------------

## VARIABLES NUMÉRICAS ------------------------------------

### HISTOGRAMA DE FRECUENCIAS ------------------------------------

## Histograma
# para crear un histograma de frecuencias absolutas
ventas %>%
    filter(VN_tar12>2500 & VN_tar12<20000) %>%
    ggplot(aes(x=VN_tar12)) +
    geom_histogram()

# cambiar parámetros para controlar el número de barras
# con bins()
ventas %>%
    filter(VN_tar12>2500 & VN_tar12<20000) %>%
    ggplot(aes(x=VN_tar12)) +
    geom_histogram(bins = 10)

# con binwidth()
ventas %>%
    filter(VN_tar12>2500 & VN_tar12<20000) %>%
    ggplot(aes(x=VN_tar12)) +
    geom_histogram(binwidth = 2500)

# para modificar los valores del eje x con scale_x_continuous()
ventas %>%
    filter(VN_tar12>2500 & VN_tar12<20000) %>%
    ggplot(aes(x=VN_tar12)) +
    geom_histogram(binwidth = 2500) +
    scale_x_continuous(breaks = seq(0, 20000, 2500))

# para modificar los valores del eje y con scale_y_continuous()
ventas %>%
    filter(VN_tar12>2500 & VN_tar12<20000) %>%
    ggplot(aes(x=VN_tar12)) +
    geom_histogram(binwidth = 2500) +
    scale_x_continuous(breaks = seq(0, 20000, 2500)) +
    scale_y_continuous(breaks = seq(0, 800, 100))

# agregar etiquetas y títulos al gráfico
ventas %>%
    filter(VN_tar12>2500 & VN_tar12<20000) %>%
    ggplot(aes(x=VN_tar12)) +
    geom_histogram(binwidth = 2500) +
    scale_x_continuous(breaks = seq(0, 20000, 2500)) +
    scale_y_continuous(breaks = seq(0, 800, 100)) +
    labs(x = "Ventas con tarifa 12% (USD)",
         y = "Frecuencia",
         title = "Ventas con tarifa 12% - Histograma")

# estética del histograma
ventas %>%
    filter(VN_tar12>2500 & VN_tar12<20000) %>%
    ggplot(aes(x=VN_tar12)) +
    geom_histogram(binwidth = 2500,
                   color = "black",
                   fill = "chartreuse4") +
    scale_x_continuous(breaks = seq(0, 20000, 2500)) +
    scale_y_continuous(breaks = seq(0, 800, 100)) +
    labs(x = "Ventas con tarifa 12% (USD)",
         y = "Frecuencia",
         title = "Ventas con tarifa 12% - Histograma")

# tema del histograma
ventas %>%
    filter(VN_tar12>2500 & VN_tar12<20000) %>%
    ggplot(aes(x=VN_tar12)) +
    geom_histogram(binwidth = 2500,
                   color = "black",
                   fill = "chartreuse4") +
    scale_x_continuous(breaks = seq(0, 20000, 2500)) +
    scale_y_continuous(breaks = seq(0, 800, 100)) +
    labs(x = "Ventas con tarifa 12% (USD)",
         y = "Frecuencia",
         title = "Ventas con tarifa 12% - Histograma") +
    theme(text = element_text(colour = "grey45",
                              size = 10),
          plot.title = element_text(face = "bold",
                                    size = 14,
                                    colour = "grey30"),
          plot.background = element_rect(fill = "grey92"),
          panel.grid.minor = element_blank())

              
## puedo invertir los ejes
ventas %>%
    filter(VN_tar12>2500 & VN_tar12<20000) %>%
    ggplot(aes(x=VN_tar12)) +
    geom_histogram(binwidth = 2500,
                   color = "black",
                   fill = "chartreuse4") +
    scale_x_continuous(breaks = seq(0, 20000, 2500)) +
    scale_y_continuous(breaks = seq(0, 800, 100)) +
    labs(x = "Ventas con tarifa 12% (USD)",
         y = "Frecuencia",
         title = "Ventas con tarifa 12% - Histograma") +
    theme(text = element_text(colour = "grey45",
                              size = 10),
          plot.title = element_text(face = "bold",
                                    size = 14,
                                    colour = "grey30"),
          plot.background = element_rect(fill = "grey92"),
          panel.grid.minor = element_blank()) +
    coord_flip()


### POLÍGONO DE FRECUENCIAS ------------------------------------
# puedo agregar un polígono de frecuencia
ventas %>%
    filter(VN_tar12>2500 & VN_tar12<20000) %>%
    ggplot(aes(x=VN_tar12)) +
    geom_histogram(binwidth = 2500,
                   color = "black",
                   fill = "chartreuse4") +
    geom_freqpoly(binwidth = 2500) +
    scale_x_continuous(breaks = seq(0, 20000, 2500)) +
    scale_y_continuous(breaks = seq(0, 800, 100)) +
    labs(x = "Ventas con tarifa 12% (USD)",
         y = "Frecuencia",
         title = "Ventas con tarifa 12% - Histograma") +
    theme(text = element_text(colour = "grey45",
                              size = 10),
          plot.title = element_text(face = "bold",
                                    size = 14,
                                    colour = "grey30"),
          plot.background = element_rect(fill = "grey92"),
          panel.grid.minor = element_blank())

## agregar estética al polígono de frecuencias
ventas %>%
    filter(VN_tar12>2500 & VN_tar12<20000) %>%
    ggplot(aes(x=VN_tar12)) +
    geom_histogram(binwidth = 2500,
                   color = "black",
                   fill = "chartreuse4") +
    geom_freqpoly(binwidth = 2500,
                  size = 1,
                  color = "thistle3") +
    scale_x_continuous(breaks = seq(0, 20000, 2500)) +
    scale_y_continuous(breaks = seq(0, 800, 100)) +
    labs(x = "Ventas con tarifa 12% (USD)",
         y = "Frecuencia",
         title = "Ventas con tarifa 12% - Histograma") +
    theme(text = element_text(colour = "grey45",
                              size = 10),
          plot.title = element_text(face = "bold",
                                    size = 14,
                                    colour = "grey30"),
          plot.background = element_rect(fill = "grey92"),
          panel.grid.minor = element_blank())


### GRÁFICO DE TEXTO ---------------------------------------------------
# puedo agregar los valores de las frecuencias en etiquetas
ventas %>%
    filter(VN_tar12>2500 & VN_tar12<20000) %>%
    ggplot(aes(x=VN_tar12)) +
    geom_histogram(binwidth = 2500,
                   color = "black",
                   fill = "chartreuse4") +
    geom_freqpoly(binwidth = 2500,
                  size = 1,
                  color = "chocolate1") +
    geom_text(stat = "bin",                       # para usar binwidth
              binwidth= 2500,
              aes(label=stat(round(count,2)),     # etiquetas de los textos
                  y=stat(count)),
              nudge_y = 30,                       # posición de etiquetas
              color = "grey50", 
              size = 3) +                     
    scale_x_continuous(breaks = seq(0, 20000, 2500)) +
    scale_y_continuous(breaks = seq(0, 800, 100)) +
    labs(x = "Ventas con tarifa 12% (USD)",
         y = "Frecuencia",
         title = "Ventas con tarifa 12% - Histograma") +
    theme(text = element_text(colour = "grey45",
                              size = 10),
          plot.title = element_text(face = "bold",
                                    size = 14,
                                    colour = "grey30"),
          plot.background = element_rect(fill = "grey92"),
          panel.grid.minor = element_blank())



### RUG PLOT ---------------------------------------------------
# puedo agregar un rug plot (gráfico de alfombra) al histograma
ventas %>%
    filter(VN_tar12>2500 & VN_tar12<20000) %>%
    ggplot(aes(x=VN_tar12)) +
    geom_histogram(binwidth = 2500,
                   color = "black",
                   fill = "chartreuse4") +
    geom_text(stat = "bin",                       # para usar binwidth
              binwidth= 2500,
              aes(label=stat(round(count,2)),     # etiquetas de los textos
                  y=stat(count)),
              nudge_y = 30,                       # posición de etiquetas
              color = "grey50", 
              size = 3) +
    geom_rug(alpha=0.1,
             color = "purple") +
    scale_x_continuous(breaks = seq(0, 20000, 2500)) +
    scale_y_continuous(breaks = seq(0, 800, 100)) +
    labs(x = "Ventas con tarifa 12% (USD)",
         y = "Frecuencia",
         title = "Ventas con tarifa 12% - Histograma") +
    theme(text = element_text(colour = "grey45",
                              size = 10),
          plot.title = element_text(face = "bold",
                                    size = 14,
                                    colour = "grey30"),
          plot.background = element_rect(fill = "grey92"),
          panel.grid.minor = element_blank())


### MAPA DE CALOR ---------------------------------------------------
# definimos geom_bin2d() y scale_fill_gradient()
ventas %>%
    filter(VN_tar12>2500 & VN_tar12<20000) %>%
    ggplot(aes(x=VN_tar12, y="")) +
    geom_bin2d() +
    scale_x_continuous(breaks = seq(0, 20000, 2500)) +
    scale_fill_gradient(low = "chocolate1", high = "black") +       # modificar escala de gradiente
    labs(x = "Ventas con tarifa 12% (USD)",
         title = "Ventas con tarifa 12% - Mapa de calor") +
    theme(text = element_text(colour = "grey45",
                              size = 10),
          plot.title = element_text(face = "bold",
                                    size = 14,
                                    colour = "grey30"),
          plot.background = element_rect(fill = "grey92"),
          panel.grid.minor = element_blank())



### GRÁFICA DE CAJAS ---------------------------------------------------
# puedo visualizar estadísticos descriptivos
# permite visualizar los quartiles de nuestra variable
ventas %>%
    filter(VN_tar12>2500 & VN_tar12<100000) %>%
    ggplot(aes(x=VN_tar12, y="")) +
    geom_boxplot(fill = "chocolate1") +
    scale_x_continuous(breaks = seq(0, 100000, 10000)) +
    labs(x = "Ventas con tarifa 12% (USD)",
         title = "Ventas con tarifa 12% - Grafico de cajas") +
    theme(text = element_text(colour = "grey45",
                              size = 10),
          plot.title = element_text(face = "bold",
                                    size = 14,
                                    colour = "grey30"),
          plot.background = element_rect(fill = "grey92"),
          panel.grid.minor = element_blank())

# agregar estadísticos
ventas %>%
    filter(VN_tar12>2500 & VN_tar12<100000) %>%
    ggplot(aes(x=VN_tar12, y="")) +
    geom_boxplot(fill = "chocolate1") +
    stat_summary(fun = mean, shape = 18, size = 2, color = "chartreuse4") +
    scale_x_continuous(breaks = seq(0, 100000, 10000)) +
    labs(x = "Ventas con tarifa 12% (USD)",
         title = "Ventas con tarifa 12% - Grafico de cajas") +
    theme(text = element_text(colour = "grey45",
                              size = 10),
          plot.title = element_text(face = "bold",
                                    size = 14,
                                    colour = "grey30"),
          plot.background = element_rect(fill = "grey92"),
          panel.grid.minor = element_blank())


### GRÁFICO DE FLUCTUACIÓN ---------------------------------------------------
# para visualizar la posición de las observaciones con geom_jitter()
ventas %>%
    filter(VN_tar12>2500 & VN_tar12<100000) %>%
    ggplot(aes(x=VN_tar12, y="")) +
    geom_boxplot(fill = "chocolate1", alpha = 0.5) +
    geom_jitter(color = "chartreuse4", alpha = 0.2) +
    scale_x_continuous(breaks = seq(0, 100000, 10000)) +
    labs(x = "Ventas con tarifa 12% (USD)",
         title = "Ventas con tarifa 12% - Grafico de cajas") +
    theme(text = element_text(colour = "grey45",
                              size = 10),
          plot.title = element_text(face = "bold",
                                    size = 14,
                                    colour = "grey30"),
          plot.background = element_rect(fill = "grey92"),
          panel.grid.minor = element_blank())


### GRÁFICO DE VIOLÍN ---------------------------------------------------
# para visualizar la concentración de las observaciones con geom_violin()
ventas %>%
    filter(VN_tar12>2500 & VN_tar12<100000) %>%
    ggplot(aes(x=VN_tar12, y="")) +
    geom_boxplot(fill = "chocolate1", alpha = 0.5) +
    geom_violin(fill = "chartreuse4", alpha = 0.3, color = NA) +
    scale_x_continuous(breaks = seq(0, 100000, 10000)) +
    labs(x = "Ventas con tarifa 12% (USD)",
         title = "Ventas con tarifa 12% - Grafico de cajas") +
    theme(text = element_text(colour = "grey45",
                              size = 10),
          plot.title = element_text(face = "bold",
                                    size = 14,
                                    colour = "grey30"),
          plot.background = element_rect(fill = "grey92"),
          panel.grid.minor = element_blank())


### DISTRIBUCIÓN Y DESCRIPTIVAS ---------------------------------------------------
# guardamos los dos gráficos en 

g1 <- ventas %>%
    filter(VN_tar12>2500 & VN_tar12<20000) %>%
    ggplot(aes(x=VN_tar12)) +
    geom_histogram(binwidth = 2500,
                   color = "chartreuse2",
                   fill = "chartreuse4") +
    geom_text(stat = "bin",                       # para usar binwidth
              binwidth= 2500,
              aes(label=stat(round(count,2)),     # etiquetas de los textos
                  y=stat(count)),
              nudge_y = 30,                       # posición de etiquetas
              color = "grey50", 
              size = 3) +                     
    scale_x_continuous(breaks = seq(0, 20000, 2500)) +
    scale_y_continuous(breaks = seq(0, 800, 100)) +
    labs(x = "Ventas con tarifa 12% (USD)",
         y = "Frecuencia",
         title = "Ventas con tarifa 12% - Histograma") +
    theme(text = element_text(colour = "grey45",
                              size = 10),
          plot.title = element_text(face = "bold",
                                    size = 14,
                                    colour = "grey30"),
          plot.background = element_rect(fill = "grey92"),
          panel.grid.minor = element_blank())


g2 <- ventas %>%
    filter(VN_tar12>2500 & VN_tar12<100000) %>%
    ggplot(aes(x=VN_tar12, y="")) +
    geom_boxplot(fill = "chocolate1") +
    stat_summary(fun = mean, shape = 18, size = 1, color = "chartreuse4") +
    theme_void() +
    theme(plot.background = element_rect(fill = "grey92", 
                                         color = "grey92"),
          panel.grid.minor = element_blank())

library(cowplot)

plot_grid(g1, g2, ncol = 1, rel_heights = c(9, 1), align = 'v')



## VARIABLES CATEGÓRICAS ---------------------------------------------

### GRÁFICO DE BARRAS ----------------------------------------------
## gráfico de barras simple
ventas %>% 
    filter(EXPORTACIONES>5000000) %>% 
    ggplot(aes(x = provincia)) +
    geom_bar() +
    labs(x = "Provincias",
         y = "Frecuencia",
         title = "Cantidad de transacciones globales por provincia") +
    theme(text = element_text(colour = "grey45",
                              size = 10),
          plot.title = element_text(face = "bold",
                                    size = 14,
                                    colour = "grey30"),
          plot.background = element_rect(fill = "grey92"),
          panel.grid.minor = element_blank())

## aumentando la frecuencia con geom_text()
ventas %>% 
    filter(EXPORTACIONES>5000000) %>% 
    ggplot(aes(x = provincia)) +
    geom_bar() +
    geom_text(stat = "count",
              aes(label=stat(round(count,2)),
                  y=stat(count)),
              nudge_y = 5,
              color = "grey50",
              size = 4) +
    labs(x = "Provincias",
         y = "Frecuencia",
         title = "Cantidad de transacciones globales por provincia") +
    theme(text = element_text(colour = "grey45",
                              size = 10),
          plot.title = element_text(face = "bold",
                                    size = 14,
                                    colour = "grey30"),
          plot.background = element_rect(fill = "grey92"),
          panel.grid.minor = element_blank())


## etiquetas del eje x de forma vertical
ventas %>% 
    filter(EXPORTACIONES>5000000) %>% 
    ggplot(aes(x = provincia)) +
    geom_bar() +
    geom_text(stat = "count",
              aes(label=stat(round(count,2)),
                  y=stat(count)),
              nudge_y = 5,
              color = "grey50",
              size = 4) +
    labs(x = "Provincias",
         y = "Frecuencia",
         title = "Cantidad de transacciones globales por provincia") +
    theme(text = element_text(colour = "grey45",
                              size = 10),
          plot.title = element_text(face = "bold",
                                    size = 14,
                                    colour = "grey30"),
          plot.background = element_rect(fill = "grey92"),
          panel.grid.minor = element_blank(),
          axis.text.x = element_text(angle = 90, size = 7))


## darle color a las barras y eliminar leyenda
ventas %>% 
    filter(EXPORTACIONES>5000000) %>% 
    ggplot(aes(x = provincia)) +
    geom_bar(aes(fill = provincia) ) +
    geom_text(stat = "count",
              aes(label=stat(round(count,2)),
                  y=stat(count)),
              nudge_y = 5,
              color = "grey50",
              size = 4) +
    labs(x = "Provincias",
         y = "Frecuencia",
         title = "Cantidad de transacciones globales por provincia") +
    theme(text = element_text(colour = "grey45",
                              size = 10),
          plot.title = element_text(face = "bold",
                                    size = 14,
                                    colour = "grey30"),
          plot.background = element_rect(fill = "grey92"),
          panel.grid.minor = element_blank(),
          axis.text.x = element_text(angle = 90, size = 7),
          legend.position = "none")

### LOLLIPOP ---------------------------------------------------------

ventas %>% 
    filter(EXPORTACIONES>5000000) %>% 
    group_by(provincia) %>% 
    summarise(Frec = n()) %>% 
    view()

## agrego solo los puntos con geom_point()
ventas %>% 
    filter(EXPORTACIONES>5000000) %>% 
    group_by(provincia) %>% 
    summarise(Frec = n()) %>% 
    ggplot(aes(x = provincia, y = Frec)) +
    geom_point()

## agrego los segmentos con geom_segment()
ventas %>% 
    filter(EXPORTACIONES>5000000) %>% 
    group_by(provincia) %>% 
    summarise(Frec = n()) %>% 
    ggplot(aes(x = provincia, y = Frec)) +
    geom_point() +
    geom_segment(aes(xend = provincia, y = 0, yend = Frec))

## agregamos etiquetas, formatos y colores
ventas %>% 
    filter(EXPORTACIONES>5000000) %>% 
    group_by(provincia) %>% 
    summarise(Frec = n()) %>% 
    ggplot(aes(x = provincia, y = Frec)) +
    geom_point(size = 5, color = "chartreuse4") +
    geom_segment(aes(xend = provincia, y = 0, yend = Frec),
                 color = "chartreuse4", size = 1) +
    labs(x = "Provincias",
         y = "Frecuencia",
         title = "Cantidad de transacciones globales por provincia") +
    theme(text = element_text(colour = "grey45",
                              size = 10),
          plot.title = element_text(face = "bold",
                                    size = 14,
                                    colour = "grey30"),
          plot.background = element_rect(fill = "grey92"),
          panel.grid.minor = element_blank(),
          axis.text.x = element_text(angle = 90, size = 7))

### GRÁFICO DE PASTEL ----------------------------------------------------

ventas %>% 
    filter(EXPORTACIONES>5000000) %>% 
    group_by(provincia) %>% 
    summarise(Frec = n()) %>% 
    mutate(Prop= round(Frec/ sum(Frec),4)*100 ) %>% 
    view()

# gráfico de pastel simple
ventas %>% 
    filter(EXPORTACIONES>5000000) %>% 
    group_by(provincia) %>% 
    summarise(Frec = n()) %>% 
    mutate(Prop= round(Frec/ sum(Frec),2) ) %>% 
    ggplot(aes(x = "", y=Prop, fill = provincia)) +
    geom_bar(stat = "identity", color="white") +
    coord_polar("y", start = 0)

# agregar texto al gráfico de pastel
ventas %>% 
    filter(EXPORTACIONES>5000000) %>% 
    group_by(provincia) %>% 
    summarise(Frec = n()) %>% 
    arrange(-Frec) %>% 
    mutate(Prop= round((Frec/ sum(Frec)),2),
           PosLab= cumsum(Prop) - 0.5*Prop)  %>% 
    view()

# convertir a factor
ventas$provincia <- factor(ventas$provincia,
                           levels = c("MANABI", "EL ORO", "SUCUMBIOS",
                                      "ZAMORA CHINCHIPE", "GUAYAS", "TUNGURAHUA",
                                      "ESMERALDAS", "COTOPAXI", "CARCHI", "PICHINCHA",
                                      "MORONA SANTIAGO", "LOJA", "LOS RIOS", "SANTA ELENA",
                                      "NAPO", "GALAPAGOS", "AZUAY", "ORELLANA", "CA�AR", 
                                      "CHIMBORAZO", "PASTAZA", "IMBABURA", "BOLIVAR",
                                      "SANTO DOMINGO DE LOS TSACHILAS"))

class(ventas$provincia)
unique(ventas$provincia)

## agregar etiquetas
ventas %>% 
    filter(EXPORTACIONES>5000000) %>% 
    group_by(provincia) %>% 
    summarise(Frec = n()) %>% 
    arrange(-Frec) %>% 
    mutate(Prop= round((Frec/ sum(Frec)),2),
           PosLab= cumsum(Prop) - 0.5*Prop) %>% 
    ggplot(aes(x = "", y=Prop, fill = reorder(provincia, Frec))) +
    geom_bar(stat = "identity", color="white") +
    coord_polar("y", start = 0) +
    geom_text(aes(y = PosLab, label = scales::percent(Prop)),
              color = "white",
              size = 3)


## mejorar temas, colores, formato
ventas %>% 
    filter(EXPORTACIONES>5000000) %>% 
    group_by(provincia) %>% 
    summarise(Frec = n()) %>% 
    arrange(-Frec) %>% 
    mutate(Prop= round((Frec/ sum(Frec)),2),
           PosLab= cumsum(Prop) - 0.5*Prop) %>% 
    ggplot(aes(x = "", y=Prop, fill = reorder(provincia, Frec))) +
    geom_bar(stat = "identity", color="white") +
    coord_polar("y", start = 0) +
    geom_text(aes(y = PosLab, label = scales::percent(Prop)),
              color = "white",
              size = 3,
              nudge_x = 0.15) +
    labs(title = "Cantidad de transacciones globales por provincia",
         fill = "Provincia",
         x = "",
         y = "") +
    theme(text = element_text(colour = "grey45",
                              size = 10),
          plot.title = element_text(face = "bold",
                                    size = 14,
                                    colour = "grey30"),
          plot.background = element_rect(fill = "grey92"),
          panel.grid.minor = element_blank(),
          panel.grid.major = element_blank(),
          axis.text.x = element_blank(),
          legend.position = "bottom",
          legend.background = element_blank(),
          legend.key = element_rect(fill = "grey92",
                                    color = "grey92"))



### GRÁFICO DE BARRAS APILADAS ----------------------------------------------

## gráfico de barras apiladas
ventas %>% 
    filter(EXPORTACIONES>5000000) %>% 
    group_by(provincia) %>% 
    summarise(Frec = n()) %>% 
    arrange(-Frec) %>% 
    mutate(Prop= round((Frec/ sum(Frec)),3),
           PosLab= cumsum(Prop) - 0.6*Prop) %>% 
    ggplot(aes(x = "", y=Prop, fill = reorder(provincia, Frec))) +
    geom_bar(stat = "identity", color="white") +
    geom_text(aes(y = PosLab, label = scales::percent(Prop)),
              color = "white",
              size = 3,
              nudge_x = 0.15)


## escala y con porcentaje
library(scales)

ventas %>% 
    filter(EXPORTACIONES>5000000) %>% 
    group_by(provincia) %>% 
    summarise(Frec = n()) %>% 
    arrange(-Frec) %>% 
    mutate(Prop= round((Frec/ sum(Frec)),3),
           PosLab= cumsum(Prop) - 0.6*Prop) %>% 
    ggplot(aes(x = "", y=Prop, fill = reorder(provincia, Frec))) +
    geom_bar(stat = "identity", color="white") +
    geom_text(aes(y = PosLab, label = scales::percent(Prop)),
              color = "white",
              size = 3,
              nudge_x = 0.15) +
    scale_y_continuous(label= percent_format())


## gráfico de barras apiladas: etiquetas y tema
ventas %>% 
    filter(EXPORTACIONES>5000000) %>% 
    group_by(provincia) %>% 
    summarise(Frec = n()) %>% 
    arrange(-Frec) %>% 
    mutate(Prop= round((Frec/ sum(Frec)),3),
           PosLab= cumsum(Prop) - 0.6*Prop) %>% 
    ggplot(aes(x = "", y=Prop, fill = reorder(provincia, Frec))) +
    geom_bar(stat = "identity", color="white") +
    geom_text(aes(y = PosLab, label = scales::percent(Prop)),
              color = "white",
              size = 3,
              nudge_x = 0.15) +
    scale_y_continuous(label= percent_format()) +
    labs(title = "Cantidad de transacciones globales por provincia",
         fill = "Provincia",
         x = "",
         y = "") +
    theme(text = element_text(colour = "grey45",
                              size = 10),
          plot.title = element_text(face = "bold",
                                    size = 14,
                                    colour = "grey30"),
          plot.background = element_rect(fill = "grey92"),
          panel.grid.minor = element_blank(),
          panel.grid.major = element_blank(),
          axis.text.x = element_blank(),
          legend.position = "bottom",
          legend.background = element_blank(),
          legend.key = element_rect(fill = "grey92",
                                    color = "grey92"))



## gráfico de barras apiladas horizontal
ventas %>% 
    filter(EXPORTACIONES>5000000) %>% 
    group_by(provincia) %>% 
    summarise(Frec = n()) %>% 
    arrange(-Frec) %>% 
    mutate(Prop= round((Frec/ sum(Frec)),3),
           PosLab= cumsum(Prop) - 0.6*Prop) %>% 
    ggplot(aes(x = "", y=Prop, fill = reorder(provincia, Frec))) +
    geom_bar(stat = "identity", color="white") +
    geom_text(aes(y = PosLab, label = scales::percent(Prop)),
              color = "white",
              size = 3,
              nudge_x = 0.15) +
    scale_y_continuous(label= percent_format()) +
    labs(title = "Cantidad de transacciones globales por provincia",
         fill = "Provincia",
         x = "",
         y = "") +
    theme(text = element_text(colour = "grey45",
                              size = 10),
          plot.title = element_text(face = "bold",
                                    size = 14,
                                    colour = "grey30"),
          plot.background = element_rect(fill = "grey92"),
          panel.grid.minor = element_blank(),
          panel.grid.major = element_blank(),
          axis.text.x = element_blank(),
          legend.position = "bottom",
          legend.background = element_blank(),
          legend.key = element_rect(fill = "grey92",
                                    color = "grey92")) +
    coord_flip()



### GRÁFICO DE CASCADA ------------------------------------------------------
library(waterfalls)

ventas %>% 
    filter(EXPORTACIONES>5000000) %>% 
    group_by(provincia) %>% 
    summarise(Frec = n()) %>% 
    arrange(-Frec) %>% 
    mutate(Prop= round((Frec/ sum(Frec))*100,2),
           PosLab= cumsum(Prop) - 0.6*Prop) %>%
    select(provincia, Prop) %>%
    waterfall(values = Prop, calc_total = TRUE) 


## color del gráfico waterfalls
ventas %>% 
    filter(EXPORTACIONES>5000000) %>% 
    group_by(provincia) %>% 
    summarise(Frec = n()) %>% 
    arrange(-Frec) %>% 
    mutate(Prop= round((Frec/ sum(Frec))*100,2),
           PosLab= cumsum(Prop) - 0.6*Prop) %>%
    select(provincia, Prop) %>%
    waterfall(values = Prop, 
              calc_total = TRUE, 
              fill_by_sign = FALSE,
              fill_colours = c("pink", "pink1", "pink2", "pink3", "plum", "plum1", "plum2", "plum3", "pink4", "plum4"),
              total_rect_color = "orchid4",
              rect_border = NA,
              total_rect_border_color = NA)


## tema del gráfico
ventas %>% 
    filter(EXPORTACIONES>5000000) %>% 
    group_by(provincia) %>% 
    summarise(Frec = n()) %>% 
    arrange(-Frec) %>% 
    mutate(Prop= round((Frec/ sum(Frec))*100,2),
           PosLab= cumsum(Prop) - 0.6*Prop) %>%
    select(provincia, Prop) %>%
    waterfall(values = Prop, 
              calc_total = TRUE, 
              fill_by_sign = FALSE,
              fill_colours = c("pink", "pink1", "pink2", "pink3", "plum", "plum1", "plum2", "plum3", "pink4", "plum4"),
              total_rect_color = "orchid4",
              rect_border = NA,
              total_rect_border_color = NA) +
    labs(title = "Cantidad de transacciones globales por provincia",
         fill = "Provincia") +
    theme(text = element_text(colour = "grey45",
                              size = 10),
          plot.title = element_text(face = "bold",
                                    size = 14,
                                    colour = "grey30"),
          plot.background = element_rect(fill = "grey92"),
          panel.grid.minor = element_blank(),
          legend.position = "bottom",
          legend.background = element_blank(),
          legend.key = element_rect(fill = "grey92",
                                    color = "grey92"))



## VARIAS VARIABLES NUMÉRICAS --------------------------------------------------------

### GRÁFICO DE DISPERSIÓN ---------------------------------------------------

# gráfico de dispersión simple
ventas %>% 
    filter(provincia=="PICHINCHA" | provincia=="GUAYAS" | provincia=="AZUAY") %>%
    view()

ventas %>% 
    filter(provincia=="PICHINCHA" |
                    provincia=="GUAYAS" |
                    provincia=="AZUAY") %>% 
    ggplot(aes(x = TOTAL_VENTAS, 
               y = TOTAL_COMPRAS)) +
    geom_point() 


# transparencia a los puntos
ventas %>% 
    filter(provincia=="PICHINCHA" |
                    provincia=="GUAYAS" |
                    provincia=="AZUAY") %>% 
    ggplot(aes(x = TOTAL_VENTAS, 
               y = TOTAL_COMPRAS)) +
    geom_point(alpha = 0.2) 



### GEOM SMOOTH -------------------------------------------------------------
# agregamos una línea de suavizado para ver la tendencia
ventas %>% 
    filter(provincia=="PICHINCHA" |
               provincia=="GUAYAS" |
               provincia=="AZUAY") %>% 
    ggplot(aes(x = TOTAL_VENTAS, 
               y = TOTAL_COMPRAS)) +
    geom_point(alpha = 0.2) +
    geom_smooth()



### MAPAS DE CALOR HEXAGONALES ----------------------------------------------
ventas %>% 
    filter(provincia=="PICHINCHA" |
               provincia=="GUAYAS" |
               provincia=="AZUAY") %>% 
    ggplot(aes(x = TOTAL_VENTAS, 
               y = TOTAL_COMPRAS)) +
    geom_hex()


## Para modificar el tamaño del hexágono
ventas %>% 
    filter(provincia=="PICHINCHA" |
               provincia=="GUAYAS" |
               provincia=="AZUAY") %>% 
    ggplot(aes(x = TOTAL_VENTAS, 
               y = TOTAL_COMPRAS)) +
    geom_hex(bins = 60)



## VARIABLES NUMÉRICAS CON 1 CATEGÓRICA ------------------------------------

# incluir una columna de region al dataset
ventas <- ventas %>% 
    mutate(region = case_when(provincia=="MANABI" ~ "COSTA",
                              provincia=="EL ORO" ~ "COSTA",
                              provincia=="GUAYAS" ~ "COSTA",
                              provincia=="ESMERALDAS" ~ "COSTA",
                              provincia=="LOS RIOS" ~ "COSTA",
                              provincia=="SANTA ELENA" ~ "COSTA",
                              provincia=="SANTO DOMINGO DE LOS TSACHILAS" ~ "COSTA",
                              provincia=="TUNGURAHUA" ~ "SIERRA",
                              provincia=="AZUAY" ~ "SIERRA",
                              provincia=="BOLIVAR" ~ "SIERRA",
                              provincia=="CARCHI" ~ "SIERRA",
                              provincia=="COTOPAXI" ~ "SIERRA",
                              provincia=="CHIMBORAZO" ~ "SIERRA",
                              provincia=="IMBABURA" ~ "SIERRA",
                              provincia=="LOJA" ~ "SIERRA",
                              provincia=="PICHINCHA" ~ "SIERRA",
                              provincia=="MORONA SANTIAGO" ~ "ORIENTE",
                              provincia=="NAPO" ~ "ORIENTE",
                              provincia=="ORELLANA" ~ "ORIENTE",
                              provincia=="PASTAZA" ~ "ORIENTE",
                              provincia=="SUCUMBIOS" ~ "ORIENTE",
                              provincia=="ZAMORA CHINCHIPE" ~ "ORIENTE",
                              provincia=="GALAPAGOS" ~ "INSULAR",
                              TRUE ~ "SIERRA"))


### HISTOGRAMA --------------------------------------------------------

## Histograma apilado
ventas %>% 
    filter(VN_tar12>2500 & VN_tar12<20000) %>% 
    ggplot(aes(x = VN_tar12, fill = region)) +
    geom_histogram()

## guardar el tema
tema_nuevo <- theme(text = element_text(colour = "grey45",
                              size = 10),
          plot.title = element_text(face = "bold",
                                    size = 14,
                                    colour = "grey30"),
          plot.background = element_rect(fill = "grey92"),
          panel.grid.minor = element_blank(),
          legend.background = element_blank())


## temas y etiquetas
ventas %>% 
    filter(VN_tar12>2500 & VN_tar12<20000) %>% 
    ggplot(aes(x = VN_tar12, fill = region)) +
    geom_histogram() +
    labs(x = "Ventas con tarifa 12% (USD)",
         y = "Frecuencia",
         title = "Ventas con tarifa 12% - Histograma",
         fill = "Region") +
    tema_nuevo

# histograma con barras laterales position = "dodge"
ventas %>% 
    filter(VN_tar12>2500 & VN_tar12<20000) %>% 
    ggplot(aes(x = VN_tar12, fill = region)) +
    geom_histogram(position = "dodge") +
    labs(x = "Ventas con tarifa 12% (USD)",
         y = "Frecuencia",
         title = "Ventas con tarifa 12% - Histograma",
         fill = "Region") +
    tema_nuevo

# histogramas de forma separada
ventas %>% 
    filter(VN_tar12>2500 & VN_tar12<20000) %>% 
    ggplot(aes(x = VN_tar12, fill = region)) +
    geom_histogram(position = "dodge") +
    facet_wrap( ~ region) +
    labs(x = "Ventas con tarifa 12% (USD)",
         y = "Frecuencia",
         title = "Ventas con tarifa 12% - Histograma",
         fill = "Region") +
    tema_nuevo

# histogramas de forma separada alineados por filas
ventas %>% 
    filter(VN_tar12>2500 & VN_tar12<20000) %>% 
    ggplot(aes(x = VN_tar12, fill = region)) +
    geom_histogram(position = "dodge") +
    facet_grid(region ~ .) +
    labs(x = "Ventas con tarifa 12% (USD)",
         y = "Frecuencia",
         title = "Ventas con tarifa 12% - Histograma",
         fill = "Region") +
    tema_nuevo

# para no tener histogramas achatados scales = "free"
ventas %>% 
    filter(VN_tar12>2500 & VN_tar12<20000) %>% 
    ggplot(aes(x = VN_tar12, fill = region)) +
    geom_histogram(position = "dodge") +
    facet_grid(region ~ ., scales = "free") +
    labs(x = "Ventas con tarifa 12% (USD)",
         y = "Frecuencia",
         title = "Ventas con tarifa 12% - Histograma",
         fill = "Region") +
    tema_nuevo


## Obtener una composición total del gráfico con position = "fill" y scale_y_continuous()
library(scales)
ventas %>% 
    filter(VN_tar12>2500 & VN_tar12<20000) %>% 
    ggplot(aes(x = VN_tar12, fill = region)) +
    geom_histogram(position = "fill") +
    scale_y_continuous(labels = percent_format()) +
    labs(x = "Ventas con tarifa 12% (USD)",
         y = "Frecuencia",
         title = "Ventas con tarifa 12% - Histograma",
         fill = "Region") +
    tema_nuevo

## Si tienen pocas categorías se puede jugar con la transparencia
ventas %>% 
    filter(VN_tar12>2500 & VN_tar12<20000) %>% 
    ggplot(aes(x = VN_tar12)) +
    geom_histogram(aes(fill = region),
                   position = "identity",
                   alpha = 0.5) +
    labs(x = "Ventas con tarifa 12% (USD)",
         y = "Frecuencia",
         title = "Ventas con tarifa 12% - Histograma",
         fill = "Region") +
    tema_nuevo



### GRÁFICO DE DENSIDAD -----------------------------------------------------
## gráfico de densidad con transparencia
ventas %>% 
    filter(VN_tar12>2500 & VN_tar12<20000) %>% 
    ggplot(aes(x = VN_tar12, fill = region)) +
    geom_density(alpha = 0.5) +
    labs(x = "Ventas con tarifa 12% (USD)",
         y = "Densidad",
         title = "Ventas con tarifa 12% - Densidad",
         fill = "Region") +
    tema_nuevo

## gráfico de densidad arreglados por filas
ventas %>% 
    filter(VN_tar12>2500 & VN_tar12<20000) %>% 
    ggplot(aes(x = VN_tar12, fill = region)) +
    geom_density(alpha = 0.5) +
    facet_grid(region ~ .) +
    labs(x = "Ventas con tarifa 12% (USD)",
         y = "Densidad",
         title = "Ventas con tarifa 12% - Densidad",
         fill = "Region") +
    tema_nuevo


### GRÁFICO DE LÍNEAS VERTICALES --------------------------------------------

## calculando estadísticos para el gráfico
ventas_medias <- ventas %>%
    filter(VN_tar12>2500 & VN_tar12<20000) %>% 
    group_by(region) %>%
    summarise(MEDIA = mean(VN_tar12, na.rm= TRUE))
                                          
## agregar gráfico con geom_vline()                      
ventas %>% 
    filter(VN_tar12>2500 & VN_tar12<20000) %>% 
    ggplot(aes(x = VN_tar12, fill = region)) +
    geom_density(alpha = 0.5) +
    geom_vline(data = ventas_medias, 
               aes(xintercept = MEDIA, colour= region), 
               linetype= "dashed", size= 1) +
    labs(x = "Ventas con tarifa 12% (USD)",
         y = "Densidad",
         title = "Ventas con tarifa 12% - Densidad",
         fill = "Region") +
    tema_nuevo


### GRÁFICO DE TEXTO --------------------------------------------------------

## incluir los valores de medias en texto con geom_text()
ventas %>% 
    filter(VN_tar12>2500 & VN_tar12<20000) %>% 
    ggplot(aes(x = VN_tar12, fill = region)) +
    geom_density(alpha = 0.5, lwd = 0.2) +
    geom_vline(data = ventas_medias, 
               aes(xintercept = MEDIA, colour= region), 
               linetype= "dashed", size= 1) +
    geom_text(data = ventas_medias,
              aes(x=MEDIA - 150, label= paste("Media: USD ", round(MEDIA,2)), y=0.00009, colour= region),
              angle=90) +
    labs(x = "Ventas con tarifa 12% (USD)",
         y = "Densidad",
         title = "Ventas con tarifa 12% - Densidad",
         fill = "Region") +
    tema_nuevo



### GRÁFICO DE VIOLÍN -------------------------------------------------------

## gráfico de violín
ventas %>% 
    filter(VN_tar12>2500 & VN_tar12<20000) %>%
    ggplot(aes(x = region, y = VN_tar12)) +
    geom_violin(aes(fill = region, color = region), alpha = 0.5) +
    coord_flip() +
    labs(x = "Region",
         y = "Ventas con tarifa 12% (USD)",
         title = "Ventas con tarifa 12%") +
    tema_nuevo



### GRÁFICO DE CAJAS --------------------------------------------------------

## gráfico de cajas sin outliers
ventas %>% 
    filter(VN_tar12>2500 & VN_tar12<20000) %>%
    ggplot(aes(x = region, y = VN_tar12)) +
    geom_violin(aes(fill = region, color = region), alpha = 0.5) +
    geom_boxplot( aes(fill = region), color= "#5B5B5B", width=.2, outlier.colour=NA) +
    coord_flip() +
    labs(x = " ",
         y = "Ventas con tarifa 12% (USD)",
         title = "Ventas con tarifa 12%") +
    tema_nuevo


## agregar capa estadística
ventas %>% 
    filter(VN_tar12>2500 & VN_tar12<20000) %>%
    ggplot(aes(x = region, y = VN_tar12)) +
    geom_violin(aes(fill = region, color = region), alpha = 0.5) +
    geom_boxplot( aes(fill = region), color= "#5B5B5B", width=.2, outlier.colour=NA) +
    stat_summary(fun=mean, geom="point", shape=15, size=2, color= "gold") +
    coord_flip() +
    labs(x = "Region",
         y = "Ventas con tarifa 12% (USD)",
         title = "Ventas con tarifa 12%") +
    tema_nuevo



# GRÁFICOS DINÁMICOS CON PLOTLY -------------------------------------------

## gráfico dinámico de un gráfico de densidad
g1 <- ventas %>% 
    filter(VN_tar12>2500 & VN_tar12<20000) %>% 
    ggplot(aes(x = VN_tar12, fill = region)) +
    geom_density(alpha = 0.5) +
    labs(x = "Ventas con tarifa 12% (USD)",
         y = "Densidad",
         title = "Ventas con tarifa 12% - Densidad",
         fill = "Region") +
    tema_nuevo

ggplotly(g1)


## gráfico dinámico de un histograma
g2 <- ventas %>%
    filter(VN_tar12>2500 & VN_tar12<20000) %>%
    ggplot(aes(x=VN_tar12)) +
    geom_histogram(binwidth = 2500,
                   color = "black",
                   fill = "chartreuse4") +
    geom_freqpoly(binwidth = 2500,
                  size = 1,
                  color = "chocolate1") +
    geom_text(stat = "bin",                       # para usar binwidth
              binwidth= 2500,
              aes(label=stat(round(count,2)),     # etiquetas de los textos
                  y=stat(count)),
              nudge_y = 30,                       # posición de etiquetas
              color = "grey50", 
              size = 3) +                     
    scale_x_continuous(breaks = seq(0, 20000, 2500)) +
    scale_y_continuous(breaks = seq(0, 800, 100)) +
    labs(x = "Ventas con tarifa 12% (USD)",
         y = "Frecuencia",
         title = "Ventas con tarifa 12% - Histograma") +
    theme(text = element_text(colour = "grey45",
                              size = 10),
          plot.title = element_text(face = "bold",
                                    size = 14,
                                    colour = "grey30"),
          plot.background = element_rect(fill = "grey92"),
          panel.grid.minor = element_blank())

ggplotly(g2)

## indicar el texto en las etiquetas
ggplotly(g2, tooltip = "y")

## gráfico dinámico de un gráfico de cajas
g3 <- ventas %>% 
    filter(VN_tar12>2500 & VN_tar12<20000) %>%
    ggplot(aes(x = region, y = VN_tar12)) +
    geom_violin(aes(fill = region, color = region), alpha = 0.5) +
    geom_boxplot( aes(fill = region), color= "#5B5B5B", width=.2, outlier.colour=NA) +
    coord_flip() +
    labs(x = " ",
         y = "Ventas con tarifa 12% (USD)",
         title = "Ventas con tarifa 12%") +
    tema_nuevo

ggplotly(g3)


## gráficos animados con gganimate
library(gganimate)

ventas %>% 
    filter(EXPORTACIONES>5000000) %>% 
    group_by(mes, provincia) %>% 
    summarise(Frec = n()) %>% 
    view()

anime <- ventas %>% 
    filter(EXPORTACIONES>5000000) %>% 
    group_by(mes, provincia) %>% 
    summarise(Frec = n()) %>% 
    ggplot(aes(x = provincia, y = Frec)) +
    geom_point(size = 5, color = "chartreuse4") +
    geom_segment(aes(xend = provincia, y = 0, yend = Frec),
                 color = "chartreuse4", size = 1) +
    labs(x = "Provincias",
         y = "Frecuencia",
         title = "Cantidad de transacciones globales por provincia",
         subtitle = "Mes: {current_frame}") +                  # incluir transición en el subtítulo
    theme(text = element_text(colour = "grey45",
                              size = 10),
          plot.title = element_text(face = "bold",
                                    size = 14,
                                    colour = "grey30"),
          plot.background = element_rect(fill = "grey92"),
          panel.grid.minor = element_blank(),
          axis.text.x = element_text(angle = 90, size = 7)) +
    transition_manual(mes)                                    # agregar transición por mes


animate(anime, renderer = gifski_renderer())
