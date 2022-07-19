speech <- readline("speech.txt", encoding = "UTF-8")
library(tm)

data <- list()
for(i in 1:length(speech)){
  if(speech[i] != "" | speech[i] != " "){
    data <- paste(data,speech[i], sep = " ")
  }
}

data <- VCorpus(VectorSource(data))

