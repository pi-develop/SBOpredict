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
    library(sbo)
    co_twitter_en = "~/downloads/final/en_US/en_US.twitter.txt"
    co_blogs_en = "~/downloads/final/en_US/en_US.blogs.txt"
    co_news_en = "~/downloads/final/en_US/en_US.news.txt"
    twitter <- readLines(con <- file(co_twitter_en), encoding = "UTF-8", skipNul = TRUE)
    close(con)
    news <- readLines(con <- file(co_blogs_en), encoding = "UTF-8", skipNul = TRUE)
    close(con)
    blogs <- readLines(con <- file(co_news_en), encoding = "UTF-8", skipNul = TRUE)
    close(con)
    
    lines <- c(twitter, blogs, news)
    psample<-sample (lines, size=length(lines)*0.2)
    ## First step: Take the Spanish udpipe model and annotate the text. Note: this takes about 3 minutes
    
    p <- sbo_predictor(object = psample
                       , # preloaded example dataset
                       N = 3, # Train a 3-gram model
                       dict = target ~ 0.5, # cover 75% of training corpus
                       .preprocess = sbo::preprocess, # Preprocessing transformation 
                       EOS = ".?!:;", # End-Of-Sentence tokens
                       lambda = 0.4, # Back-off penalization in SBO algorithm
                       L = 6L, # Number of predictions for input
                       filtered = "<UNK>" # Exclude the <UNK> token from predictions
    )

    output$distPlot <- renderText({
        bins<-as.character(input$bins)
        predict(p, bins)
        
    })

})
