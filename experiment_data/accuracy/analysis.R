
library(dplyr)

response_data <- read.csv("C:/Users/casey/Desktop/Stat 496/Capstone/experiment_data/accuracy/response_data.csv")


# Covariate level population proportions ----------------------------------
# Files from https://www.sos.wa.gov/elections/data-research/election-data-and-maps/reports-data-and-statistics/voter-demographics
wa_demographics_file_path <- "C:/Users/casey/Desktop/Stat 496/Capstone/experiment_data/accuracy/sample_voters/Voter Demographics Tables.xlsx"
wa_demographics_tabs <- readxl::excel_sheets(wa_demographics_file_path)
wa_county_age <- readxl::read_excel(wa_demographics_file_path, sheet=wa_demographics_tabs[1])
wa_county_gender <- readxl::read_excel(wa_demographics_file_path, sheet=wa_demographics_tabs[2])

# Create variables
age_buckets <- colnames(wa_county_age)[-c(1, ncol(wa_county_age))]
wa_counties <- unlist(wa_county_age$County)[-nrow(wa_county_age)]
genders <- colnames(wa_county_gender)[-c(1, ncol(wa_county_gender))]
N <- unlist(wa_county_age[wa_county_age[, "County"]=="Total", "Total"])

# Variable population proportions
## P(county)
county_prop <- unlist(lapply(X=wa_counties,
                             FUN=function(X) {wa_county_age[wa_county_age[, "County"]==X, "Total"] /
                                 wa_county_age[wa_county_age[, "County"]=="Total", "Total"]}))
names(county_prop) <- wa_counties
## P(age bucket | county)
wa_age_county_prop <- data.frame("County"=wa_county_age$County)
for (bucket in age_buckets) {
  wa_age_county_prop[, bucket] <- wa_county_age[, bucket] / wa_county_age$Total
}
wa_age_county_prop <- wa_age_county_prop[-nrow(wa_age_county_prop), ]
## P(gender | county)
wa_gender_county_prop <- data.frame("County"=wa_county_age$County)
for (gender in genders) {
  wa_gender_county_prop[, gender] <- wa_county_gender[, gender] / wa_county_gender$Total
}
wa_gender_county_prop <- wa_gender_county_prop[-nrow(wa_gender_county_prop), ] 



# Population proportion for covariate combinations ------------------------

for (row in 1:nrow(response_data)) {
  county <- unlist(response_data[row, "county"])
  age <- unlist(response_data[row, "age"])
  gender <- unlist(response_data[row, "gender"])
  
  p_county <- county_prop[county] # P(county)
  p_age <- wa_age_county_prop[wa_age_county_prop[, "County"]==county, age] # P(age | county)
  p_gender <- wa_gender_county_prop[wa_gender_county_prop[, "County"] == county, gender] # P(gender | county)
  
  prop <- p_county * p_age * p_gender # P(county, age, gender)
  response_data[row, "pop_proportion"] <- prop
}


# Probability of vote prediction ------------------------------------------

setwd("C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\experiment_data\\accuracy") # data from https://results.vote.wa.gov/results/20241105/export.html
county_data <- read.csv("20241105_allcounties.csv") %>%
  mutate(Candidate=ifelse(Candidate=="Yes", "yes", ifelse(Candidate=="No", "no", Candidate)))
questions <- c("what_party"="what_party", "vote_democrat"="vote_democrat",
               "vote_republican"="vote_republican", "vote_third_party"="vote_third_party",
               "United States President/Vice President"="president_vote",
               "United States U.S. Senator"="wa_senator",
               "Washington State Initiative Measure No. 2066"="energy_initiative",
               "Washington State Initiative Measure No. 2109"="taxes_initiative",
               "Washington State Initiative Measure No. 2117"="carbon_tax_initiative",
               "Washington State Initiative Measure No. 2124"="insurance_initiative",
               "SUPREME COURT Justice Position #02"="supreme_court",
               "Washington State Governor"="governor",
               "Washington State State Treasurer"="state_treasurer",
               "Washington State State Treasurer"="attorney_general")


get_counts <- function(county, measure, vote) {
  measure_name <- names(which(questions==measure))
  count <- (county_data %>% filter(County==county, Race==measure_name, grepl(vote, Candidate)))["Votes"]
  return(unlist(count))
  }



# Get expected counts for 1 question: president_vote
question <- "president_vote"
question_data <- response_data %>% count(county, age, gender, !!sym(question))

for (row in 1:nrow(question_data)) {
  county <- question_data[row, "county"]
  measure_name <- names(which(questions==question))
  vote <- question_data[row, question]
  if (vote == "Unknown") {
    percent <- "unknown"
  } else {
    count <- (county_data %>% filter(County==county,
                                     Race==measure_name,
                                     grepl(vote, Candidate)))["Votes"]
  }
  question_data[row, "raw_count"] <- as.numeric(count)
}

raw_total <- sum(question_data$raw_count)
question_data <- question_data %>% mutate("expected_count"=raw_count/raw_total * 100)

test_data <- na.omit(question_data)
test_stat <- sum((test_data$n - test_data$expected_count)^2 / test_data$expected_count)
p_val <- pchisq(q=test_stat, df=(nrow(test_data) - 1))


