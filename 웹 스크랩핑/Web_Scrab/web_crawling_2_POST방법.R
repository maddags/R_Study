# get 에서 이어집니다

# 다시 Network로 들어와서 싹 다 지우고 더보기를 누른다.
# 그리고 Preview 창에서 아무것도 안뜨면
# Fetch/XHR 누르면 나옴

# 이때 Headers에서 보면 설명 나와 있음


url <- "https://www.diningcode.com/2018/ajax/list.php"

# POST 방식은 밑으로 내려가면 FORM DATA가 있다
# 그 부분 싹다 복사
# : 뒤에 아무것도 없는 것은 지워도 됨
body <- list(
    query = "초밥", # 퍼센트 인코딩이라고 한다.
    page = 2, # 이걸 반복문 돌리면 여러개 가져올 수 있음음
  chunk = 10
)

# 이렇게 바꾼다.
#library(urlencodind)하면 퍼센트인코딩을 바꿔주는게 있음

res <- POST(url = url, body = body,
            encode ="form")

res

# size 준 이유는 10개만 받았기 때문에

# Response에 가면 li부터 시작하는 것을 알 수 있다.
# 따라서 css가 달라짐

items <- res %>% 
  read_html() %>% 
  html_nodes(css = "a")

df1 <- data.frame(
  name =getText(html = items, css ="span.btxt") ,
  menu =getText(html = items, css ="span.stxt") ,
  text =getText(html = items, css ="span.ctxt") ,
  addr =getText(html = items, css ="span:nth-child(5)")
)

df1

df <- rbind(df,df1)

# page는 위에서 POST의 page를 바꾸면서 하면 된다.
# 다이닝코드는 100개밖에 안준다.(ㅅㅂ)