rm(list=ls())
library(Hmisc) 

data <- read.csv("C:\Users\User\Downloads\COVID19_line_list_data.csv")
describe(data) # library command

# cleaned up 
data$death_dummy <- as.integer(data$death != 0)
# death rate
sum(data$death_dummy) / nrow(data)


# claim people who die are older
dead = subset(data, death_dummy == 1)
alive = subset(data, death_dummy == 0)
mean(dead$age, na.rm = TRUE)
mean(alive$age, na.rm = TRUE)

t.test(alive$age, dead$age, alternative="two.sided", conf.level = 0.99)
# normally p-value < 0.05 reject null hypothesis
# p-value ~ 0 reject the null hypothesis and conclude that this is statistically significant


# claim gender has no effect
men = subset(data, gender == "male")
women = subset(data, gender == "female")
mean(men$death_dummy, na.rm = TRUE) #8.5%!
mean(women$death_dummy, na.rm = TRUE) #3.7%

t.test(men$death_dummy, women$death_dummy, alternative="two.sided", conf.level = 0.99)
# men have from 0.8% to 8.8% higher chance of dying.
# p-value = 0.002 < 0.05, so this is statistically significant
