#########################################
## Line Graph
#########################################

###################################################################
## Palette combinations can be used under scale_fill_brewer( )
###################################################################
## A. Diverging ---->
#BrBG, PiYG, PRGn, PuOr, RdBu, RdGy, RdYlBu, RdYlGn, Spectral

## B. Qualitative ---->
# Accent, Dark2, Paired, Pastel1, Pastel2, Set1, Set2, Set3

## C. Sequential ---->
# Blues, BuGn, BuPu, GnBu, Greens, Greys, Oranges, OrRd, PuBu, PuBuGn, PuRd, Purples, RdPu, Reds, YlGn, YlGnBu, YlOrBr, YlOrRd

####################################################################

library(ggplot2)

data(BOD)

BOD

str(BOD)

# 1. Making a Basic Line Graph

# Line graph with continous variable

ggplot(data=BOD, mapping = aes(x=Time, y = demand)) +
  geom_line()

# Line graph with discrete variable
# Convert time to a factor value
# aes(group=1) mainly used to tell ggplot that data points belongs together and should be connected with a line

ggplot(BOD, mapping = aes(x=factor(Time), y=demand, group=1)) +
  geom_line()


# 2. Making a Line Graph with Multiple Lines

# Summarize the dataset1 speed data

library(readxl)
dataset1 <- read_excel("E:/My documents/Youtube_Channel/Video/6.0 ggplot2/Line_plot/dataset1.xlsx")
View(dataset1)


library(dplyr)

testset1 <- dataset1 %>% 
  group_by(vehicle_type, road_width) %>% 
  summarise(speed=mean(speed))



# Maping vehicle_type to colour

ggplot(data = testset1, mapping = aes(x=road_width, y=speed, colour=vehicle_type)) + geom_line()



# Maping vehicle_type to linetype

ggplot(testset1, mapping = aes(x=road_width, y=speed, linetype=vehicle_type)) + geom_line()



# Treat road_width as a factor due to value 3.75, 7.0 and 10.5

ggplot(testset1, mapping = aes(x=factor(road_width), y=speed, colour=vehicle_type, group=vehicle_type)) + geom_line()




## If your plot has points along with the lines, you can also map variables to properties of the points, such as shape and fill

ggplot(data = testset1, mapping=aes(x=road_width, y=speed, shape=vehicle_type)) + geom_line() +
  geom_point(size=3) # Make the points a little larger

ggplot(data = testset1, mapping = aes(x=road_width, y=speed, fill=vehicle_type)) + geom_line() +
  geom_point(size=3, shape=22) # Also use a square point with a color fill



# Removing overlapping of points by dodge
# Shift both line and point to left or right


ggplot(data = testset1, mapping = aes(x=road_width, y=speed, fill=vehicle_type)) +
  geom_line(position = position_dodge(0.5)) +   # Dodge lines by 0.5
  geom_point(position = position_dodge(0.5), shape=21, size=4) 

















# 3.0 Changing the Appearance of Lines

BOD

# The type of line (solid, dashed, dotted, etc.) is set with linetype, the thickness (in mm) with size, and the color of the line with colour.

ggplot(data = BOD, mapping = aes(x=Time, y=demand)) +
  geom_line(linetype="dotted", size=1, colour="red")


## Set palette colour to change the default colour

ggplot(data = testset1, mapping = aes(x=road_width, y=speed, colour=vehicle_type)) +
  geom_line() +
  scale_color_brewer(palette="Set2")


# If both lines have the same properties, you need to specify a variable to use for grouping

ggplot(data = testset1, mapping = aes(x=road_width, y=speed, group=vehicle_type)) +
  geom_line(colour="darkgreen", size=1.5)


ggplot(data = testset1, mapping = aes(x=road_width, y=speed, colour=vehicle_type)) +
  geom_line(linetype="dashed") +
  geom_point(shape=21, size=4, fill="white") # shape=21 is for circular points













# 4.0 Changing the Appearance of Points
data(BOD)

View(BOD)

View(testset1)

ggplot(data = BOD, mapping = aes(x=Time, y=demand)) +
  geom_line() +
  geom_point(size=4, shape=21, colour="darkred", fill="pink")


# Use geom_line() before geom_point() so that geom_points overlap the lines and at the point line could not appear

ggplot(data = BOD, mapping=aes(x=Time, y=demand)) + # point overlap lines
  geom_line() +
  geom_point(size=4, shape=21, fill="white")


ggplot(BOD, mapping=aes(x=Time, y=demand)) + # Lines overlap points
  geom_point(size=4, shape=21, fill="white") +
  geom_line()


# To set a single constant shape or size for all the points, specify shape or size outside of aes():


