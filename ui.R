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
                      fluidPage(
                        titlePanel("The relationship between variables and miles per gallon (MPG)"),
                        sidebarLayout(
                          sidebarPanel(
                            selectInput("variable", "Variable:",
                                        c("Number of cylinders" = "cyl",
                                          "Displacement (cu.in.)" = "disp",
                                          "Gross horsepower" = "hp",
                                          "Rear axle ratio" = "drat",
                                          "Weight (lb/1000)" = "wt",
                                          "1/4 mile time" = "qsec",
                                          "V/S" = "vs",
                                          "Transmission" = "am",
                                          "Number of forward gears" = "gear",
                                          "Number of carburetors" = "carb"
                                        )),
                            
                            checkboxInput("outliers", "Show BoxPlot's outliers", FALSE)
                          ),
                          
                          mainPanel(
                            h3(textOutput("caption")),
                            
                            tabsetPanel(type = "tabs", 
                                        tabPanel("BoxPlot", plotOutput("mpgBoxPlot")),
                                        tabPanel("Regression model", 
                                                 plotOutput("mpgPlot"),
                                                 verbatimTextOutput("fit")
                                        )
                            )
                          )
                        )
                      )
             ),
             tabPanel("SourceCode",
                      p("part1_devdataprod-shiny"),
                      a("https://github.com/swhgoon/devdataprod-cp/tree/master/part1_devdataprod-shiny")
             )
  )
)