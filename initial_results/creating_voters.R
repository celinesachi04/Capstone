
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


total <- max(length(age_bucket), length(gender), length(wa_county), length(return_method))

all_levels <- data.frame(age_bucket=c(age_bucket, rep(NA, total - length(age_bucket))),
                         gender=c(gender, rep(NA, total - length(gender))),
                         wa_county=c(wa_county, rep(NA, total - length(wa_county))),
                         return_method=c(return_method, rep(NA, total - length(return_method))))
all_levels <- na.omit(all_levels %>% expand(age_buckets, gender, wa_county, return_method))



