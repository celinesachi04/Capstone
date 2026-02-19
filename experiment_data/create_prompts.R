
# Questions
## General questions
what_party <- paste0("For each voter in the voter data, what party is the voter likely to vote for in the next ",
                     "U.S. presidential election? Respond with one word, yes no. ",
                     "Can only return unknown sparingly: voter id. prediction")
vote_democrat <- paste0("For each voter in the voter data, is the voter likely to vote ",
                        "democrat in the next U.S. presidential election? Respond with ",
                        "one word, yes no. Can only return unknown sparingly: voter id. prediction")
vote_republican <- paste0("For each voter in the voter data, is the voter likely to vote ",
                          "republican in the next U.S. presidential election? Respond with ",
                          "one word, yes no. Can only return unknown sparingly: voter id. prediction")
vote_third_party <- paste0("For each voter in the voter data, is the voter likely to vote third party in the next U.S. ",
                           "presidential election? Respond with one word, yes no. Can ",
                           "only return unknown sparingly: voter id. prediction")
easy_to_predict <- paste0("For each voter in the voter data, is their behavior easy to predict? Respond with one word, ",
                          "yes no. Can only return unknown sparingly: voter id. prediction")

## Pew study questions: https://www.pewresearch.org/politics/quiz/political-typology/
  
gov_services <- paste0("for each voter in the voter data , does the voter think A: small government providing ",
                       "fewer services; or B: bigger government providing more services; ",
                       "Respond with only A B. Can only return unknown sparingly: voter id. prediction")
corporation_profit <- paste0("Does this voter think A: Business corporations make ",
                             "too much profit or B: Most corporations make a fair ",
                             "and reasonable amount of profit. ",
                             "Can only return unknown sparingly: voter id. prediction")
candidates_view <- paste0("for each voter in the voter data, which comes closer to the voters view of candidates ",
                          "for political office, even if neither is exactly right? ",
                          "A: There is at least one candidate who shares most of my ",
                          "views; B: None of the candidates represent my views well. ",
                          "Respond with only A B. Can only return unknown sparingly: voter id. prediction")
religion_government <- paste0("For each voter in the voter data, which of the following ",
                              "statements comes closest to their view? Religion should ",
                              "be kept separate from government policies Government policies ",
                              "should support religious values and beliefs. Respond with only A B. ",
                              "Can only return unknown sparingly: voter id. prediction")

## Specific voting: https://www.sos.wa.gov/elections/data-research/election-results-and-voters-pamphlets/2024-general-election-voters-guide
### Federal:
president_vote <- paste0("For each voter in the voter data, who would the voter vote ",
                         "for in the 2024 general election for President/Vice President? ",
                         "Respond with only the first name of the presidential candidate. ",
                         "Can only return unknown sparingly: voter id. prediction")
wa_senator <- paste0("For each voter in the voter data, would the voter vote for Maria Cantwell ",
                     "or Dr Raul Garcia for U.S. Senator for Washington State in the 2024 ",
                     "General Election? Respond with only the first name of the candidate. ",
                     "Can only return unknown sparingly: voter id. prediction")
### State:
energy_initiative <- paste0("For each voter in the voter data, how would the voter vote on the following: ",
                            "Initiative Measure No. 2066 concerns regulating energy services, ",
                            "including natural gas and electrification. This measure would repeal ",
                            "or prohibit certain laws and regulations that discourage natural gas ",
                            "use and/or promote electrification, and require certain utilities and ",
                            "local governments to provide natural gas to eligible customers. Should ",
                            "this measure be enacted into law? Respond with one word, yes no. Can ",
                            "only return unknown sparingly: voter id. prediction")
taxes_initiative <- paste0("For each voter in the voter data, how would the voter vote on the following: ",
                           "Initiative Measure No. 2109 concerns taxes. This measure would repeal ",
                           "an excise tax imposed on the sale or exchange of certain long-term ",
                           "capital assets by individuals who have annual capital gains of over ",
                           "$250,000. This measure would decrease funding for K-12 education, ",
                           "higher education, school construction, early learning, and childcare. ",
                           "Should this measure be enacted into law? Respond with one word, yes no. Can ",
                           "only return unknown sparingly: voter id. prediction")
carbon_tax_initiative <- paste0("For each voter in the voter data, how would the voter vote on the following: ",
                                "Initiative Measure No. 2117 concerns carbon tax credit trading. This ",
                                "measure would prohibit state agencies from imposing any type of ",
                                "carbon tax credit trading, and repeal legislation establishing a ",
                                "cap and invest program to reduce greenhouse gas emissions. This ",
                                "measure would decrease funding for investments in transportation, ",
                                "clean air, renewable energy, conservation, and emissions-reduction. ",
                                "Should this measure be enacted into law? Respond with one word, yes no. Can ",
                                "only return unknown sparingly: voter id. prediction")
