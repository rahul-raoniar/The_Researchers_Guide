#######################################
## Importing data in R
#######################################

# Types: Flat files, Excel files, Databases, Web, Statistical Softwares

#########################################
## 1. Reading data with base package
#########################################


# Setting working directory

setwd("E:/Documents/Youtube_Channel/Video/3.0 Download Data/Loading Data in R 2/Data_import")
getwd()

###############################################
# Reading data with comma separated values using read.csv()
###############################################

# utils


iris_data <- read.csv("iris_CSV.csv")
head(iris_data)
str(iris_data)

# stringsAsFactors tells whether we need to conver stings to factors while 
# importing
# Here default set to, header = TRUE and sep = ",", dec = "." 

iris_data <- read.csv("iris_CSV.csv", stringsAsFactors = FALSE) 
head(iris_data)
str(iris_data)

# There is another function read.csv2()
# Where default is header = TRUE, sep = ";", dec = ","

#########################################
# Reading tab separated .txt file with read.delim()
# by default it set to tab separated with sep = "\t" 
# Also header = TRUE, dec = "."
# If header set to FALSE then R by default assing column names

# Reading with header
iris_tab <- read.delim("iris_TSV.txt")
head(iris_tab)



# Reading with out header dataset
# Default: header = TRUE; sep = "\t"; dec = "."
# Set header to FALSE

iris_tab_wwh <- read.delim("iris_wwh_TSV.txt", header = FALSE)
head(iris_tab_wwh)

str(iris_tab_wwh)

# Adding column classes
iris_tab_wwh <- read.delim("iris_wwh_TSV.txt", header = FALSE, 
                       col.names = c("Sepal.Length", "Sepal.Width",
                                     "Petal.Length", "Petal.Width", 
                                     "Species"),
                       colClasses = c("numeric", "numeric", "numeric",
                                      "numeric", "character"))

str(iris_tab_wwh)

###############################################
## Reading different types of files using primary reading function 
# read.table()
# here default: header = FALSE; sep = ""; dec = "."

path <- file.path("E:/Documents/Youtube_Channel/Video/3.0 Download Data/Loading Data in R 2/Data_import",
                  "iris_wwh_TSV.txt")
path


iris_headerF <- read.table(path, sep = "\t")
head(iris_headerF)

iris_with_col <- read.table(path, sep = "\t", 
                            col.names = c("Sepal.Length", "Sepal.Width",
                                          "Petal.Length", "Petal.Width", 
                                          "Species"))

head(iris_with_col)












####################################
## 2. Data importing using readr and data.table package 
####################################

# Setting working directory

setwd("E:/Documents/Youtube_Channel/Video/3.0 Download Data/Loading Data in R 2/Data_import")
getwd()

# install.packages("readr")
# load readr library

library(readr)

# Author: Hadley Wickham and Jim Hester and Romain Francois

# Reading comma separated values
# default col_names = TRUE; skip = 0, n_max = Inf 
# skip: Number of lines to skip before reading data.
# n_max: Maximum number of records to read.

iris_data <- read_csv("iris_CSV.csv")
head(iris_data)
str(iris_data)


# Reading tab separated values
# default col_names = TRUE; skip = 0, n_max = Inf 
# Adding column names

# default col_names = TRUE and 
iris_tab_wwh <- read_tsv("iris_wwh_TSV.txt", 
                         col_names = c("Sepal.Length", "Sepal.Width",
                                       "Petal.Length", "Petal.Width", 
                                       "Species"))

head(iris_tab_wwh)


###############################################
## Reading different types of files using primary reading function 
# read_delim()
# default col_names = TRUE; skip = 0, n_max = Inf 


path <- file.path("E:/Documents/Youtube_Channel/Video/3.0 Download Data/Loading Data in R 2/Data_import",
                  "iris_wwh_TSV.txt")
path

# without column names
iris_headerF <- read_delim(path, delim = "\t", col_names = F)
head(iris_headerF)


# with column names
iris_with_col <- read_delim(path, delim = "\t", 
                            col_names = c("Sepal.Length", "Sepal.Width",
                                          "Petal.Length", "Petal.Width", 
                                          "Species"))

head(iris_with_col)





# skip and n_max arguments
head(iris)

columns <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", 
             "Species")

iris_tab_wwh_skip_nmax <- read_tsv("iris_wwh_TSV.txt",
                                   skip = 4,
                                   n_max=100,
                                   col_names = columns)

