################
## data.table
################

#install.packages("data.table")
library(data.table)

# ** Authors of data.table package
citation("data.table")   # Matt Dowle and Arun Srinivasan


################################################
## 1. Download and check the hflights data set
################################################


#install.packages("hflights")
library(hflights) #This dataset contains all flights departing from Houston airports IAH
                  #(George Bush Intercontinental) and HOU (Houston Hobby).


# View data.frame

View(hflights)

# Check top 6 rows

head(hflights)

# Check column names

colnames(hflights)


class(hflights)


hflights <- as.data.table(hflights)

class(hflights)


######################
## data selection
######################

# Select multiple columns using data.table way

hflights[1:3, c("ArrDelay", "DepDelay")] # data.frame way


hflights[1:3, list(ArrDelay, DepDelay)] # data.table way


# Select multiple columns using .operation

hflights[1:3, .(ArrDelay, DepDelay)] # data.table way



######################
## data filtration
######################


head(hflights[hflights$ArrDelay>=45, Origin]) # data.frame way

head(hflights[ArrDelay>=45, Origin]) # data.table way


######################
## remove/omit NA values
######################

head(hflights[!is.na(hflights$ArrDelay), "ArrDelay"]) # data.frame way


head(hflights[, na.omit(ArrDelay)]) # data.table way


######################
## Add new column
######################


hflights_total_delay <- hflights[, total_delay := ArrDelay + DepDelay]
head(hflights_total_delay)


head(hflights_total_delay[total_delay>=80, ],5)


######################
## Remove column
######################


hflights_total_delay[, total_delay := NULL]


######################
## Copy entire table
######################


copied_new_data <- copy(hflights_total_delay)

class(copied_new_data)

######################
## select last flight in the dataset
######################


hflights[.N, ]




######################
## data aggregation            
######################

# df[i, j, by]

# i = row
# j = col
# by = group by



# Mean arrival delay by month

hflights[, mean(na.omit(ArrDelay)), by = Month]

# mean delay of unique carriers by month

shorted_mean_delay_by_month <- hflights[,.(mean_delay= mean(na.omit((ArrDelay+DepDelay))),
                                           N_UniqueCarrier = length(unique(UniqueCarrier))),
                                        by = Month]

shorted_mean_delay_by_month

######################
## sort as per accending and decending order
######################


shorted_mean_delay_asc <- shorted_mean_delay_by_month[order(mean_delay)]

shorted_mean_delay_asc


shorted_mean_delay_dec <- shorted_mean_delay_by_month[order(-mean_delay)]

shorted_mean_delay_dec





############################
# left join and right join
############################

x <- data.table(colour =c("red", "green", "black"), num=1:3)


y <- data.table(colour =c("red", "green", "orange"), size=c("Small", "Medium", "Large"))


x

y

# Join data tables

left_join <- merge(x, y, by = "colour", all.x = TRUE)
left_join



right_join <- merge(x, y, by = "colour", all.y = TRUE)
right_join



full_outer_join <- merge(x, y, by = "colour", all = TRUE)
full_outer_join

