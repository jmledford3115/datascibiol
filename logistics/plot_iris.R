library(shiny)
library(tidyverse)

ui <- fluidPage(
  selectInput("x", "Select X Variable", choices = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"), 
              selected = "Petal.Width"),
  selectInput("y", "Select Y Variable", choices = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"),
              selected = "Petal.Length"),
  plotOutput("plot", width = "500px", height = "400px")
)

server <- function(input, output, session) {
  
  output$plot <- renderPlot({
    ggplot(iris, aes_string(x = input$x, y = input$y, col = "Species")) + geom_point() + theme_light(base_size = 18)
  })

}

shinyApp(ui, server)

