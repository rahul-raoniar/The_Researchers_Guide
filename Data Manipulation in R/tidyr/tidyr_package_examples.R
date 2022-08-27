##################################
## Package "tidyr" 
##################################
# The goal of tidyr is to help you create tidy data. Tidy data is data where:
#   
# Each variable is in a column.
# Each observation is a row.
# Each value is a cell.

install.packages("tidyr")

# or install tideyverse package that contains all tidyverse family packages such as
# dplyr
# ggplot2
# tidyr
# purr
# readr
# tibble

# install.packages("tidyverse")

library(tidyverse)




############################################################

# Package name

#    tidyr                    gather                 spread

#   reshape(2)                 melt                    cast

#   spreadsheets             unpivot                  pivot

#   databases                 fold                  unfold

##############################################################



data()



# Check all data sets




data(package = .packages(all.available = TRUE))




# View table1 dataset

table1


# Check the structure
str(table1)



#################################
# Lets start with tidyr
#################################

# Gather() function convert wider format to long format

# Example 1

table4a

table4a %>% 
  gather("1999", "2000", key = "year", value = "cases")


# Example 2: Countries population

table4b

table4b %>% 
  gather("1999", "2000", key = "year", value = "population")


# Join both datasets

tidy4a <- table4a %>% 
  gather("1999", "2000", key = "year", value = "cases")

tidy4b <- table4b %>% 
  gather("1999", "2000", key = "year", value = "population")



left_join_data <- left_join(tidy4a, tidy4b)

left_join_data


# Lets plot the combined data

str(left_join_data)

left_join_data$country <- as.factor(left_join_data$country)
left_join_data$year <- as.factor(left_join_data$year)


# Plotting Example of ggplot2

ggplot(data = left_join_data, mapping = aes(x=country, y=cases, fill=year)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_fill_manual(values = c("red", "blue")) +
  geom_text(aes(label=cases), vjust=-0.5, colour="black", position = position_dodge(0.9),
            size=3.5) + 
  ylim(0, max(left_join_data$cases)*1.1)






# spread() function convers long format to wider format


table2


# Convers long format to wide format

spread(table2, key = type, value = count)






########################
## separate()
########################

# Separate pulls apart one column into multiple columns, by splitting wherever a separator character appears.

# syntax: 

# separate(column_name, into = c("column1", "column2"))

# separate() will split values wherever it sees a non-alphanumeric character (i.e. a character that isn't a number or letter). 



table3


table3 %>% 
  separate(rate, into = c("cases", "population"))


# similarly


table_separate <- table3 %>% 
  separate(rate, into = c("cases", "population"), sep = "/")

str(table_separate)

# as we can see separated columns are chareacter type
# So to convert the columns during separation use argument convert = TRUE

table_separate_conv <- table3 %>% 
  separate(rate, into = c("cases", "population"), convert = TRUE)

str(table_separate_conv)




################################
# unite()
################################


# unite() is the inverse of separate(): it combines multiple columns into a single column.

# Syntax:

#  unite(new_column_name, column1, column2)

table5


table5 %>% 
  unite(new, century, year)











##############################
## Dealing with missing values
##############################

# Explicitly, i.e. flagged with NA.
# Implicitly, i.e. simply not present in the data

# create a tibble

stocks <- tibble(
  year   = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
  qtr    = c(   1,    2,    3,    4,    2,    3,    4),
  return = c(1.88, 0.59, 0.35,   NA, 0.92, 0.17, 2.66)
)


# View data

stocks



# Spread data

stocks %>% 
  spread(year, value = return)


# Important tool for making missing values explicit in tidy data is complete()

stocks %>% 
  complete(year, qtr)



# Fill missing values with fill()
# Missing values to be replaced by the most recent non-missing value (sometimes called last observation carried forward).

# create a tibbble

treatment <- tribble(
  ~ person,           ~ treatment, ~response,
  "Derrick Whitmore", 1,           7,
  NA,                 2,           10,
  NA,                 3,           9,
  "Katherine Burke",  1,           4
)



treatment



treatment %>% 
  fill(person)

