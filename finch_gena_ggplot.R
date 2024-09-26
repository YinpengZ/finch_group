library(dplyr)
library(ggplot2)
library(dslabs)

###Simplifying dataset -Gena
finch_simple = subset(finch, select = -c(month, day, year, day_of_year, number_of_visit, latitude, longitude, wind, pox_scale, pox_lesion))

###So 2 of the individuals had a value that was not correct for the sex column
### SM1813 on line 1700 had sex as 0
### SM1778 on line 1666 had sex as 4
###My guess is that those values were supposed to be for the plumage columns
finch_simple[1700,"sex"]
finch_simple[1700,"sex"] <- "U"

finch_simple[1666,"sex"]
finch_simple[1666,"sex"] <- "U"

###This figure is the first draft of the violin plot without mean values
ggplot(finch_simple, aes(sex, mass, group=sex)) + 
  geom_violin(fill="#B7410E", color="black") + 
  ggtitle("Finch Mass by Sex") + 
  ylab("Mass (g)") +
  xlab("Sex")

###Obtaining mean values
mean_values <- finch_simple %>%
  group_by(sex) %>%
  summarize(mean_mass = mean(mass, na.rm = TRUE))

###Adding mean values to violin plot
ggplot(finch_simple, aes(sex, mass, group=sex)) + 
  geom_violin(fill="#B7410E", color="black") + 
  ggtitle("Finch Mass by Sex") + 
  ylab("Mass (g)") + 
  xlab("Sex") +
  geom_point(data = mean_values, aes(x = sex, y = mean_mass), 
             color = "black", size = 3, shape = 21, fill = "black") + 
  geom_text(data = mean_values, aes(x = sex, y = mean_mass, label = round(mean_mass, 1)), 
            vjust = -0.9, hjust = -0.50, color = "black") +  # Adding text labels above median points
  theme_minimal()

###Testing
