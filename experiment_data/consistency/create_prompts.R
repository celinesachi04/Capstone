
# Questions
## General questions
what_party <- paste0("For each voter in the voter data, what party is the voter likely to vote for in the next ",
                     "U.S. presidential election? Respond with one word, name of party. ",
                     "Rules (MUST follow all): Can only return unknown sparingly, do not omit any voter, Produce EXACTLY 100 predictions, Return only the 100 prediction lines with no intro or explanation, For line k, use voter_ID from row k in the voter data above, Do NOT sort, group, or reorder by voter_ID; keep the exact row sequence as provided, do not fabricate voter_ID values, Format each line exactly: voter_ID. prediction")
vote_democrat <- paste0("For each voter in the voter data, is the voter likely to vote ",
                        "democrat in the next U.S. presidential election? Respond with ",
                        "one word, yes no. Rules (MUST follow all): Can only return unknown sparingly, do not omit any voter, Produce EXACTLY 100 predictions, Return only the 100 prediction lines with no intro or explanation, For line k, use voter_ID from row k in the voter data above, Do NOT sort, group, or reorder by voter_ID; keep the exact row sequence as provided, do not fabricate voter_ID values, Format each line exactly: voter_ID. prediction")
vote_republican <- paste0("For each voter in the voter data, is the voter likely to vote ",
                          "republican in the next U.S. presidential election? Respond with ",
                          "one word, yes no. Rules (MUST follow all): Can only return unknown sparingly, do not omit any voter, Produce EXACTLY 100 predictions, Return only the 100 prediction lines with no intro or explanation, For line k, use voter_ID from row k in the voter data above, Do NOT sort, group, or reorder by voter_ID; keep the exact row sequence as provided, do not fabricate voter_ID values, Format each line exactly: voter_ID. prediction")
vote_third_party <- paste0("For each voter in the voter data, is the voter likely to vote third party in the next U.S. ",
                           "presidential election? Respond with one word, yes no. Use this decision rule: output yes when your estimated chance of a third-party vote is 20% or higher, otherwise no. Do not default to one label for every voter; evaluate each voter independently based on their covariates. Rules (MUST follow all): Can only return unknown sparingly, do not omit any voter, Produce EXACTLY 100 predictions, Return only the 100 prediction lines with no intro or explanation, For line k, use voter_ID from row k in the voter data above, Do NOT sort, group, or reorder by voter_ID; keep the exact row sequence as provided, do not fabricate voter_ID values, Format each line exactly: voter_ID. prediction")
easy_to_predict <- paste0("For each voter in the voter data, is their behavior easy to predict? Respond with one word, ",
                          "yes no. Rules (MUST follow all): Can only return unknown sparingly, do not omit any voter, Produce EXACTLY 100 predictions, Return only the 100 prediction lines with no intro or explanation, For line k, use voter_ID from row k in the voter data above, Do NOT sort, group, or reorder by voter_ID; keep the exact row sequence as provided, do not fabricate voter_ID values, Format each line exactly: voter_ID. prediction")

## Pew study questions: https://www.pewresearch.org/politics/quiz/political-typology/
  
gov_services <- paste0("for each voter in the voter data , does the voter think A: small government providing ",
                       "fewer services; or B: bigger government providing more services; ",
                       "Respond with only A B. Rules (MUST follow all): Can only return unknown sparingly, do not omit any voter, Produce EXACTLY 100 predictions, Return only the 100 prediction lines with no intro or explanation, For line k, use voter_ID from row k in the voter data above, Do NOT sort, group, or reorder by voter_ID; keep the exact row sequence as provided, do not fabricate voter_ID values, Format each line exactly: voter_ID. prediction")
corporation_profit <- paste0("Does this voter think A: Business corporations make ",
                             "too much profit or B: Most corporations make a fair ",
                             "and reasonable amount of profit. ",
                             " Rules (MUST follow all): Can only return unknown sparingly, do not omit any voter, Produce EXACTLY 100 predictions, Return only the 100 prediction lines with no intro or explanation, For line k, use voter_ID from row k in the voter data above, Do NOT sort, group, or reorder by voter_ID; keep the exact row sequence as provided, do not fabricate voter_ID values, Format each line exactly: voter_ID. prediction")
candidates_view <- paste0("for each voter in the voter data, which comes closer to the voters view of candidates ",
                          "for political office, even if neither is exactly right? ",
                          "A: There is at least one candidate who shares most of my ",
                          "views; B: None of the candidates represent my views well. ",
                          "Respond with only A B. Rules (MUST follow all): Can only return unknown sparingly, do not omit any voter, Produce EXACTLY 100 predictions, Return only the 100 prediction lines with no intro or explanation, For line k, use voter_ID from row k in the voter data above, Do NOT sort, group, or reorder by voter_ID; keep the exact row sequence as provided, do not fabricate voter_ID values, Format each line exactly: voter_ID. prediction")
