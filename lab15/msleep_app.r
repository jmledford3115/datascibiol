## Load the libraries
library(tidyverse)
library(shiny)
library(shinythemes)
library(janitor)

ui <- fluidPage(
  
  theme=shinythemes::shinytheme("cyborg"),
  
  selectInput("y",
              "Select Sleep Variable",
              choices = c("sleep_total",
                          "sleep_rem",
                          "sleep_cycle",
                          "awake"),
              selected = "sleep_total"),
  
  plotOutput("plot", width="600px", height= "500px")
  
)

server <- function(input, output, session) {
  
  output$plot <- renderPlot({
    
    msleep %>% 
      filter(vore!="NA") %>% 
      ggplot(aes(x = vore,
                 y = .data[[input$y]],
                 fill = vore))+
      geom_boxplot(alpha=0.75)+
      labs(title="Sleep Variables by Vore Type",
           x="Vore",
           fill="Vore Type")+
      theme_minimal()
  })
}

shinyApp(ui, server)