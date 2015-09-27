# Text of the books downloaded from:
# Don Quijote:
#  http://www.gutenberg.org/cache/epub/2000/pg2000.txt
# El Lazarillo de Tormes:
#  http://www.gutenberg.org/cache/epub/320/pg320.txt
# La Celestina:
#  http://www.gutenberg.org/cache/epub/1619/pg1619.txt

function(input, output, session) {
  # Define a reactive expression for the document term matrix
  terms <- reactive({
    # Change when the "update" button is pressed...
    input$update
    # ...but not for anything else
    isolate({
      withProgress({
        setProgress(message = "Processing corpus...")
        getTermMatrix(input$selection)
      })
    })
  })
  
  # Make the wordcloud drawing predictable during a session
  wordcloud_rep <- repeatable(wordcloud)
  
  output$plot <- renderPlot({
    v <- terms()
    wordcloud_rep(names(v), v, scale=c(4,0.5),
                  min.freq = input$freq, max.words=input$max,
                  colors=brewer.pal(8, "Dark2"))
  })
}