religion_government <- paste0("For each voter in the voter data, which of the following ",
                              "statements comes closest to their view? Religion should ",
                              "be kept separate from government policies Government policies ",
                              "should support religious values and beliefs. Respond with only A B. ",
                              " Rules (MUST follow all): Can only return unknown sparingly, do not omit any voter, Produce EXACTLY 100 predictions, Return only the 100 prediction lines with no intro or explanation, For line k, use voter_ID from row k in the voter data above, Do NOT sort, group, or reorder by voter_ID; keep the exact row sequence as provided, do not fabricate voter_ID values, Format each line exactly: voter_ID. prediction")

## Specific voting: https://www.sos.wa.gov/elections/data-research/election-results-and-voters-pamphlets/2024-general-election-voters-guide
### Federal:
president_vote <- paste0("For each voter in the voter data, who would the voter vote ",
                         "for in the 2024 general election for President/Vice President? ",
                         "Respond with only one word: Trump or Kamala. ",
                         " Rules (MUST follow all): Can only return unknown sparingly, do not omit any voter, Produce EXACTLY 100 predictions, Return only the 100 prediction lines with no intro or explanation, For line k, use voter_ID from row k in the voter data above, Do NOT sort, group, or reorder by voter_ID; keep the exact row sequence as provided, do not fabricate voter_ID values, Format each line exactly: voter_ID. prediction")
wa_senator <- paste0("For each voter in the voter data, would the voter vote for Maria Cantwell ",
                     "or Dr Raul Garcia for U.S. Senator for Washington State in the 2024 ",
                     "General Election? Respond with only the first name of the candidate. ",
                     " Rules (MUST follow all): Can only return unknown sparingly, do not omit any voter, Produce EXACTLY 100 predictions, Return only the 100 prediction lines with no intro or explanation, For line k, use voter_ID from row k in the voter data above, Do NOT sort, group, or reorder by voter_ID; keep the exact row sequence as provided, do not fabricate voter_ID values, Format each line exactly: voter_ID. prediction")
### State:
energy_initiative <- paste0("For each voter in the voter data, how would the voter vote on the following: ",
                            "Initiative Measure No. 2066 concerns regulating energy services, ",
                            "including natural gas and electrification. This measure would repeal ",
                            "or prohibit certain laws and regulations that discourage natural gas ",
                            "use and/or promote electrification, and require certain utilities and ",
                            "local governments to provide natural gas to eligible customers. Should ",
                            "this measure be enacted into law? Respond with one word, yes no. Rules (MUST follow all): Can ",
                            "only return unknown sparingly, do not omit any voter, Produce EXACTLY 100 predictions, Return only the 100 prediction lines with no intro or explanation, For line k, use voter_ID from row k in the voter data above, Do NOT sort, group, or reorder by voter_ID; keep the exact row sequence as provided, do not fabricate voter_ID values, Format each line exactly: voter_ID. prediction")
taxes_initiative <- paste0("For each voter in the voter data, how would the voter vote on the following: ",
                           "Initiative Measure No. 2109 concerns taxes. This measure would repeal ",
                           "an excise tax imposed on the sale or exchange of certain long-term ",
                           "capital assets by individuals who have annual capital gains of over ",
                           "$250,000. This measure would decrease funding for K-12 education, ",
                           "higher education, school construction, early learning, and childcare. ",
                           "Should this measure be enacted into law? Respond with one word, yes no. Rules (MUST follow all): Can ",
                           "only return unknown sparingly, do not omit any voter, Produce EXACTLY 100 predictions, Return only the 100 prediction lines with no intro or explanation, For line k, use voter_ID from row k in the voter data above, Do NOT sort, group, or reorder by voter_ID; keep the exact row sequence as provided, do not fabricate voter_ID values, Format each line exactly: voter_ID. prediction")
carbon_tax_initiative <- paste0("For each voter in the voter data, how would the voter vote on the following: ",
                                "Initiative Measure No. 2117 concerns carbon tax credit trading. This ",
                                "measure would prohibit state agencies from imposing any type of ",
                                "carbon tax credit trading, and repeal legislation establishing a ",
                                "cap and invest program to reduce greenhouse gas emissions. This ",
                                "measure would decrease funding for investments in transportation, ",
                                "clean air, renewable energy, conservation, and emissions-reduction. ",
                                "Should this measure be enacted into law? Respond with one word, yes no. Rules (MUST follow all): Can ",
                                "only return unknown sparingly, do not omit any voter, Produce EXACTLY 100 predictions, Return only the 100 prediction lines with no intro or explanation, For line k, use voter_ID from row k in the voter data above, Do NOT sort, group, or reorder by voter_ID; keep the exact row sequence as provided, do not fabricate voter_ID values, Format each line exactly: voter_ID. prediction")
