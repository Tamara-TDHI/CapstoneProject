library(shiny)
#setwd("C:/Coursera/Developing Data Products")
shinyUI(pageWithSidebar(
  # Application title
  headerPanel("XXXXX"),
  sidebarPanel(
    h3('YYYY'),
    p('ZZZZZ'),
    textInput('yourtext','please type your text'),
  # numericInput('transactiewaarde','Average Transaction Value',
  #               0, min = 0, step=10),
  #  numericInput('norepeat','Number of transactions per year', 1, min = 0, step=1),
  #  radioButtons('status', 'Status Customer',
  #                     c('Prospect' = 1,
  #                      'Existing Customer' = 2),
  #               selected=NULL),
  #  radioButtons('soort', 'Type',
  #                     c('Company' = '1',
  #                      'Person' = '2'),
  #               selected=NULL),
    submitButton('Submit')
  ),
  mainPanel(
    h3('AAAA'),
    h4('BBBBB - you entered:'),
    verbatimTextOutput('transactiewaarde'),
  #  h4('CCCC - you entered:'),
  #  verbatimTextOutput('norepeat'),
  #  h4('Status - you entered:'),
  #  verbatimTextOutput('status'),
  #  h4('Type - you entered:'),
  #  verbatimTextOutput('soort'),
    
    h3('EEEEEEE'),
    verbatimTextOutput('prediction')
  )
))