setwd('/Users/dylansosa/Documents/UChicago/MBL/BSD-QBio5/tutorials/reproducibility/data')
require(tidyverse)
require(RMKdiscrete)


artho <- read_csv('cole_arthropod_data_1946.csv')
weevil <- read_csv('mitchell_weevil_egg_data_1975.csv')

total_spiders <- sum(artho$k_number_of_arthropods*artho$C_count_of_boards_with_k_spiders)
total_spider_boards <- sum(artho$C_count_of_boards_with_k_spiders)
spiderLambda1 <- total_spiders/total_spider_boards
spiderLambda2 <- 0

total_sowbugs <- sum(artho$k_number_of_arthropods*artho$C_count_of_boards_with_k_sowbugs)
total_sowbug_boards <- sum(artho$C_count_of_boards_with_k_sowbugs)
sowLambda1 <- total_sowbugs/total_sowbug_boards
sowLambda2 <- 0.53214


##########################################################################################
# My contribution:

addLGPCurveToPlot <- function(plot, dataInPlot, lambda1, lambda2){
  
  countsVector <- nrow(dataInPlot)
  # dataInPlot is the data file used to draw whichever plot you pass to this function
  
  LGPCurve <- dLGP(countsVector, lambda1, lambda2)
  # dLGP() returns numeric vectors of probabilities
  # use this vector to draw LGP curve 
  
  show(plot + geom_line(LGPCurve))
  # overlay Lagrangian Poisson Distribution on plot passed as argument 
  
}

addLGPCurveToPlot()

countsVector <- nrow(artho)
