library(dplyr)
library(tidyverse)
library(shiny)
library(plotly)
library(ggplot2)
source('./a5.app_server.R')



chart_page <- tabPanel(
  "CO2 Emissions Per Capita By Country",
  titlePanel("Comparing Countries CO2 Emissions Per Capita"),
  sidebarLayout(
    sidebarPanel(sliderInput(
      inputId = 'year',
      label = 'Year',
      min = 1750,
      max = 2020,
      value = range(1850,1950),
      step = 10,
      timeFormat = "%Y"
    ),
    selectInput(
      inputId = "country",
      label = "Choose Country",
      choices = unique(df1$df.country),
      selected = "World")
    ),
    
        mainPanel(plotOutput("line")
               )
                ),
  p(
    'This interactive visualization depicts the co2 emmision per capita
    of a self-selected country. This visaulization reveals the amount of emissions each country is
    emitting based on its population. This information is important in assessing which nations are 
    the largest contributers to the increase of CO2 in our atmosphere. By studying CO2 trends over time
    we can analyze peak CO2 emssions and estimate that countries CO2 productions in the future. '
  )
)

introduction <- tabPanel(
  "Introduction",
  titlePanel('Introduction'),
  p('In my report, I will be focusing on the CO2 emmisions per capita in countries
    overtime. In the large data set provided by Our World in Data, I focused on the country, year, and
    co2_per_capita variables. By analyzing the patterns in co2 emmisions, we can make conclusions about which
    countries have had the most significant contributions to increasing CO2 emmisions, and thus global warming.
    Three relevant values in my report will be:
    '
  ),
  tags$div(tags$ul(
    tags$li("Average CO2 emmsions per capita worldwide:", print(avgco2))
  )),
  
  tags$div(tags$ul(
    tags$li("Country with highest CO2 Emissions per capita:", print(maxco2))
  )),
  
  tags$div(tags$ul(
    tags$li("Country with lowest CO2 Emissions per capita:", print(minco2))
  )),
  mainPanel(tags$figure(
    align = 'center',
    tags$image(src = "https://www.news-medical.net/image.axd?picture=2020%2F12%2Fshutterstock_772541140.jpg",
               width = 500,
               alt = "CO2 graphic")
  ))
)

ui <- navbarPage("A5 Project", introduction, chart_page)
