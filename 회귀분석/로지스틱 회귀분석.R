rm(list = ls())

View(mtcars)

data <- glm(am ~ mpg + hp + wt + qsec, data = mtcars , family ="binomial")

summary(data)

car <- mtcars[,c(1,4,6,7,9)]

step(glm(am ~ 1, car, family = "binomial"), scope = c(lower = ~ 1, upper = ~mpg + hp + wt + qsec), direction = "forward")

b <- glm(am ~ wt + qsec , data = car, family = "binomial")

fitted(b)

View(round(predict(b, newdata = car,type = "response"))) 
#type에는 link, response, terms가 있으며 
#multinom()함수를 이용해서 회귀분석시, type에 prob와 class가 추가됨(각각 확률과 속한 클래스가 예측됨) 

result <- cbind(round(predict(b, newdata = car,type = "response")), mtcars$am)

View(result)


