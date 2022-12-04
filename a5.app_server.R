library(dplyr)
library(tidyverse)
library(shiny)
library(plotly)
library(ggplot2)
df <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

df1 <-data.frame(df$country, df$year, df$co2_per_capita) %>% 
  na.omit(df1) 

#as.numeric(as.character(df1['df.year'], origin = '1750'))


server <- function(input, output) {
output$comparison_plot <- renderPlotly({
  compare1 <- df1 %>% 
    filter(df.country == input$country_one) %>% 
    mutate(country = df.country, co2 = df.co2_per_capita) %>% 
    filter(df.year > input$year_range[1], df.year < input$year_range[2]) %>% 
    select(df.year, country, co2)
  
  compare2 <- df1 %>% 
    filter(df.country == input$country_two) %>% 
    mutate(country = df.country, co2 = df.co2_per_capita) %>% 
    filter(df.year > input$year_range[1], df.year < input$year_range[2]) %>% 
    select(df.year, country, co2)


  
  country_one_name = as.character(input$country_one)
  country_two_name = as.character(input$country_two)
  
  #plot
  if(input$smooth_line) {
    comparison_plot <- ggplot() + 
      geom_smooth(data = compare1, mapping = aes(x= as.Date(df1$df.year), y=co2, color = country_one_name)) +
      geom_smooth(data = compare2, mapping = aes(x = as.Date(df1$df.year), y=co2, color = country_two_name)) +
      scale_color_manual(name = "Country", values = c("blue", "black")) +
      labs(
        title = paste("CO2 Emmision per Capita of", input$country_one, "vs", input$country_two, "from", input$year_range[1], "-", input$year_range[2]),
        x = "Year",
        y = "CO2 Emmision"
      ) 
  } else {
    comparison_plot <- ggplot() + 
      geom_line(data = compare1, mapping = aes(x= as.Date(df1$df.year), y=co2, color = country_one_name)) +
      geom_line(data = compare2, mapping = aes(x = as.Date(df1$df.year), y=co2, color = country_two_name)) +
      scale_color_manual(name = "Team", values = c("blue", "black")) +
      labs(
        title = paste("CO2 Emmision per Capita of", input$country_one, "vs", input$country_two, "from", input$year_range[1], "-", input$year_range[2]),
        x = "Year",
        y = "CO2 Emmision"
      ) 
  }
  ggplotly(comparison_plot)
})  
}
