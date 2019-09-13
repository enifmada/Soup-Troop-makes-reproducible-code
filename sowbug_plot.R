#plot_real_data.r:
#contains a single function, plot_real_data, that plots the number of
#counts for each count given a data set

library(tidyverse)
arth_data = read_csv("cole_arthropod_data_1946.csv")
weevil_data = read_csv("mitchell_weevil_egg_data_1975.csv")

arth_length = nrow(arth_data)
weevil_length = nrow(weevil_data)

#find the mean of the arthropod counts (in bugs per board)
total_spiders = sum(arth_data$spider_counts)
total_sowbugs = sum(arth_data$sowbug_counts)
total_weevils = sum(weevil_data$weevil_counts)
mean_spiders = sum(arth_data$arthropod_count_index*arth_data$spider_counts)/total_spiders
mean_sowbugs = sum(arth_data$arthropod_count_index*arth_data$sowbug_counts)/total_sowbugs
mean_weevils = sum(weevil_data$weevil_count_index*weevil_data$weevil_counts)/total_weevils

poisson_to_n = function(data_length, lambda){
  return(dpois(x=1:data_length,lambda))
}

sowbug_poisson = poisson_to_n(arth_length, mean_sowbugs)

plt = ggplot() + geom_point(data=arth_data, aes(x=arthropod_count_index, y=sowbug_counts/total_sowbugs))+
  geom_line(data=arth_data, aes(x=arthropod_count_index, y=sowbug_poisson), linetype='dashed', colour='#006400')