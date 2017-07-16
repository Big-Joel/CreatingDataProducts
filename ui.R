#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Going Faster with mtcars Data"),
  
  # Sidebar with app instructions
  sidebarLayout(
    sidebarPanel(
        h3("Instructions:"),
        p("This application shows the relationship between the quarter mile time (qsec) 
          of a car and its horsepower (hp). Linear regression is used to model this 
          relationship. You can add multiple regressors by clicking the checkboxes. The 
          'adjusted R squared' value will update, as well as the diagnostic plots, as you 
          add or remove regressors."),
        width=3
    ),
    
    # Show a plot of qsec vs hp for mtcars
    mainPanel(
        h3("Quarter mile time and Horsepower"),
        p("Note that the blue line (linear model) shown only includes the horsepower,
          not weight or displacement."),
        plotOutput("qsecPlot"),
        h3("Linear Model Diagnostics"),
        p("Click to add weight and displacement to the model. The diagnostic plots will 
          change to reflect the current model."),
        checkboxInput("include_weight", "Include weight", value = FALSE),
        checkboxInput("include_disp", "Include engine displacement", value = FALSE),
        textOutput("adjustedR"),
        plotOutput("residualsPlot"),
        width=9
    )
  )
))
