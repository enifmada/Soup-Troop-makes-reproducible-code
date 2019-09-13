# Reproducibility Data Challenge - Species Diversity and Distribution

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

#calculating the means for the spider and sowbug data (lambda values for Poisson)
spider_lambda1 <- sum(arthropod_data$`arthropod count`*arthropod_data$`spiders on boards`)/sum(arthropod_data$`spiders on boards`)
spider_lambda2 <- 0

sowbug_lambda1 <- sum(arthropod_data$`arthropod count`*arthropod_data$`sowbugs on boards`)/sum(arthropod_data$`sowbugs on boards`)
sowbug_lambda2 <- 0.53214

#make a plot to look at spider count vs board counts (data points)
library(ggplot2)
spider_data_plot <- ggplot(arthropod_data, aes(x = `arthropod count`, y = `spiders on boards`)) + geom_point()
spider_data_plot

#adding the Poisson distribution curve to the plot for spider data
addLGPCurveToPlot <- function(plot, data_in_plot, lambda1, lambda2){
  
  LGPCurve <- dLGP(nrow(data_in_plot), lambda1, lambda2)
  # dataInPlot is the data file used to draw whichever plot you pass to this function
  # dLGP() returns numeric vectors of probabilities
  # use this vector to draw LGP curve 
  
  show(plot + geom_line(LGPCurve))
  # overlay Lagrangian Poisson Distribution on plot passed as argument 
  
}

addLGPCurveToPlot(spider_data_plot, arthropod_data, spider_lambda1, spider_lambda2)

#plotting the Poisson distribution with the same mean as the sowbug counts, along with the data 

#loading weevil dataset
weevil_data = read_csv("mitchell_weevil_egg_data_1975.csv")