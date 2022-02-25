library("shiny")
library("tidyverse")

homerange <- readr::read_csv("data/Tamburelloetal_HomeRangeDatabase.csv")

ui <- fluidPage(    
  
  titlePanel("Log 10 Homerange by Taxon"), # give the page a title
  
  # generate a row with a sidebar
  sidebarLayout(      
    
    # define the sidebar with one input
    sidebarPanel(
      selectInput("taxon", " Select Taxon of Interest:", choices=unique(homerange$taxon)), hr(),
      helpText("Reference: Tamburello N, Cote IM, Dulvy NK (2015) Energy and the scaling of animal space use. The American Naturalist 186(2):196-211.")),
    
    # create a spot for the barplot
    mainPanel(
      plotOutput("taxonPlot"))
  )
)

# define a server for the Shiny app
server <- function(input, output, session) {
  
  # fill in the spot we created for a plot
  output$taxonPlot <- renderPlot({
    
    homerange %>% 
      filter(taxon == input$taxon) %>% 
      ggplot(aes(x=log10.hra)) + 
      geom_density(color="black", fill="red", alpha=0.6)
  })
}

shinyApp(ui, server)