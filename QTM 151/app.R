library(shiny)
library(tidyverse)
pop_growth <- read.csv("four_countries_pop.csv")

ui <- fluidPage(
  h1("Population Growth of Four Countries"),
  sliderInput(inputId = "Years",
              label = "Choose a Year",
              value = 1900, min = 1500, max = 2000, step = 100),
  plotOutput("hist")
  
)

server <- function(input, output){
  
  select_data <- reactive({
    pop_growth %>% 
      filter(Year == input$Years)
  })
  
  output$hist <- renderPlot({
      ggplot(select_data(), aes(x=Entity, y = Population.by.Country..Clio.Infra..2016..)) +
      geom_bar(stat = "identity") +
      labs(x = "Four Different Countries", y = "Population")
  })
}

shinyApp(ui = ui, server = server)


