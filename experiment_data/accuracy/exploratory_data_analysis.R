
library(ggplot2)
library(dplyr)
library(patchwork)

response_data <- read.csv("C:/Users/casey/Desktop/Stat 496/Capstone/experiment_data/accuracy/response_data.csv")

table(response_data %>% select(what_party, vote_democrat))
table(response_data %>% select(what_party, vote_republican))

sum(ifelse(response_data$energy_initiative == "yes", 1, 0))
sum(ifelse(response_data$energy_initiative == "no", 1, 0))
sum(ifelse(response_data$energy_initiative == "unknown", 1, 0))


table(response_data$energy_initiative)

initiative_data <- data.frame("initiative"=c("energy_initiative", "taxes_initiative",
                                             "carbon_tax_initiative", "insurance_initiative"),
                              "no"=NA,
                              "unknown"=NA,
                              "yes"=NA)

for (initiative in initiative_data$initiative) {
  summary <- table(response_data[, initiative])
  initiative_data[initiative_data[, "initiative"]==initiative, -1] <- summary
}

initiative_data





energy <- ggplot(response_data, mapping=aes(x=energy_initiative, fill=age)) + geom_bar() +
  labs(x="", title="Energy Initiative") + annotate(geom = "text", x = "no", y = 60, label = "62%") + theme_bw()
taxes <- ggplot(response_data, mapping=aes(x=taxes_initiative, fill=age)) + geom_bar() +
  labs(x="", title="Taxes Initiative") + theme_bw()
carbon <- ggplot(response_data, mapping=aes(x=carbon_tax_initiative, fill=age)) + geom_bar() +
  labs(x="", title="Carbon Tax Initiative") + theme_bw()
insurance <- ggplot(response_data, mapping=aes(x=insurance_initiative, fill=age)) + geom_bar() +
  labs(x="", title="Insurance Initiative") + theme_bw()

energy + taxes + carbon + insurance + plot_annotation(title="Predicted initiative votes by age")

energy <- ggplot(response_data, mapping=aes(x=energy_initiative, fill=gender)) + geom_bar() +
  labs(x="", title="Energy Initiative") + theme_bw()
taxes <- ggplot(response_data, mapping=aes(x=taxes_initiative, fill=gender)) + geom_bar() +
  labs(x="", title="Taxes Initiative") + theme_bw()
carbon <- ggplot(response_data, mapping=aes(x=carbon_tax_initiative, fill=gender)) + geom_bar() +
  labs(x="", title="Carbon Tax Initiative") + theme_bw()
insurance <- ggplot(response_data, mapping=aes(x=insurance_initiative, fill=gender)) + geom_bar() +
  labs(x="", title="Insurance Initiative") + theme_bw()

energy + taxes + carbon + insurance + plot_annotation(title="Predicted initiative votes by county")
