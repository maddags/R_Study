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

iris_var_sepal_Length <- c(var(setosa$Sepal.Length),var(versicolor$Sepal.Length),var(virginica$Sepal.Length))
iris_var_sepal_Width <- c(var(setosa$Sepal.Width),var(versicolor$Sepal.Width),var(virginica$Sepal.Width))
iris_var_petal_Length <- c(var(setosa$Petal.Length),var(versicolor$Petal.Length),var(virginica$Petal.Length))
iris_var_petal_Width <- c(var(setosa$Petal.Width), var(versicolor$Petal.Width), var(virginica$Petal.Width))

iris_sd_sepal_Length <- c(sd(setosa$Sepal.Length),sd(versicolor$Sepal.Length),sd(virginica$Sepal.Length))
iris_sd_sepal_Width <- c(sd(setosa$Sepal.Width),sd(versicolor$Sepal.Width),sd(virginica$Sepal.Width))
iris_sd_petal_Length <- c(sd(setosa$Petal.Length),sd(versicolor$Petal.Length),sd(virginica$Petal.Length))
iris_sd_petal_Width <- c(sd(setosa$Petal.Width), sd(versicolor$Petal.Width), sd(virginica$Petal.Width))

iris_var <- data.frame(iris_var_sepal_Length,iris_var_sepal_Width,iris_var_petal_Length,iris_var_petal_Width)
colnames(iris_var) <- c("sepal.Length", "sepal.width","petal.Length","petal.width")
rownames(iris_var)<- c("setosa", "versicolor","virginica")
iris_var

iris_sd <- data.frame(iris_sd_sepal_Length,iris_sd_sepal_Width,iris_sd_petal_Length,iris_sd_petal_Width)
colnames(iris_sd) <- c("sepal.Length", "sepal.width","petal.Length","petal.width")
rownames(iris_sd)<- c("setosa", "versicolor","virginica")
iris_sd
