library(shiny)
# interfaz de usuario 
ui <- fluidPage(
  titlePanel("TITULO"),
  
  sidebarLayout(
    sidebarPanel("siderbar panel"),
    mainPanel("main panel")
  )
)

# server ----
server <- function(input, output) {
  
}

# Ejecutar app  ----
shinyApp(ui = ui, server = server)