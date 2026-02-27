
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

response_data[, "pop_counts"] <- response_data$pop_proportion * N
