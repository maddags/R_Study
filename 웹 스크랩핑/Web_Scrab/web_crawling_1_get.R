library(tidyverse)
library(httr)
library(rvest)
library(jsonlite)


url <- "https://www.diningcode.com/list.php"
query <- list(query =  "초밥") # 나중에 함수에 집어 넣을 것

res <- GET(url = url, query = query) # GET : 개발자도구에서 보임

print(x = res)
# status : 200이면 정상
# content-type : html로 받았다./ json, excel...이 온다.
# charset = utf-8이다.
# size : 받은용량

res %>% 
  content(as = "text")
'#div_list > li:nth-child(4) > a > span.btxt'

# . : class 의미
# span의 클래스가 btxt임
# > 직계를 의미
# a가 부모 span이 자식
# div_list 중 4번째 li라는 뜻
# #이 아이디를 의미(#div_list)

res %>% 
  read_html() %>% 
  html_node(css = "#div_list > li:nth-child(4) > a > span.btxt") %>% 
  html_text()

items <- res %>% 
  read_html() %>% 
  html_nodes(css = "#div_list > li > a")

# node vs nodes : 1개만 가져온다 여러개 가져온다.


items %>% 
  html_node(css = "span.btxt") %>% 
  html_text(trim = TRUE) # trim : 공백 제거


items %>% 
  html_node(css = "span.stxt") %>% 
  html_text(trim = TRUE) 


getText <- function(html,css) {
  html %>% 
    html_node(css = css) %>% 
    html_text(trim = TRUE) %>% 
    return()
}


getText(html = items, css ="span.btxt")
getText(html = items, css ="span.stxt")
getText(html = items, css ="span.ctxt")
getText(html = items, css ="span:nth-child(5)")



# ctxt는 2개 있음
getText(html = items, css ="span:nth-child(5)")


df <- data.frame(
  name =getText(html = items, css ="span.btxt") ,
  menu =getText(html = items, css ="span.stxt") ,
  text =getText(html = items, css ="span.ctxt") ,
  addr =getText(html = items, css ="span:nth-child(5)")
)

# tip
# alt 누른상태로 드래그 후 복사 한 뒤
# 복사할 자리에 alt누르고 드래그 한뒤 붙여넣기 하면 그대로 들어온다


df
View(df) 


# 다시 Network로 들어와서 싹 다 지우고 더보기를 누른다.
# 그리고 Preview 창에서 아무것도 안뜨면
# Fetch/XHR 
