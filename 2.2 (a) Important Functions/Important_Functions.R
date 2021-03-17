##################################
## Frequently used functions
##################################


## Use of length()

f <- c(1, 3, 5, 10)
length(f)



## Use of round()

g <- c(1.499, 3.55, 7.8, 1.04)
round(g)



## Use of seq()

seq(from = 10, to = 40, by = 4)


seq(from = 1, to = 2, length = 10)




## Use of rep()

rep(5, 4)

rep(c(2, 4, 5, 6), 4)

rep(c(2, 4, 5, 6), each=4)





## Use of all() and any()

y <- c(3, 8, 12, 15)

all(y>9)

all(y<21)

any(y> 7)

any(y<4)




## Use of subset()

x <- c(1, 3, 4, 6, 12, 22, 45)
subset(x, x>10)




## Use of which()

d <- c(3, -4, 2, 10, 5)

which(d*d>10)




## Use of ifelse()

gender <- c("F", "M", "F", "F", "M")
ifelse(gender=="M", 1, 2)


gender <- c("F", "M", "F", "F", "M", "I", "F", "I", "F")
ifelse(gender=="M", 1, ifelse(gender=="F", 2, 3))



# Use of apply()

data <- data.frame(c(1,2,3), c(2,3,4), c(2, 4, 6))
data


apply(data, 1, mean) # rowwise mean calculation

apply(data, 2, mean) # columnwise mean calculation


## Use of lapply()
## Used for list apply
## Returns another list

lapply(list(10:20, 20:30), median)



## Use of sapply()
## Used for simplified [l] apply
## Returns a vector or matrix

sapply(list(10:20, 20:30), median)


## Use of paste()

paste("hello", "world")


## Identify number of charecter nchar()

nchar("hello")



##################################
## Useful functions for exploring datasets
##################################

data("iris")



## Identify first 6 rows of iris data.frame using head()
head(iris)



## Identify last 6 rows of iris data.frame using tail()

tail(iris)




## Identify column names using names()

names(iris)




## Identify number of rows using nrow()

nrow(iris)




## Identify number of columns using ncol()

ncol(iris)




## Identify dimension of data set using dim()

dim(iris)




## Identify structure of dataset using str()

str(iris)




## Identify the range using range()

range(iris$Sepal.Length)




## Identify levels in Species using levels()

levels(iris$Species)



## Use of plot()

plot(x= iris$Sepal.Length, y= iris$Sepal.Width)
