
library(dplyr)

# Files from https://www.sos.wa.gov/elections/data-research/election-data-and-maps/reports-data-and-statistics/voter-demographics
wa_demographics_file_path <- "C:/Users/casey/Desktop/Stat 496/Capstone/experiment_data/Voter Demographics Tables.xlsx"
wa_demographics_tabs <- readxl::excel_sheets(wa_demographics_file_path)
wa_county_age <- readxl::read_excel(wa_demographics_file_path, sheet=wa_demographics_tabs[1])
wa_county_gender <- readxl::read_excel(wa_demographics_file_path, sheet=wa_demographics_tabs[2])

# Create variables
age_buckets <- colnames(wa_county_age)[-c(1, ncol(wa_county_age))]
wa_counties <- unlist(wa_county_age$County)[-nrow(wa_county_age)]

genders <- colnames(wa_county_gender)[-c(1, ncol(wa_county_gender))]
return_methods <- c("dropbox", "mail", "other")
voter_id <- sprintf("%03d", 1:N)


# Data engineering
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




# Simulate voters based on WA demographic data
set.seed(496)
N <- 100


sampled_counties <- sample(x=wa_counties, size=N, replace=TRUE, prob=county_prop)
sampled_ages <- vector(length=N)
sampled_genders <- vector(length=N)
for (i in 1:N) {
  county <- sampled_counties[i]
  age <- sample(x=age_buckets, size=1, prob=(wa_age_county_prop %>% filter(County == county))[-1])
  gender <- sample(x=genders, size=1, prob=(wa_gender_county_prop %>% filter(County == county))[-1])
  sampled_ages[i] <- age
  sampled_genders[i] <- gender
}

simulated_voters <- data.frame("voter_id"=voter_id,
                               "county"=sampled_counties,
                               "age"=sampled_ages,
                               "gender"=sampled_genders)

write.csv(simulated_voters,
          "C:/Users/casey/Desktop/Stat 496/Capstone/experiment_data/accuracy/sample_voters/sim_wa_voters.csv",
          row.names = FALSE)

