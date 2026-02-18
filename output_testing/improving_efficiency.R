
simulated_voters <- read.csv("C:/Users/casey/Desktop/Stat 496/Capstone/experiment_data/simulated_voters.csv")
test_data <- head(simulated_voters, n=10)


# Prompt for manual testing in testing_efficiency.py
formatted_data <- apply(X=test_data, MARGIN=1, FUN=function(X) paste(X, collapse=", "))

paste0("Voter data (Washington state county, age group, gender): ",
       paste(formatted_data, collapse="; "),
      ", for each voter in the voter data, is the voter likely to vote democrat in the next ",
      "U.S. presidential election? Respond with one word, yes no or unknown")



# Entire data set:
large_formatted_data <- apply(X=simulated_voters, MARGIN=1, FUN=function(X) paste(X, collapse=", "))
prompt1 <- paste0("Voter data (Washington state county, age group, gender): ",
                  paste(large_formatted_data, collapse="; "),
                  ", for each voter in the voter data, is the voter likely to vote democrat in the next ",
                  "U.S. presidential election? Respond with one word, yes no or unknown")
writeLines(prompt1,
           "C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\output_testing\\prompt1.txt")

