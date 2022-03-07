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
    titlePanel("SBO Text Predictor"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            textInput("bins",
                        "Text Here! <EOS> means an end of sentence marker, and the model is based on a 3 gram system!",
                        value="",
                        placeholder="Your Text")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            textOutput("distPlot")
        )
    )
))
