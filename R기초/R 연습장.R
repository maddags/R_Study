bloodtype <- c("A","B","O","AB","B","A","B","AB","A","A")
gender <- c("M","M","F","F","F","M","M","M","M","F")
height <- c(178,185,169,160,170,160,156,163,185,149)
weight <- c(79,89,56,50,74,84,57,49,87,78)

data.frame(bloodtype, stringsAsFactors = F)
data.frame(gender, stringsAsFactors = F)
data.frame(height, stringsAsFactors = F)
data.frame(weight, stringsAsFactors = F)

imf <- cbind(bloodtype,gender,height,weight)
imf

rownames(imf) <- c("NO1","NO2","NO3","NO4","NO5","NO6","NO7","NO8","NO9","NO10")
imf

imf <- as.data.frame(imf, stringAsFactor = F)
str(imf)

imf <- rbind(imf,add_person)

rank <- c("S","A","B","C")
score <- c(4.5,4.0,3.5,3.0)

levels(imf$height)
record <- cbind(rank,score)
record <- as.data.frame(record)
record

new_data <- c("D",2.5)
record <- rbind(record,new_data)
record

str(imf)



male_mean_height <- mean(imf$height[imf$gender == "M"])
female_mean_heigth <- mean(imf$heigth[imf$gender == "F"])

