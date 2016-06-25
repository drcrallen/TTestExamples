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
                   "Adjust this to move the peak of Planck 1",
                   min = 1,
                   max = 1000,
                   value = 200),
       sliderInput("FormPlanck1",
                   "Adjust this to flatten or tighten out the distribution of Planck 1",
                   min = 1,
                   max = 100,
                   value = 50),
       sliderInput("ShiftPlanck2",
                   "Adjust this to move the peak of Planck 2",
                   min = 1,
                   max = 1000,
                   value = 500),
       sliderInput("FormPlanck2",
                   "Adjust this to flatten or tighten the distribution of Planck 2",
                   min = 1,
                   max = 100,
                   value = 50),
       
       sliderInput("ShiftNorm1",
                   "Adjust this to move the peak of Normal 1",
                   min = 1,
                   max = 1000,
                   value = 200),
       sliderInput("FormNorm1",
                   "Adjust this to decrease or increase the variance of Normal 1",
                   min = 1,
                   max = 100,
                   value = 50),
       sliderInput("ShiftNorm2",
                   "Adjust this to move the peak of Normal 2",
                   min = 1,
                   max = 1000,
                   value = 500),
       sliderInput("FormNorm2",
                   "Adjust this to decrease or increase the variance of Normal 2",
                   min = 1,
                   max = 100,
                   value = 50),
       sliderInput("sampleSize",
                   "Adjust this to set the assumed sample size. Larger samples yield higher confidence in results (lower p-values)",
                   min = 2,
                   max = 100,
                   value = 10)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
        span("Planck-like distributions (long-tail)", plotOutput("distPlotPlanck")),
        span("Normal distributions", plotOutput("distPlotNorm")),
        span("Results for Gaussian and Planck-like distributions. meanDelta is the difference in the mean. SE is the standard error. tValue is the t-value and pValue is the p value. Lower p value indicates more confidence there is a chagne between the two distributions.", tableOutput("ttestTable"))
    )
  )
))
