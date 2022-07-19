iris

getmode <- function(x){
  x <- table(x)
  mod <- as.numeric(names(which(max(x) == x[])))
  if (length(as.numeric(names(x))) == length(mod)){
    print(NULL)
  }
  else{
    mod
  }
}

setosa <- iris[iris$Species == "setosa",1:4]
versicolor <- iris[iris$Species == "versicolor",1:4]
virginica <- iris[iris$Species == "virginica",1:4]

iris_mean_sepal.Length <- c(mean(setosa$Sepal.Length), mean(versicolor$Sepal.Length), mean(virginica$Sepal.Length))

iris_median_sepal.Length <- c(median(setosa$Sepal.Length), median(versicolor$Sepal.Length), median(virginica$Sepal.Length))

iris_mode_sepal.Length <- c(getmode(setosa$Sepal.Length), getmode(versicolor$Sepal.Length), getmode(virginica$Sepal.Length))

iris_mean_sepal.width <- c(mean(setosa$Sepal.Width), mean(versicolor$Sepal.Width), mean(virginica$Sepal.Width))

iris_median_sepal.width <- c(median(setosa$Sepal.Width), median(versicolor$Sepal.Width), median(virginica$Sepal.Width))

iris_mode_sepal.width <- c(getmode(setosa$Sepal.Width), getmode(versicolor$Sepal.Width), getmode(virginica$Sepal.Width))

iris_mean_petal.Length <- c(mean(setosa$Petal.Length), mean(versicolor$Petal.Length), mean(virginica$Petal.Length))

iris_median_petal.Length <- c(median(setosa$Petal.Length), median(versicolor$Petal.Length), median(virginica$Petal.Length))

iris_mode_petal.Length <- c(getmode(setosa$Petal.Length), getmode(versicolor$Petal.Length), getmode(virginica$Petal.Length))

iris_mean_petal.width <- c(mean(setosa$Petal.Width), mean(versicolor$Petal.Width), mean(virginica$Petal.Width))

iris_median_petal.width <- c(median(setosa$Petal.Width), median(versicolor$Petal.Width), median(virginica$Petal.Width))

iris_mode_petal.width <- c(getmode(setosa$Petal.Width), getmode(versicolor$Petal.Width), getmode(virginica$Petal.Width))


iris_mode_petal.Length

iris_mean <- data.frame(iris_mean_sepal.Length,iris_mean_sepal.width,iris_mean_petal.Length,iris_mean_petal.width)
colnames(iris_mean) <- c("sepal.Length", "sepal.width","petal.Length","petal.width")
rownames(iris_mean)<- c("setosa", "versicolor","virginica")


iris_median <- data.frame(iris_median_sepal.Length,iris_median_sepal.width,iris_median_petal.Length,iris_median_petal.width)
colnames(iris_median) <- c("sepal.Length", "sepal.width","petal.Length","petal.width")
rownames(iris_median)<- c("setosa", "versicolor","virginica")
iris_median

iris_mode_sepal.width <- c(3.4,"", 3.0, "" ,"", 3.0)
iris_mode_petal.width <- c(0.2, "", 1.3, "", "", 1.8)
iris_mode_petal.Length <- c(1.4, 1.5,4.5, "", "", 5.1)
iris_mode <- data.frame(iris_mode_sepal.Length,iris_mode_sepal.width,iris_mode_petal.Length,iris_mode_petal.width)
colnames(iris_mode) <- c("sepal.Length", "sepal.width","petal.Length","petal.width")
rownames(iris_mode)<- c("setosa","","versicolor"," ","   ","virginica")
iris_mode