dim(iris_tab_wwh_skip_nmax)

head(iris_tab_wwh_skip_nmax)

str(iris_tab_wwh_skip_nmax)

# Adding column types
# where, n = numeric, c = character, l = logical, f = factor

iris_tab_wwh_col_types <- read_tsv("iris_wwh_TSV.txt",
                                   col_types = c("nnnnf"),
                                   col_names = columns)
str(iris_tab_wwh_col_types)


# data.table's fread() function
# Author: Matt Dowle and Arun Srinivasan

library(data.table)

# One of the fastest available function to read data
# Default header = "auto"
# stringsAsFactors = FALSE
# select and drop arguments are available
# Here the output data frame will be of data.table class

x <- fread("iris_CSV.csv", drop = 2:4)
x

str(x)

fread("iris_CSV.csv", drop = c("Sepal.Width", "Petal.Length",
                               "Petal.Width"))

## or

fread("iris_CSV.csv", select = c(1, 5))

fread("iris_CSV.csv", select = c("Sepal.Length", "Species"))











##############################################
## 3. Reading Excel files using "readxl" package
##############################################

# .xls Vs .xlsx

# a) The main difference between these two file extensions is 
#    that the XLS is created on the version of Excel prior to 2007 
#    while XLSX is created on the version of Excel 2007 and onward.

# b) They are also different on the basis of information storing way.
#    XLS is a binary format while that XLSX is Open XML format.


# Setting working directory

setwd("E:/Documents/Youtube_Channel/Video/3.0 Download Data/Loading Data in R 2/Data_import")
getwd()

# install.packages("readxl")
library(readxl)

# Authors: Hadley Wickham and Jennifer Bryan

# Printing names all worksheet

excel_sheets("iris_Excel.xlsx")


# Reading excel sheets

# Read the sheets, one by one
iris_150 <- read_excel("iris_Excel.xlsx", sheet = 1)
iris_100 <- read_excel("iris_Excel.xlsx", sheet = "iris_100")


iris_list <- list(iris_150, iris_100)
str(iris_list)



# Download using path and lapply

path <- file.path("E:/Documents/Youtube_Channel/Video/3.0 Download Data/Loading Data in R 2/Data_import",
                  "iris_EXCEL.xlsx")
path

# lapply() helps in applying a function itteratively on a vector (atomic or list) 
# The output of lapply is a list irrespective of input data structure

iris_list_lapply <- lapply(excel_sheets("iris_Excel.xlsx"), 
                           read_excel,
                           path = path)

str(iris_list_lapply)


# map() function of purrr package
# map() function returns a list

library(purrr)

iris_list_map <- map(excel_sheets("iris_Excel.xlsx"),
                           read_excel,
                           path = path)

str(iris_list_map)




# Import the first Excel sheet 
# with externally specifying column name
# Skipping first 20 rows

columns <- c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", 
             "Species")

iris_wwh_col_names_excel <- read_excel("iris_wwh_Excel.xlsx",
                                sheet = 1,
                                col_names = columns,
                                skip = 20)

str(iris_wwh_col_names_excel)











######################################
## 4. Reading data from web
######################################

# import the csv file directly into R seassion
# Connecting to HTTPS (secure) connection also possible

url_csv <- "https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"

coln <- c("Sepal.Length", "Sepal.Width", "Petal.Length",
          "Petal.Width", "Species")


# Base R function read.csv() & read.delim() both able to
# featch files from web



iris_base <- read.csv(url_csv, header = FALSE, col.names = coln)

dim(iris_base)
head(iris_base)

# Load the readr package
library(readr)

# readr package's read_csv() & read_tsv() both able to
# featch files from web

iris_readr <- read_csv(url_csv, col_names = coln)

head(iris_readr)


##################################################
# Downloading any file whether it is secure or not
##################################################


setwd("E:/Documents/Youtube_Channel/Video/3.0 Download Data/Loading Data in R 2/Data_import")
getwd()

# https URL to the iris csv file.
url_data_link <- "https://github.com/rahul-raoniar/Rahul_CODIFY/blob/master/iris_EXCEL.xlsx?raw=true"

# Download the iris file in your working directory
download.file(url_data_link, "iris_download.xlsx", mode = "wb")


library(readxl)

# Load the iris_download.csv file into your workspace using load()

iris_download <- read_excel("iris_download.xlsx")


head(iris_download)
