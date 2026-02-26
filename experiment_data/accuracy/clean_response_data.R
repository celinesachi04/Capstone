
# Set working directory to accuracy folder
setwd("C:/Users/casey/Desktop/Stat 496/Capstone/experiment_data/accuracy")

questions <- c("what_party", "vote_democrat", "vote_republican", "vote_third_party",
               "president_vote", "wa_senator", "energy_initiative", "taxes_initiative",
               "carbon_tax_initiative", "insurance_initiative", "supreme_court",
               "governor", "state_treasurer", "attorney_general")

response_data <- read.csv(".\\sample_voters\\sim_wa_voters.csv")

for (question in questions) {
  # Read in txt response file
  response_file <- readLines(paste0(".\\responses\\", question, ".txt"))
  
  # Find first value of list of responses
  first_val <- grep("1. ", response_file)[1]
  # Exactract list of responses from txt response file
  response_text <- response_file[c(first_val: (first_val + 99))]
  
  # Split list into voter id and response value
  split_string <- stringr::str_split_fixed(response_text, ". ", 2)
  # Save information to data frame
  question_data <- data.frame("voter_id"=split_string[, 1],
                              "question"=split_string[, 2])
  names(question_data) <- c("voter_id", question)
  
  # Merge data into final data frame
  response_data <- merge(x=response_data, y=question_data, by="voter_id", all=TRUE)
}


# Fix specific columns
response_values <- stringr::str_split_fixed(response_data$what_party, ". ", 2)
response_data$what_party <- response_values[, 2]
response_data <- response_data %>%
  mutate(across(where(is.character), stringr::str_trim, side="left"))


# Save data frame as csv file
write.csv(response_data, file=".\\response_data.csv", row.names=FALSE)

