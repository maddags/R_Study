#출처 : https://stats.idre.ucla.edu/r/dae/ordinal-logistic-regression/

library(foreign)
#foreign 패키지에 read.dta들어있음
library(ggplot2)
library(MASS)
#plor를 함수 포함


dat <- read.dta("https://stats.idre.ucla.edu/stat/data/ologit.dta")
#dat$pared : 부모중 한명 대학 학위 여부
#dat$public : 졸업한 학교가 공립인지
#dat$gpa : 학점
#dat$apply : 대학원에 진학할 가능성

str(dat)
#str는 1개의 서수형 변수, 2개의 이항범주형 변수, 1개의 연속변수

#순서형 척도를 종속변수로하는 로지스틱 회귀분석의 중요한 가정은 회귀계수가 같다고 가정하는 것
#y = 1,2,3인 데이터의 경우, 1 vs 2,3의 OR에 미치는 경향과 1,2 vs 3의 OR에 미치는 경향이 같다고 가정
#즉 3개의 범주로 이루어 질때, 2개의 식의 회귀계수는 같고, 단지 절편만 다르다.


m <- polr(apply ~ pared + public + gpa, data = dat, Hess = TRUE)
#Hess는 Hessian Matrix를 의미
summary(m)


#회귀계수에 exponentail취하면 OR(Odds Ratio)이 된다.
exp(coef(m))
