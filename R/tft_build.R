library(shiny)
library(tidyverse)

tft_build = function(...) {
  ui <- fluidPage(
    
    
    titlePanel(div(HTML("<em> Crime Rate in Chichago </em>"))),
    
    tabsetPanel(
      
      
      
      tabPanel(" Frequency of Crime ",
               sidebarLayout(
                 
                 sidebarPanel(
                   #First Input#
                   
                   selectInput(inputId = "Month",
                               label = " Choose a Month",
                               choices = unique(crime$Month)),
                   
                   #Second input#
                   selectInput(inputId = "Crime",
                               label = " Choose among Crime",
                               choices = unique(crime$`Primary Type`),
                               multiple = TRUE)
                 ),
                 
                 #Output#
                 
                 mainPanel(
                   plotOutput("bar_plot")
                 )
                 
               )
               
               
      )
    )
  )
  
  
  #Shiny app -Server#
  server <- function(input, output) {
    
    output$bar_plot <- renderPlot({
      Monthfilter <- crime[crime$Month == input$Month,]
      print('hello')
      crimefilter <- Monthfilter[Monthfilter$`Primary Type` %in% input$Crime,]
      
      ggplot(data = crimefilter, aes(x = `Primary Type`, y = Count)) + geom_bar(stat="identity")
    })
  }
  
  shinyApp(ui, server, ...)
}