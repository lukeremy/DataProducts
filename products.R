###################################################
## DEVELOPING DATA PRODUCTS
###################################################

setwd("./DataProducts")
install.packages("shiny")
install.packages("installr")
library(installr); library(shiny)

# require(Rtools)
# install.packages("Rtools")


####################################
## SHINY
####################################

# R functions for HTML markup

# shiny projects contain ui.R for UI &
# server.R that controls what it does

# ui.R

library(shiny)
shinyUI(pageWithSidebar(
     headerPanel("Data science FTW!"),
     sidebarPanel(
          h3('Sidebar text')
     ),
     mainPanel(
          h3('Main Panel text')
     )
))

# server.r

library(shiny)
shinyServer(
     function(input, output) {
     }
)

# to run it, change to directories with these files
# and type runApp()
runApp()

# ui.R

shinyUI(pageWithSidebar(
     headerPanel("Illustrating markup"),
     sidebarPanel(
          h1('Sidebar panel'),
          h1('H1 text'),
          h2('H2 Text'),
          h3('H3 Text'),
          h4('H4 Text')
          
     ),
     mainPanel(
          h3('Main Panel text'),
          code('some code'),
          p('some ordinary text')
     )
))


# ui.R
library(shiny)
shinyUI(pageWithSidebar(
     headerPanel("Data science FTW!"),
     sidebarPanel(
          h3('Sidebar text')
     ),
     mainPanel(
          h3('Main Panel text')
     )
))
server.r

library(shiny)
shinyServer(
     function(input, output) {
     }
)

# Illustrating inputs ui.R

shinyUI(pageWithSidebar(
     headerPanel("Illustrating inputs"),
     sidebarPanel(
          numericInput('id1', 'Numeric input, labeled id1', 0, min = 0, max = 10, step = 1),
          checkboxGroupInput("id2", "Checkbox",
                             c("Value 1" = "1",
                               "Value 2" = "2",
                               "Value 3" = "3")),
          dateInput("date", "Date:")  
     ),
     mainPanel(
          
     )
))

# Part of ui.R
mainPanel(
     h3('Illustrating outputs'),
     h4('You entered'),
     verbatimTextOutput("oid1"),
     h4('You entered'),
     verbatimTextOutput("oid2"),
     h4('You entered'),
     verbatimTextOutput("odate")
)

# server.R

shinyServer(
     function(input, output) {
          output$oid1 <- renderPrint({input$id1})
          output$oid2 <- renderPrint({input$id2})
          output$odate <- renderPrint({input$date})
     }
)

# Let's build our prediction function

shinyUI(
     pageWithSidebar(
          # Application title
          headerPanel("Diabetes prediction"),
          
          sidebarPanel(
               numericInput('glucose', 'Glucose mg/dl', 90, min = 50, max = 200, step = 5),
               submitButton('Submit')
          ),
          mainPanel(
               h3('Results of prediction'),
               h4('You entered'),
               verbatimTextOutput("inputValue"),
               h4('Which resulted in a prediction of '),
               verbatimTextOutput("prediction")
          )
     )
)

# server.R

diabetesRisk <- function(glucose) glucose / 200

shinyServer(
     function(input, output) {
          output$inputValue <- renderPrint({input$glucose})
          output$prediction <- renderPrint({diabetesRisk(input$glucose)})
     }
)

# build example with image, using slider to set mean

# ui.R

shinyUI(pageWithSidebar(
     headerPanel("Example plot"),
     sidebarPanel(
          sliderInput('mu', 'Guess at the mean',value = 70, min = 62, max = 74, step = 0.05,)
     ),
     mainPanel(
          plotOutput('newHist')
     )
))

# server.R

library(UsingR)
data(galton)

shinyServer(
     function(input, output) {
          output$newHist <- renderPlot({
               hist(galton$child, xlab='child height', col='lightblue',main='Histogram')
               mu <- input$mu
               lines(c(mu, mu), c(0, 200),col="red",lwd=5)
               mse <- mean((galton$child - mu)^2)
               text(63, 150, paste("mu = ", mu))
               text(63, 140, paste("MSE = ", round(mse, 2)))
          })
          
     }
)

