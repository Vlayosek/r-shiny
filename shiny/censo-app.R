# Load packages ----
library(shiny)
library(maps)
library(mapproj)

# Load data ----
counties <- readRDS("counties.rds")

# Source helper functions -----
source("helpers.R")

# User interface ----
ui <- fluidPage(
  titlePanel("Censo"),
  sidebarLayout(
    sidebarPanel(helpText("Crear un mapa demográfico 
            con información
           del censo del 2010 - USA."),
                 selectInput("var", 
                             label = "Escoger una variable a mostrar",
                             choices = list("Porcentaje blanco", 
                                            "Porcentaje negro",
                                            "Porcentaje hispano", 
                                            "Porcentaje asiatico"),
                             selected = "Porcentaje blanco"),
                 sliderInput("rango", 
                             label = "Rango de interés:",
                             min = 0, max = 100, 
                             value = c(0, 100))
    ),

    mainPanel(plotOutput("map"))
  )
)

# Server logic ----
server <- function(input, output) {
  output$map <- renderPlot({
    data <- switch(input$var, 
                   "Porcentaje blanco" = counties$white,
                   "Porcentaje negro" = counties$black,
                   "Porcentaje hispano" = counties$hispanic,
                   "Porcentaje asiatico" = counties$asian)
    
    color <- switch(input$var, 
                    "Porcentaje blanco" = "darkgreen",
                    "Porcentaje negro" = "black",
                    "Porcentaje hispano" = "darkorange",
                    "Porcentaje asiatico" = "darkviolet")
    
    legend <- switch(input$var, 
                     "Porcentaje blanco" = "% Blanco",
                     "Porcentaje negro" = "% Negro",
                     "Porcentaje hispano" = "% Hispano",
                     "Porcentaje asiatico" = "% Asiatico")
    
    percent_map(data, color, legend, input$rango[1], input$rango[2])
  })
}

# Run app ----
shinyApp(ui, server)