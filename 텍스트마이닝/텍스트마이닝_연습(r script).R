library(wordcloud)
library(RColorBrewer)
library(KoNLP)

# 리뷰 크롤링
install.packages("rvest")
install.packages("R6")

library(rvest)
library(R6)

url.site <- "https://movie.naver.com/movie/point/af/list.nhn?st=mcode&sword=193194&target=after&page="

review <- c()

for(page in 1:20){
  url_1 <- paste(url.site,page,sep="",encoding = "euc-kr")
  htxt <- read_html(url_1)
  table <- html_nodes(htxt,'.list_netizen')
  content <- html_nodes(table,'.table')
  reviews <- html_text(content)
  if(length(reviews)==0){break}
  review <- c(review,reviews)
  print(page)
}


write.table(review, "도박_리뷰.txt")
