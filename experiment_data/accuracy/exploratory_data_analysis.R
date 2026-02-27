
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


# initiatives by age plots
energy <- ggplot(response_data, mapping=aes(x=energy_initiative, fill=age)) + geom_bar() +
  labs(x="", y="vote count", title="Energy Initiative") +
  annotate(geom = "text", x = "yes", y = 30, label = "22%") +
  annotate(geom = "text", x = "no", y = 82, label = "76%") + 
  annotate(geom = "text", x = "unknown", y = 8, label = "2%") + 
  ylim(0, 90) + theme_bw()
taxes <- ggplot(response_data, mapping=aes(x=taxes_initiative, fill=age)) + geom_bar() +
  labs(x="", y="vote count", title="Taxes Initiative") +
  annotate(geom = "text", x = "yes", y = 30, label = "22%") +
  annotate(geom = "text", x = "no", y = 82, label = "76%") + 
  annotate(geom = "text", x = "unknown", y = 8, label = "2%") + 
  ylim(0, 90) + theme_bw()
carbon <- ggplot(response_data, mapping=aes(x=carbon_tax_initiative, fill=age)) + geom_bar() +
  labs(x="", y="vote count", title="Carbon Tax Initiative") +
  annotate(geom = "text", x = "yes", y = 42, label = "34%") +
  annotate(geom = "text", x = "no", y = 70, label = "64%") + 
  annotate(geom = "text", x = "unknown", y = 8, label = "2%") + 
  ylim(0, 90) + theme_bw()
insurance <- ggplot(response_data, mapping=aes(x=insurance_initiative, fill=age)) + geom_bar() +
  labs(x="", y="vote count", title="Insurance Initiative") +
  annotate(geom = "text", x = "yes", y = 44, label = "36%") +
  annotate(geom = "text", x = "no", y = 68, label = "62%") + 
  annotate(geom = "text", x = "unknown", y = 8, label = "2%") + 
  ylim(0, 90) + theme_bw()

energy + taxes + carbon + insurance + plot_annotation(title="Predicted initiative votes by age")


# initiatives by gender plots
energy <- ggplot(response_data, mapping=aes(x=energy_initiative, fill=gender)) + geom_bar() +
  labs(x="", y="vote count", title="Energy Initiative") + theme_bw()
taxes <- ggplot(response_data, mapping=aes(x=taxes_initiative, fill=gender)) + geom_bar() +
  labs(x="", y="vote count", title="Taxes Initiative") + theme_bw()
carbon <- ggplot(response_data, mapping=aes(x=carbon_tax_initiative, fill=gender)) + geom_bar() +
  labs(x="", y="vote count", title="Carbon Tax Initiative") + theme_bw()
insurance <- ggplot(response_data, mapping=aes(x=insurance_initiative, fill=gender)) + geom_bar() +
  labs(x="", y="vote count", title="Insurance Initiative") + theme_bw()

energy + taxes + carbon + insurance + plot_annotation(title="Predicted initiative votes by gender")


# initiatives by county plots
energy <- ggplot(response_data, mapping=aes(x=energy_initiative, fill=county)) + geom_bar() +
  labs(x="", y="vote count", title="Energy Initiative") + guides(fill="none") + theme_bw()
taxes <- ggplot(response_data, mapping=aes(x=taxes_initiative, fill=county)) + geom_bar() +
  labs(x="", y="vote count", title="Taxes Initiative") +  guides(fill="none") + theme_bw()
carbon <- ggplot(response_data, mapping=aes(x=carbon_tax_initiative, fill=county)) + geom_bar() +
  labs(x="", y="vote count", title="Carbon Tax Initiative") +  guides(fill="none") + theme_bw()
insurance <- ggplot(response_data, mapping=aes(x=insurance_initiative, fill=county)) + geom_bar() +
  labs(x="", y="vote count", title="Insurance Initiative") +  guides(fill="none") + theme_bw()

energy + taxes + carbon + insurance + plot_annotation(title="Predicted initiative votes by county")