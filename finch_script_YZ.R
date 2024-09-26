<<<<<<< HEAD
#plotting the finch data
library(ggplot2)
finch <- read.csv("finch.csv", header = TRUE)
head(finch)
class(finch)
summary(finch)
#simplify
finch_simple = subset(finch, select = -c(month, day, year, day_of_year, number_of_visit, latitude, longitude, wind, pox_scale, pox_lesion))

subset(finch_simple)
#identify the morphology data
#class(finch_simple$morphology)
#convert to integer
finch_simple$beak_depth <- as.integer(finch_simple$beak_depth)
finch_simple$beak_length <- as.integer(finch_simple$beak_length) 
finch_simple$beak_width <- as.integer(finch_simple$beak_width) 
finch_simple$wing <- as.integer(finch_simple$wing) 
finch_simple$mass <- as.integer(finch_simple$mass)

#plot the correlation b/w species and mass
ggplot(finch_simple, aes(x = species, y = mass, fill = species)) +
  geom_boxplot() +
  stat_summary(fun = mean, geom = "point", shape = 23, size = 2, fill = "black", color = "black") +
  stat_summary(fun = mean, geom = "text", aes(label = round(..y.., 1)), vjust = -1.5, color = "black") +
  labs(title = "Body Mass by Finch Species", x = "Finch Species", y = "Body Mass (g)") +
  scale_fill_manual(values = c("cactus" = "lightblue", "large" = "lightgreen", "medium" = "red", "small" = "yellow"))
=======
#plotting the finch data
library(ggplot2)
finch <- read.csv("finch.csv", header = TRUE)
head(finch)
class(finch)
summary(finch)
#simplify
finch_simple = subset(finch, select = -c(month, day, year, day_of_year, number_of_visit, latitude, longitude, wind, pox_scale, pox_lesion))

subset(finch_simple)
#identify the morphology data
#class(finch_simple$morphology)
#convert to integer
finch_simple$beak_depth <- as.integer(finch_simple$beak_depth)
finch_simple$beak_length <- as.integer(finch_simple$beak_length) 
finch_simple$beak_width <- as.integer(finch_simple$beak_width) 
finch_simple$wing <- as.integer(finch_simple$wing) 
finch_simple$mass <- as.integer(finch_simple$mass)

#plot the correlation b/w species and mass
ggplot(finch_simple, aes(x = species, y = mass, fill = species)) +
  geom_boxplot() +
  labs(title = "Body mass by finch species", x = "Finch Species", y = "Body Mass (g)") +
  scale_fill_manual(values = c("cactus" = "lightblue", "large" = "lightgreen", "medium" = "red", "small" = "yellow"))
>>>>>>> c728a81ab8cc714c90970844da4f3378a0560e4f
