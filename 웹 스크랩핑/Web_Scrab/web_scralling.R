#install.packages("rvest")

library(rvest)

# 주요 함수들
## read_html() : 웹 페이지 읽어오기
## html_elemetns() : 특정 요소에 해당하는 내용 추출하기
## html_attr() : 특정 태그에 해당하는 값 추출하기
## html_text() : 추출한 내용 택스트로 바꾸기


# 가져올 url 입력
url <- "https://www.theissaclee.com/ko/courses/rstat101/"
web_page <- read_html(url)
print(web_page)


# 목차 내용 가져오기
chapter_name <- web_page %>% 
  html_elements(".docs-sidenav a")


### width : n번째글자까지 보여주는 옵션
print(chapter_name[1], width = 1000)
head(chapter_name) 


# 목차 내용 가져오기
chapter_name <- web_page %>% 
  html_elements(".docs-sidenav a") %>% 
  html_text()
chapter_name



## 트랜스퍼마켓에서 선수이름 뽑아오기(1페이지껏만)
url <- "https://www.transfermarkt.com/spieler-statistik/wertvollstespieler/marktwertetop"
web_page <- read_html(url)
player_name <- web_page %>% 
  html_elements("#yw1 .spielprofil_tooltip") %>% 
  html_text()
player_name


## 선수 나이 가져오기
url <- "https://www.transfermarkt.com/spieler-statistik/wertvollstespieler/marktwertetop"
web_page <- read_html(url)
player_age <- web_page %>% 
  html_elements("#yw1 td:nth-child(3)") %>% 
  html_text()
player_age


## 선수 클럽정보 가져오기
url <- "https://www.transfermarkt.com/spieler-statistik/wertvollstespieler/marktwertetop"
web_page <- read_html(url)
player_club <- web_page %>% 
  html_elements("#yw1 .vereinprofil_tooltip") %>% 
  # a > alt에 클럽이름이 저장되어있음
  # html_chidren() : 하위태그안의 내용을 가져올때 사용
  html_children()

print(head(player_club,1),width = 1000)

player_club <- player_club %>% 
  html_attr("alt")

player_club


### 선수 국가정보 가져오기
url <- "https://www.transfermarkt.com/spieler-statistik/wertvollstespieler/marktwertetop"
web_page <- read_html(url)
player_country <- web_page %>% 
  html_elements(".flaggenrahmen") %>% 
  html_attr("title")

player_country
print(player_country[1], width =1000) 

## 이렇게 하면 안되는 이유? >> 이중국적
data.frame(name = player_name,
           age = player_age,
           club = player_club,
           national = player_country)



### 선수 국가정보 가져오기
url <- "https://www.transfermarkt.com/spieler-statistik/wertvollstespieler/marktwertetop"
web_page <- read_html(url)
national2 <- web_page %>% 
  html_elements("#yw1 .zentriert:nth-child(4)")
national2 <- national2[-1]
# 이미지 태크 2개임
print(national2[6],width = 1000)

# 하위태크로 분리(6번째 선수만) <br>은 줄바꿈
html_children(national2[6]) %>% length()

# 이중국적 있는 선수 번호 찾기
count_dup <- sapply(national2,
                    \(x) length(html_children(x)))
which(count_dup > 1)

result <- sapply(national2,
                 \(x) html_attr(html_children(x)[1],"alt"))
result



# 선수 가치 정보 불러오기
url <- "https://www.transfermarkt.com/spieler-statistik/wertvollstespieler/marktwertetop"
web_page <- read_html(url)
player_value <- web_page %>% 
  html_elements("#yw1 b") %>% 
  html_text()
player_value

library(stringr)
# 정규 표현식 사용
player_value <- player_value %>%  
  str_extract("\\d+[.]\\d\\d") %>% 
  as.numeric()



# df 만들기
mydb<- data.frame(name = player_name,
           age = player_age,
           club = player_club,
           national = result,
           value = player_value)


write.csv(mydb,
          file = "./soccoer_player.csv",
          row.names = F,
          fileEncoding = "UTF-8")


## 각 페이지마다 선수 정보 가져오기
base_url <- "https://www.transfermarkt.com/spieler-statistik/wertvollstespieler/marktwertetop?ajax=yw1&page="
url <- paste0(base_url, 1:20)
url


player_names <- function(url){
  Sys.sleep(2)
  web_page <- read_html(url)
  
  player_name <- web_page %>% 
    html_elements("#yw1 .spielprofil_tooltip") %>% 
    html_text()
}


players_age <- function(url){
  Sys.sleep(2)
  web_page <- read_html(url)
  player_age <- web_page %>% 
    html_elements("#yw1 td:nth-child(3)") %>% 
    html_text()
}

players_club <- function(url){
  Sys.sleep(2)
  web_page <- read_html(url)
  player_club <- web_page %>% 
    html_elements("#yw1 .vereinprofil_tooltip") %>% 
    html_children() %>% 
    html_attr("alt")
}


players_national <- function(url){
  Sys.sleep(2)
  web_page <- read_html(url)
  player_national <- web_page %>% 
    html_elements("#yw1 .zentriert:nth-child(4)")
  player_national <- player_national[-1]
  player_nationals <- sapply(player_national,
                             \(x) html_attr(html_children(x)[1],"alt"))
  player_nationals
}


players_value <- function(url){
  Sys.sleep(2)
  web_page <- read_html(url)
  
  player_value <- web_page %>% 
    html_elements("#yw1 b") %>% 
    str_extract("\\d+[.]\\d\\d") %>% 
    as.numeric()
}






player_name_list <- lapply(url,player_names)
player_name_list <- unlist(player_name_list)
player_age_list <- lapply(url,players_age)
player_age_list <- unlist(player_age_list)
player_club_list <- lapply(url,players_club)
player_club_list <- unlist(player_club_list)

player_club_list[454]
player_club_list2 <- player_club_list
player_club_list2[500] <- 500
for(i in range(500:456)){
  player_club_list2[i] <- player_club_list2[i-1]
}
player_club_list2[455] <- NA

player_national_list <- lapply(url,players_national)
player_national_list <- unlist(player_national_list)
player_value_list <- lapply(url,players_value)
player_value_list <- unlist(player_value_list)


player_table <- data.frame(name = player_name_list,
                           age = player_age_list,
                           nation = player_national_list,
                           club = player_club_list2,
                           value = player_value_list)

writexl::write_xlsx(player_table,"./tm_top500_player.xlsx")



