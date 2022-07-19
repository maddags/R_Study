library(readxl)

pct <- read_excel("C:/Users/madda/Documents/동아리/R문서(개인)/회귀분석/회귀분석(예제문제1).xlsx")

###########################
pct1 <- pct

pct1$`학력(졸)` <- factor(pct1$`학력(졸)`)
pct1$성별 <- factor(pct1$성별)

lm_pct1 <- lm(총소요시간 ~ 적성검사점수 + 성별 + `학력(졸)`,data = pct1, family = gaussian)

str(pct1)

summary(lm_pct)

#########################

pct2 <- read_excel("~/동아리/R문서(개인)/회귀분석/회귀분석(예제문제1_변형).xlsx")

lm_pct2 <- lm(총소요시간 ~ 적성검사점수 + 남자 + 초졸 +중졸,data = pct2, family = gaussian)

summary(lm_pct2)


#결론 : factor 써서 하면 됨.
