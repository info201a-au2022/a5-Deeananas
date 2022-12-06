library(dplyr)
library(tidyverse)
library(shiny)
library(plotly)
library(ggplot2)
df <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

df1 <-data.frame(df$country, df$year, df$co2_per_capita) %>% 
  na.omit(df1) 


server <- function(input, output) {
  compare1 <- reactive ({
  compare1 <- df1 %>% 
    filter(df.country == input$country_one) %>% 
    mutate(country = df.country, co2 = df.co2_per_capita) %>% 
    filter((df.year) > input$year_range[1], (df.year) < input$year_range[2]) %>% 
    select((df.year), country, co2)
  
})
  compare2 <- reactive ({
    compare2 <- df1 %>% 
    filter(df.country == input$country_two) %>% 
    mutate(country = df.country, co2 = df.co2_per_capita) %>% 
    filter((df.year) > input$year_range[1], (df.year) < input$year_range[2]) %>% 
    select((df.year), country, co2)

  
  country_one_name = as.character(input$country_one)
  country_two_name = as.character(input$country_two)
  })
plot <-  reactive ({
  if(input$smooth_line) {
  comparison_plot <- ggplot() + 
    geom_smooth(data = compare1, mapping = aes(x= ((df1$df.year)), y=co2, color = country_one_name)) +
    geom_smooth(data = compare2, mapping = aes(x = ((df1$df.year)), y=co2, color = country_two_name)) +
    scale_color_manual(name = "Country", values = c("blue", "black")) +
    labs(
      title = paste("CO2 Emmision per Capita of", input$country_one, "vs", 
                    input$country_two, "from", input$year_range[1], "-", input$year_range[2]),
      x = "Year",
      y = "CO2 Emmision",
      caption = "line graph comparing CO2 Emissions per capita"
    ) 
} else {
  comparison_plot <- ggplot() + 
    geom_line(data = compare1, mapping = aes(x= ((df1$df.year)), y=co2, color = country_one_name)) +
    geom_line(data = compare2, mapping = aes(x = ((df1$df.year)), y=co2, color = country_two_name)) +
    scale_color_manual(name = "Country", values = c("blue", "black")) +
    labs(
      title = paste("CO2 Emmision per Capita of", input$country_one, "vs", 
                    input$country_two, "from", input$year_range[1], "-", input$year_range[2]),
      x = "Year",
      y = "CO2 Emmision",
      caption = "line graph comparing CO2 Emissions per capita"
    ) 
}
  return(comparison_plot)
})

output$comparison_plot <- renderPlot({
  ggplot(plot)
 
})

}



#intro values code
sum <- sum(df1$df.co2_per_capita)
rownum <- nrow(df1)
avgco2 <- (sum/rownum)

maxco2 <- df1 %>% 
  filter(df.co2_per_capita == max(df.co2_per_capita)) %>% 
  pull(df.country)

  
minco2<- 'Africa'
  