ggplot(data = testset1, mapping = aes(x=road_width, y=speed, fill=vehicle_type)) +
  geom_line(position = position_dodge(0.2)) + 
  geom_point(shape=21, size=3, position=position_dodge(0.2)) + 
  scale_fill_manual(values=c("green", "white", "red"))













###########
# 5.0 Making a Graph with a Shaded Area
###########

# sunspot.year dataset contains yearly numbers of sunspots from 1700 to 1988

data(sunspot.year)

str(sunspot.year)


# Use geom_area( )
# Convert sunspot.year data to a data frame

data_sunspotyear <- data.frame(
  Year = as.numeric(time(sunspot.year)), # time creates the vector of times at which a time series was sampled
  Sunspots = as.numeric(sunspot.year) # This include sunspot data
)


ggplot(data = data_sunspotyear, mapping = aes(x=Year, y=Sunspots)) +
  geom_area()


# Fill a different colour say blue using fill = "blue"
# Make it 70% transparent by setting alpha = 0.3
# Make a black outline using colour = "black"

ggplot(data = data_sunspotyear, mapping = aes(x=Year, y=Sunspots)) +
  geom_area(colour = "black", fill="blue", alpha=0.3)


# Remove side and bottom line boundaries
# To avoid this issue, we can draw the area without an outline (by not specifying colour), and then layer a geom_line() on top,


ggplot(data = data_sunspotyear, mapping = aes(x=Year, y=Sunspots)) +
  geom_area(fill="blue", alpha=0.3) +
  geom_line()
















# 6.0 Making a Stacked Area Graph
# Use geom_area() and map a factor to fill

install.packages("gcookbook")

library(gcookbook)

# uspopage dataset which contains age distribution of population in the United States, 1900-2002
uspopage 

str(uspopage)

ggplot(data=uspopage, mapping=aes(x=Year, y=Thousands, fill=AgeGroup)) +
  geom_area()

# Reverse the legend
# Add blue colour or fill
# Add thin line (size = 0.2) between each area
# Make colour semi-transparent using (alpha = 0.4)

ggplot(data=uspopage, mapping=aes(x=Year, y= Thousands, fill=AgeGroup)) +
  geom_area(colour = "black", size=0.2, alpha=0.4) +
  scale_fill_brewer(palette = "Blues", breaks=rev(uspopage$AgeGroup))


# Reverse the stacking order 
# We'll put position = position_stack(reverse = TRUE) inside of geom_area()


ggplot(data=uspopage, mapping = aes(x=Year, y=Thousands, fill=AgeGroup)) +
  geom_area(colour="black", size=0.2, alpha=0.4, position = position_stack(reverse = TRUE)) +
  scale_fill_brewer(palette = "Blues")


# Reverse the legend order using breaks = rev(uspopage$AgeGroup) inside scale_fill_brewer()
# Reverse the stacking order
# we'll put position = position_stack(reverse = TRUE) inside of geom_area()

ggplot(data=uspopage, mapping = aes(x=Year, y=Thousands, fill=AgeGroup)) +
  geom_area(colour="black", size=0.2, alpha=0.4, position = position_stack(reverse = TRUE)) +
  scale_fill_brewer(palette = "Blues", breaks=rev(uspopage$AgeGroup))

# Or
# Reverse the legend order using guides(fill=guide_legend(reverse=TRUE))
# Reverse the stacking order
# we'll put position = position_stack(reverse = TRUE) inside of geom_area()

ggplot(data=uspopage, mapping = aes(x=Year, y=Thousands, fill=AgeGroup)) +
  geom_area(colour="black", size=0.2, alpha=0.4, position = position_stack(reverse = TRUE)) +
  scale_fill_brewer(palette = "Blues") + 
  guides(fill=guide_legend(reverse=TRUE))


# Since each filled area is drawn with a polygon, the outline includes the left and right sides. This might be distracting or misleading.
# To get rid of it first draw the stacked areas without an outline (by leaving colour as the default NA value), and then add a geom_line() on top:

ggplot(data=uspopage, mapping=aes(x=Year, y=Thousands, fill=AgeGroup)) +
  geom_area(colour=NA, alpha=0.4) + # colour = NA means no closed polygon and no lines on the right or left of the graph
  scale_fill_brewer(palette="Blues") +
  geom_line(position = "stack", size=0.2)



#################
## 7.0 Making a Proportional Stacked Area Graph
#################

# Using dplyr package
library(dplyr)

uspopage_prop_dplyr <- uspopage %>% 
  group_by(Year) %>% 
  mutate(percent = Thousands/sum(Thousands)*100)


ggplot(data = uspopage_prop_dplyr, mapping = aes(x = Year, y = percent, fill = AgeGroup)) +
  geom_area(colour = "black", size = .2, alpha = 0.4) +
  scale_fill_brewer(palette = "Blues")
