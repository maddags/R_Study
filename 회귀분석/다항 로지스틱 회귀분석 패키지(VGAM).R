#VGAM 패키지(다항 로지스틱 회귀분석)

#install.packages("VGAM")
library(VGAM)

#함수 입력인자
#vglm()
#fomula = 함수식(종속변수 ~ 독립변수 1 + 독립변수 2 +...)
#family = vglmff의 함수(vglmff의 도움말 참조)
#data
#weights 가중치
#subset 그룹데이터
#na.action = 결측값 처리
#etastart, mustart, coefstart  예측 초기치
#offset = eta 포함 선형예측 성분지정
#method = 적용하는 추정방법

data("airquality")
View(airquality)

air <- as.data.frame(na.omit(airquality))
str(air)
air$date = paste0(2000,"-",air$Month,"-",air$Day)
result1 = lm(data = air, formula =  Temp ~ Ozone + Solar.R + Wind)
result1




air$date = as.Date(air$date)
air$date = paste0(format(air$date,"%m"),"/",format(air$date,"%d"))
air$date = as.Date(air$date, format = "%m/%d")






###시각화
library(ggplot2)
ggplot(air) +
  geom_line(aes(x = date, y = Ozone)) +
  labs(x = "Month")
