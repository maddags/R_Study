install.packages("dplyr")
library(xlsx)
library(dplyr)

data_file = read.xlsx("C:/Users/madda/Documents/동아리/R문서(개인)/연습자료.xlsx",
                      1,
                      colIndex = 1 : 9,
                      rowIndex = 1: 125,
                      header = T,
                      encoding = "UTF-8")

str(data_file)
data_file$성별 <- as.factor(data_file$성별)
data_file$부족한서비스 <- as.factor(data_file$부족한서비스)
data_file$남는서비스 <- as.factor(data_file$남는서비스)
data_file$직업 <- as.factor(data_file$직업)
data_file$통신사 <- as.factor(data_file$통신사)
data_file$가입년수 <- as.factor(data_file$가입년수)
str(data_file)

data_file2 <- data_file[-1,]
data_file2_male <- data_file2[data_file2$성별 == 1,]
data_file2_female <- data_file2[data_file2$성별 == 2,]


set.seed(100)
train <- rbind(sample_frac(data_file2_male,0.7), sample_frac(data_file2_female,0.7))
test <- setdiff(data_file2,train) #차집합 구하는 값
train <- train[,-1]
test <- test[,-1]

...................................................................................................................................................................................................

#install.packages("party")
#install.packages("rpart")
#install.packages("C50")
#install.packages("rpart.plot")
library(rpart)
library(party)
library(rpart.plot)
library(C50)
tree = ctree(부족한서비스 ~ ., data= train)
plot(tree)
plot(tree, type = "simple")

rpart_tree <- rpart(부족한서비스 ~ ., data = train, method = "class")
rpart.plot(rpart_tree)
#rpart.plot(data,main = 그래프제목입력,branch.lty=, shadow.col = "")

################################################
printcp(rpart_tree)
plotcp(rpart_tree) # cp값을 확인

prune(rpart_tree, cp = 0.13)
confusionMatrix(predict(rpart_tree,test),test$부족한서비스 )






