library(shiny)

shinyUI(pageWithSidebar(
  # Application title
  headerPanel("The next word - prediction app"),
  sidebarPanel(
    h3('Your input here'),
    p('You enter a word or a partial sentence, and we will predict the next word'),
    textInput('yourtext','please type your text'),
    submitButton('Submit')
  ),
  mainPanel(
    h3('You entered'),
    h4('The input you entered:'),
    verbatimTextOutput('yourtext'),
    
    h3('Our prediction of the next word'),
    verbatimTextOutput('prediction')
  )
))