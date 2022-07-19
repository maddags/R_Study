install.packages("rlang")
install.packages("digest")
library(KoNLP)
library(wordcloud)
library(dplyr)
library(tm)
library(stringr)
useSejongDic()


kakao <- readLines("~/동아리/R문서(개인)/텍스트마이닝/카카오톡/kakao_ver.2.txt")
kakao <- iconv(kakao,"UTF-8")

kko_1 <- kakao[-2]
View(kko_1)

kko_2 <- gsub("[[].+[]]","",kko_1)
head(kko_2,20)

kko_3 <- gsub("이모티콘","",kko_2)

kko_4 <- gsub("사진","",kko_3)

kko_5 <- gsub("[-].+[-]","",kko_4)

View(kko_5)

kko_6 <- gsub("[ㄱ-ㅎ]","",kko_5)

kko_7 <- gsub("[ㅏ-ㅣ]","",kko_6)

kko_8 <- gsub("[!@#$%^&*().,?/;:~]","",kko_7)

kko_9 <- gsub("[http].","",kko_8)

kko_10 <- na.omit(kko_9)

kko_11 <- Filter(function(x){x != ""},kko_10)

View(kko_11)

kko_list <- function(doc){
  d <- as.character(doc)
  doc2 <- paste(SimplePos22(d))
  doc3 <- str_match(doc2, "([ㄱ-힣]+)/NC")
  doc4 <- doc3[,2]
  doc4[!is.na(doc4)]
}

kko_12 <- kko_list(kko_11)

kko_13 <- gsub("프레","프레이야",kko_12)

View(kko_13)


kko_14 <- Corpus(VectorSource(kko_13))

kko_15 <- TermDocumentMatrix(kko_14, list(removePunction = T,
                                          wordLengths = c(2,10))
)

kko_16 <- as.matrix(kko_15)

kko_17 <- rowSums(kko_16)

View(kko_17)

