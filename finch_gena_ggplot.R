library(dplyr)
library(ggplot2)
library(dslabs)

###Simplifying dataset -Gena
finch_simple = subset(finch, select = -c(month, day, year, day_of_year, number_of_visit, latitude, longitude, wind, pox_scale, pox_lesion))