# Experiment (code in the slidify document)

ui.R

shinyUI(pageWithSidebar(
     headerPanel("Hello Shiny!"),
     sidebarPanel(
          textInput(inputId="text1", label = "Input Text1"),
          textInput(inputId="text2", label = "Input Text2")
     ),
     mainPanel(
          p('Output text1'),
          textOutput('text1'),
          p('Output text2'),
          textOutput('text2'),
          p('Output text3'),
          textOutput('text3'),
          p('Outside text'),
          textOutput('text4'),
          p('Inside text, but non-reactive'),
          textOutput('text5')
     )
))

# server.R Set x <- 0 before running

library(shiny)
x <- 0
# x <<- x + 1
y <<- 0

shinyServer(
     function(input, output) {
          y <<- y + 1
          output$text1 <- renderText({input$text1})
          output$text2 <- renderText({input$text2})
          output$text3 <- renderText({as.numeric(input$text1)+1})
          output$text4 <- renderText(y)
          output$text5 <- renderText(x)
     }
)

# reactive expressions
# server.R

shinyServer(
     function(input, output) {
          x <- reactive({as.numeric(input$text1)+100})      
          output$text1 <- renderText({x()                          })
          output$text2 <- renderText({x() + as.numeric(input$text2)})
     }
)

# As opposed to

shinyServer(
     function(input, output) {
          output$text1 <- renderText({as.numeric(input$text1)+100  })
          output$text2 <- renderText({as.numeric(input$text1)+100 + 
                                           as.numeric(input$text2)})
     }
)

# sometimes you don't want shiny to immediately perform reactive calculations
# from widget inputs
# aka, something like submit button

# ui.R

shinyUI(pageWithSidebar(
     headerPanel("Hello Shiny!"),
     sidebarPanel(
          textInput(inputId="text1", label = "Input Text1"),
          textInput(inputId="text2", label = "Input Text2"),
          actionButton("goButton", "Go!")
     ),
     mainPanel(
          p('Output text1'),
          textOutput('text1'),
          p('Output text2'),
          textOutput('text2'),
          p('Output text3'),
          textOutput('text3')
     )
))

# Server.R

shinyServer(
     function(input, output) {
          output$text1 <- renderText({input$text1})
          output$text2 <- renderText({input$text2})
          output$text3 <- renderText({
               input$goButton
               isolate(paste(input$text1, input$text2))
          })
     }
)

# create conditional statements for go button

# replace code in server.R with below for example
output$text3 <- renderText({
     if (input$goButton == 0) "You have not pressed the button"
     else if (input$goButton == 1) "you pressed it once"
     else "OK quit pressing it"
})


############################################
## MANIPULATE
############################################


library(manipulate)
manipulate(plot(1:x), x = slider(1, 100))

# Example from the regression class

library(manipulate)
myHist <- function(mu){
     hist(galton$child,col="blue",breaks=100)
     lines(c(mu, mu), c(0, 150),col="red",lwd=5)
     mse <- mean((galton$child - mu)^2)
     text(63, 150, paste("mu = ", mu))
     text(63, 140, paste("MSE = ", round(mse, 2)))
}
manipulate(myHist(mu), mu = slider(62, 74, step = 0.5))


############################################
## rCharts
############################################

# creates interactive javascript visualizations using R
isnstall.packages('base64enc')
devtools::install_github('ramnathv/rCharts')

# Example
require(rCharts)
haireye = as.data.frame(HairEyeColor)
n1 <- nPlot(Freq ~ Hair, group = 'Eye', type = 'multiBarChart',
            data = subset(haireye, Sex == 'Male')
)
# this line saves file in wd
n1$save('fig/n1.html', cdn = TRUE)
# this line is for embedding chart in html
cat('<iframe src="fig/n1.html" width=100%, height=600></iframe>')

## see discussion thread below, had to edit html code from output
# https://class.coursera.org/devdataprod-012/forum/thread?thread_id=9

# Deconstructing another example

