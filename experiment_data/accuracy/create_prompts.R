
# Questions
## General questions
what_party <- paste0("For each voter in the voter data, what party is the voter likely to vote for in the next ",
                     "U.S. presidential election? Respond with one word, name of party. ",
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


sim_wa_voters <- read.csv("C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\experiment_data\\accuracy\\sample_voters\\sim_wa_voters.csv",
                          header=TRUE)
formatted_data <- apply(X=sim_wa_voters, MARGIN=1, FUN=function(X) paste(X, collapse=", "))
data_string <- paste0("Voter data (", paste(colnames(sim_wa_voters), collapse=", "), "): ")
                       
questions <- c("what_party"=what_party, "vote_democrat"=what_party, "vote_republican"=what_party,
               "vote_third_party"=vote_third_party,
               "president_vote"=president_vote, "wa_senator"=wa_senator, "energy_initiative"=energy_initiative,
               "taxes_initiative"=taxes_initiative, "carbon_tax_initiative"=carbon_tax_initiative,
               "insurance_initiative"=insurance_initiative, "supreme_court"=supreme_court,
               "governor"=governor, "state_treasurer"=state_treasurer, "attorney_general"=attorney_general)

for (question in names(questions)) {
  prompt <- paste0(data_string,
                   paste(formatted_data, collapse="; "),
                   ". ", questions[question])
  file_path <- paste0("C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\experiment_data\\accuracy\\prompts\\",
                          question, ".txt")
  writeLines(prompt, file_path)
}
