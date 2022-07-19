install.packages("digest")
library(KoNLP)
library(dplyr)
library(stringr)
library(tm)
library(wordcloud)
library(RColorBrewer)

useSejongDic()

test <- readLines("~/동아리/R문서(개인)/텍스트마이닝/카카오톡/kakao_practice.txt")

View(test)
test1 <- gsub("[!]","",test)

View(test1)

test2 <- gsub("(ㅜ|ㅠ)+","",test1)

View(test)

test3 <- na.omit(test2)

View(test3)

test4 <- Filter(function(x){x != ""},test3)

View(test4)
str(test4)

##################################

test5 <- as.character(test4)
View(test5)

test5_1 <- extractNoun(test5)
View(test5_1)

test5_1_1 <- Corpus(VectorSource(test5_1))
View(test5_1_1)

test5_1_2 <- TermDocumentMatrix(test5_1_1, control = list(removePunctution = T))
View(test5_1_2)
test5_1_3 <- as.matrix(test5_1_2)
View(test5_1_3)
#######################################
# 주의 terdocumetnmatrix는 chr형식은 지원 x
test5_1_1_1 <- as.character(test5_1_1)
View(test5_1_1_1)

test5_1_1_2 <- TermDocumentMatrix(test5_1_1_1, control = list(removePunctuation = T))
test5_1_1_3 <- as.matrix(test5_1_1_2)

########################################
test6 <- SimplePos09(test5)
View(test6)

test7 <- SimplePos22(test5)
View(test7)


test6_1 <- paste(test6)
View(test6_1)

test7_1 <- paste(test7)
View(test7_1)

test6_2 <- str_match(test6_1, "([ㄱ-힣]+)/N")

View(test6_2)



