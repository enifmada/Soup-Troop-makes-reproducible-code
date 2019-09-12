spiders <- read_csv("cole_arthropod_data_1946.csv")
weevils <- read_csv("mitchell_weevil_egg_data_1975.csv")
as.data.frame(weevils)
as.data.frame(spiders)
number_weevils <- weevils$k_number_of_eggs
number_arthropods <- spiders$k_number_of_arthropods
count_boards_k_spiders <- spiders$C_count_of_boards_with_k_spiders
count_boards_k_sowbugs <- spiders$C_count_of_boards_with_k_sowbugs


#find the mean of the spider counts (in bugs per board)
total_spiders <- sum(spiders$k_number_of_arthropods*spiders$C_count_of_boards_with_k_spiders)
total_spider_boards <- sum(spiders$C_count_of_boards_with_k_spiders)
mean_spiders <- total_spiders/total_spider_boards
#plot the Poisson distribution of spider counts
  #add a curve based on the spider parameters
#find the mean of the sowbug counts (in bugs per board)
total_sowbugs <- sum(spiders$k_number_of_arthropods*spiders$C_count_of_boards_with_k_sowbugs)
total_sowbug_boards <- sum(spiders$C_count_of_boards_with_k_sowbugs)
mean_sowbugs <- total_sowbugs/total_sowbug_boards
#plot the Poisson distribution of sowbug counts counts
  #add a curve based on the sowbug parameters
#find the mean 0f the weevil egg counts (in eggs per bean)
total_weevils <- sum(number_weevils*weevils$C_count_of_beans_with_k_eggs)
total_weevil_boards <- sum(weevils$C_count_of_beans_with_k_eggs)
mean_weevils <- total_weevils/total_weevil_boards
#plot the Poisson distribution of weevil counts
  #add a curve based on the weevil parameters