#plotting the finch data
library(ggplot2)
finch <- read.csv("finch.csv", header = TRUE)
head(finch)
class(finch)
summary(finch)
#simplify
finch_simple = subset(finch, select = -c(month, day, year, day_of_year, number_of_visit, latitude, longitude, wind, pox_scale, pox_lesion))

p |> ggplot(aes(x=finch_simple$species, y=finch_simple$beak_length, label=finch_simple_band)) + geom_label()

subset(finch_simple)
#identify the morphology data
#class(finch_simple$morphology)
#convert to integer
finch_simple$beak_depth <- as.integer(finch_simple$beak_depth)
finch_simple$beak_length <- as.integer(finch_simple$beak_length) 
finch_simple$beak_width <- as.integer(finch_simple$beak_width) 
finch_simple$wing <- as.integer(finch_simple$wing) 
finch_simple$mass <- as.integer(finch_simple$mass) 
#ignore the label if too messy
ggplot(finch_simple, aes(x = species, y = beak_length, label = band)) + 
  geom_label()

