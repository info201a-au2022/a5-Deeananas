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
    value = 1950,
    #timeFormat = "%Y"
  ),
  selectInput(
    inputId = "country_one",
    label = "Choose 1st Country",
    choices = unique(df1$df.country),
    selected = "England"
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
  "Title",
  titlePanel("text"),
  sidebarLayout(inputs, 
                mainPanel(plotlyOutput("comparison_plot"))),
  p('text')
)
