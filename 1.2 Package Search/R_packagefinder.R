########################################
## Searching R packages
########################################

# 1. METACRAN
# https://r-pkg.org/


# 2. packagefinder

# A R community blog by Joseph Rickert
# https://rviews.rstudio.com/2018/10/22/searching-for-r-packages/

# R CRAN library - Package finder

library(packagefinder) # For finding package
library(tidyverse) # data manupulation and plotting
library(dlstats)  # Number of download per package per month
library(cranly)  # Tracking authors network

########################################
# Looking for random forest package
########################################

rf_pkg <- as.tibble(findPackage("random forest"))

names(rf_pkg) # identify column names

head(rf_pkg) # see first 6 rows





#############################################
# Identify download per package per month
# using cran_stats() from dlstat package
#############################################

pkg_downloads <- cran_stats(rf_pkg$NAME)

dim(pkg_downloads) # check dimension

head(pkg_downloads)


# Use dplyr or tidyverse pipe to summarize total
# download over it's life span

most_downloaded <- pkg_downloads %>% 
  group_by(package) %>% 
  summarize(downloads = sum(downloads)) %>% 
  arrange(desc(downloads))

head(most_downloaded)


# Plotting the downloaded trend of top 3 packages

top_three_pkgs <- pkg_downloads %>%
  filter(package %in% most_downloaded$package[1:3])

head(top_three_pkgs)

ggplot(data = top_three_pkgs, 
       mapping = aes(x = end, y = downloads,
                     group = package, color = package)) +
  geom_line() +
  geom_point(mapping = aes(shape = package), size = 2)


############################################
# Use cranly package to know about authors
############################################

# One way to gauge the quality and reliability of a 
# package is to see how many other packages depend on it.
# These would be the packages listed as 
# “Reverse depends” and “Reverse imports”


# with cranly package, it is simple to track 
# down an author's collaboration network.

citation("randomForest")

library(cranly)
library(tools)

p_db <- CRAN_package_db()  # obtaining information about
                           # current packages in the CRAN package
                           # repository, and their check status

clean_p_db <- clean_CRAN_db(p_db) # Clean and organise package and
                                  # author names in the output


# build_network method for an object
author_net <- build_network(object = clean_p_db,
                            perspective = "author")

plot(author_net, author = "Andy Liaw", exact = TRUE)


# Who is the most popular author in CRAN
# in terms of packages and in terms of collaborators

author_summary <- summary(author_net)

plot(author_summary)

