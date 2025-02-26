library(shiny)
library(shinydashboard)
library(readr)
library(janitor)
library(DT)

ui <- dashboardPage(
  dashboardHeader(title = "CSV Data Cleaner"),
  dashboardSidebar(
    fileInput("file", "Upload CSV File", accept = ".csv"),
    checkboxInput("replace_na", "Replace -999 with NA", value = FALSE),
    checkboxInput("clean_names", "Clean Column Names", value = FALSE)
  ),
  dashboardBody(
    box(title = "Cleaned Data", width = 12, status = "primary", solidHeader = TRUE,
        DTOutput("table")
    )
  )
)

server <- function(input, output) {
  df <- reactiveVal()
  observe({
    req(input$file)
    temp_df <- read_csv(input$file$datapath)
    
    if (input$replace_na) {
      temp_df[temp_df == -999] <- NA
    }
    
    if (input$clean_names) {
      temp_df <- clean_names(temp_df)
    }
    
    df(temp_df)
    assign("df", temp_df, envir = .GlobalEnv)
  })
  
  output$table <- renderDT({
    req(df())
    datatable(df(), options = list(pageLength = 10))
  })
}

shinyApp(ui, server)
