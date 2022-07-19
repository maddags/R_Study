library(foreign)
library(nnet)

mi <- read.dta("http://stats.idre.ucla.edu/stat/data/hsbdemo.dta")

mi$prog2 <- relevel(mi$prog, ref = "academic")
#로짓변환할 때 p의 기준을 설정하는 것

test <- multinom(prog2 ~ ses + write, data = mi)
test2 <- multinom(prog ~ ses + write, data = mi)
summary(test)
#test의 회귀식
#ln[p(general)/p(academic)] = b0 + b1x1(=-0.5332 x sesmiddle) + b1x2(=-1.1628 x seshigh) + b1x3(= -0.0579 x write)
#write가 1단위 증가할 때, academic이 general이 될 log odds가 -0.058이 된다.
#write가 1단위 증가할 때, academic이 vocation이 될 log odds가 -0.1136037이 된다.
#ses:row에서 ses:high로 변할 때, academic이 general이 될 log odds가 -1.1628이 된다.
#ses:row에서 ses:middle로 변할 때, academic이 general이 될 log odds가 -0.5332가 된다.
#ses:row에서 ses:high로 변할 때, academic이 vocation이 될 log odds가 -0.9826이 된다.
#ses:row에서 ses:middle로 변할 때, academic이 vocation이 될 log odds가 +0.29가 된다.

z <- summary(test)$coefficients/summary(test)$standard.errors
p <- pnorm(abs(z),0,1) * 2
p
#############

library(nnet)

iris_data <- multinom(data = iris, Species ~ .)
iris_data


# z-value

iris_zvalue <- summary(iris_data)$coefficients/summary(iris_data)$standard.errors
iris_zvalue

# p_value

iris_pvalue <- pnorm(abs(iris_zvalue)) * 2
iris_pvalue
