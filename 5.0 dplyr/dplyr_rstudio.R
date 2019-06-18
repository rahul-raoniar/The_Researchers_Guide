

################################################
## 1. Download and check the hflights data set
################################################


#install.packages("hflights")
library(hflights)

# View data.frame

View(hflights)

# Check top 6 rows

head(hflights)

# Check column names

colnames(hflights)


################################################
## 2. Use of select()
################################################


### Load dplyr package
library(dplyr)

select_data <- select(hflights, Year, Dest, ArrDelay, DepDelay, Diverted)
head(select_data)

## Select everything using everything()

select_everything <- select(hflights, everything())
head(select_everything)

## Select Year column then in sequence AirTime to Distance and Diverted

select_type <- select(hflights, Year, AirTime:Distance, Diverted)
head(select_type)

## Select columns with phrases or words

select_by_word <- select(hflights, contains("Arr"))
head(select_by_word)

## Select columns using start_with()

select_start_with <- select(hflights, starts_with("Arr"))
head(select_start_with)

## Select columns using end_with()

select_end_with <- select(hflights, ends_with("Delay"))
head(select_end_with)




################################################
## 3. Use of filter()
################################################



## Select columns with select() and filter()

select_filter <- select(filter(hflights, ArrDelay >= 500), contains("Arr"))
head(select_filter)




################################################
## 4. Chaining operation using %>%
################################################


### Arrange in Ascending order

hflights %>% 
  arrange(DepDelay) %>% 
  head()

### Arrange in Descending order

hflights %>% 
  arrange(desc(DepDelay)) %>% 
  head()


### Arrange Arrival Delay in Ascending order and AirTime in Descending order

hflights %>% 
  arrange(ArrDelay, desc(AirTime)) %>% 
  head()




################################################
## 5. Identify unique values
################################################




## Use distinct() to identify unique values

hflights %>%
  select(Dest) %>% 
  distinct() %>% 
  head()



################################################
## 6. Adding new columns
################################################



# Use mutate() to add new column

# Create a new column Total_Delay

hflights %>% 
  select(ArrDelay, DepDelay) %>% 
  mutate(Total_Delay = ArrDelay + DepDelay) %>% 
  head()



################################################
## 7. Use of group_by() and summarise()
################################################



## Use of group_by() & summarise

hflights %>% 
  select(ArrDelay, DepDelay, Month) %>% 
  mutate(Total_Delay = ArrDelay + DepDelay) %>% 
  filter(!is.na(Total_Delay)) %>% 
  group_by(Month) %>% 
  summarise(mean(Total_Delay)) %>% 
  head()


## Use of group_by() and summarise_each()

hflights %>% 
  select(ArrDelay, DepDelay, FlightNum, Month, Distance) %>% 
  mutate(Total_Delay = ArrDelay + DepDelay) %>%
  filter(!is.na(Total_Delay)) %>%
  group_by(Month) %>% 
  summarise_each(funs(mean), Total_Delay, Distance) %>% 
  head()


################################################
## 8. Count using count()
################################################



## Count each month number of flights

hflights %>% 
  group_by(Month) %>% 
  count() %>% 
  head()


## Count and Sort each month's total flight

hflights %>% 
  group_by(Month) %>% 
  summarise(Count = n()) %>% 
  arrange(desc(Count)) %>% 
  head()



################################################
## 9. Merging datasets
################################################



x <- data.frame(color =c("red", "green", "black"), num=1:3)


y <- data.frame(color =c("red", "green", "orange"), size=c("Small", "Medium", "Large"))

x

y

## inner_join() : Join based on common observation in both "x" and "y"

inner_join(x, y)

## full_join() : Include observations that found in "x" or "y"

full_join(x, y)

## left_join() : Include all observation that found in "x"

left_join(x, y)

## right_join()  : Include all observation that found in "y"

right_join(x, y)

## semi_join()   : filter "x" observations to only show values match with "y"

semi_join(x, y)

## anti_join() : Only shows observation of "x" that don't match with "y"

anti_join(x, y)

