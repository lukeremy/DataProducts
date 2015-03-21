## quiz 1

# 1
# Consider the following code for the cars data set
library(manipulate)
myPlot <- function(s) {
     plot(cars$dist - mean(cars$dist), cars$speed - mean(cars$speed))
     abline(0, s)
}
# This function plots distance versus speed, each de-meaned 
# and an associated line of slope s. 
# Which of the following code will make a manipulate plot that 
# creates a slider for the slope?
manipulate(myPlot(s), s = slider(0, 2, step = 0.1))


# 2
# Which of the following code uses the rCharts package to create a 
# sortable and searchable data table for the airquality data set? 
# Assume the rCharts package and the airquality data set have already been loaded into R.
library(rCharts)
data(airquality)
dTable(airquality, sPaginationType = "full_numbers")


# 3
# A basic shiny data product requires:
## A ui.R and server.R file or a A server.R file and a directory called www 
## containing the relevant html files.


# 4
# What is incorrect about the followig syntax in ui.R?
library(shiny)
shinyUI(pageWithSidebar(
     headerPanel("Data science FTW!"),
     sidebarPanel(
          h2('Big text')
          h3('Sidebar')
     ),
     mainPanel(
          h3('Main Panel text')
     )
))

## Missing a comma in the sidebar panel


# 5
# Consider the following code in ui.R
shinyUI(pageWithSidebar(
     headerPanel("Example plot"),
     sidebarPanel(
          sliderInput('mu', 'Guess at the mu',value = 70, min = 60, max = 80, step = 0.05,)
     ),
     mainPanel(
          plotOutput('newHist')
     )
))
# And the following server.R code.

library(UsingR)
data(galton)

shinyServer(
     function(input, output) {
          output$myHist <- renderPlot({
               hist(galton$child, xlab='child height', col='lightblue',main='Histogram')
               mu <- input$mu
               lines(c(mu, mu), c(0, 200),col="red",lwd=5)
               mse <- mean((galton$child - mu)^2)
               text(63, 150, paste("mu = ", mu))
               text(63, 140, paste("MSE = ", round(mse, 2)))
          })
          
     }
)
## The server.R output name isn't the same as the plotOutput command used in ui.R.


###########################
## quiz 2

# 1
# In the slidify YAML text. Changing the framework from io2012 to shower does what?

## It changes the html5 framework thus changing the style of the slides.

# 2
# You wrote R code in a slidify document as follows
```{r}
fit <- lm(y ~ x1 + x2 + x3)
summary(fit)
```
# If you want to hide the results of the summary statement (yet still have it run),
# what should you do?

## Add a results = 'hide' option in the {r} call of the code chunk


# 3
# You wrote R code in a slidify document as follows
```{r}
fit <- lm(y ~ x1 + x2 + x3)
summary(fit)
```
# If you want to display the results, but not the actual code, what should you do?

## Add a echo = FALSE option in the {r} call of the code chunk

# 4
# R studio presentation tool does what?

## Creates HTML5 slides using a generalized markdown format having an extention Rpres and 
## creates reproducible presentations by embedding and running the R code from within 
## the presentation document.


# 5
# In Rstudio presenter, if you do not want the code to be evaluated, what option 
# do you need to add to the {r} options?

## eval = FALSE

# 6
# When presenting data analysis to a broad audience, which of the following should be done?

## Summarize the problem first.