insurance_initiative <- paste0("For each voter in the voter data, how would the voter vote on the following: ",
                               "Initiative Measure No. 2124 concerns state long term care insurance. ",
                               "This measure would provide that employees and self-employed people must ",
                               "elect to keep coverage under RCW 50B.04 and could opt-out any time. It ",
                               "would also repeal a law governing an exemption for employees. This measure ",
                               "would decrease funding for Washington’s public insurance program providing ",
                               "long-term care benefits and services. Should this measure be enacted into law?",
                               "Respond with one word, yes no. Rules (MUST follow all): Can only return unknown sparingly, do not omit any voter, Produce EXACTLY 100 predictions, Return only the 100 prediction lines with no intro or explanation, For line k, use voter_ID from row k in the voter data above, Do NOT sort, group, or reorder by voter_ID; keep the exact row sequence as provided, do not fabricate voter_ID values, Format each line exactly: voter_ID. prediction")

supreme_court <- paste0("For each voter in the voter data, would the voter vote ",
                        "for Sal Mungia or Dave Larson for Supreme Court Justice Position ",
                        "#02 in Washington State, in the 2024 general election?, Respond ",
                        "with only the first name of the candidate. Rules (MUST follow all): Can only return unknown sparingly, do not omit any voter, Produce EXACTLY 100 predictions, Return only the 100 prediction lines with no intro or explanation, For line k, use voter_ID from row k in the voter data above, Do NOT sort, group, or reorder by voter_ID; keep the exact row sequence as provided, do not fabricate voter_ID values, Format each line exactly: voter_ID. prediction")

governor <- paste0("For each voter in the voter data, would the voter vote ",
                   "for Bob Ferguson or Dave Reichert for Governor ",
                   "in Washington State, in the 2024 general election?, Respond ",
                   "with only the first name of the candidate. Rules (MUST follow all): Can only return unknown ",
                   "sparingly, do not omit any voter, Produce EXACTLY 100 predictions, Return only the 100 prediction lines with no intro or explanation, For line k, use voter_ID from row k in the voter data above, Do NOT sort, group, or reorder by voter_ID; keep the exact row sequence as provided, do not fabricate voter_ID values, Format each line exactly: voter_ID. prediction")
state_treasurer <- paste0("For each voter in the voter data, would the voter vote ",
                          "for Mike Pellicciotti or Sharon Hanek for State Treasurer ",
                          "in Washington State, in the 2024 general election?, Respond ",
                          "with only the first name of the candidate. Rules (MUST follow all): Can only return unknown ",
                          "sparingly, do not omit any voter, Produce EXACTLY 100 predictions, Return only the 100 prediction lines with no intro or explanation, For line k, use voter_ID from row k in the voter data above, Do NOT sort, group, or reorder by voter_ID; keep the exact row sequence as provided, do not fabricate voter_ID values, Format each line exactly: voter_ID. prediction")
attorney_general <- paste0("For each voter in the voter data, would the voter vote ",
                           "for Pete Serrano or Nick Brown for Attorney General ",
                           "in Washington State, in the 2024 general election?, Respond ",
                           "with only the first name of the candidate. Rules (MUST follow all): Can only return unknown ",
                           "sparingly, do not omit any voter, Produce EXACTLY 100 predictions, Return only the 100 prediction lines with no intro or explanation, For line k, use voter_ID from row k in the voter data above, Do NOT sort, group, or reorder by voter_ID; keep the exact row sequence as provided, do not fabricate voter_ID values, Format each line exactly: voter_ID. prediction")


# Save questions as files
df_all <- read.csv("/Users/celine/Desktop/Capstone_Repo/Capstone/experiment_data/consistency/sample_voters/df_all.csv", header=TRUE)
df_demo <- read.csv("/Users/celine/Desktop/Capstone_Repo/Capstone/experiment_data/consistency/sample_voters/df_demo.csv", header=TRUE)
df_family <- read.csv("/Users/celine/Desktop/Capstone_Repo/Capstone/experiment_data/consistency/sample_voters/df_family.csv", header=TRUE)
df_ses <- read.csv("/Users/celine/Desktop/Capstone_Repo/Capstone/experiment_data/consistency/sample_voters/df_ses.csv", header=TRUE)