## Example 1 Facetted Scatterplot
names(iris) = gsub("\\.", "", names(iris))
r1 <- rPlot(SepalLength ~ SepalWidth | Species, data = iris, color = 'Species', type = 'point')
r1$save('fig/r1.html', cdn = TRUE)
cat('<iframe src="fig/r1.html" width=100%, height=600></iframe>')

# had to add http: to html output again

# another example
Example 2 Facetted Barplot

hair_eye = as.data.frame(HairEyeColor)
r2 <- rPlot(Freq ~ Hair | Eye, color = 'Eye', data = hair_eye, type = 'bar')
r2$save('fig/r2.html', cdn = TRUE)
cat('<iframe src="fig/r2.html" width=100%, height=600></iframe>')

# How to get the js/html or publish an rChart

# Now you can add whatever you'd like

r1 <- rPlot(mpg ~ wt | am + vs, data = mtcars, type = "point", color = "gear")
r1$print("chart1") # print out the js 
r1$save('myPlot.html') #save as html file
r1$publish('myPlot', host = 'gist') # save to gist, rjson required
r1$publish('myPlot', host = 'rpubs') # save to rpubs

# morris
# plotting package for time series data

data(economics, package = "ggplot2")
econ <- transform(economics, date = as.character(date))
m1 <- mPlot(x = "date", y = c("psavert", "uempmed"), type = "Line", data = econ)
m1$set(pointSize = 0, lineWidth = 1)
m1$save('fig/m1.html', cdn = TRUE)

# xCharts
# another plotting package

require(reshape2)
uspexp <- melt(USPersonalExpenditure)
names(uspexp)[1:2] = c("category", "year")
x1 <- xPlot(value ~ year, group = "category", data = uspexp, type = "line-dotted")
x1$save('fig/x1.html', cdn = TRUE)
cat('<iframe src="fig/x1.html" width=100%, height=600></iframe>')
cat('<iframe src="fig/m1.html" width=100%, height=600></iframe>')

# Leaflet
# creates maps

map3 <- Leaflet$new()
map3$setView(c(51.505, -0.09), zoom = 13)
map3$marker(c(51.5, -0.09), bindPopup = "<p> Hi. I am a popup </p>")
map3$marker(c(51.495, -0.083), bindPopup = "<p> Hi. I am another popup </p>")
map3$save('fig/map3.html', cdn = TRUE)
cat('<iframe src="fig/map3.html" width=100%, height=600></iframe>')

# Rickshaw

usp = reshape2::melt(USPersonalExpenditure)
# get the decades into a date Rickshaw likes
usp$Var2 <- as.numeric(as.POSIXct(paste0(usp$Var2, "-01-01")))
p4 <- Rickshaw$new()
p4$layer(value ~ Var2, group = "Var1", data = usp, type = "area", width = 560)
# add a helpful slider this easily; other features TRUE as a default
p4$set(slider = TRUE)
p4$save('fig/p4.html', cdn = TRUE)
cat('<iframe src="fig/p4.html" width=100%, height=600></iframe>')

# highchart

h1 <- hPlot(x = "Wr.Hnd", y = "NW.Hnd", data = MASS::survey, type = c("line", 
                                                                      "bubble", "scatter"), group = "Clap", size = "Age")
h1$save('fig/h1.html', cdn = TRUE)
cat('<iframe src="fig/h1.html" width=100%, height=600></iframe>')

########################################
## Google Vis API
########################################

install.packages("googleVis")

# Example

suppressPackageStartupMessages(library(googleVis))
## Warning: package 'googleVis' was built under R version 3.0.3
M <- gvisMotionChart(Fruits, "Fruit", "Year", options = list(width = 600, height = 400))
print(M, "chart")
plot(M)

# Charts in googleVis

# "gvis + ChartType"
# Motion charts: gvisMotionChart
# Interactive maps: gvisGeoChart
# Interactive tables: gvisTable
# Line charts: gvisLineChart
# Bar charts: gvisColumnChart
# Tree maps: gvisTreeMap

# Plots on maps

G <- gvisGeoChart(Exports, locationvar = "Country", colorvar = "Profit", options = list(width = 600, 
                                                                                        height = 400))
