#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/


library(shiny)
library(ggplot2)
library(dplyr)
# Define UI for application that draws a histogram
shinyUI(fluidPage(

        # Application title
        titlePanel("Workout2 Yujun Hu"),
        
        fluidRow(
            column(3,
                   sliderInput(
                       inputId = "init",
                       label = "Initial Amount",
                       min = 0, max = 10000, value = 1000, step = 100,
                       pre = "$", sep = ",",
                       animate = TRUE
                   ),
                   sliderInput(
                       inputId = "contribute",
                       label = "Annual Contribution",
                       min = 0, max = 5000, value = 200, step = 100, 
                       pre = "$", sep = ",",
                       animate = TRUE
                   ),
                   sliderInput(
                       inputId = "growth_rate",
                       label = "Annual Growth Rate (in %)",
                       min = 0, max = 20, value = 2, step = 0.1
                   )
            ),
            
            column(3,
                   sliderInput(
                       inputId = "yield_rate",
                       label = "High Yield rate (in %)",
                       min = 0, max = 20, value = 2, step = 0.1
                   ),
                   sliderInput(
                       inputId = "income_rate",
                       label = "Fixed Income annual rate (in %)",
                       min = 0, max = 20, value = 5, step = 0.1
                   ),
                   sliderInput(
                       inputId = "equity_rate",
                       label = "US Equity rate (in %)",
                       min = 0, max = 20, value = 10, step = 0.1
                   )
            ),
            
            column(3,
                   sliderInput(
                       inputId = "yield_vol",
                       label = "High Yield volatility (in %)",
                       min = 0, max = 20, value = 0.1, step = 0.1
                   ),
                   sliderInput(
                       inputId = "income_vol",
                       label = "Fixed Income annual volatility (in %)",
                       min = 0, max = 20, value = 4.5, step = 0.1
                   ),
                   sliderInput(
                       inputId = "equity_vol",
                       label = "US Equity volatility (in %)",
                       min = 0, max = 20, value = 15, step = 0.1
                   )
            ),
            
            column(3,
                   sliderInput(
                       inputId = "year",
                       label = "Years",
                       min = 0, max = 50, value = 20, step = 1
                   ),
                   numericInput(
                       inputId = "seed",
                       label = "Random Seed",
                       value = 12345
                   ),
                   selectInput(
                       inputId = "facet",
                       label = "Facet?",
                       choices = c("Yes", "No"), selected = "Yes"
                   )
            ),
            
            mainPanel(
                titlePanel("Timelines"),
                plotOutput("plot")
            )
        )
    
))
