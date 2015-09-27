library(shiny)

shinyUI(
  navbarPage("Best Spanish Books Word Cloud",
             tabPanel("Detail",
                      h2("Spanish Best Books Word Cloud"),
                      hr(),
                      h3("Description"),
                      helpText("This is an application that gives a Word Cloud Analysis of Some of the Best Spanish Books",
                               " ever wroten. In the application you can choose the minimum frequency of the words, and",
                               " the maximum number of words in the Cloud"),
                      hr(),
                      h3("Instructions"),
                      helpText("In the Application Tab you can choose the Book you want to analize, then click in Change Button",
                               " an the analysis start. First the Corpus is indexed and then some transformations are done.",
                               " The Word Cloud is done with the parameters in the input panel."),
                      hr(),
                      h3("Inspiration"),
                      p("I'm working in this type of analysis in Twitter with a huge number of tweets around a hashtag."),
                      p("But this kind of analysis is not able to do in a Shiny applications beacause of the tweet downloads."),
                      p("So I found in a blog this kind of application done in Shiny. I have change the cloud analysis, prepare it to the spanish language, and change a little the IU layout (but not really much in the application, most in the panel visualization) "),
                      hr(),
                      h3("Source"),
                      p("The Books you can find in Gutenberg Project:"),
                      p("Don Quijote: http://www.gutenberg.org/cache/epub/2000/pg2000.txt"),
                      p("El Lazarillo de Tormes: http://www.gutenberg.org/cache/epub/320/pg320.txt"),
                      p("La Celestina: http://www.gutenberg.org/cache/epub/1619/pg1619.txt"),
                      p("The idea of word cloud for Books: http://pirategrunt.com/2013/12/11/24-days-of-r-day-11/"),
                      p("The Shiny Application part: http://shiny.rstudio.com/gallery/word-cloud.html")
             ),
             tabPanel("Application",
                  #fluidPage(
                    # Application title
                   # titlePanel("Spanish Best Books Word Cloud"),
                    
                    sidebarLayout(
                      # Sidebar with a slider and selection inputs
                      sidebarPanel(
                        selectInput("selection", "Choose a book:",
                                    choices = books),
                        actionButton("update", "Change"),
                        hr(),
                        sliderInput("freq",
                                    "Minimum Frequency:",
                                    min = 1,  max = 50, value = 15),
                        sliderInput("max",
                                    "Maximum Number of Words:",
                                    min = 1,  max = 300,  value = 100)
                      ),
                      
                      # Show Word Cloud
                      mainPanel(
                        plotOutput("plot")
                      )
                    )
             ),
             tabPanel("Analysis",
                      h3("Load the entire book"),
                      helpText("The first thing done is to read the book from a txt file (thanks to Gutenberg Project),",
                               " this will be the base for the analysis. The name of the book is compared to the list",
                               " of the books that we have downloaded. In order to not break."),
                      hr(),
                      h3("Corpus construction"),
                      helpText("Then some modifications and preparations are done to the text: ",
                               " lower any upper case, take punctations, numbers, and some stop words from spanish."),
                      hr(),
                      h3("Word Matrix"),
                      helpText("With the tm library we can do Corpus and transform this list of words in a Matrix. ",
                               " This MAtrix is necesary for the WordCloud Application."),
                      hr(),
                      h3("Word Cloud Plot"),
                      helpText("The Word Cloud Plot is done using the wordcloud library, with the wordcloud_rep function",
                               " than plots the information with minimum frequency an the number of words plotted.")
             ),
             tabPanel("SourceCode",
                      p("Shiny Spanish Books"),
                      a("https://github.com/davidmanero/Shiny-Spanish-Books/")
             )
  )
)