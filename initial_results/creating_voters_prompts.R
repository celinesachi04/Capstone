
# Create variables
age_bucket <- c("18-24", "25-34", "35-44", "45-54", "55-64", "65+")

gender <- c("female", "male", "unspecified")

wa_county <- c("Adams", "Asotin", "Benton", "Chelan", "Clallam", "Clark", 
               "Columbia", "Cowlitz", "Douglas", "Ferry", "Franklin", "Garfield", 
               "Grant", "Grays Harbor", "Island", "Jefferson", "King", "Kitsap", 
               "Kittitas", "Klickitat", "Lewis", "Lincoln", "Mason", "Okanogan", 
               "Pacific", "Pend Oreille", "Pierce", "San Juan", "Skagit", "Skamania", 
               "Snohomish", "Spokane", "Stevens", "Thurston", "Wahkiakum", "Walla Walla", 
               "Whatcom", "Whitman", "Yakima")

return_method <- c("dropbox", "mail", "other")


# Create voter information data frame
N <- 50
voters <- data.frame("age"=rep(NA, 50), "gender"=NA, "wa_county"=NA, "return_method"=NA)
write.csv(voters, file="voter_data.csv", row.names=FALSE)
  
for (i in 1:50) {
  age_sample <- sample(x=1:6, size=1)
  gender_sample <- sample(x=1:3, size=1)
  county_sample <- sample(x=1:39, size=1)
  return_sample <- sample(x=1:3, size=1)
  voters[i, ] <- c(age_bucket[age_sample], gender[gender_sample],
                   wa_county[county_sample], return_method[return_sample])
  
}


# Create prompt files
for (i in 1:nrow(voters)) {
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



