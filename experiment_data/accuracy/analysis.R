
library(dplyr)
library(ExactMultinom)
library(kableExtra)
library(ggplot2)

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

get_expected_counts <- function(question) {
  question_data <- response_data %>% count(county, age, gender, !!sym(question))
  
  for (row in 1:nrow(question_data)) {
    county <- question_data[row, "county"]
    measure_name <- names(which(questions==question))
    vote <- question_data[row, question]
    if (vote == "Unknown") {
      num_votes <- NA
    } else if (question == "what_party") {
      num_votes <- unlist(party_votes[vote]) * county_prop[county]
    } else if (question %in% c("vote_democrat", "vote_republican", "vote_third_party")) {
      num_votes <- manual_counts[vote, question] * county_prop[county]
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
  return(question_data)
}

# No aggregation
results_df <- data.frame("question"=c(unlist(as.list(questions), use.names=FALSE)),
                         row.names=c(unlist(as.list(questions), use.names=FALSE)))

for (question in questions) {
  question_data <- get_expected_counts(question)
  
  test_data <- na.omit(question_data) %>%
    mutate("expected_prob"=expected_count/sum(expected_count))
  
  # Exact multinomial goodness of fit test
  results <- multinom.test(x=test_data$n, p=test_data$expected_prob, method="Monte-Carlo")
  p_value <- results$pvals_mc[1]
  results_df[question, "p_value"] <- p_value
  
  # KL Divergence Test
  P <- test_data$n / nrow(test_data)
  Q <- test_data$expected_count / nrow(test_data)
  results_df[question, "divergence"] <- philentropy::KL(rbind(P, Q))
}

results_df %>% kbl(caption="Goodness-of-fit P-values", format="latex", row.names=FALSE, booktabs=TRUE)

results_df$question <- factor(results_df$question, levels=results_df$question)
total_divergence <- ggplot(data=results_df, mapping=aes(x=question, y=divergence, fill=question)) +
  geom_bar(stat="identity") +
  geom_text(aes(label=round(divergence, 2)), vjust=-0.3, size=3.2) +
  labs(title="KL divergence by question") +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 45, hjust=1)) 


# Aggregate over county
## initialize empty data sets
no_county_df <- data.frame("question"=c(unlist(as.list(questions), use.names=FALSE)),
                           row.names=c(unlist(as.list(questions), use.names=FALSE)))
no_age_df <- county_df
no_gender_df <- county_df
only_county_df <- county_df
only_age_df <- county_df
only_gender_df <- county_df

