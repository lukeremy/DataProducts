library(shiny)
shinyUI(pageWithSidebar(
     headerPanel("The Grim Reaper app"),
     sidebarPanel(
          dateInput("birthdate", "Select your birthdate (YYYY/MM/DD):",
                    value=NULL,
                    min=1900-01-01),
          selectInput("gender", "Select your gender:",
                      choices=c("Male","Female"),
                      selected="Male"),
          submitButton("When will I die?")
     ),
     mainPanel(
          tags$head(
               tags$style("body {background-color: black; }")
          ),
          br(),
          img(src="grim_reaper.png",height=400,width=600,align="right"),
          em(textOutput("text1")),
          code(textOutput("text1a")),
          em(textOutput("text2")),
          code(textOutput("text2a")),
          strong(textOutput("text3")),
          code(textOutput("death"))
     )
))