library(shiny)
library(rCharts)
source("caloriesByDistance.R")

shinyServer(
  function(input, output)
  {
    output$grade <- renderPrint({input$grade})
    
    output$weight <- renderPrint({input$weight})
    output$weightunits <- renderPrint({input$weightUnit})
    
    output$distance <- renderPrint({input$distance})
    output$distanceunits <- renderPrint({input$distanceUnit})
    
    output$myChart <- renderChart(
      {
        input$goButton
        if (input$goButton[1] > 0)
        {
          cb <- caloriesByDistance(if (input$distanceUnit == "MI")
                                    {
                                      distance = input$distance * 1.609
                                    }
                                     else
                                     {
                                       distance = input$distance
                                     },
                                    if (input$weightUnit == "LB")
                                     {
                                        weight = input$weight * 0.45
                                     }
                                     else 
                                     {
                                       weight = input$weight
                                     },
                                   grade = input$grade)
          if (input$distanceUnit == "MI")
          {
            cb$distance <- cb$distance / 1.605
            p1 <- rPlot(calories ~ distance, data = cb, type = 'line')
            p1$guides(x = list(title = "Distance (Mi)"))
          }
          else
          {
            p1 <- rPlot(calories ~ distance, data = cb, type = 'line')
            p1$guides(x = list(title = "Distance (KM)"))
          }
          p1$guides(y = list(title = "Calories Burned"))
          p1$guides(y = list(min = 0, max = max(cb$calories)*1.1))
          p1$set(title = "Calories Burned by Distance")
          p1$addParams(dom = 'myChart')
          return(p1)
        }
      }
    )
  }
)