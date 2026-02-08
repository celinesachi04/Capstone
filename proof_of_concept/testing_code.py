import os
from google import genai

os.environ["GOOGLE_GENAI_USE_VERTEXAI"] = "True"
os.environ["GOOGLE_CLOUD_PROJECT"] = "stat-496-project"
os.environ["GOOGLE_CLOUD_LOCATION"] = "global"

response = client.models.generate_content(
    model="gemini-2.0-flash", 
    contents="Say 'Hello World' if you can hear me."
)

print(response.text)

# Prompt 1
client = genai.Client(http_options=HttpOptions(api_version="v1"))
response = client.models.generate_content(
    model="gemini-2.5-flash",
    contents="Voter profile; Age: 28; Gender: Female; Race/Ethnicity: White; Education:" \
    "Bachelor’s degree; Income: $80,000; Location: Seattle; Past voting behavior: Voted Democrat"
    "in the last two presidential elections; Party registration: Independent." \
    "Which party is this voter more likely to vote for in the next U.S. presidential election?" \
    "Provide a prediction and briefly explain your reasoning."
)
print(response.text)


# Prompt 2
client = genai.Client(http_options=HttpOptions(api_version="v1"))
response = client.models.generate_content(
    model="gemini-2.5-flash",
    contents="Voter A - Age: 70; Location: Florida; Past voting behavior: Consistent Republican" \
    "Voter B - Age: 26; Location: Texas; Past voting behavior: First-time voter"
    "Given Voter A and Voter B, Task: Which voter’s behavior is easier to predict and why?" \
    "Do not assume certainty."
)
print(response.text)


# Prompt 3
client = genai.Client(http_options=HttpOptions(api_version="v1"))
response = client.models.generate_content(
    model="gemini-2.5-flash",
    contents="Analyze voting behavior in a parliamentary democracy. Voter profile: Age: 37;" \
    "Gender: Male; Education: University degree; Income: Middle income; Country: United Kingdom; " \
    "Past voting behavior: Labour voter; Current concerns: Immigration, cost of living." \
    "Task: Predict whether this voter is more likely to continue supporting labour or shift toward a "\
    "conservative or populist party. Explain your reasoning."
)
print(response.text)


# Prompt 4
client = genai.Client(http_options=HttpOptions(api_version="v1"))
response = client.models.generate_content(
    model="gemini-2.5-flash",
    contents="Voter profile: Age: 41; Location: Michigan; Education: Some college. Question: "\
    "Based only on this information, what additional data would be most important for predicting "\
    "this voter’s behavior? Do not make a prediction yet—explain uncertainty."
)
print(response.text)


# Prompt 5
client = genai.Client(http_options=HttpOptions(api_version="v1"))
response = client.models.generate_content(
    model="gemini-2.5-flash",
    contents="Given incomplete and potentially noisy voter data, how confident can you be in "\
    "predicting individual voting behavior? Respond by: 1. Giving a rough prediction for the voter "\
    "below 2. Listing key sources of uncertainty 3. Explaining limitations of this approach Voter profile:"\
    " Age: 33; Location: New York; Income: $80,000; Past voting behavior: Unknown"
)
print(response.text)


# Prompt 6
client = genai.Client(http_options=HttpOptions(api_version="v1"))
response = client.models.generate_content(
    model="gemini-2.5-flash",
    contents="Consider the following voter profile: Age: 62; Gender: Male; Race/Ethnicity: Hispanic; "\
    "Education: High school diploma; Income: $45,000; Location: Rural Arizona; Past voting behavior: "\
    "Voted Republican in 2016, Democrat in 2020; Party registration: Independent Task: Predict which "\
    "party this voter is more likely to support in the next presidential election. Include a confidence "\
    "estimate (low / medium / high) and justification."
)
print(response.text)
