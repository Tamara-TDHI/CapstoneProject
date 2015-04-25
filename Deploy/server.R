library(shiny)

load('bigrams.Rda',.GlobalEnv)
load('trigrams.Rda',.GlobalEnv)
load('quatrograms.Rda',.GlobalEnv)
load('quintograms.Rda',.GlobalEnv)

split_by_word <- function (text) {
  stopifnot (is.character (text))
  words <- unlist (strsplit (text, split = "[ ]+"))
  words [nchar (words) > 0]
}

last_word <- function (text) {
  stopifnot (is.character (text))
  stopifnot (length (text) == 1)
  # split the phrase into words
  words <- split_by_word (text)
  # the last word only
  words [length (words)]
}

check_ngram <- function (text) {
  sapply(strsplit(text, "\\s+"), length)
}

test <- function(yourtext)
  
  # count words
    check_ngram(yourtext)

   


   # if aantal words groter of gelijk aan 5:
      # pak dan de laatste 5 en ga zoeken
  
          # gevonden? geef dan terug
  
          # niet gevonden? ga dan naar 4
      # is dan het aantal woorden 4? zo ja herhaal, zo nee, dan 3?
      # --> recursief
  
   #last_word(head(bigrams[grep(paste("^", yourtext, sep=""), bigrams$word2),],1)[,2])
   
   
shinyServer(
  function(input,output){
    output$yourtext <- renderPrint({input$yourtext})
#    output$status <- renderPrint({input$status})
#    output$soort <- renderPrint({input$soort})
#    output$norepeat <- renderPrint({input$norepeat})
    output$prediction <- renderPrint({test(input$yourtext)})
  }
)