library(shiny)
library(rCharts)

shinyUI(
  fluidPage(
    fluidRow(
      column(12, align = 'center',
             titlePanel("Calorie Calculator - Distance vs Calories Burned")
      )
    ),
    mainPanel(width = '100%',
              fluidRow(
                column(3, 
                       style = "background-color:#f7f7f9; border: 1px solid #e1e1e8;", 
                       h4(),
                       sliderInput('grade', 'Running Gradient (%)',
                                   value = 0, min = -15, max = 15, step = 0.5),
                       numericInput('age', 'Age',
                                    value = 30, min = 10, max = 100, step = 1),
                       fluidRow(
                         column(9,
                                numericInput('weight', 'Weight',
                                             value = 60, min = 30, max = 120, step = 0.5)
                         ),
                         column(3,
                                radioButtons('weightUnit', '',
                                             c('KG' = 'KG',
                                               'LB' = 'LB'))
                         )
                       ),
                       fluidRow(
                         column(9,
                                numericInput('distance', 'Distance Run',
                                             value = 5, min = 0, step = 0.5)
                         ),
                         column(3,
                                radioButtons('distanceUnit', '',
                                             c('KM' = 'KM',
                                               'Mi' = 'MI')
                                )
                         )
                       ),
                       actionButton('goButton', 'Calculate', width = '100%'),
                       h4()     
                ),
                column(9,
                       tabsetPanel(
                         tabPanel("Calculator", 
                                  h3('Variables used for calculations'),
                                  h4('Gradient'),
                                  verbatimTextOutput('grade'),
                                  fluidRow(
                                    column(6,
                                           h4('Weight'),
                                           verbatimTextOutput('weight')
                                    ),
                                    column(6,
                                           h4('Weight Units'),
                                           verbatimTextOutput('weightunits')
                                    )
                                  ),
                                  fluidRow(
                                    column(6,
                                           h4('Distance Run'),
                                           verbatimTextOutput('distance')
                                    ),
                                    column(6,
                                           h4('Distance Units'),
                                           verbatimTextOutput('distanceunits')
                                    )
                                  )
                         ),
                         tabPanel("Instructions", 
                                  h3("Welcome to the Calories Burned Calculator"),
                                  p("This is designed to give runners an estimate of the number of calories burned during their latest run."),
                                  p("Using simply the gradient of the run, the age and weight of the runner, it is possible to estimate the numbers of calories burned."),
                                  p("The calculations used here are based on the equations shown at ShapeSense.com, as derived from experimental data gathered by R Mergaria et. al."),
                                  tags$a("http://www.shapesense.com/fitness-exercise/calculators/running-calorie-burn-calculator.shtml", target = "_blank", href = "http://www.shapesense.com/fitness-exercise/calculators/running-calorie-burn-calculator.shtml"),
                                  h3("How to use"),
                                  p("Use the inputs on the left to add details about your run."),
                                  p("Using the 'Gradient' slider, select the average gradient of the route. Keep in mind that a negative gradient implies a downhill."),
                                  p("Using the Age input, set your age. This allows for customisation of the calories burned according to your maximum heart rate. Please note that this has an almost negligable effect on the calories burned."),
                                  p("Using the Weight input, set your weight in either kilograms or pounds as appropriate. Don't worry, we don't store this information."),
                                  p("Using the Distance input, set the distance you ran in either kilometers or miles."),
                                  p("Finally, press the 'Calculate' button to check you calorie burn as you ran. Keep in mind that calorie burn is almost entirely based on the distance you ran, which gives the output graph a very linear look.")
                                  )
                       )
                )
              ),
              fluidRow(
                column(12, align = 'center',
                       tags$hr(),
                       h4(),
                       conditionalPanel(
                         'input.goButton > 0',
                         showOutput("myChart", "polycharts")
                       )
                       #showOutput('myChart', 'polycharts')
                )
              )
    )
  )
)