insurance_initiative <- paste0("For each voter in the voter data, how would the voter vote on the following: ",
                               "Initiative Measure No. 2124 concerns state long term care insurance. ",
                               "This measure would provide that employees and self-employed people must ",
                               "elect to keep coverage under RCW 50B.04 and could opt-out any time. It ",
                               "would also repeal a law governing an exemption for employees. This measure ",
                               "would decrease funding for Washington’s public insurance program providing ",
                               "long-term care benefits and services. Should this measure be enacted into law?",
                               "Respond with one word, yes no. Can ",
                               "only return unknown sparingly: voter id. prediction")

supreme_court <- paste0("For each voter in the voter data, would the voter vote ",
                        "for Sal Mungia or Dave Larson for Supreme Court Justice Position ",
                        "#02 in Washington State, in the 2024 general election?, Respond ",
                        "with only the first name of the candidate. Can only return unknown ",
                        "sparingly: voter id. prediction")

governor <- paste0("For each voter in the voter data, would the voter vote ",
                   "for Bob Ferguson or Dave Reichert for Governor ",
                   "in Washington State, in the 2024 general election?, Respond ",
                   "with only the first name of the candidate. Can only return unknown ",
                   "sparingly: voter id. prediction")
state_treasurer <- paste0("For each voter in the voter data, would the voter vote ",
                          "for Mike Pellicciotti or Sharon Hanek for State Treasurer ",
                          "in Washington State, in the 2024 general election?, Respond ",
                          "with only the first name of the candidate. Can only return unknown ",
                          "sparingly: voter id. prediction")
attorney_general <- paste0("For each voter in the voter data, would the voter vote ",
                           "for Pete Serrano or Nick Brown for Attorney General ",
                           "in Washington State, in the 2024 general election?, Respond ",
                           "with only the first name of the candidate. Can only return unknown ",
                           "sparingly: voter id. prediction")


# Save questions as files
df_all <- read.csv("C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\experiment_data\\consistency\\sample_voters\\df_all.csv", header=TRUE)
df_demo <- read.csv("C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\experiment_data\\consistency\\sample_voters\\df_demo.csv", header=TRUE)
df_family <- read.csv("C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\experiment_data\\consistency\\sample_voters\\df_family.csv", header=TRUE)
df_ses <- read.csv("C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\experiment_data\\consistency\\sample_voters\\df_ses.csv", header=TRUE)

all_formatted_data <- apply(X=df_all, MARGIN=1, FUN=function(X) paste(X, collapse=", "))
demo_formatted_data <- apply(X=df_demo, MARGIN=1, FUN=function(X) paste(X, collapse=", "))
family_formatted_data <- apply(X=df_family, MARGIN=1, FUN=function(X) paste(X, collapse=", "))
ses_formatted_data <- apply(X=df_ses, MARGIN=1, FUN=function(X) paste(X, collapse=", "))

questions <- c("what_party"=what_party, "vote_democrat"=what_party, "vote_republican"=what_party,
               "vote_third_party"=vote_third_party, "easy_to_predict"=easy_to_predict,
               "gov_services"=gov_services, "corporation_profit"=corporation_profit,
               "candidates_view"=candidates_view, "religion_government"=religion_government,
               "president_vote"=president_vote, "wa_senator"=wa_senator, "energy_initiative"=energy_initiative,
               "taxes_initiative"=taxes_initiative, "carbon_tax_initiative"=carbon_tax_initiative,
               "insurance_initiative"=insurance_initiative, "supreme_court"=supreme_court,
               "governor"=governor, "state_treasurer"=state_treasurer, "attorney_general"=attorney_general)


for (question in names(questions)) {
  # all covariates
  all_prompt <- paste0("Voter data (", paste(colnames(df_all), collapse=", "), "): ",
                       paste(all_formatted_data, collapse="; "),
                       ". ", questions[question])
  all_file_path <- paste0("C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\experiment_data\\prompts\\all_covariates\\",
                          question, ".txt")
  writeLines(all_prompt, all_file_path)
  
  # demo covariates
  demo_prompt <- paste0("Voter data (", paste(colnames(df_demo), collapse=", "), "): ",
                       paste(demo_formatted_data, collapse="; "),
                       ". ", questions[question])
  demo_file_path <- paste0("C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\experiment_data\\prompts\\demo_covariates\\",
                           question, ".txt")
  writeLines(demo_prompt, demo_file_path)
  
  # family covariates
  family_prompt <- paste0("Voter data (", paste(colnames(df_family), collapse=", "), "): ",
                        paste(family_formatted_data, collapse="; "),
                        ". ", questions[question])
  family_file_path <- paste0("C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\experiment_data\\prompts\\family_covariates\\",
                             question, ".txt")
  writeLines(family_prompt, family_file_path)

  # ses covariates
  ses_prompt <- paste0("Voter data (", paste(colnames(df_ses), collapse=", "), "): ",
                          paste(ses_formatted_data, collapse="; "),
                          ". ", questions[question])
  ses_file_path <- paste0("C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\experiment_data\\prompts\\ses_covariates\\",
                             question, ".txt")
  writeLines(ses_prompt, ses_file_path)
}
