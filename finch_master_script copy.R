###HEAD
library(dplyr)
library(ggplot2)
library(dslabs)
library(tidyverse)

#plotting the finch data
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


###So 2 of the individuals had a value that was not correct for the sex column
### SM1813 on line 1700 had sex as 0
### SM1778 on line 1666 had sex as 4
###My guess is that those values were supposed to be for the plumage columns
finch_simple[1700,"sex"]
finch_simple[1700,"sex"] <- "U"

finch_simple[1666,"sex"]
finch_simple[1666,"sex"] <- "U"

finch_simple$sex <- trimws(finch_simple$sex)

### Filter out any rows with undefined or unexpected 'sex' values
valid_sex <- c("M", "F", "U")
finch_simple <- finch_simple %>% filter(sex %in% valid_sex)

### Ensure 'sex' is a factor with correct levels
finch_simple$sex <- factor(finch_simple$sex, levels = c("M", "F", "U"))

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
  stat_summary(aes(x=sex, y=mass), fun.y = mean, geom="point") +
  geom_point(data = mean_values, aes(x = sex, y = mean_mass), 
             color = "black", size = 3, shape = 21, fill = "black") + 
  geom_text(data = mean_values, aes(x = sex, y = mean_mass, label = round(mean_mass, 1)), 
            vjust = -0.9, hjust = -0.50, color = "black") +  # Adding text labels above median points
  theme_minimal()



# Tanner
# Cleaning NAs and parsing out columns needed for Tanner's plots

# Subset data to get only vars we care about for the next two plots
elev_vol = subset(finch_simple, select = c(elevation, beak_width, beak_length, beak_depth, species, type_of_site))

# Get rid of NAs
elev_vol = na.omit(elev_vol)

# Calculate and add the volume column to the data
elev_vol = elev_vol %>% 
  mutate(beak_volume = 3.14159*(beak_width/2)*(beak_depth/2)*beak_length/3) %>% 
  filter(beak_volume < 20000, beak_width < 60, species == c('small', 'medium', 'cactus'))

# comparative beak volume by site/species

p <- ggplot(data = elev_vol)

# Violin lot for beak volume by species
p + geom_violin(aes(species, beak_volume, col=species)) + xlab("Species") +
  theme(legend.position = 'none') +
  ylab("Approximate Beak Volume (mm^3)") +
  ggtitle("Beak volume distribution across species") +
  scale_x_discrete(labels = c(cactus = "Cactus", medium = "Medium", small = 'Small')) +
  stat_summary(aes(x=species, y=beak_volume), fun.y = mean, geom = "point", col='black')

# Violin plot for beak volume by site type
p + geom_violin(aes(type_of_site, beak_volume, color = type_of_site)) + 
  xlab("Site Type") +
  ylab("Approximate Beak Volume (mm^3)") +
  ggtitle("Beak volume distribution across types of sites") +
  theme(legend.position = 'none') +
  scale_fill_brewer(palette = "BuPu") + 
  scale_x_discrete(labels = c(Agricola = "Farm", arida = "Dryland", Bosque = "Forest", Ganadera = "Ranch")) +
  stat_summary(aes(x=type_of_site, y=beak_volume), fun.y = mean, geom = "point", col='black')