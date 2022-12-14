library(dplyr)
library(tidyverse)
library(shiny)
library(plotly)
library(ggplot2)
source('./a5.app_server.R')
inputs <- sidebarPanel(
  sliderInput(
    inputId = "year_range",
    label = "Choose date range",
    min = 1750,
    max = 2021,
    value = range(1750,2020),
    timeFormat = "%Y"
  ),
  selectInput(
    inputId = "country_one",
    label = "Choose 1st Country",
    choices = unique(df1$df.country),
    selected = "World"
  ),
  selectInput(
    inputId = "country_two",
    label = "Choose 2nd Country",
    choices = unique(df1$df.country),
    selected = "Spain"
  ),
  checkboxInput(
    inputId = "smooth_line",
    label = "Show smooth line?",
    value = T
  )
)
chart_page <- tabPanel(
  "Country Comparison of CO2 Emissions Per Capita",
  titlePanel("Comparing Countries CO2 Emissions Per Capita"),
  sidebarLayout(inputs,
                mainPanel(plotOutput("comparison_plot")
                          )
                ),
  p(
    'This interactive visualization compares the co2 emmision per capita
    of two self-selected countries. The countries are compared using the continuous variable of time
    which is can be selected by the user. This visaulization reveals the amount of emissions each country is
    emitting based on its population. '
  )
)

introduction <- tabPanel(
  "Introduction",
  titlePanel('Introduction'),
  p(
    'In my report, I will be focusing on the CO2 emmisions per capita in countries
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