print(G, "chart")
plot(G)

# Specifying a region
# region 150 = Europe

G2 <- gvisGeoChart(Exports, locationvar = "Country", colorvar = "Profit", options = list(width = 600, 
                                                                                         height = 400, region = "150"))
print(G2, "chart")
plot(G2)

# Setting more options

df <- data.frame(label=c("US", "GB", "BR"), val1=c(1,3,4), val2=c(23,12,32))
Line <- gvisLineChart(df, xvar="label", yvar=c("val1","val2"),
                      options=list(title="Hello World", legend="bottom",
                                   titleTextStyle="{color:'red', fontSize:18}",                         
                                   vAxis="{gridlines:{color:'red', count:3}}",
                                   hAxis="{title:'My Label', titleTextStyle:{color:'blue'}}",
                                   series="[{color:'green', targetAxisIndex: 0}, 
{color: 'blue',targetAxisIndex:1}]",
                                   vAxes="[{title:'Value 1 (%)', format:'##,######%'}, 
{title:'Value 2 (\U00A3)'}]",                          
                                   curveType="function", width=500, height=300                         
                      ))

# Setting more options

print(Line, "chart")

# Combining multiple plots together
# merge them together 2 at a time

G <- gvisGeoChart(Exports, "Country", "Profit",options=list(width=200, height=100))
T1 <- gvisTable(Exports,options=list(width=200, height=270))
M <- gvisMotionChart(Fruits, "Fruit", "Year", options=list(width=400, height=370))
GT <- gvisMerge(G,T1, horizontal=FALSE)
GTM <- gvisMerge(GT, M, horizontal=TRUE,tableOptions="bgcolor=\"#CCCCCC\" cellspacing=10")

# Combining multiple plots together
print(GTM, "chart")
plot(GTM)

# Seeing the HTML code

M <- gvisMotionChart(Fruits, "Fruit", "Year", options = list(width = 600, height = 400))
print(M)

print(M, "chart", file = "myfilename.html")



print(GTM, "chart")

# for more info
demo(googleVis)

######################################
## plotly
######################################

library(plotly)
library(ggplot2)

set_credentials_file("lukeremy", "ldqkvxqubx")

# Make a plot with ggplot2, as usual:

ggiris <- qplot(Petal.Width, Sepal.Length, data = iris, color = Species)
ggiris

# Now make this plot interactive and online. To do this, first instantiate a Plotly object:
     
py <- plotly()

# And call the ggplotly() method to convert your ggplot2 plot into a Plotly plot:
     
r <- py$ggplotly(ggiris)

# Your online, interactive, collaborative plot lives at this URL:
     
r$response$url
## [1] "https://plot.ly/~lukeremy/1"


###################################################
## SLIDIFY
###################################################

# get slidify
library(devtools)
install_github('slidify', 'ramnathv')
install_github('slidifyLibraries', 'ramnathv')
library(slidify)

# getting started
# setwd, create project and give it a name
# will open up index.Rmd file in RStudio
author("first_project")

# see edits to index.Rmd file in "first_project" folder
# make desired edits to index.Rmd file, then run:
slidify('index.Rmd')
# creates index.md file output in first_project folder

# load knitr to use browseURL() and view slides deck in browser
library(knitr)
browseURL('index.html')

# getting to know index.Rmd file

# YAML = yet another markdown language
# first bit of index.Rmd file is YAML code

# making slides
--- # marks end of slide
     .class #id # are class attributes to customize slide
##  # starts new slide

# publishing to github
# see notes on coursera for other notes
# first, log in to github and create new empty rep
# replace user with your name and repo with your repo name
publish_github(user,repo)

# see Slidify more details lecture notes for editing markdown

# using slidify with knitr
# see notes on index.Rmd slide 2


###############################################
## R STUDIO PRESENTER
###############################################

# File > New File > Presentation

# see test.Rpres file

# see R Studio Presenter 2 Authoring details lecture for
# more notes on how to change settings, font, background, etc.


########################################
## HOSTING ON gh-pages
########################################

# follow lecture notes if need to post on github


