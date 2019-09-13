

plot_spider_counts <- function(spider_data) {
  
  g_spiders <- ggplot(spider_data, aes(x=k_number_of_arthropods, y=C_count_of_boards_with_k_spiders)) +
    geom_point(size = 3) + xlab("# of spiders") + ylab("count")
  g_spiders
  
  g_spiders <- g_spiders + geom_line(data=spider_data, aes(x=k_number_of_arthropods, y=count_spiders_p_theoretical, colour='#006400'),  
                               linetype='dotted', colour='#006400') +  
    geom_point(data=spider_data, aes(x=k_number_of_arthropods, y=count_spiders_p_theoretical),  
               colour='#006400', shape=0, size = 5)
  g_spiders
  
  g_spiders <- g_spiders + geom_line(data=spider_data, aes(x=k_number_of_arthropods, y=count_spiders_L_theoretical),  
                                     linetype='dashed', colour='orchid') +  
    geom_point(data=spider_data, aes(x=k_number_of_arthropods, y=count_spiders_p_theoretical),  
               colour='orchid', shape=0, size = 3)
  g_spiders
  
  return(g_spiders)
}
plot_spider_counts(cole_arthropod_data_1946)



#Calculated total number of spiders
total_number_spiders <- sum(cole_arthropod_data_1946$k_number_of_arthropods*cole_arthropod_data_1946$C_count_of_boards_with_k_spiders)

#calculate total number of observations
total_board_observations <- sum(cole_arthropod_data_1946$C_count_of_boards_with_k_spiders)

#Calculate average (lambda)
avg_spiders_per_obs <- total_number_spiders/total_board_observations

#making theoretical propbabilities (dpois(x, lambda, log = FALSE))
p_theoretical_spiders <- dpois(cole_arthropod_data_1946$k_number_of_arthropods, avg_spiders_per_obs)

#Poisson Theoretical number of times you would observe k spiders (in new column)
cole_arthropod_data_1946$count_spiders_p_theoretical <- total_board_observations*p_theoretical_spiders

#making theoretical propbabilities with LGP (dLGP(x,theta,lambda,nc=NULL,log=FALSE))
L_theoretical_spiders <- dLGP(cole_arthropod_data_1946$k_number_of_arthropods,avg_spiders_per_obs,0)

#LGP Theoretical number of times you would observe k spiders (in new column)
cole_arthropod_data_1946$count_spiders_L_theoretical <- total_board_observations*L_theoretical_spiders
#Theta (or lambda2 in the workbook) is 0, as stated in the workbook. When lambda2 is = 0, 
#then we get the same as the Poisson distribution
