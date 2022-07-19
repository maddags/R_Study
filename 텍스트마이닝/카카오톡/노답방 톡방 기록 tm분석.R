install.packages("digest")
library(KoNLP)
library(dplyr)
library(stringr)
library(tm)
library(wordcloud)
library(RColorBrewer)

useSejongDic()
kakao <- readLines("kakao_ver.1.txt") # txt파일을 불러오는 함수
kakao <- iconv(kakao,'UTF-8') # data를 인코딩하는 함수

#텍스트 지우기

## 시간 사람 지우기
kko_1 <- gsub('[[].+[]]',"",kakao)
head(kakao,10)
head(kko_1,10)


## 날짜 지우기
kko_2 <- gsub('[-].+[-]',"",kko_1)

## 위에 2줄 지우기
kko_3 <- kko_2[-2]

## 한글자 자음 지우기
kko_4 <- gsub("[ㄱ-ㅎ]","",kko_3)


## URL주소 지우기(맨뒤 / 전까지)
kko_5 <- gsub("[http].+[/]","",kko_4)
head(kko_5,20)

## 모음으로만 이루어진 것 지우기
kko_6 <- gsub("[ㅏ-ㅢ]","",kko_5)
head(kko_6,100)

## 특수문자 지우기
kko_7 <- gsub("[!@#$%^&*()]<>","",kko_6)
head(kko_7,100)

## 이모티콘 지우기
kko_8 <- gsub('이모티콘',"",kko_7)
head(kko_8,100)

## 이미지 지우기(이미지는 글자 '사진'으로 저장됨)
kko_9 <- gsub('[사진]',"",kko_8)
head(kko_9,100)

## ""로 대체한 것 & NA값 지우기
kko_10 <- na.omit(kko_9)

kko_11 <- Filter(function(x){x != ""},kko_10)
head(kko_11,100)

## 단어 추출
kko_list <- function(doc){
  d <- as.character(doc)
  doc2 <- paste(SimplePos22(d)) # SimplePos22 : 명사를 22가지로 나눠주는 함수
  doc3 <- str_match(doc2, "([ㄱ-힣]+)/NC") 
  # str_match : 주어진 개체로부터 특정 문자열을 반환하는 함수, 
  #             따로 때여내고 싶은 부분에 ()를 치면 된다.
  #             2열의 형태로 나오기 때문에 2열만을 추출해야함.
  doc4 <- doc3[,2]
  doc4[!is.na(doc4)]
}
 
kko_12 <- kko_list(kko_11)
kko_12

kko_13 <- Corpus(VectorSource(kko_12))
#Corpus : 데이터를 말뭉치로 변환해주는 함수


kko_14 <- TermDocumentMatrix(kko_13,
                             control = list(removePunction = T, 
                                            removeNumbers = T,
                                            wordLengths=c(1,8))
)


#TermDocumentMatrix : 데이터에서 행에 출현했던 단어들을 나열해주는 함수

kko_15 <- as.matrix(kko_14)

kko_16 <- rowSums(kko_15)

View(kko_16)

### 맘에 들지 않은 글자 지우기 <- 위에 지우는 단계로 다시 돌아가자

kko_9_1 <- gsub("[빡+]","",kko_9)
kko_9_2 <- gsub("[라]","",kko_9_1)
kko_9_3 <- gsub("[뜯+]","",kko_9_2)
kko_9_4 <- gsub("[부]","",kko_9_3)
kko_9_5 <- gsub("[맞+]","",kko_9_4)
kko_9_6 <- gsub("[됬+]","",kko_9_5)
kko_9_7 <- gsub("[태]","",kko_9_6)
kko_9_8 <- gsub("[되+]","",kko_9_7)
kko_9_9 <- gsub("[+했+]","",kko_9_8)
kko_9_10 <- gsub("[+였+]","",kko_9_9)
kko_9_11 <- gsub("[+쨌+]","",kko_9_10)
kko_9_12 <- gsub("[+었+]","",kko_9_11)

kko_10_1 <- na.omit(kko_9_12)

kko_11_1 <- Filter(function(x){x != ""},kko_10_1)
head(kko_11_1,100)

## 단어 추출
kko_list <- function(doc){
  d <- as.character(doc)
  doc2 <- paste(SimplePos22(d)) # SimplePos22 : 명사를 22가지로 나눠주는 함수
  doc3 <- str_match(doc2, "([ㄱ-힣]+)/NC") 
  # str_match : 주어진 개체로부터 특정 문자열을 반환하는 함수, 
  #             따로 때여내고 싶은 부분에 ()를 치면 된다.
  #             2열의 형태로 나오기 때문에 2열만을 추출해야함.
  doc4 <- doc3[,2]
  doc4[!is.na(doc4)]
}

kko_12_1 <- kko_list(kko_11_1)
kko_12_1

kko_13_1 <- Corpus(VectorSource(kko_12_1))
#Corpus : 데이터를 말뭉치로 변환해주는 함수


kko_14_1 <- TermDocumentMatrix(kko_13_1,
                             control = list(removePunction = T, 
                                            removeNumbers = T,
                                            wordLengths=c(2,8))
)


#TermDocumentMatrix : 데이터에서 행에 출현했던 단어들을 나열해주는 함수

kko_15_1 <- as.matrix(kko_14_1)

kko_16_1 <- rowSums(kko_15_1)

View(kko_16_1)

wordcloud(words = names(kko_16_1),kko_16_1,
          max.words = 300,
          random.order = F,
          rot.per = 0.35,
          family = "font",
          colors = brewer.pal(8,"Dark2"))

save.image(file = "C:/Users/madda/Documents/동아리/R문서(개인)/텍스트마이닝/카카오톡/kakao_data.RData")
