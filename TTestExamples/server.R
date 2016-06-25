#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
planck_fn <- function(x, a) {
    y <- x
    positive = x > 0
    y[!positive] <- 0
    y[positive] <- 1/(exp(a/x[positive]) - 1) / x[positive]^5
    y / sum(y)
}

# Not really mu and sd, we just use the same "concepts"
planck_df <- function(x, mu1, sd1, mu2, sd2) {
    df1 <- data.frame(x = x, y = planck_fn((x - mu1)/ 500, sd1 / 10))
    df1$DistType <- "Planck 1"
    df2 <- data.frame(x = x, y = planck_fn((x - mu2)/ 500, sd2 / 10))
    df2$DistType <- "Planck 2"
    df <- rbind(df1, df2)
    df$DistType <- factor(df$DistType)
    df
}

gausian_fn <- function(x, mu, sigma) {
    dnorm(x, mean = mu, sd = sigma)
}

x <- 1:10000

gausian_df <- function(x, mu1, sd1, mu2, sd2){
    df1 <- data.frame(x = x, y = gausian_fn(x, mu1 + 500, sd1 * 5))
    df1$DistType <- "Normal 1"
    df2 <- data.frame(x = x, y = gausian_fn(x, mu2 + 500, sd2 * 5))
    df2$DistType <- "Normal 2"
    df <- rbind(df1, df2)
    df$DistType <- factor(df$DistType)
    df
}

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$distPlotPlanck <- renderPlot({
      ggplot2::ggplot(data = planck_df(x, input$ShiftPlanck1, input$FormPlanck1, input$ShiftPlanck2, input$FormPlanck2), ggplot2::aes(x = x, y = y, group = DistType, color = DistType)) + ggplot2::geom_line() + ggplot2::xlim(c(0, 2000)) + ggplot2::xlab("") + ggplot2::ylab("Density")
  })
  output$distPlotNorm <- renderPlot({
      ggplot2::ggplot(data = gausian_df(x, input$ShiftNorm1, input$FormNorm1, input$ShiftNorm2, input$FormNorm2), ggplot2::aes(x = x, y = y, group = DistType, color = DistType)) + ggplot2::geom_line() + ggplot2::xlim(c(0, 2000)) + ggplot2::xlab("") + ggplot2::ylab("Density")
  })
  output$ttestTable <- renderTable({
      g_df <- gausian_df(x, input$ShiftNorm1, input$FormNorm1, input$ShiftNorm2, input$FormNorm2)
      p_df <- planck_df(x, input$ShiftPlanck1, input$FormPlanck1, input$ShiftPlanck2, input$FormPlanck2)
      df <- rbind(g_df, p_df)
      result <- lapply(split(df, df$DistType), function(d){
          mu = sum(d$y*d$x)
          var = sum((d$x - mu)^2*d$y)
          data.frame(mu = mu, var = var)
      })
      n <- input$sampleSize
      norm_mu_delta <- result[["Normal 1"]]$mu - result[["Normal 2"]]$mu
      norm_SE <- sqrt((result[["Normal 1"]]$var + result[["Normal 2"]]$var)/n)
      planck_mu_delta <- result[["Planck 1"]]$mu - result[["Planck 2"]]$mu
      planck_SE <- sqrt((result[["Planck 1"]]$var + result[["Planck 2"]]$var)/n)
      t_norm <- norm_mu_delta / norm_SE
      t_planck <- planck_mu_delta / planck_SE
      data.frame(distType = c("Gaussian", "Planck"), meanDelta = c(norm_mu_delta, planck_mu_delta), SE = c(norm_SE, planck_SE), tValue = c(t_norm, t_planck), pValue = c(pt(t_norm, df = n - 1), pt(t_planck, df = n - 1)))
  })
})
