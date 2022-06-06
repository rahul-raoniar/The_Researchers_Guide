####################################
# Supervised Learning
####################################

####################################
## Linear Regression
####################################

# Inbuilt dataset cars
# The data give the speed of cars and the distances taken to stop

cars




# Plot Dataset

plot(cars$speed, cars$dist)




# Fit a linear regression model

lm_model <- lm(dist ~ speed, data = cars)




# Put a regression line on plot

abline(lm_model, col = "blue")


# Check model coefficients

lm_model





# Checking different options using attributes

attributes(lm_model)






#####################################
# Fitting model with ordinary least square function
#####################################

plot(cars$speed, cars$dist)

lm_model_2 <- lsfit(cars$speed, cars$dist)

abline(lm_model_2, col = "red")






######################################
# Regression summary and other details
######################################

summary(lm_model)


coefficients(lm_model) # Shows the exact model coefficients


fitted(lm_model) # Shows the model fitted values


confint(lm_model, level=0.95) # Computes confidence intervals for model parameters


residuals(lm_model) # Shows the extract model residuals


vcov(lm_model) # Varience Co-varience matrix










#####################################
# Predicting new values
#####################################

new_speed_data <- data.frame(speed = c(30, 26, 11, 21))

# Compute the prediction results using confidence interval with level set to 0.95

predict(lm_model, new_speed_data, interval = "confidence", level= 0.95)
















# Compute the prediction result using prediction interval

predict(lm_model, new_speed_data, interval = "predict")






# Diagnostic plot of a fitted regression model

par(mfrow=c(2,2))

plot(lm_model)





# Check Cook's distance using cooks.distance() function

cd <- cooks.distance(lm_model)

plot(cd)







#####################################
# Fitting a robust linear regression model with rlm
#####################################

# Take inbuilt dataset Quartet
data(package = .packages(all.available = TRUE))

library(car)
Quartet





# Check how outlier moves away the fitted line using lm()

plot(Quartet$x, Quartet$y3)

lmfit <- lm(Quartet$y3 ~ Quartet$x)

abline(lmfit, col="red")






# Applying robust linear regression

library(MASS)

plot(Quartet$x, Quartet$y3)

lmfit <- rlm(Quartet$y3 ~ Quartet$x)

abline(lmfit, col="red")







# Diagnose multi-colinearity of the regression model using vif() function
# In case of multi-colinearity, one should find predictors with the square root of variance inflation factor above 2.



# Fit lm to mtcars dataset

mtcars


# Create a linear model 

lm_model_3 <- lm(mpg~hp + wt, data = mtcars)


vif(lm_model_3)


sqrt(vif(lm_model_3)) >2









# Boot-strapping

# Bootstrap methods are resampling techniques for assessing uncertainty. 
# They are useful when inference is to be based on a complex procedure for which theoretical
# results are unavailable or not useful for the sample sizes met in practice 

###################################################
# There are several  forms of the bootstrap (e.g. non-parametric, parametric, residual resampling and many more).  
# The basic idea is that you treat your sample as population and repeatedly draw new samples from it with 
# replacement. All original observations have equal probability of being drawn into the new sample. 
# Then you calculate and store the statistic(s) of interest, this may be the mean,
# the median or regression coefficients using the newly drawn sample.
# This is repeated n times. 
# In each iteration, some observations from your original sample are drawn multiple times 
# while some observations may not be drawn at all. 
# After nn iterations, you have nn stored bootstrap estimates of the statistic(s) of interest 
# (e.g. if n=1000n=1000 and the statistic of interest is the mean,
# you have 1000 bootstrapped estimates of the mean).
# Lastly, summary statistics such as the mean, median and the standard deviation of the nn bootstrap-estimates 
# are calculated.
#############################################


# The bootstrap is a great way to estimate the performance of a model

# Bootstrap does not require distributional assumptions 
# bootstrap can provide more accurate inferences when the data are not well behaved or when the sample size is small
# It is relatively simple to apply the bootstrap to complex data-collection plans 

##################################################


N = length(cars[,1])   # Counts the number of observations
Boot_number = 400      # Number of times to recompute estimate

          

store_r2 = rep(0,Boot_number)  ## Create a Storage Vector



## Create a Loop that does the bootstrap on R-squared ##

set.seed(122)

for(i in 1:Boot_number ){
  
  idx = sample(1:N, N, replace = TRUE)
  newdata.df = cars[idx,]
  lm_boot = lm(dist~speed, data=newdata.df)  
  store_r2[i] = summary(lm_boot)$r.squared
}


hist(store_r2) # Plot a r2 histogram

min(store_r2) # identify minimum r2

max(store_r2) # identify minimum r2

mean(store_r2) # calculate minimum r2
