#Plot # of spiders on X axis
library(tidyverse)
library(RMKdiscrete)
library(ggplot2)
cole_arthropod_data_1946 <- read_csv('cole_arthropod_data_1946.csv')

plot_spider_counts <- function(spider_data) {
  
  g_spiders <- ggplot(spider_data, aes(x=arthropod_count_index, y=spider_counts)) +
    geom_point(size = 3) + xlab("# of spiders") + ylab("count")
  g_spiders
  
  g_spiders <- g_spiders + geom_line(data=spider_data, aes(x=arthropod_count_index, y=spider_counts, colour='#006400'),  
                               linetype='dotted', colour='#006400') +  
    geom_point(data=spider_data, aes(x=arthropod_count_index, y=count_spiders_p_theoretical),  
               colour='#006400', shape=0, size = 5)
  
  g_spiders <- g_spiders + geom_line(data=spider_data, aes(x=arthropod_count_index, y=count_spiders_p_theoretical),  
                               linetype='dashed', colour='#006400') +  
    geom_point(data=spider_data, aes(x=arthropod_count_index, y=count_spiders_p_theoretical),  
               colour='#006400', shape=0, size = 3)
              g_spiders
  
  g_spiders <- g_spiders + geom_line(data=spider_data, aes(x=arthropod_count_index, y=count_spiders_L_theoretical),  
                                     linetype='dashed', colour='orchid') +  
    geom_point(data=spider_data, aes(x=arthropod_count_index, y=count_spiders_p_theoretical),  
               colour='orchid', shape=0, size = 3)
              g_spiders
  
  return(g_spiders)
}


#Calculated total number of spiders
total_number_spiders <- sum(cole_arthropod_data_1946$arthropod_count_index*cole_arthropod_data_1946$spider_counts)

#calculate total number of observations
total_board_observations <- sum(cole_arthropod_data_1946$spider_counts)

#Calculate average (lambda)
avg_spiders_per_obs <- total_number_spiders/total_board_observations


#making theoretical propbabilities (dpois(x, lambda, log = FALSE))
p_theoretical_spiders <- dpois(cole_arthropod_data_1946$arthropod_count_index, avg_spiders_per_obs)

#making theoretical propbabilities 
p_theoretical_spiders <- dpois(cole_arthropod_data_1946$arthropod_count_index, avg_spiders_per_obs)


#Poisson Theoretical number of times you would observe k spiders (in new column)
cole_arthropod_data_1946$count_spiders_p_theoretical <- total_board_observations*p_theoretical_spiders

#making theoretical propbabilities with LGP (dLGP(x,theta,lambda,nc=NULL,log=FALSE))
L_theoretical_spiders <- dLGP(cole_arthropod_data_1946$arthropod_count_index,avg_spiders_per_obs,0)

#LGP Theoretical number of times you would observe k spiders (in new column)
cole_arthropod_data_1946$count_spiders_L_theoretical <- total_board_observations*L_theoretical_spiders
#Theta (or lambda2 in the workbook) is 0, as stated in the workbook. When lambda2 is = 0, 
#then we get the same as the Poisson distribution

#making theoretical propbabilities with LGP
L_theoretical_spiders <- dLGP(cole_arthropod_data_1946$arthropod_count_index, theta = avg_spiders_per_obs, lambda = 0)

#LGP Theoretical number of times you would observe k spiders in new column
#cole_arthropod_data_1946$count_spiders_L_theoretical <- total_board_observations*L_theoretical_spiders
cole_arthropod_data_1946$count_spiders_p_theoretical <- total_board_observations*p_theoretical_spiders

plot_spider_counts(cole_arthropod_data_1946)