for (question in questions) {
  question_data <- get_expected_counts(question)
  
  # Calculate aggregated expected counts and drop 1 variable
  no_county_agg <- merge((question_data %>% group_by(age, gender, !!sym(question)) %>%
                            summarize("expected_count"=sum(expected_count, na.rm=TRUE), .groups="drop")),
                         (question_data %>% group_by(age, gender, !!sym(question)) %>%
                            summarize("n"=sum(n, na.rm=TRUE), .groups="drop"))) %>%
    filter(!!sym(question) != "Unknown", !!sym(question) != "unknown", !!sym(question) != "Unknown/Other") %>%
    mutate("expected_prob"=expected_count/sum(expected_count))
  no_age_agg <- merge((question_data %>% group_by(county, gender) %>%
                         summarize("expected_count"=sum(expected_count, na.rm=TRUE), .groups="drop")),
                      (question_data %>% group_by(county, gender, !!sym(question)) %>%
                         summarize("n"=sum(n, na.rm=TRUE), .groups="drop"))) %>%
    filter(!!sym(question) != "unknown", !!sym(question) != "Unknown", !!sym(question) != "Unknown/Other") %>%
    mutate("expected_prob"=expected_count/sum(expected_count))
  no_gender_agg <- merge((question_data %>% group_by(county, age, !!sym(question)) %>%
                            summarize("expected_count"=sum(expected_count, na.rm=TRUE), .groups="drop")),
                         (question_data %>% group_by(county, age, !!sym(question)) %>%
                            summarize("n"=sum(n, na.rm=TRUE), .groups="drop"))) %>%
    filter(!!sym(question) != "unknown", !!sym(question) != "Unknown", !!sym(question) != "Unknown/Other") %>%
    mutate("expected_prob"=expected_count/sum(expected_count))
  # Calculate aggregated expected counts and drop 2 variables
  only_county_agg <- merge((question_data %>% group_by(county, !!sym(question)) %>%
                              summarize("expected_count"=sum(expected_count, na.rm=TRUE), .groups="drop")),
                           (question_data %>% group_by(county, !!sym(question)) %>%
                              summarize("n"=sum(n, na.rm=TRUE), .groups="drop"))) %>%
    filter(!!sym(question) != "unknown", !!sym(question) != "Unknown", !!sym(question) != "Unknown/Other") %>%
    mutate("expected_prob"=expected_count/sum(expected_count))
  only_age_agg <- merge((question_data %>% group_by(age, !!sym(question)) %>%
                           summarize("expected_count"=sum(expected_count, na.rm=TRUE), .groups="drop")),
                        (question_data %>% group_by(age, !!sym(question)) %>%
                           summarize("n"=sum(n, na.rm=TRUE), .groups="drop"))) %>%
    filter(!!sym(question) != "unknown", !!sym(question) != "Unknown", !!sym(question) != "Unknown/Other") %>%
    mutate("expected_prob"=expected_count/sum(expected_count))
  only_gender_agg <- merge((question_data %>% group_by(gender, !!sym(question)) %>%
                              summarize("expected_count"=sum(expected_count, na.rm=TRUE), .groups="drop")),
                           (question_data %>% group_by(gender, !!sym(question)) %>%
                              summarize("n"=sum(n, na.rm=TRUE), .groups="drop"))) %>%
    filter(!!sym(question) != "unknown", !!sym(question) != "Unknown", !!sym(question) != "Unknown/Other") %>%
    mutate("expected_prob"=expected_count/sum(expected_count))
  
  # Exact Multinomial goodness-of-fit test
  no_county_df[question, "p_value"] <- multinom.test(x=no_county_agg$n,
                                                     p=no_county_agg$expected_prob,
                                                     method="Monte-Carlo")$pvals_mc[1]
  no_age_df[question, "p_value"] <- multinom.test(x=no_age_agg$n,
                                                     p=no_age_agg$expected_prob,
                                                     method="Monte-Carlo")$pvals_mc[1]
  no_gender_df[question, "p_value"] <- multinom.test(x=no_gender_agg$n,
                                                     p=no_gender_agg$expected_prob,
                                                     method="Monte-Carlo")$pvals_mc[1]
  only_county_df[question, "p_value"] <- multinom.test(x=only_county_agg$n,
                                                     p=only_county_agg$expected_prob,
                                                     method="Monte-Carlo")$pvals_mc[1]
  only_age_df[question, "p_value"] <- multinom.test(x=only_age_agg$n,
                                                     p=only_age_agg$expected_prob,
                                                     method="Monte-Carlo")$pvals_mc[1]
  only_gender_df[question, "p_value"] <- multinom.test(x=only_gender_agg$n,
                                                     p=only_gender_agg$expected_prob,
                                                     method="Monte-Carlo")$pvals_mc[1]
  
  # KL divergence
  no_county_df[question, "divergence"] <- philentropy::KL(rbind(no_county_agg$n/nrow(no_county_agg),
                                                          no_county_agg$expected_count/nrow(no_county_agg)))
  no_age_df[question, "divergence"] <- philentropy::KL(rbind(no_age_agg$n/nrow(no_age_agg),
                                                             no_age_agg$expected_count/nrow(no_age_agg)))
  no_gender_df[question, "divergence"] <- philentropy::KL(rbind(no_gender_agg$n/nrow(no_gender_agg),
                                                                no_gender_agg$expected_count/nrow(no_gender_agg)))
  only_county_df[question, "divergence"] <- philentropy::KL(rbind(only_county_agg$n/nrow(only_county_agg),
                                                                  only_county_agg$expected_count/nrow(only_county_agg)))
  only_age_df[question, "divergence"] <- philentropy::KL(rbind(only_age_agg$n/nrow(only_age_agg),
                                                               only_age_agg$expected_count/nrow(only_age_agg)))
  only_gender_df[question, "divergence"] <- philentropy::KL(rbind(only_gender_agg$n/nrow(only_gender_agg),
                                                                  only_gender_agg$expected_count/nrow(only_gender_agg)))
}


