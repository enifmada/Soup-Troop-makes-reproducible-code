# Reproducibility Data Challenge - Species Diversity and Distribution

# NB: A Poisson distribution has a variance:mean ratio = 1. Show that the variance of the spider count distribution is approsimately equal to its mean
#loading libraries for future use
library(stats)
library(tidyverse)

#loading arthropod dataset
arthropod_data <- read_csv("../reproducibility/data/cole_arthropod_data_1946.csv")

#rename columns, check headers, if its a data frame and the tibble dimensions
names(arthropod_data) <- c("arthropod count", "spiders on boards", "sowbugs on boards")
head(arthropod_data)
dim(arthropod_data)
is.data.frame(arthropod_data)

#calculating the means and variances for the arthropod data (add later)
spider_mean <-
spider_variance <-
  
sowbug_mean <-
sowbug_variance <-
  
#make a plot to look at arthropod count vs board counts (data points)
library(ggplot2)
spider_data_plot <- ggplot(arthropod_data, aes(x = `arthropod count`, y = `spiders on boards`)) + geom_point()
spider_data_plot

#adding the Poisson distribution curve to the plot
lambda_spiders <- spider_mean
k_spiders <- c(1:17)
#write a function to plot points for the poisson distribution