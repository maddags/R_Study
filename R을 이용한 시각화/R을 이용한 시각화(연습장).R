library(ggplot2)
library(extrafont)
library(showtext)
library(plyr)
library(ggthemes)

bloodtype <- c("A","B","O","AB","B","A","B","AB","A","A","A","B","O","A","B","AB","O","O","O","AB","A","B","AB","A","A","B","B","B","O","AB")
gender <- c("M","M","F","F","F","M","M","M","M","F","M","M","F","M","F","F","F","F","M","M","M","F","M","F","M","M","F","F","M","M")
height <- c(178,185,169,160,170,160,156,163,185,149,178,145,150,178,167,165,163,162,157,170,171,178,180,189,172,155,162,168,175,173)
weight <- c(79,89,56,50,74,84,57,49,87,78,60,59,48,80,71,79,105,69,50,69,82,89,93,74,81,74,67,66,54,100)

imf <- cbind(bloodtype,gender,height,weight)
rownames(imf) <- c("NO1","NO2","NO3","NO4","NO5","NO6","NO7","NO8","NO9","NO10","NO11","NO12","NO13","NO14","NO15","NO16","NO17","NO18","NO19","NO20",
                   "NO21","NO22","NO23","NO24","NO25","NO26","NO27","NO28","NO29","NO30")
imf <- as.data.frame(imf)
imf

gp1 <- ggplot(data = imf) +
  geom_point(aes(x = weight, y = height, color = gender))

gp2 <- ggplot(data= imf) +
  geom_bar(aes(x = gender, color = bloodtype), position = "dodge")


bmi <- weight / ((height/100)*(height/100))

bmi <- weight / ((height/100)*(height/100))
imf <- cbind(imf,bmi)

gp3 <-  ggplot(data = imf) +
  geom_point(mapping = aes(x = bmi , y = height, color = bloodtype), stat = "identity")

gp3

install.packages("gridExtra")
library(gridExtra)

gp3 +
  lims(x = c(0,50))


ggplot(data = iris) +
  geom_point(mapping = aes(x = Petal.Length, y = Petal.Width, color = Species)) +
  scale_x_continuous(breaks = c(1,2,3,4,5,6,7))

ggplot(data = iris) +
  geom_point(mapping = aes(x = Petal.Length, y = Petal.Width, color = Species)) +
  scale_x_continuous(breaks = c(1,2,3,4,5,6,7), labels = paste0(c(1,2,3,4,5,6,7),"cm"))+
  theme(axis.text.x = element_text(angle = 45, size = 8)) +
  scale_y_continuous(breaks = c(0,0.5,1,1.5,2,2.5),labels = paste0(c(0,0.5,1,1.5,2,2.5), "cm")) +
  theme(axis.text.y = element_text(size = 8))




airport <- read.csv("~/동아리/R문서(개인)/R을 이용한 시각화/airports.dat",sep = ",",header = F, stringsAsFactor = F)
route <- read.csv("~/동아리/R문서(개인)/R을 이용한 시각화/routes.dat",sep = ",",header = F, stringsAsFactor = F)
colnames(airport) <- c("Airport ID","Name","City","Country","IATA","ICAO","Latitude","Longitude","Altitude","Timezone","DST")
colnames(route) <- c("Airline","Airline ID","Source airport","Source airport ID","Destination airport","Destination airport ID",
                    "Codershare","Stops","Equipment")


list_loc <- cbind(airport$IATA,airport$IATA,airport$Latitude,airport$Longitude)
colnames(list_loc) <- c("Source airport","Destination airport","Latitude","Longitude")

korea <- airport[airport$Country == "South Korea",]
korea.dp <- route[route$`Source airport` == korea$IATA,]

korea.data <- cbind(korea.dp$Airline,korea.dp$`Source airport`,korea.dp$`Destination airport`)
colnames(korea.data) <- c("Airline","Depart","Arrival")

dp_lalong <- merge(x = korea.dp, y =list_loc, by ="Source airport")
ar_lalong <- merge(x = korea.dp, y = list_loc, by = "Destination airport")

loc <- cbind(dp_lalong$Airline,dp_lalong$`Source airport`,dp_lalong$Latitude,dp_lalong$Longitude,ar_lalong$`Destination airport`,ar_lalong$Latitude,ar_lalong$Longitude)
colnames(loc) <- c("Airline","Depart","Dp_latitude","Dp_longtitude","Arrival","Ar_latitude","Ar_longtitude")
write.csv(loc,"다시.csv")


str(loc)
View(loc)

depart <- subset(loc, select = c("Depart","Dp_latitude","Dp_longtitude"))
arrival <- subset(loc, select = c("Arrival","Ar_latitude","Ar_longtitude"))

