#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    output$text1 <- renderText({ 
        "Input your measurements below to receive a body fat index based on average values." 
    })
    
    output$text2 <- renderText({ 
        "Use a tape measure to determine your waist, wrist, hip and forearm circumference." 
    })
    
    v = reactiveValues(doCalculate = FALSE)
    observeEvent(input$calculate, {
        # 0 will be coerced to FALSE
        # 1+ will be coerced to TRUE
        v$doCalculate <- input$calculate
    })
    
        
        output$text3 <- renderText({ 
            if (v$doCalculate == FALSE) return("Please enter your body data and click the button")
            "Your body fat percentage is:" 
        })
        
        output$bodyfat <- renderText({ 
            if (v$doCalculate == FALSE) return()
            bodyfat = 7.776 - 0.1263 * input$height_cm + 0.05329 * input$age - 0.37239 * input$neck + 0.72955 * input$abdomen
            + 0.27822 * input$forearm - 1.6408 * input$writst
            paste(bodyfat)

        })
        
        output$text4 <- renderText({ 
            if (v$doCalculate == FALSE) return()
            "Body Fat Percentage Categorie:" 
        })
        
        output$static <- renderTable({
            if (v$doCalculate == FALSE) return()
            data.frame("Classification" = c("Essential Fat", "Athletes", "Fitness", "Acceptable", "Obese"), 
                       "Women" = c("10-12%", "14-20%", "21-24%", "25-31%", "32% +"), 
                       "Men" = c("2-4%", "6-13%", "14-17%", "18-25%", "25% +"))
        })
        
        output$text5 <- renderText({ 
            if (v$doCalculate == FALSE) return()
            "Please check out what category you belong to and do more exercise if you are overweight" 
        })
        
        output$text6 <- renderText({ 
            "The author and maintainer of this app is Chenhao Fang. Please contact throught cfang45@wisc.edu if you encountered any bugs." 
        })
        output$text7 <- renderText({ 
            "For source code of this app, please check https://github.com/USTCLink/STAT628-Module-2." 
        })
})
