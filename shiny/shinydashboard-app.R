## app.R ##
library(shiny)
## app.R ##
library(shinydashboard)
ui <- dashboardPage( skin = "yellow",
  dashboardHeader(title = "Tablero"),
  ## Contido - Siderbar
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("facebook")),
      menuItem("Widgets", tabName = "widgets", icon = icon("gauge"))
    )
  ),
  ## Body content
  dashboardBody(
    tabItems(
    tabItem(tabName = "dashboard",
            fluidRow(
              infoBox(
                "Nueva Orden", 1000, icon = icon("credit-card")
              ),
              valueBox(1000, "Nueva Compra", icon = icon("credit-card")),
              infoBox(
                "Registros", 500, icon = icon("twitter")
              )
            ),
    fluidRow(
      tabBox(title = "Tab Box",
             id = "p1",
             selected = "Pestaña1",
             tabPanel("Pestaña1", plotOutput("plot1")),
             tabPanel("Pestaña2", "Pestaña-2")
             
          ),
      box(title = "Slider",
        "Box content here", br(), "More box content",
        status = "primary",
        collapsible = T,
        solidHeader = T,
        background = "black",
        sliderInput("slider", "Slider input:", 1, 100, 50),
        textInput("text", "Text input:")
      )
    )),
  
      # Second tab content
      tabItem(tabName = "widgets",
              h2("Widgets tab content")
              
      )
    )
  ))
server <- function(input, output) {
  set.seed(122)
  histdata <- rnorm(500)
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
}
shinyApp(ui, server)