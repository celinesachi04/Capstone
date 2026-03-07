
library(dplyr)
library(ExactMultinom)

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



# P(age, gender | county) for covariate combinations ------------------------

for (row in 1:nrow(response_data)) {
  county <- unlist(response_data[row, "county"])
  age <- unlist(response_data[row, "age"])
  gender <- unlist(response_data[row, "gender"])
  
  p_county <- county_prop[county] # P(county)
  p_age <- wa_age_county_prop[wa_age_county_prop[, "County"]==county, age] # P(age | county)
  p_gender <- wa_gender_county_prop[wa_gender_county_prop[, "County"] == county, gender] # P(gender | county)
  
  prop <- p_age * p_gender # P(age, gender | county)
  response_data[row, "pop_count"] <- prop * N
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
               "Washington State Attorney General"="attorney_general")

party_votes <- c("Democrat"=2713178, "Republican"=1432497, "Third_party"=1043921) # data from https://independentvoterproject.org/voter-stats/wa
manual_counts <- data.frame("vote_democrat"=c(2713178, 1432497 + 1043921),
                            "vote_republican"=c(1432497, 2713178 + 1043921),
                            "vote_third_party"=c(1043921, 2713178 + 1432497))
rownames(manual_counts) <- c("yes", "no")

get_counts <- function(county, measure, vote) {
  measure_name <- names(which(questions==measure))
  count <- (county_data %>% filter(County==county, Race==measure_name, grepl(vote, Candidate)))["Votes"]
  return(unlist(count))
  }


results_list <- vector(mode="list", length=length(questions))
names(results_list) <- questions

for (question in questions) {
  question_data <- response_data %>% count(county, age, gender, !!sym(question))
  
  for (row in 1:nrow(question_data)) {
    county <- question_data[row, "county"]
    measure_name <- names(which(questions==question))
    vote <- question_data[row, question]
    if (vote == "Unknown") {
      num_votes <- NA
    } else if (question == "what_party") {
      num_votes <- unlist(party_votes[vote])
    } else if (question %in% c("vote_democrat", "vote_republican", "vote_third_party")) {
      num_votes <- manual_counts[vote, question]
    } else {
      num_votes <- (county_data %>% filter(County==county,
                                       Race==measure_name,
                                       grepl(vote, Candidate)))["Votes"]
      num_votes <- as.numeric(num_votes) / 100
    }
     prob_covariates <- unlist(response_data %>% filter(county==question_data[row, "county"],
                                                  age==question_data[row, "age"],
                                                  gender==question_data[row, "gender"]) %>%
                           select(pop_proportion))[1]
    question_data[row, "expected_count"] <- prob_covariates * num_votes * 100 / N
  }
  
  test_data <- na.omit(question_data) %>%
    mutate("expected_prob"=expected_count/sum(expected_count))
  results <- multinom.test(x=test_data$n, p=test_data$expected_prob, method="Monte-Carlo")
  results_list[question] <- results
}

