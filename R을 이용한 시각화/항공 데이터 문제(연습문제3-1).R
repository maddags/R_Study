library(ggplot2)
library(tidyverse)


# 데이터 불러오기
airport <- read.csv("~/동아리/R문서(개인)/R을 이용한 시각화/airports.dat",sep = ",",header = F, stringsAsFactor = F)
route <- read.csv("~/동아리/R문서(개인)/R을 이용한 시각화/routes.dat",sep = ",",header = F, stringsAsFactor = F)
colnames(airport) <- c("Airport ID","Name","City","Country","IATA","ICAO","Latitude","Longitude","Altitude","Timezone","DST")
colnames(route) <- c("Airline","Airline ID","Source airport","Source airport ID","Destination airport","Destination airport ID","Codershare","Stops","Equipment")



#loc 데이터 만들기
list_loc <- cbind(airport$IATA,airport$IATA,airport$Latitude,airport$Longitude)
colnames(list_loc) <- c("Source airport","Destination airport","Latitude","Longitude")

korea <- airport[airport$Country == "South Korea",]
korea.dp <- route[route$`Source airport` == korea$IATA,]

korea.data <- cbind(korea.dp$Airline,korea.dp$`Source airport`,korea.dp$`Destination airport`)
colnames(korea.data) <- c("Airline","Depart","Arrival")

dp_lalong <- merge(x = korea.dp, y =list_loc, by ="Source airport")
ar_lalong <- merge(x = korea.dp, y = list_loc, by = "Destination airport")

loc <- cbind(dp_lalong$Airline,dp_lalong$`Source airport`,dp_lalong$Latitude,dp_lalong$Longitude,ar_lalong$`Destination airport`,ar_lalong$Latitude,ar_lalong$Longitude)
colnames(loc) <- c("Airline","Depart","Dp_latitude","Dp_longtitude","Arrivals","Ar_latitude","Ar_longtitude")

loc_factor <- as.data.frame(loc)
loc_non_factor <- as.data.frame(loc, stringsAsFactors = F)


# factor 유무 데이터 생성
Airport <- cbind(c(loc_factor$Depart,loc_factor$Arrivals))
Latitude <- cbind(c(loc_factor$Dp_latitude,loc_factor$Ar_latitude))
Longtitude <- cbind(c(loc_factor$Dp_longtitude,loc_factor$Ar_longtitude))
grp <- c(rep(1:18,2))
dec <- c(rep("depart",18),rep("arrival",18))
loc_factor.ver2 <- cbind(Airport,Depart,Arrival,grp,dec)
loc_factor.ver2 <- as.data.frame(loc_factor.ver2)
colnames(loc_factor.ver2) <- c("Airport","Latitude","Longtitude","grp","dec")
str(loc_factor.ver2)


Airport.ver2 <- cbind(c(loc_non_factor$Depart,loc_non_factor$Arrivals))
Latitude.ver2 <- cbind(c(loc_non_factor$Dp_latitude,loc_non_factor$Ar_latitude))
Longtitude.ver2 <- cbind(c(loc_non_factor$Dp_longtitude,loc_non_factor$Ar_longtitude))
grp <- c(rep(1:18,2))
dec <- c(rep("depart",18),rep("arrival",18))
loc_non_factor.ver2 <- cbind(Airport.ver2,Latitude.ver2,Longtitude.ver2,grp,dec)
loc_non_factor.ver2 <- as.data.frame(loc_non_factor.ver2, stringsAsFactors = F)
colnames(loc_non_factor.ver2) <- c("Airport","Latitude","Longtitude","grp","dec")
str(loc_non_factor.ver2)
loc_non_factor.ver2$Latitude <- as.numeric(loc_non_factor.ver2$Latitude)
loc_non_factor.ver2$Longtitude <- as.numeric(loc_non_factor.ver2$Longtitude)

#factor에 따른 그래프 생성

ggplot(loc_factor.ver2) +
  geom_point(aes(x = Latitude, y = Longtitude, color = dec)) +
  geom_line(aes(x = Latitude, y = Longtitude, group = grp, color = Airport)) +
  ggtitle("한국 -> 외국 항공편") +
  theme(plot.title = element_text(size = 14, color = "black", hjust = 0.5))

ggplot(loc_non_factor.ver2) +
  geom_point(aes(x = Latitude, y = Longtitude, color = dec)) +
  geom_line(aes(x = Latitude, y = Longtitude, group = grp, color = Airport)) +
  ggtitle("한국 -> 외국 항공편") +
  theme(plot.title = element_text(size = 14, color = "black", hjust = 0.5)) +
  scale_x_continuous(breaks = c(1000,2000,3000,4000,5000,6000,7000,8000))


#적절한 factor를 사용한 데이터 그래프

new_loc <- loc_non_factor.ver2 
new_loc$Longtitude <- as.factor(new_loc$Longtitude)
str(new_loc)

new_loc$Longtitude = as.numeric(as.character(Longtitude))
str(Longtitude)

ggplot(new_loc) +
  geom_point(aes(x = Latitude, y = Longtitude, color = dec)) +
  geom_line(aes(x = Latitude, y = Longtitude, group = grp, color = Airport)) +
  ggtitle("한국 -> 외국 항공편") +
  theme(plot.title = element_text(size = 14, color = "black", hjust = 0.5)) +
  scale_x_continuous(breaks = c(1000,2000,3000,4000,5000,6000,7000,8000))


new_loc %>% 
  mutate(위도 = as.numeric(Longtitude))


