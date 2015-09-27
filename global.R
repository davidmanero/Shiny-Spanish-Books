library(tm)
library(wordcloud)
library(memoise)

# The list of valid books
books <<- list(
               "El Lazarillo de Tormes" = "lazarillo",
               "Don Quijote de la Mancha" = "quijote",
               "La Celestina" = "celestina")

# Stop Words in Spanish Language
stopwords_spanish <- read.table("stop-words-spanish.txt", col.names=c("word"))

# Using "memoise" to automatically cache the results
getTermMatrix <- memoise(function(book) {
  # Careful not to let just any name slip in here; a
  # malicious user could manipulate this value.
  if (!(book %in% books))
    stop("Unknown book")
  
  text <- readLines(paste(book,".txt", sep = ""),
                    encoding="UTF-8")
  
  myCorpus = Corpus(VectorSource(text))
  myCorpus = tm_map(myCorpus, content_transformer(tolower))
  myCorpus = tm_map(myCorpus, removePunctuation)
  myCorpus = tm_map(myCorpus, removeNumbers)
  myCorpus = tm_map(myCorpus, removeWords,
                    c(stopwords("SMART"),"por", "con", "los", "como", "del", "las",
                      "algún" ,"alguna" ,"algunas" ,"alguno" ,"algunos" ,"ambos" ,"ampleamos" , "ante" ,"antes" ,"aquel" ,"aquellas" ,"aquellos" ,"aqui" ,"arriba" ,
                      "atras" ,"bajo" ,"bastante" ,"bien" ,"cada" ,"cierta" ,"ciertas" ,
                      "cierto" ,"ciertos" ,"como" ,"con" ,"conseguimos" ,"conseguir" ,"consigo" ,
                      "consigue" ,"consiguen" ,"consigues" ,"cual" ,"cuando" ,"dentro" ,
                      "desde" ,"donde" ,"dos" ,"el" ,"ellas" ,"ellos" ,"empleais" ,
                      "emplean" ,"emplear" ,"empleas" ,"empleo" ,"en" ,"encima" ,
                      "entonces" ,"entre" ,"era" ,"eramos" ,"eran" ,"eras" ,"eres" ,
                      "es" ,"esta" ,"estaba" ,"estado" ,"estais" ,"estamos" ,"estan" ,
                      "estoy" ,"fin" ,"fue" ,"fueron" ,"fui" ,"fuimos" ,"gueno" ,"ha" ,
                      "hace" ,"haceis" ,"hacemos" ,"hacen" ,"hacer" ,"haces" ,"hago" ,
                      "incluso" ,"intenta" ,"intentais" ,"intentamos" ,"intentan" ,
                      "intentar" ,"intentas" ,"intento" ,"ir" ,"la" ,"largo" ,"las",
                      "lo",
                      "los",
                      "mientras",
                      "mio",
                      "modo",
                      "muchos",
                      "muy",
                      "nos",
                      "nosotros",
                      "otro",
                      "para",
                      "pero",
                      "podeis",
                      "podemos",
                      "poder",
                      "podria",
                      "podriais",
                      "podriamos",
                      "podrian",
                      "podrias",
                      "por",
                      "por qué",
                      "porque",
                      "primero",
                      "puede",
                      "pueden",
                      "puedo",
                      "quien",
                      "sabe",
                      "sabeis",
                      "sabemos",
                      "saben",
                      "saber",
                      "sabes",
                      "ser",
                      "si",
                      "siendo",
                      "sin",
                      "sobre",
                      "sois",
                      "solamente",
                      "solo",
                      "somos",
                      "soy",
                      "su",
                      "sus",
                      "también",
                      "teneis",
                      "tenemos",
                      "tener",
                      "tengo",
                      "tiempo",
                      "tiene",
                      "tienen",
                      "todo",
                      "tras",
                      "tuyo",
                      "ultimo",
                      "un",
                      "una",
                      "unas",
                      "uno",
                      "unos",
                      "usa",
                      "usais",
                      "usamos",
                      "usan",
                      "usar",
                      "usas",
                      "uso",
                      "va",
                      "vais",
                      "vamos",
                      "van",
                      "vaya",
                      "verdad",
                      "verdadera",
                      "verdadero",
                      "vosotras",
                      "vosotros",
                      "voy",
                      "yo", "gutenbergtm", "project","más", "mas", "gutenberg", "work",
                      "thy", "thou", "thee", "the", "and", "but", stopwords_spanish$word))
  
  myDTM = TermDocumentMatrix(myCorpus,
                             control = list(minWordLength = 1))
  
  m = as.matrix(myDTM)
  
  sort(rowSums(m), decreasing = TRUE)
})