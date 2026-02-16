
simulated_voters <- read.csv("C:/Users/casey/Desktop/Stat 496/Capstone/experiment_data/simulated_voters.csv")
test_data <- head(simulated_voters, n=10)


# Prompt for manual testing in testing_efficiency.py
formatted_data <- apply(X=test_data, MARGIN=1, FUN=function(X) paste(X, collapse=", "))

paste0("Voter data (Washington state county, age group, gender): ",
       paste(formatted_data, collapse="; "),
      ", for each voter in the voter data, is the voter likely to vote democrat in the next U.S. presidential election? Respond with one word, yes no or unknown")




## CODE FROM CREATING_VOTERS_PROMPTS
individual_data <- paste0("age: ", voters[i, "age"],
                          "; gender: ", voters[i, "gender"],
                          "; location: ", voters[i, "wa_county"], ", Washington",
                          "; return method: ", voters[i, "return_method"])
# Generate prompts
prompt1 <- paste("Given the following voter data -", individual_data,
                 "- what party is this voter most likely to vote for in the next U.S. presidential election, only give the party.")
prompt2 <- paste("Given the following voter data -", individual_data,
                 "Is this voter likely to vote democrat in the next U.S. presidential election? Yes or no, do not explain.")
prompt3 <- paste("Given the following voter data -", individual_data,
                 "Is this voter likely to vote republican in the next U.S. presidential election? Yes or no, do not explain.")
prompt4 <- paste("Given the following voter data -", individual_data,
                 "Is this voter likely to vote third party in the next U.S. presidential election? Yes or no, do not explain.")
prompt5 <- paste("Given the following voter data -", individual_data,
                 "Is the behavior easy to predict? Yes or no, do not explain")
prompt6 <- paste("Given the following voter data -", individual_data,
                 "Estimate the annual income of the voter with a number, do not explain.")
prompt7 <- paste("Given the following voter data -", individual_data,
                 "Would this voter rather have small government providing fewer services or bigger government providing more services? Pick one, do not explain.")
prompt8 <- paste("Given the following voter data -", individual_data,
                 "Does this voter think 'Business corporations make too much profit' or 'Most corporations make a fair and reasonable amount of profit'. Pick one, do not explain.")

# Save prompts
writeLines(prompt1,
           paste0("C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\initial_results\\prompts\\prompt1_", i, ".txt"))
writeLines(prompt2,
           paste0("C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\initial_results\\prompts\\prompt2_", i, ".txt"))
writeLines(prompt3,
           paste0("C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\initial_results\\prompts\\prompt3_", i, ".txt"))
writeLines(prompt4,
           paste0("C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\initial_results\\prompts\\prompt4_", i, ".txt"))
writeLines(prompt5,
           paste0("C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\initial_results\\prompts\\prompt5_", i, ".txt"))
writeLines(prompt6,
           paste0("C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\initial_results\\prompts\\prompt6_", i, ".txt"))
writeLines(prompt7,
           paste0("C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\initial_results\\prompts\\prompt7_", i, ".txt"))
writeLines(prompt8,
           paste0("C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\initial_results\\prompts\\prompt8_", i, ".txt"))
}

