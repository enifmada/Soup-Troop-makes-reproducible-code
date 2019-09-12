library(tidyverse)
arth_data = read_csv("cole_arthropod_data_1946.csv")
weevil_data = read_csv("mitchell_weevil_egg_data_1975.csv")

#find the mean of the arthropod counts (in bugs per board)
mean_spiders = sum(arth_data$arthropod_count_index*arth_data$spider_counts)/sum(arth_data$spider_counts)
mean_sowbugs = sum(arth_data$arthropod_count_index*arth_data$sowbug_counts)/sum(arth_data$sowbug_counts)
mean_weevils = sum(weevil_data$weevil_count_index*weevil_data$weevil_counts)/sum(weevil_data$weevil_counts)