#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)

# Define UI for application that draws a histogram
shinyUI(
    
    fluidPage(theme = shinytheme("spacelab"),
    navbarPage("STAT628 Module 2",   
    
     # Application title                         
    tabPanel('Fat Calculator', icon = icon("child"),            


    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(width = 4,
            textOutput("text1"),
            tags$head(tags$style("#text1{color: black;
                                 font-size: 20px;
                                 font-style: bold;
                                 }"
            )
            ),
            sliderInput("height_cm",
                        "Please enter your height in cm:",
                        min = 130,
                        max = 240,
                        value = 178),
            sliderInput("age",
                        "Please enter your age:",
                        min = 0,
                        max = 100,
                        value = 44),
            textOutput("text2"),
            tags$head(tags$style("#text2{color: black;
                                 font-size: 20px;
                                 font-style: bold;
                                 }"
            )
            ),
            sliderInput("neck",
                        "Please enter your neck circumferenc in cm:",
                        min = 21,
                        max = 70,
                        value = 38),
            sliderInput("abdomen",
                        "Please enter your abdomen circumferenc in cm:",
                        min = 50,
                        max = 150,
                        value = 93),
            sliderInput("forearm",
                        "Please enter your forearm circumferenc in cm:",
                        min = 10,
                        max = 50,
                        value = 29),
            sliderInput("writst",
                        "Please enter your wrist circumferenc in cm:",
                        min = 10,
                        max = 30,
                        value = 18),

                       actionButton("calculate", "Calculate your body fat!", icon("table"), class = "btn-lg btn-success"),
                       tags$head(tags$style("#calculate{color: balck;
                                 font-size: 14px;
                                 font-style: italic;
                                 text-align: center;
                                 }"
                       )
                       ),
                
                
            
            
            
        ),

        # Show a plot of the generated distribution
        mainPanel(
            textOutput("text3"),
            tags$head(tags$style("#text3{color: black;
                                 font-size: 20px;
                                 font-style: bold;
                                 text-align: center;
                                 }"
            )),
            textOutput("bodyfat"),
            tags$head(tags$style("#bodyfat{color: black;
                                 font-size: 40px;
                                 font-style: bold;
                                 text-align: center;
                                 }"
            )),
            textOutput("text4"),
            tags$head(tags$style("#text4{color: balck;
                                 font-size: 23px;
                                 font-style: bold;
                                 text-align: center;
                                 }"
            )
            ),
        
                       div(tableOutput("static"), align = "center"),
                       
                       tags$head(tags$style("#static{color: balck;
                                 font-size: 20px;
                                 font-style: italic;
                                 text-align: center;
                                 }"
                       )
            ),
            
            textOutput("text5"),
            tags$head(tags$style("#text5{color: balck;
                                 font-size: 20px;
                                 font-style: italic;
                                 text-align: center;
                                 }"
            )
            ),
            
            
            
        )
    )
    
),
    tabPanel("Contact Info", icon = icon("id-card"),   
             textOutput("text6"),
             textOutput("text7"),
             )

)
)
)

