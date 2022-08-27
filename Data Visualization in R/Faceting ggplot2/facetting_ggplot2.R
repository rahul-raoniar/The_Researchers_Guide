###################
##Facetting
####################

# Facetting is a technique for displying additional
# categorical variables on a plot

# facetting split the data into subsets
# and display same plot for each data subsets



# There are three ways one can do facetting

# facet_null(): this is a default single plot
# facet_wrap()
# facet_grid()


# facet_wrap()
# This generates a long ribbon of panels 
# produced by any number of variables
# and this wraps it into 2d
# useful for single variables with many levels
# control is available with ncol, nrow

library(ggplot2)

data(package="ggplot2")
mpg

# displ: engine displacement, in litres
# hwy: highway miles per gallon
# drv:  f = front-wheel drive, r = rear wheel drive, 4 = 4wd

# see data structure

str(mpg)

#or

dplyr::glimpse(mpg)


# lets plot a scatter plot

plot1 <- ggplot(data = mpg, mapping = aes(x=displ, y=hwy,
                                          colour=drv))+
  geom_point()

plot1

plot1 + facet_wrap(~drv, ncol=2) # tilde then variable (~variable)


plot1 + facet_wrap(~drv+class, ncol=2) # tilde then variable (~variable)




# facet_grid()
# provides plots in a 2d grid
# .~X spread values of X accross the columns
# X~. spread values of X down the rows
# while X~Y spreads X across columns and Y down rows
# It is recommnded to put variable across column which has many levels


plot1 + facet_grid(class~drv) # tilde then variable (~variable)


# Adjusting scales
# scales argument provides better control on axis
# fixed vs free


plot1 + facet_grid(class~drv, scales = "free_x")

plot1 + facet_grid(class~drv, scales = "free_y")

