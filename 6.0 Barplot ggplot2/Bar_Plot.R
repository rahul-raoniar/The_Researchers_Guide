#########################################
## 1.0 Bar Graphs
#########################################
install.packages("ggplot2")

library(ggplot2)

data(BOD)

View(BOD)

str(BOD)

ggplot(data = BOD, mapping = aes(x = Time, y = demand)) +
  geom_bar(stat = "identity")

# Create a plot using ggplot( ) function
ggplot(data=BOD, mapping = aes(x=Time, y=demand)) + # Add an aesthetic mapping
  geom_bar(stat = "identity") # Add geometric object i.e. bars




# Convert time to a discrete value using factor( )

ggplot(data=BOD, mapping = aes(x=factor(Time), y=demand)) + # Add an aesthetic mapping
  geom_bar(stat = "identity") # Add geometric object i.e. bars




# Add fill inside the bars and give a black outline
 
ggplot(data=BOD, mapping = aes(x=factor(Time), y=demand)) + 
  geom_bar(stat = "identity", fill="lightblue", colour="black") 




#################
## 1.1 Grouping Bars (type = dodge)
#################

# Create a experiment data frame

experiment <- data.frame(exp_type = c("Exp1", "Exp1", "Exp2", "Exp2"),
                    date = c("Jan7", "Jan14", "Jan7", "Jan14"),
                    speed_kmph = c(65, 40, 75, 45))

str(experiment) # Check structure of experiment data frame



# Create a grouped bar graph (dodge type)

ggplot(data = experiment, mapping = aes(x=date, y=speed_kmph, fill=exp_type)) +
  geom_bar(stat="identity", position = "dodge")




# Change the default fill colour scale_fill_brewer() or scale_fill_manual()

# 1.1 a) Using scale_fill_brewer()

ggplot(data = experiment, mapping = aes(x=date, y=speed_kmph, fill=exp_type)) +
  geom_bar(stat="identity", position = "dodge") +
  scale_fill_brewer(palette = "Pastel1")



# 1.1 b) scale_fill_manual()
ggplot(data = experiment, mapping = aes(x=date, y=speed_kmph, fill=exp_type)) +
  geom_bar(stat="identity", position = "dodge") +
  scale_fill_manual(values = c("red", "blue"))



# Remove the legend

ggplot(data = experiment, mapping = aes(x=date, y=speed_kmph, fill=exp_type)) +
  geom_bar(stat="identity", position = "dodge") +
  scale_fill_manual(values = c("red", "blue"), guide=FALSE) # add guide = FALSE




#########################################
## 1.3 Adjusting Bar Width and Spacing
#########################################

experiment <- data.frame(exp_type = c("Exp1", "Exp1", "Exp2", "Exp2"),
                         date = c("Jan7", "Jan14", "Jan7", "Jan14"),
                         speed_kmph = c(65, 40, 75, 45))

# Note: default width = 0.9
# Max width = 1

ggplot(data = experiment, mapping = aes(x=date, y=speed_kmph, fill=exp_type)) +
  geom_bar(stat="identity", position = "dodge", width = 0.5)




# Plot with some space between the bars
# Set position_dodge to be larger than width

ggplot(data = experiment, mapping = aes(x=date, y=speed_kmph, fill=exp_type)) +
  geom_bar(stat="identity", width = 0.5, position = position_dodge(0.8))




#######################################
## 1.4 Making a Stacked Bar plot
#######################################

ggplot(data = experiment, mapping = aes(x=date, y=speed_kmph, fill=exp_type)) +
  geom_bar(stat="identity") # Don't use position = "dodge"


# Change the stacking order
# Change the legend order

ggplot(data = experiment, mapping = aes(x=date, y=speed_kmph, fill=exp_type)) +
  geom_bar(stat="identity", position = position_stack(reverse=TRUE)) + 
  guides(fill = guide_legend(reverse=TRUE))





#####################################################
## 1.5 Adding Labels to a Bar Graph
#####################################################

experiment <- data.frame(exp_type = c("Exp1", "Exp1", "Exp2", "Exp2"),
                         date = c("Jan7", "Jan14", "Jan7", "Jan14"),
                         speed_kmph = c(65, 40, 75, 45))

# Lebel below the top
ggplot(data = experiment, mapping = aes(x=interaction(exp_type, date), y=speed_kmph)) +
  geom_bar(stat="identity") +
  geom_text(aes(label=speed_kmph), vjust= 1.5, colour = "white", size=5)

# Lebel above the top
ggplot(data = experiment, mapping = aes(x=interaction(exp_type, date), y=speed_kmph)) +
  geom_bar(stat="identity") +
  geom_text(aes(label=speed_kmph), vjust= -0.2, colour = "black", size=5)



# Adjusting y limits to be a little higher

ggplot(data = experiment, mapping = aes(x=interaction(exp_type, date), y=speed_kmph)) +
  geom_bar(stat="identity") +
  geom_text(aes(label=speed_kmph), vjust= -0.2, colour = "red", size=5) +
  ylim(0, max(experiment$speed_kmph)*1.1)



# Add lebels on grouped bars (Type = dodge)

ggplot(data = experiment, mapping = aes(x=date, y=speed_kmph, fill=exp_type)) +
  geom_bar(stat="identity", position = "dodge") +
  geom_text(aes(label=speed_kmph), vjust= 1.5, colour = "white", size=5, position = position_dodge(0.9))



# Add lebels on stack bars

ggplot(data = experiment, mapping = aes(x=date, y=speed_kmph, fill=exp_type)) +
  geom_bar(stat="identity") +
  geom_text(aes(label=speed_kmph), position = position_stack(vjust= 0.5), colour = "white", size = 5)




# Plot stacked bar graph
# Change outline colour="black"
# Resize text
# Add "kmph" using paste()
# Add two digits after decimal point using format()
# Use Pastel1 color combination


ggplot(data = experiment, mapping = aes(x=date, y=speed_kmph, fill=exp_type)) +
  geom_bar(stat="identity", colour = "black") + # add black outline
  geom_text(aes(label=paste(format(speed_kmph, nsmall=2), "kmph")), 
            position = position_stack(vjust= 0.5),
            colour = "black", size = 5) +
  scale_fill_brewer(palette = "Pastel1")
