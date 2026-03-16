
library(ggplot2)
library(dplyr)
library(patchwork)

response_data <- read.csv("C:/Users/casey/Desktop/Stat 496/Capstone/experiment_data/accuracy/response_data.csv")

table(response_data %>% select(what_party, vote_democrat))
table(response_data %>% select(what_party, vote_republican))
table(response_data %>% select(vote_democrat, vote_republican))

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
  if(initiative=="taxes_initiative") {
    summary <- c(summary[1], list("unknown"=0), summary[2])
  }
  initiative_data[initiative_data[, "initiative"]==initiative, -1] <- summary
}

initiative_data


# initiatives by age plots
energy <- ggplot(response_data, mapping=aes(x=energy_initiative, fill=age)) + geom_bar() +
  labs(x="", y="vote count", title="Energy Initiative") +
  annotate(geom = "text", x = "yes", y = 51, label = "45%") +
  annotate(geom = "text", x = "no", y = 59, label = "53%") + 
  annotate(geom = "text", x = "unknown", y = 8, label = "2%") + 
  ylim(0, 110) + theme_bw()
taxes <- ggplot(response_data, mapping=aes(x=taxes_initiative, fill=age)) + geom_bar() +
  labs(x="", y="vote count", title="Taxes Initiative") +
  annotate(geom = "text", x = "yes", y = 56, label = "50%") +
  annotate(geom = "text", x = "no", y = 56, label = "50%") + 
  annotate(geom = "text", x = "unknown", y = 6, label = "0%") + 
  ylim(0, 110) + theme_bw()
carbon <- ggplot(response_data, mapping=aes(x=carbon_tax_initiative, fill=age)) + geom_bar() +
  labs(x="", y="vote count", title="Carbon Tax Initiative") +
  annotate(geom = "text", x = "yes", y = 7, label = "1%") +
  annotate(geom = "text", x = "no", y = 104, label = "98%") + 
  annotate(geom = "text", x = "unknown", y = 7, label = "1%") + 
  ylim(0, 110) + theme_bw()
insurance <- ggplot(response_data, mapping=aes(x=insurance_initiative, fill=age)) + geom_bar() +
  labs(x="", y="vote count", title="Insurance Initiative") +
  annotate(geom = "text", x = "yes", y = 73, label = "67%") +
  annotate(geom = "text", x = "no", y = 37, label = "31%") + 
  annotate(geom = "text", x = "unknown", y = 7, label = "1%") + 
  ylim(0, 110) + theme_bw()

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
