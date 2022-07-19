library(readxl)
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
library(mapproj)
library(raster)


View(data1)
#[raw,col]
#raw는 전부다 col은 원하는 col를 뽑아야함.
data1[-c(1:2),c(2,3)]
View(data1[-c(1,2),])
View(data1[-28,])
View(data1[-c(1,2,28),])
View(data1[,-c(5,8,11)])
ver.1 <- data1[-c(1,2,28),-c(1,5,8,11)]
View(ver.1)
#지역별 초중고 그래프로 나타내기


ggplot(iris) +
  geom_point(mapping = aes(x = Sepal.Length, y = Sepal.Width, color = Species))

ggplot(iris) +
  geom_point(mapping = aes(x = Sepal.Length, y = Sepal.Width, color = Petal.Width))

View(ver.1)

ggplot(ver.1) +
  geom_bar(mapping = aes(x = 지역, y = 초등학교...3, color = 지역), stat = "identity")


a1<-ggplot(data=ver.1) +
  geom_bar(mapping=aes(x=지역, y=초등학교...3, fill=지역), stat="identity") +
  ggtitle(label="지역별 초등학생수") +
  theme(plot.title = element_text(size=20, hjust=0.5)) +
  labs(y="학\n생\n수")+
  theme(axis.title.y  = element_text(angle = 0 , vjust = 0.5 ))+
  theme(legend.position = "none")+
  theme(axis.text.x = element_text(angle = 45, vjust = 0.6 , size = 8))
a2<-ggplot(data=ver.1) +
  geom_bar(mapping=aes(x=지역, y=중학교...6, fill=지역), stat="identity") +
  ggtitle(label="지역별 중학생수") +
  theme(plot.title = element_text(size=20, hjust=0.5)) +
  labs(y="학\n생\n수")+
  theme(axis.title.y  = element_text(angle = 0 , vjust = 0.5 ))+
  theme(legend.position = "none")+
  theme(axis.text.x = element_text(angle = 45, vjust = 0.6 , size= 8))
a3<-ggplot(data=ver.1) +
  geom_bar(mapping=aes(x=지역, y=고등학교...9, fill=지역), stat="identity") +
  theme_hc() +
  ggtitle(label="지역별 고등학생수") +
  theme(plot.title = element_text(size=20, hjust=0.5)) +
  labs(y="학\n생\n수")+
  theme(axis.title.y  = element_text(angle = 0 , vjust = 0.5 ))+
  theme(legend.position = "none")+
  theme(axis.text.x = element_text(angle = 45, vjust = 0.6,size = 8 ))

a3

library(ggthemes)
library(gridExtra)
grid.arrange(a1,a2,a3, ncol = 3)
ver.1$초등학교...3 <- as.numeric(ver.1$초등학교...3)
ver.1$중학교...6 <- as.numeric(ver.1$중학교...6)
ver.1$고등학교...9 <- as.numeric(ver.1$고등학교...9)


#
View(ver.1)
ver.1$초등학교...3 <- as.numeric(ver.1$초등학교...3)
ver.1$중학교...6 <- as.numeric(ver.1$중학교...6)
ver.1$고등학교...9 <- as.numeric(ver.1$고등학교...9)

ver.1$초등학교수비율 <- round((ver.1$초등학교...3 / sum(ver.1$초등학교...3)) * 100, 2)
ver.1$중학교수비율 <- round((ver.1$중학교...6 / sum(ver.1$중학교...6)) * 100,2)
ver.1$고등학교수비율 <- round((ver.1$고등학교...9 / sum(ver.1$고등학교...9)) * 100,2)

pie(ver.1$초등학교...3,label = paste(ver.1$지역,"\n",ver.1$초등학교수비율,"%"))

ver.2 <- read.csv("C:/Users/madda/Documents/동아리/R문서(개인)/R공부/Ver.1.csv")
View(ver.2)
str(ver.2)

ct <- ver.2[ver.2$지역분류 == "중앙",]
ct<- sum(ct$초등학교수비율)
ne <- ver.2[ver.2$지역분류 == "북동",]
ne <- sum(ne$초등학교수비율)           
nw <- ver.2[ver.2$지역분류 == "북서",]
nw <- sum(nw$초등학교수비율)
sw <- ver.2[ver.2$지역분류 == "남서",]
sw <- sum(sw$초등학교수비율)
se <- ver.2[ver.2$지역분류 == "남동",]
se <- sum(se$초등학교수비율)


ratio <- c(ct,ne,nw,se,sw)
ratio_name<- c("중앙","북동","북서","남동","남서")
pie(ratio, label = paste(ratio_name,"\n",ratio,"%"), cex = 0.9,col = rainbow(length(ratio)))


a3 + coord_polar()

#####
register_google("AIzaSyDtnZaVt1HnJJECViCLH7vOAAlK5OLpZAg")
korea <- getData("GADM", country = " kor", level = 2)
korea <- shapefile("TL_SCCO_SIG.shp")
korea <- fortify(korea, region = "SIG_CD")

ggplot() +
  geom_polygon(data = ver.2)