depart <- cbind(depart,grp =c(1:18))
colnames(depart) <- c("Airport","Latitude","Longtitude","grp")
arrival <- cbind(arrival,grp = c(1:18))
colnames(arrival) <- c("Airport","Latitude","Longtitude","grp")
sum_lalong <- rbind(depart,arrival, stringsAsFactor = F)
sum_lalong_1 <- sum_lalong[c(-18,-36),]


str(loc)
str(sum_lalong_1)
str(loc2)
ggplot(arrival) +
  geom_point(aes(x = Latitude, y = Longtitude, color = Airport))

ggplot(depart) +
  geom_point(aes(x = Latitude, y = Longtitude, color = Airport))

ggplot(sum_lalong_1) +
  geom_point(aes(x = Latitude, y = Longtitude, group = grp))

loc2 <- read.csv("~/동아리/R문서(개인)/R을 이용한 시각화/loc.csv",header = T, stringsAsFactor = T)
loc3 <- read.csv("~/동아리/R문서(개인)/R을 이용한 시각화/loc.csv",header = T, stringsAsFactor = F)

str(loc2)
str(loc3)
loc2$Longtitude <- as.factor(loc2$Longtitude)
loc2$dec <- c(rep("depart",18),rep("arrival",18))
loc2$dec <- as.factor(loc2$dec)

  ggplot(loc2) +
  geom_point(aes(x = Latitude, y = Longtitude, color = dec)) +
  geom_line(aes(x = Latitude, y = Longtitude, group = grp, color = Airport)) +
  ggtitle("한국 -> 외국 항공편") +
  theme(plot.title = element_text(size = 14, color = "black", hjust = 0.5)) +
  scale_x_continuous(breaks = c(1000,2000,3000,4000,5000,6000,7000,8000))

  ##############################################################################
  
#범례
  iris_1 <- ggplot(data = iris) +
    geom_point(mapping = aes(x = Petal.Length, y = Petal.Width, color = Species)) +
    scale_x_continuous(breaks = c(1,2,3,4,5,6,7))
  
  iris_2<- iris_1 + theme(legend.title = element_text(size = 15, hjust = 0.5),
                          legend.text = element_text(face = "bold", size = 9, color ="red"),
                          legend.key = element_rect(color = "black", fill = "white"),
                          legend.key.size = unit(1,"cm"))
  
  grid.arrange(iris_1,iris_2,ncol = 2)    

iris_1 +
  theme(legend.position = c(0.855,0.2))


#####################################################3

# 4.연습문제 

str(imf)
imf$height <- as.numeric(as.character(imf$height))
imf$weight <- as.numeric(as.character(imf$weight))
imf$bmi <- imf$weight / ((imf$height/100)*(imf$height/100))
str(imf)

ggplot(imf) +
  geom_point(aes(x = bloodtype, y = height, color = bmi)) +
  ggtitle("혈액형별 BMI") +
  theme(plot.title = element_text(hjust = 0.5,size = 15)) +
  scale_color_continuous(name = "BMI") +
  theme(legend.box.background = element_rect(color = "black",size = 2)) +
  theme(legend.title = element_text(hjust = 0.5))



#############################################

imf$height <- as.numeric(as.character(imf$height))
imf$weight <- as.numeric(as.character(imf$weight))
imf$bmi <- imf$weight / ((imf$height/100)*(imf$height/100))

ggplot(imf) +
  geom_point(aes(x = bmi, y = height, color = bloodtype)) +
  annotate("rect", xmin = 18.5, xmax = 25, ymin = 140, ymax = 190, fill = "white", alpha = 0.2, color = "blue") +
  annotate("text", x = 21.8, y = 185, label ="표준")
  
  
####################
# 연습문제 5

data <- diamonds[diamonds$carat > 1,]
View(data)

ggplot(data) +
  geom_point(aes(x = depth, y = table,color = cut)) +
  ggtitle("등급별 다이아몬드 분포") +
  theme(plot.title = element_text(hjust = 0.5, size = 15, color = "black")) +
  scale_y_continuous(breaks = c(40,50,60,70,80,90,100)) +
  annotate("rect", xmin = 57, xmax = 60, ymin = 93.5, ymax = 97.5, fill = "white", alpha = 0.2, color = "red") +
  annotate("text", x = 65, y = 92, label = "이상값") +
  scale_color_discrete(name = "등급") +
  theme(legend.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = c(45,55,65,75))

########################################

#테마 꾸미기

ggplot(iris) +
  geom_point(aes(y = Petal.Width, x = Petal.Length, color = Species))

ggplot(iris) +
  geom_point(aes(x = Petal.Length, y = Petal.Width)) +
  facet_wrap(~Species)

ggplot(iris) +
  geom_point(aes(x = Petal.Length, y = Petal.Width)) +
  facet_wrap(~Species) +
  theme(strip.background = element_rect(fill = "white", color = "dark green")) +
  theme(strip.text.x = element_text(size = 10))

ggplot(iris, mapping = aes(x = Petal.Length, y = Petal.Width,color = Species)) +
  geom_point() +
  theme_gdocs()






