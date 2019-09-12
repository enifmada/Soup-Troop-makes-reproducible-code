#
# Author: Graham Smith
#
# Analyses statistics of bent coin lottery
#

# Load lottery function(s)
# If this fails with "No such file or directory",
# then "Session -> Set Working Directory -> To Source File Location"
source("lottery.R")

library(ggplot2)

set.seed(2018)

number_of_samples <- 100
length_of_ticket <- 20
probability_of_heads <- 0.1

sample_count_ones_probabilities <- function(n_samples, len_ticket, p_heads) {
  
  lottery_data <- data.frame(n_count_ones=array(0,dim=len_ticket+1))
  lottery_data$count_ones <- as.numeric(row.names(lottery_data)) - 1
  for (i_sample in 1:n_samples) {
    n_ones <- sum(generate_bent_coin_ticket(len_ticket, p_heads))
    lottery_data$n_count_ones[n_ones+1] <- lottery_data$n_count_ones[n_ones+1] + 1
  }

  lottery_data$p_count_ones <- lottery_data$n_count_ones / n_samples
  
  lottery_data$p_theoretical <- dpois(0:len_ticket,p_heads*len_ticket)
  
  return(lottery_data)
}

plot_count_ones_probabilities_with_fit <- function(lottery_data) {

  g_ones <- ggplot(lottery_data, aes(x=count_ones, y=p_count_ones)) +
    geom_point(size = 3) + xlab("# of 1's") + ylab("probability")
  g_ones

  g_ones <- g_ones + geom_line(data=lottery_data, aes(x=count_ones, y=p_theoretical),  
                                             linetype='dashed', colour='#006400') +  
    geom_point(data=lottery_data, aes(x=count_ones, y=p_theoretical),  
               colour='#006400', shape=0, size = 3)
  g_ones

  return(g_ones)
}

lottery_data <- sample_count_ones_probabilities(number_of_samples, length_of_ticket, probability_of_heads)
g <- plot_count_ones_probabilities_with_fit(lottery_data)
print(g)
