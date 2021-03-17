#########################################
## Data Preparation
#########################################

###############################################################

## Download data

weblink <- "http://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"

iris <- read.csv(url(weblink), header = FALSE)


###############################################################

## view data

View(iris)

###############################################################


## Name the columns

colnames(iris) <-  c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species")

colnames(iris)

names(iris)


###############################################################

## See the number of rows and number of columns

dim(iris)


###############################################################


## Detecting NA values, using apply and is.na function

apply(iris, 2, function(x) sum(is.na(x)))


###############################################################


## Identify the structure of iris data set


str(iris)


###############################################################


# Select Sepal columns

sepal_cols <- iris[, c("Sepal.Length", "Sepal.Width")] 

head(sepal_cols)





## Select Petal columns

petal_cols <- iris[, c(3,4)]

head(petal_cols)




## Select first four rows of Sepal.Length column


iris[1:4, "Sepal.Length"]






## Select first four rows with all columns

iris[1:4, ]





## Select virginica with all columns


virginica <- iris[iris$Species=="Iris-virginica", ]

head(virginica)


###############################################################

## Data subset 

# subset data with versicolor species

versicolor <- subset(iris, Species=="Iris-versicolor")

head(versicolor)




## Conditional subsetting


cond_subset <- subset(iris, Sepal.Length <= 5 & Petal.Width >= 0.1)

head(cond_subset)




## Conditional subsetting


cond_subset1 <- subset(iris, Sepal.Length <= 5 & Petal.Width >= 0.1, select = Species)

head(cond_subset1)


###############################################################


## Data ordering

# Ascending order

ascending <- iris[order(iris$Petal.Length),]

head(ascending)

# descending order

descending <- iris[order(iris$Petal.Length, decreasing = TRUE),]

head(descending)


###############################################################


## merging dataset

# Create a new column with column name " Id " and assigning values 1 to 150

iris_id <- iris
iris_id$Id <- 1:150    # Generate Id: 1 to 150

head(iris_id)


# Create two data subsets with a common variable ( "Id" )

sepal_data <- subset(iris_id, select = c("Sepal.Length", "Sepal.Width", "Id"))

petal_data <- subset(iris_id, select = c("Petal.Length", "Petal.Width", "Id"))


# Merge the two subsets

merged_data <- merge(sepal_data, petal_data, by = "Id")

head(merged_data)


###############################################################

## Adding new row

iris1 <- rbind(iris, c("5.3","3.3", "1.3", "0.3", "Iris-setosa" ))

nrow(iris1)   # Check numbers of rows


####################################################################


## Dropping a column

# Drop column using index

iris2 <- iris_id[ , -6]
head(iris2)

# Dropping column by assigning NULL

iris_id$Species <- NULL

head(iris_id)

# Use within() to remove attributes

iris4 <- within(iris, rm(Sepal.Length))

head(iris4)