# Analyze aggregate results
colnames(no_county_df) <- c("question", "no_county_p_value", "no_county_divergence")
colnames(no_age_df) <- c("question", "no_age_p_value", "no_age_divergence")
colnames(no_gender_df) <- c("question", "no_gender_p_value", "no_gender_divergence")
colnames(only_county_df) <- c("question", "only_county_p_value", "only_county_divergence")
colnames(only_age_df) <- c("question", "only_age_p_value", "only_age_divergence")
colnames(only_gender_df) <- c("question", "only_gender_p_value", "only_gender_divergence")


total_df <- merge(no_county_df, merge(no_age_df,
                                      merge(no_gender_df,
                                            merge(only_county_df, merge(only_age_df, only_gender_df, by="question"),
                                                  by="question"), by="question"), by="question"), by="question")

# Divergence Analysis
## Data Cleaning
divergence_cols <- c("no_county_divergence", "no_age_divergence", "no_gender_divergence",
                     "only_county_divergence", "only_age_divergence", "only_gender_divergence")
divergence_long <- total_df %>% tidyr::pivot_longer(cols=all_of(divergence_cols),
                                                    names_to = "group", values_to = "divergence")
group_labels <- c(no_county_divergence="No County", no_age_divergence="No Age",
                  no_gender_divergence="No Gender", only_county_divergence="Only County",
                  only_age_divergence="Only Age", only_gender_divergence="Only Gender")
divergence_long <- divergence_long %>% mutate(group=recode(group, !!!group_labels))
divergence_long$question <- factor(divergence_long$question, levels=results_df$question)
## Plot
agg_divergence <- ggplot(data=divergence_long, mapping=aes(x=question, y=divergence, color=group)) +
  geom_point() +
  geom_line(mapping=aes(group=group), linewidth=0.8, alpha=0.5) +
  labs(title="KL divergence by question for each aggregated group") +
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 45, hjust=1))

total_divergence + agg_divergence

# Goodness-of-fit analysis
## Data Cleaning
pval_cols <- c("no_county_p_value", "no_age_p_value", "no_gender_p_value",
                     "only_county_p_value", "only_age_p_value", "only_gender_p_value")
pval_long <- total_df %>% tidyr::pivot_longer(cols=all_of(pval_cols),
                                                    names_to = "group", values_to = "p_value")
group_labels <- c(no_county_p_value="No County", no_age_p_value="No Age",
                  no_gender_p_value="No Gender", only_county_p_value="Only County",
                  only_age_p_value="Only Age", only_gender_p_value="Only Gender")
pval_long <- pval_long %>% mutate(group=recode(group, !!!group_labels))
## Plot
pval_long$question <- factor(pval_long$question, levels=results_df$question)
ggplot(data=pval_long, mapping=aes(x=question, y=log(p_value), color=group)) +
  geom_point() +
  geom_line(mapping=aes(group=group, linetype="log(0.05)"), linewidth=1, alpha=0.5) +
  geom_hline(yintercept=log(0.05), size=1) + 
  labs(title="Goodness-of-fit test P-Value by question for each aggregated group") +
  scale_linetype_manual(name="significance level", values=c("log(0.05)"=1)) +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 45, hjust=1))
## non-significant p-values
pval_long %>% filter(p_value >= 0.05) %>% select(question, group, p_value)

