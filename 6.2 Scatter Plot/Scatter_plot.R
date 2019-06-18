###############
## Scatter Plot
###############

# Import ggplot2

library(ggplot2)



# Import mtcars Data

mtcars



# Dataset description

# mpg	 Miles/(US) gallon
# cyl	 Number of cylinders
# disp	 Displacement (cu.in.)
# hp	 Gross horsepower
# drat	 Rear axle ratio
# wt	 Weight (1000 lbs)
# qsec	 1/4 mile time
# vs	 V/S
# am	 Transmission (0 = automatic, 1 = manual)
# gear	 Number of forward gears
# carb	 Number of carburetors

str(mtcars)

new_data <- mtcars





######################
# 1.0 make basic scatter plot
######################


ggplot(data = new_data, mapping = aes(x = wt, y = mpg)) +
  geom_point()





# Change the point shapes

ggplot(data = new_data, mapping = aes(x = wt, y = mpg)) +
  geom_point(shape = 7)





# change the point size

ggplot(data = new_data, mapping = aes(x = wt, y = mpg)) +
  geom_point(shape = 19, size = 3)





# Group data points by assigning a variable to shape or colour

# With shape

ggplot(data = new_data, mapping = aes(x = wt, y = mpg, shape = as.factor(am))) +
  geom_point(size = 3)




# With Colour
ggplot(data = new_data, mapping = aes(x = mpg, y = wt, colour = as.factor(am))) +
  geom_point(size=3)
  







#####################
## 2.0 Adding different point shapes, colour and fill
#####################

# Import ggplot2 library

library(ggplot2)

# Assing mtcars data set to a variable new_data

new_data <- mtcars







# Include am to both shape and colour

ggplot(data = new_data, mapping = aes(x = mpg, y = wt,
                                      shape = as.factor(am),
                                      colour = as.factor(am))) +
  geom_point(size=3)




# Change the shape using scale_shape_manual()

ggplot(data=new_data, mapping = aes(x=mpg, y=wt, shape=as.factor(am))) +
  geom_point(size=3) +
  scale_shape_manual(values = c(7, 8))



# Costomize shape and colour
# Use shape and color
# Change default colour to user defined colours

ggplot(data = new_data, mapping = aes(x = mpg, y = wt,
                                      shape = as.factor(am),
                                      colour = as.factor(am))) +
  geom_point(size=3) +
  scale_shape_manual(values = c(19, 18)) +
  scale_colour_manual(values = c("red", "blue"))
  








# Map different categorical variables to shape and fill

ggplot(data=new_data, mapping = aes(x=mpg, y=wt, shape=as.factor(am), fill=as.factor(gear))) +
  geom_point(size=2.5) +
  scale_shape_manual(values = c(21, 22)) + # Shape with fill and colour
  scale_fill_manual(values=c("green", "red", "blue"), guide= guide_legend(override.aes = list(shape= 21))) +
  theme_bw()








########################
# 3.0 Use continous variables in colour and size
########################

# Import ggplot2 library

library(ggplot2)


# Assing mtcars data set to a variable new_data

new_data <- mtcars




# With respect to colour

ggplot(data = new_data,
       mapping = aes(x=mpg, y=wt, colour= hp)) +
  geom_point(size = 3)




# With respect to size

ggplot(data = new_data,
       mapping = aes(x=mpg, y=wt, size= hp)) +
  geom_point(shape=22)





# By default the sizes of points go from 1 to 6 mm.

ggplot(data=new_data, mapping = aes(x=mpg, y=wt, fill= hp)) +
  geom_point(shape=22, size=3) +
  scale_fill_gradient(low = "red", high = "white")



# Plot continous variable to size and categorical variable to colour
# Add hp to size
# Add gear to colour
# make points semi transparent using alpha = 0.4
# use scale_size_area() to make area of points proportional to the values

ggplot(data=new_data, mapping=aes(x=mpg, y=wt,
                                      size=hp,
                                      colour=as.factor(gear))) +
  geom_point(alpha=0.4) +
  scale_size_area() +
  scale_colour_manual(values = c("red", "blue", "green"))









####################
## 4.0 Analyzing overplotted scatter plots
####################

# Overplotting can caused by variables when plot on one or both axes
# The jitter geom is a convenient way to add 
# Small amount of random variation to the location of each point
# Jitter add smaller variation along width and height
# By default the amount of jitter is 40% of the resolution of the data in each directions

# Import ggplot2 library

library(ggplot2)

# Assing mtcars data set to a variable new_data

new_data <- mtcars






new_plot <- ggplot(data = new_data,
                   mapping = aes(x = as.factor(gear), y = mpg,
                                 colour = as.factor(am))) +
  geom_point(size = 2.5)




new_plot




# jitter the points

new_plot + geom_point(position = "jitter")





# or use geom_jitter()

new_plot + geom_jitter()





# Adjusting the height and width of jitter points

new_plot + geom_point(position = position_jitter(width=0.2, height=0.2))



# Or we can do it by

new_plot + geom_jitter(width = 0.2, height = 0.2)










#########################
## 5.0 Box plot
#########################


# When One variable is descrete and another is continous
# Then it is better to go for a box plot

# Import ggplot2 library

library(ggplot2)


# Assing mtcars data set to a variable new_data

new_data <- mtcars




ggplot(data = new_data, mapping = aes(x = as.factor(gear), y = mpg)) +
  geom_boxplot()





# Map a third categorical variable i.e. "am" to colour

ggplot(data = new_data, mapping = aes(x = as.factor(gear), y = mpg)) +
  geom_boxplot(aes(colour = as.factor(am)))





# Add a jittered points to box plot

ggplot(data = new_data, mapping = aes(x = as.factor(gear), y = mpg)) +
  geom_boxplot() +
  geom_jitter(width = 0.2)





# Flip the co-ordinates

ggplot(data = new_data, mapping = aes(x = as.factor(gear), y = mpg)) +
  geom_boxplot() +
  geom_jitter(width = 0.2) +
  coord_flip()





# Make a notched box plot

ggplot(data = new_data, mapping = aes(x = as.factor(gear), y = mpg)) +
  geom_boxplot(notch = TRUE)





