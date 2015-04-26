library(shiny)
#library(tm)


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

count_words <- function (text) {
  

  sapply(strsplit(text, "\\s+"), length)
}

#prepare_text <- function (yourtext)
#{
#  text_to_predict <- Corpus(VectorSource(yourtext))
#    
#  
#  text_to_predict <- tm_map(text_to_predict, removeNumbers)
#  text_to_predict <- tm_map(text_to_predict, removePunctuation)
#  text_to_predict <- tm_map(text_to_predict ,stripWhitespace)
#  text_to_predict <- tm_map(text_to_predict, tolower)
#
#  text_to_predict <- tm_map(text_to_predict, PlainTextDocument)
#  
#  unlist(sapply(text_to_predict, `[`, "content"))
#}


test <- function(yourtext)

  {
# yourtext = prepare_text(yourtext)
  prediction_word = 'please enter your text' 
  found='0'
  wordsused = count_words(yourtext)
  last4 = paste(tail(strsplit(yourtext,split=" ")[[1]],4),sep='', collapse=' ')
  last3 = paste(tail(strsplit(yourtext,split=" ")[[1]],3),sep='', collapse=' ')
  last2 = paste(tail(strsplit(yourtext,split=" ")[[1]],2),sep='', collapse=' ')
  last1 = paste(tail(strsplit(yourtext,split=" ")[[1]],1),sep='', collapse=' ')
  testvar = 0
  
  
  if (wordsused >= 4) {
    
    hits5 = quintograms[grep(paste("^", last4, sep=""), quintograms$word5),]
    if (nrow(hits5) > 0) {
      prediction_word = last_word(head(hits5,1)[,2])
      found = '1'
    }
   else {
      wordsused = 3
    }
  }
  if (wordsused == 3) {
    
    hits4 = quatrograms[grep(paste("^", last3, sep=""), quatrograms$word4),]
    if (nrow(hits4) > 0) {
      prediction_word = last_word(head(hits4,1)[,2])
      found = '1'
    }
    else {
      wordsused = 2
    }
  }
  if (wordsused == 2) {
    hits3 = trigrams[grep(paste("^", last2, sep=""), trigrams$word3),]
    if (nrow(hits3)> 0) {
      prediction_word = last_word(head(hits3,1)[,2])
      found = '1'
    }
    else {
      wordsused = 1
    }
  }
  if (wordsused == 1) {
    hits2 = bigrams[grep(paste("^", last1, sep=""), bigrams$word2),]
    if (nrow(hits2)> 0) {
      prediction_word = last_word(head(hits2,1)[,2])
      found = '1'
    }
    else {
      prediction_word ='the'
    }
  }

  #paste(testvar, found,wordsused,prediction_word,last4,last3,last2,last1)
  paste(prediction_word)
  

   }
   
shinyServer(
  function(input,output){
    output$yourtext <- renderPrint({input$yourtext})
    
    output$prediction <- renderPrint({test(input$yourtext)})
  }
)