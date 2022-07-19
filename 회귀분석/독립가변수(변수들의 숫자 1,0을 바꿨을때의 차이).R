library(readxl)


#practice1 -> (남자,여자) = (1,0) / practice2 -> (남자,여자) = (0,1)
practice1 <- read_excel("~/동아리/R문서(개인)/회귀분석/회귀분석(로지스틱_독립가변수_예제1).xlsx")
practice2 <- read_excel("~/동아리/R문서(개인)/회귀분석/회귀분석(로지스틱_독립가변수_예제2).xlsx")



y1 <- as.vector(practice1$총소요시간)
dim(y1) <- c(20,1)

X1 <- c(rep(1,20),as.vector(practice1$적성검사점수),as.vector(practice1$성별))
dim(X1) <- c(20,3)

revX1 <- t(X1) #행과 열을 바꿔주는 함수

revX1

sol <- solve(revX1%*%X1)%*%revX1%*%y1
sol


# 남자 : 41.7689 - 0.1009x1 - 7.9339 = 33.835 - 0.1009x1
# 여자 : 41.7689 - 0.1009x1


#####################################################################

y2 <- as.vector(practice2$총소요시간)
dim(y2) <- c(20,1)

X2 <- c(rep(1,20),as.vector(practice2$적성검사점수),as.vector(practice2$성별))
dim(X2) <- c(20,3)

revX2 <- t(X2) #행과 열을 바꿔주는 함수

revX2

sol <- solve(revX2%*%X2)%*%revX2%*%y2
sol


# 남자 : 33.835 - 0.1009x1
# 여자 : 33.834 - 0.1009x1 + 7.934 = 41.769 - 0.1009x1


# 결론
# practice1 , practice2의 차이가 없다.

########################################################

# 분산분석표

lm1 <- glm(practice1$총소요시간 ~ practice1$적성검사점수 + practice1$성별, family = gaussian)
lm2 <- glm(practice2$총소요시간 ~ practice2$적성검사점수 + practice2$성별, family = gaussian)

lm1
anova(lm1)
lm2
