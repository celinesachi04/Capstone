
library(ggplot2)

response_data <- read.csv("C:/Users/casey/Desktop/Stat 496/Capstone/experiment_data/accuracy/response_data.csv")
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

table(response_data %>% select(what_party, vote_democrat))
table(response_data %>% select(what_party, vote_republican))


# Ideally, would want this number to be 1.0
nrow(response_data %>% filter(vote_democrat=="no",
                              vote_republican=="yes",
                              vote_third_party=="no")) / 
  nrow(response_data %>% filter(what_party=="Republican"))

