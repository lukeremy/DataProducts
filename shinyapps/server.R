
library(lubridate); library(shiny)

shinyServer(
     function(input, output) { 

                    output$text1 <- renderText({
                         paste("If you were born on: ")
                    })
                    output$text1a <- renderPrint({
                         input$birthdate
                    })
                    output$text2 <- renderText({
                         paste("and you are: ")
                    })
                    output$text2a <- renderPrint({
                         input$gender
                    })
                    output$text3 <- renderText({
                         paste("you can expect to die on:")                
                    })
                    output$death <- renderPrint({
                         death(input$birthdate,input$gender)
                    })

     }
)

death <- function(birthdate,gender){
     if(is.null(birthdate))
          return()
     
     birth <- as.POSIXct(birthdate)
     # 68.5 year lifespan for avg male
     if(gender=="Male"){
          death_date <- birth + years(68) + months(6)
     } 
     
     # 73.5 year lifespan for avg female
     else if(gender=="Female"){
          death_date <- birth + years(73) + months(6)
     }
     
     else{death_date <- "Hmmmm... try again!"}

     death_day <- as.character(wday(death_date,label=TRUE))
     result <- list(death_day, as.Date(death_date,format=MMddyyyy))
     return(result)
}