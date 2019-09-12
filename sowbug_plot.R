#plot_real_data.r:
#contains a single function, plot_real_data, that plots the number of
#counts for each count given a data set

library(tidyverse)
arth_data = read_csv("cole_arthropod_data_1946.csv")
weevil_data = read_csv("mitchell_weevil_egg_data_1975.csv")

arth_length = nrow(arth_data)
weevil_length = nrow(weevil_data)

#find the mean of the arthropod counts (in bugs per board)
mean_spiders = sum(arth_data$arthropod_count_index*arth_data$spider_counts)/sum(arth_data$spider_counts)
mean_sowbugs = sum(arth_data$arthropod_count_index*arth_data$sowbug_counts)/sum(arth_data$sowbug_counts)
mean_weevils = sum(weevil_data$weevil_count_index*weevil_data$weevil_counts)/sum(weevil_data$weevil_counts)

poisson_to_n = function(data_length, lambda){
  return(dpois(x=1:data_length,lambda))
}

sowbug_poisson = poisson_to_n(arth_length, mean_sowbugs)

plt = ggplot(data = arth_data) + 
  aes(x=arth_count_index, y=sowbug_counts) + geom_point() +
  ggplot(data = sowbug_poisson)+aes(x=arth_count_index, y=sowbug_poisson) +
  geom_line()