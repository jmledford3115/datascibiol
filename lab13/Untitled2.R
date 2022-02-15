library(shiny)
library(here)

read_csv(here("lab13", "data", "Tamburelloetal_HomeRangeDatabase.csv"))

ui <- fluidPage(
  
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)