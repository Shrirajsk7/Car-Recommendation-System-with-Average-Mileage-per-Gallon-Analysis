# Importing the required library for the shiny application:
library(shiny)
library(shinydashboard)
library(ggplot2)

#Creating the UI:

ui <- fluidPage(
  titlePanel(
    h1("Analysis of cars based on engine size and class by different car makers", align = "center")
  ),
  
  # Creating the rows in the UI to select the inputs: Manufacturer, engine-size and class of the car.
  
  fluidRow(
    column(3,
           selectInput("mfg",
                       "Manufacturer:",
                       c("All",
                         unique(as.character(mpg$manufacturer))))
    ),
    
    column(3,
           selectInput("size",
                        "Engine Size:",
                       c("All",
                         unique(as.character(mpg$displ))))
    ),
    
    column(3,
           selectInput("cartype",
                       "Class:",
                       c("All",
                         unique(as.character(mpg$class))))
    )
  ),
  
  # Create a new row for the table.
  DT::dataTableOutput("table")
)

server <- function(input, output){
  
  # Filter data based on input selection in UI:
  output$table <- DT::renderDataTable(DT::datatable({
    data <- mpg
    if (input$mfg != "All") {
      data <- data[data$manufacturer == input$mfg,]
    }
    if (input$size != "All") {
      data <- data[data$displ == input$size,]
    }
    if (input$cartype != "All") {
      data <- data[data$class == input$cartype,]
    }
    data
    
  }))
  
}

#Calling shinyapp to run the application:
shinyApp(ui, server)