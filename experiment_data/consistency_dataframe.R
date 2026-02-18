set.seed(496)

# Voter id
voter_id <- sprintf("%03d", 1:N)

# Cluster 1 categories
age_bucket <- c("18-24", "25-34", "35-44", "45-54", "55-64", "65+")
gender <- c("female", "male", "nonbinary", "unspecified")
race <- c(
  "White", "Black/African American", "Hispanic/Latino", "Asian",
  "Native American/Alaska Native", "Native Hawaiian/Pacific Islander",
  "Middle Eastern/North African", "Multiracial", "Other", "Prefer not to say"
)
urbanicity <- c("urban", "suburban", "rural")

# Cluster 2 categories
marital_status <- c("single/never married", "married", "partnered",
                    "divorced", "separated", "widowed", "prefer not to say")

num_kids <- c("0", "1", "2", "3", "4+")
religion <- c(
  "none/agnostic/atheist", "Christian", "Jewish", "Muslim",
  "Hindu", "Buddhist", "Sikh", "Other", "Prefer not to say"
)

# Cluster 3 categories
education <- c(
  "less than HS", "HS/GED", "some college", "associate",
  "bachelor", "graduate/professional", "prefer not to say"
)
income <- c(
  "<$25k", "$25k-$49k", "$50k-$74k",
  "$75k-$99k", "$100k-$149k", "$150k+",
  "prefer not to say"
)

return_method <- c("dropbox", "mail", "other")

# Sample size
N <- 100

# Cluster 4 categories (include ALL)
# 4th data frame (ALL variables)
df_all <- data.frame(
  voter_ID = voter_id,
  race = sample(race, N, replace = TRUE),
  age = sample(age_bucket, N, replace = TRUE),
  gender = sample(gender, N, replace = TRUE),
  urbanicity = sample(urbanicity, N, replace = TRUE),
  marital_status = sample(marital_status, N, replace = TRUE),
  num_kids = sample(num_kids, N, replace = TRUE),
  religion = sample(religion, N, replace = TRUE),
  education = sample(education, N, replace = TRUE),
  income = sample(income, N, replace = TRUE),
  return_method = sample(return_method, N, replace = TRUE),
  stringsAsFactors = FALSE
)

# 1st cluster data frame
df_demo <- df_all[, c("voter_ID", "race", "age", "gender", "urbanicity")]

# 2nd cluster data frame 
df_family <- df_all[, c("voter_ID", "marital_status", "num_kids", "religion")]

# 3rd cluster data frame 
df_ses <- df_all[, c("voter_ID", "education", "income")]

# Save each data frame

"C:/Users/YourName/Desktop/df_demo.csv"
write.csv(df_demo,"/Users/celine/Desktop/Capstone/df_demo.csv", row.names = FALSE)
write.csv(df_family,"/Users/celine/Desktop/Capstone/df_family.csv", row.names = FALSE)
write.csv(df_ses,"/Users/celine/Desktop/Capstone/df_ses.csv", row.names = FALSE)
write.csv(df_all,"/Users/celine/Desktop/Capstone/df_all.csv", row.names = FALSE)
