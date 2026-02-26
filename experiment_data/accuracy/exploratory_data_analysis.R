
library(ggplot2)

setwd("C:/Users/casey/Desktop/Stat 496/Capstone/experiment_data/accuracy")
response_data <- read.csv(".\\sample_voters\\sim_wa_voters.csv")
n <- nrow(response_data)

ggplot(response_data, mapping=aes(x=county, y=age, shape=gender, color=what_party)) +
  geom_point()

# Would want these values to sum to 100
nrow(response_data %>% filter(vote_democrat=="yes",
                              vote_republican=="no",
                              vote_third_party=="no"))
nrow(response_data %>% filter(vote_democrat=="no",
                              vote_republican=="yes",
                              vote_third_party=="no"))
nrow(response_data %>% filter(vote_democrat=="no",
                              vote_republican=="no",
                              vote_third_party=="yes"))

nrow(response_data %>% filter(what_party=="Democrat",
                              vote_democrat=="yes"))
nrow(response_data %>% filter(what_party=="Democrat",
                              vote_democrat=="no"))
nrow(response_data %>% filter(what_party=="Republican",
                              vote_republican=="yes"))
nrow(response_data %>% filter(what_party=="Republican",
                              vote_republican=="no"))
table(response_data %>% select(what_party, vote_democrat))


# Ideally, would want this number to be 1.0
nrow(response_data %>% filter(vote_democrat=="no",
                              vote_republican=="yes",
                              vote_third_party=="no")) / 
  nrow(response_data %>% filter(what_party=="Republican"))

