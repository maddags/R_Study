#로지스틱 회귀분석(종속변수 = 가변수일때)

a <- subset(iris, Species == "setosa" | Species == "versicolor")

str(a)

a$Species <- factor(a$Species)

str(a)

b <- glm(Species ~ Sepal.Length, data= a, family = binomial)
summary(b)

coef(b)

fitted

######################################


temp <- c(27.2, 27.7, 28.3, 28.4, 29.9) # 온도
male <- c(2, 17, 26, 19, 27) # 각 온도에서 수컷으로 부화한 알 개수
female <- c(25, 7, 4, 8, 1) # 각 온도에서 암컷으로 부화한 알 개수
total <- male + female
p_male <- male / total


g <- glm(p_male ~ temp, family = binomial, weights= total)

g

summary(g)

phat1 <- coefficients(g)[1] + coefficients(g)[2]*temp
phat1

phat_tr <- exp(phat1)

rbind(temp,phat_tr) # 온도별 오즈 수치


######

car <- glm(data = mtcars, vs ~ mpg + disp + hp, family = "binomial")
summary(car)

car.step = step(car, direction = "backward")


###########

week <- c(1,2,3,4,5)
sale <- c(5,10,15,20,25)
guest <- c(400,400,400,400,400)
buyer <- c(64,102,140,206,296)

data1 <- cbind(week,sale,guest,buyer)
data1 <- as.data.frame(data1)

View(data1)

data1$buyer.ratio <- data1$buyer / data1$guest


#log 변환 하는거 하기 회귀분석 책 참조
