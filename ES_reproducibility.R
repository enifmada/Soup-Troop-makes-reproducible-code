# Reproducibility Data Challenge - Species Diversity and Distribution

#loading libraries for future use
library(stats)
library(tidyverse)

#loading arthropod dataset
arthropod_data <- read_csv("../data/cole_arthropod_data_1946.csv")

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

#calculating theoretical values for Poisson distribution using calculated (lambda1s) for the spider and sowbug data
theoretical_spider_Poiss <- dpois(arthropod_data$`arthropod count`, spider_lambda1, log = FALSE)
theoretical_sowbug_Poiss <- dpois(arthropod_data$`arthropod count`, sowbug_lambda1, log = FALSE) 

#total arthropod counts
total_spiders <- sum(arthropod_data$`spiders on boards`)
total_sowbugs <- sum(arthropod_data$`sowbugs on boards`)

#theoretical Poisson counts for spiders and sowbugs to use in the final plot
spider_Poiss_counts <- total_spiders*theoretical_spider_Poiss
sowbug_Poiss_counts <- total_sowbugs*theoretical_sowbug_Poiss

#make Poisson counts into a data fram and add to arthropod data table
spider_Poiss_counts_df <- as.data.frame(spider_Poiss_counts)
sowbug_Poiss_counts_df <- as.data.frame(sowbug_Poiss_counts)

arthropod_data_final <- cbind(arthropod_data, spider_Poiss_counts_df, sowbug_Poiss_counts_df)

# graph the final plots for spiders and sowbugs
spider_data_plot <- ggplot(arthropod_data_final, aes(x = `arthropod count`, y = `spiders on boards`)) + geom_point()
spider_Poiss_plot <- ggplot(arthropod_data_final, aes(x = `arthropod count`, y = `spider_Poiss_counts`)) + geom_line()


sowbug_data_plot <- ggplot(arthropod_data_final, aes(x = `arthropod count`, y = `sowbugs on boards`)) + geom_point()
sowbug_Poiss_plot <- ggplot(arthropod_data_final, aes(x = `arthropod count`, y = `sowbug_Poiss_counts`)) + geom_line()


  