questions <- c("what_party"=what_party, "vote_democrat"=vote_democrat, "vote_republican"=vote_republican,
               "vote_third_party"=vote_third_party, "easy_to_predict"=easy_to_predict,
               "gov_services"=gov_services, "corporation_profit"=corporation_profit,
               "candidates_view"=candidates_view, "religion_government"=religion_government,
               "president_vote"=president_vote, "wa_senator"=wa_senator, "energy_initiative"=energy_initiative,
               "taxes_initiative"=taxes_initiative, "carbon_tax_initiative"=carbon_tax_initiative,
               "insurance_initiative"=insurance_initiative, "supreme_court"=supreme_court,
               "governor"=governor, "state_treasurer"=state_treasurer, "attorney_general"=attorney_general)


for (question in names(questions)) {
  # all covariates
  ## Randomize voter and covariate order
  rows_all <- sample(c(1:nrow(df_all)), size=nrow(df_all))
  cols_all <- sample(c(1:ncol(df_all)), size=ncol(df_all))
  shuffled_all <- df_all[rows_all, cols_all]
  
  ## Save all voter data into one string
  all_formatted_data <- apply(X=shuffled_all, MARGIN=1, FUN=function(X) paste(X, collapse=", "))
  ## Add question to voter data to create prompt
  all_prompt <- paste0("Voter data (", paste(colnames(shuffled_all), collapse=", "), "): ",
                       paste(all_formatted_data, collapse="; "),
                       ". ", questions[question])
  ## Save prompt
  all_file_path <- paste0("/Users/celine/Desktop/Capstone_Repo/Capstone/experiment_data/consistency/prompts/all_covariates/",
                          question, ".txt")
  writeLines(all_prompt, all_file_path)
  
  # demo covariates
  ## Randomize voter and covariate order
  rows_demo <- sample(c(1:nrow(df_demo)), size=nrow(df_demo))
  cols_demo <- sample(c(1:ncol(df_demo)), size=ncol(df_demo))
  shuffled_demo <- df_demo[rows_demo, cols_demo]
  
  ## Save all voter data into one string
  demo_formatted_data <- apply(X=shuffled_demo, MARGIN=1, FUN=function(X) paste(X, collapse=", "))
  ## Add question to voter data to create prompt
  demo_prompt <- paste0("Voter data (", paste(colnames(shuffled_demo), collapse=", "), "): ",
                       paste(demo_formatted_data, collapse="; "),
                       ". ", questions[question])
  ## Save prompt
  demo_file_path <- paste0("/Users/celine/Desktop/Capstone_Repo/Capstone/experiment_data/consistency/prompts/demo_covariates/",
                          question, ".txt")
  writeLines(demo_prompt, demo_file_path)
  
  # family covariates
  ## Randomize voter and covariate order
  rows_family <- sample(c(1:nrow(df_family)), size=nrow(df_family))
  cols_family <- sample(c(1:ncol(df_family)), size=ncol(df_family))
  shuffled_family <- df_family[rows_family, cols_family]
  
  ## Save all voter data into one string
  family_formatted_data <- apply(X=shuffled_family, MARGIN=1, FUN=function(X) paste(X, collapse=", "))
  ## Add question to voter data to create prompt
  family_prompt <- paste0("Voter data (", paste(colnames(shuffled_family), collapse=", "), "): ",
                        paste(family_formatted_data, collapse="; "),
                        ". ", questions[question])
  ## Save prompt
  family_file_path <- paste0("/Users/celine/Desktop/Capstone_Repo/Capstone/experiment_data/consistency/prompts/family_covariates/",
                           question, ".txt")
  writeLines(family_prompt, family_file_path)

  # ses covariates
  ## Randomize voter and covariate order
  rows_ses <- sample(c(1:nrow(df_ses)), size=nrow(df_ses))
  cols_ses <- sample(c(1:ncol(df_ses)), size=ncol(df_ses))
  shuffled_ses <- df_ses[rows_ses, cols_ses]
  
  ## Save all voter data into one string
  ses_formatted_data <- apply(X=shuffled_ses, MARGIN=1, FUN=function(X) paste(X, collapse=", "))
  ## Add question to voter data to create prompt
  ses_prompt <- paste0("Voter data (", paste(colnames(shuffled_ses), collapse=", "), "): ",
                          paste(ses_formatted_data, collapse="; "),
                          ". ", questions[question])
  ## Save prompt
  ses_file_path <- paste0("/Users/celine/Desktop/Capstone_Repo/Capstone/experiment_data/consistency/prompts/ses_covariates/",
                             question, ".txt")
  writeLines(ses_prompt, ses_file_path)
}
