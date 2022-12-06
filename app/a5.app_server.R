library(dplyr)
library(tidyverse)
library(shiny)
library(plotly)
library(ggplot2)
df <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

df1 <-data.frame(df$country, df$year, df$co2_per_capita) %>% 
  na.omit(df1) 


server <- function(input, output) ({
  output$line <- renderPlot ({
    ggplot(df1 %>% filter(df.country == input$country) %>% 
             filter(df.year > input$year[1], df.year < input$year[2]),
    aes(x= df.year, y= df.co2_per_capita), group = country) + geom_line() +
      labs(x= 'Year', y= 'CO2 Per Capita', title = "CO2 Emmissions over Time",
          caption = "This line chart depicts CO2 emissions per capita over time")
    
  })
  
})




#intro values code
sum <- sum(df1$df.co2_per_capita)
rownum <- nrow(df1)
avgco2 <- (sum/rownum)

maxco2 <- df1 %>% 
  filter(df.co2_per_capita == max(df.co2_per_capita)) %>% 
  pull(df.country)

  
minco2<- 'Africa'
  