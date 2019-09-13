#Plot # of sowbugs on X axis
library(tidyverse)
library(RMKdiscrete)
library(ggplot2)
cole_arthropod_data_1946 <- read_csv('cole_arthropod_data_1946.csv')

plot_sowbug_counts <- function(sowbug_data) {
  
  g_sowbugs <- ggplot(sowbug_data, aes(x=arthropod_count_index, y=sowbug_counts)) +
    geom_point(size = 3) + xlab("# of sowbugs") + ylab("count")
  g_sowbugs
  
  g_sowbugs <- g_sowbugs + geom_line(data=sowbug_data, aes(x=arthropod_count_index, y=sowbug_counts, colour='#006400'),  
                                     linetype='dotted', colour='#006400') +  
    geom_point(data=sowbug_data, aes(x=arthropod_count_index, y=count_sowbugs_p_theoretical),  
               colour='#006400', shape=0, size = 5)
  g_sowbugs <- g_sowbugs + geom_line(data=sowbug_data, aes(x=arthropod_count_index, y=count_sowbugs_p_theoretical),  
                                     linetype='dashed', colour='#006400') +  
    geom_point(data=sowbug_data, aes(x=arthropod_count_index, y=count_sowbugs_p_theoretical),  
               colour='#006400', shape=0, size = 3)
  g_sowbugs
  
  g_sowbugs <- g_sowbugs + geom_line(data=sowbug_data, aes(x=arthropod_count_index, y=count_sowbugs_L_theoretical),  
                                     linetype='dashed', colour='orchid') +  
    geom_point(data=sowbug_data, aes(x=arthropod_count_index, y=count_sowbugs_p_theoretical),  
               colour='orchid', shape=0, size = 3)
  g_sowbugs
  
  return(g_sowbugs)
}


#Calculated total number of sowbugs
total_number_sowbugs <- sum(cole_arthropod_data_1946$arthropod_count_index*cole_arthropod_data_1946$sowbug_counts)

#calculate total number of observations
total_board_observations <- sum(cole_arthropod_data_1946$sowbug_counts)

#Calculate average (lambda)
avg_sowbugs_per_obs <- total_number_sowbugs/total_board_observations


#making theoretical propbabilities (dpois(x, lambda, log = FALSE))
p_theoretical_sowbugs <- dpois(cole_arthropod_data_1946$arthropod_count_index, avg_sowbugs_per_obs)

#making theoretical propbabilities 
p_theoretical_sowbugs <- dpois(cole_arthropod_data_1946$arthropod_count_index, avg_sowbugs_per_obs)


#Poisson Theoretical number of times you would observe k sowbugs (in new column)
cole_arthropod_data_1946$count_sowbugs_p_theoretical <- total_board_observations*p_theoretical_sowbugs

#making theoretical propbabilities with LGP (dLGP(x,theta,lambda,nc=NULL,log=FALSE))
L_theoretical_sowbugs <- dLGP(cole_arthropod_data_1946$arthropod_count_index,avg_sowbugs_per_obs,0)

#LGP Theoretical number of times you would observe k sowbugs (in new column)
cole_arthropod_data_1946$count_sowbugs_L_theoretical <- total_board_observations*L_theoretical_sowbugs
#Theta (or lambda2 in the workbook) is 0, as stated in the workbook. When lambda2 is = 0, 
#then we get the same as the Poisson distribution

#making theoretical propbabilities with LGP
L_theoretical_sowbugs <- dLGP(cole_arthropod_data_1946$arthropod_count_index, theta = avg_sowbugs_per_obs, lambda = 0)

#LGP Theoretical number of times you would observe k sowbugs in new column
#cole_arthropod_data_1946$count_sowbugs_L_theoretical <- total_board_observations*L_theoretical_sowbugs
cole_arthropod_data_1946$count_sowbugs_p_theoretical <- total_board_observations*p_theoretical_sowbugs

plot_sowbug_counts(cole_arthropod_data_1946)
