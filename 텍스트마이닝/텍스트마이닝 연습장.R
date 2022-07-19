list.files() #현재 작업경로에 있는 파일목록 호출
data <- readLines("review.txt") # readLines : 파일을 행단위로 읽어 백터로 저장해주는 함수

install.packages("wordcloud")         #워드클라우드를 위한 패키지
install.packages("RColorBrewer")      #여러 색을 제공해주는 팔레트 패키지
install.packages("KoNLP")             #한국어 텍스트마이닝을 위한 패키지

library(wordcloud)
library(RColorBrewer)
library(KoNLP)


useSejongDic()


data<- readLines("C:/Users/madda/Documents/동아리/R문서(개인)/텍스트마이닝/comment.txt",
                 encoding = "UTF-8")


letter <- c("ㅈㅈ","ㅋㅋ","ㅋ한ㅋ","ㅠㅠ")

letter <- gsub('[ㄱ-ㅎ]',"",letter)
letter

data_nounlist <- gsub("//d+","",data_nounlist)
data_nounlist


data_noun_filter <- Filter(function(x){
  nchar(x) >= 2}, data_noun100
)
data_noun_filter <- gsub("\\d+"," ",data_noun_filter)
data_noun_filter



