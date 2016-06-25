#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Example t-test results for Planck and Normal distributions"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("ShiftPlanck1",
                   "Shift of Planck Distribution 1:",
                   min = 1,
                   max = 1000,
                   value = 200),
       sliderInput("FormPlanck1",
                   "Form of Planck Distribution 1:",
                   min = 1,
                   max = 100,
                   value = 50),
       sliderInput("ShiftPlanck2",
                   "Shift of Planck Distribution 2:",
                   min = 1,
                   max = 1000,
                   value = 500),
       sliderInput("FormPlanck2",
                   "Form of Planck Distribution 2:",
                   min = 1,
                   max = 100,
                   value = 50),
       
       sliderInput("ShiftNorm1",
                   "Shift of Normal Distribution 1:",
                   min = 1,
                   max = 1000,
                   value = 200),
       sliderInput("FormNorm1",
                   "Form of Normal Distribution 1:",
                   min = 1,
                   max = 100,
                   value = 50),
       sliderInput("ShiftNorm2",
                   "Shift of Norm Distribution 2:",
                   min = 1,
                   max = 1000,
                   value = 500),
       sliderInput("FormNorm2",
                   "Form of Norm Distribution 2:",
                   min = 1,
                   max = 100,
                   value = 50),
       sliderInput("sampleSize",
                   "Assumed Sample Size:",
                   min = 2,
                   max = 100,
                   value = 10)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlotPlanck"),
       plotOutput("distPlotNorm"),
       tableOutput("ttestTable")
    )
  )
))
