import os
from google import genai
from google.genai import types

os.environ["GOOGLE_CLOUD_PROJECT"] = "STAT-496"
os.environ["GOOGLE_CLOUD_LOCATION"] = "global"

client = genai.Client(api_key="AIzaSyCBuGuEo_3LLTns8xIvJqrBXLgUCO6E4pM")

# Manual testing with small dataset (10 voters)
response1 = client.models.generate_content(
    model="gemini-3-flash-preview",
    contents="Voter data (Washington state county, age group, gender): King, 55-64, Male; Kitsap, 25-34, " \
    "Male; Thurston, 45-54, Male; Yakima, 18-24, Male; Snohomish, 55-64, Male; King, 55-64, Female; Pierce, " \
    "55-64, Male; Pierce, 35-44, Female; Snohomish, 35-44, Unknown/Other; Thurston, 35-44, Male, for each voter"
    " in the voter data, is the voter likely to vote democrat in the next U.S. presidential election? Respond " \
    "with one word, yes no or unknown",
    config=types.GenerateContentConfig(
            thinking_config=types.ThinkingConfig(thinking_level="low", include_thoughts=False)
        )
    )

print(response1.text)

for i in range(5):
    response2 = client.models.generate_content(
        model="gemini-3-flash-preview",
        contents="Voter data (Washington state county, age group, gender): King, 55-64, Male; Kitsap, 25-34, " \
        "Male; Thurston, 45-54, Male; Yakima, 18-24, Male; Snohomish, 55-64, Male; King, 55-64, Female; Pierce, " \
        "55-64, Male; Pierce, 35-44, Female; Snohomish, 35-44, Unknown/Other; Thurston, 35-44, Male, for each voter"
        " in the voter data, is the voter likely to vote democrat in the next U.S. presidential election? Respond " \
        "with one word, yes no. Can only return unknown sparingly",
        config=types.GenerateContentConfig(
                thinking_config=types.ThinkingConfig(thinking_level="low", include_thoughts=False)
            )
        )

    print("repetition", i, "\n", response2.text)


for i in range(5):
    response3 = client.models.generate_content(
        model="gemini-3-flash-preview",
        contents="Voter data (Washington state county, age group, gender): King, 55-64, Male; Kitsap, 25-34, " \
        "Male; Thurston, 45-54, Male; Yakima, 18-24, Male; Snohomish, 55-64, Male; King, 55-64, Female; Pierce, " \
        "55-64, Male; Pierce, 35-44, Female; Snohomish, 35-44, Unknown/Other; Thurston, 35-44, Male, for each voter"
        " in the voter data, is the voter likely to vote democrat in the next U.S. presidential election? Respond " \
        "with one word, yes no. Can only return unknown sparingly: voter index. prediction",
        config=types.GenerateContentConfig(
                thinking_config=types.ThinkingConfig(thinking_level="low", include_thoughts=False)
            )
        )

    print("repetition", i, "\n", response3.text)

"""
response1: Returned all voters as unknown, but run time is quick
response2: Combined with responseI formatting from reducing_nas.py.
            Voter predictions were a good mix of yes, no and unknown
            Output format had a lot of variation
response3: Output as desired!
"""

# Automated testing with larger dataset
with open("C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\output_testing\\prompt1.txt") as file:
    large_prompt = file.read()

response4 = client.models.generate_content(
    model="gemini-3-flash-preview",
    contents=large_prompt,
    config=types.GenerateContentConfig(
            thinking_config=types.ThinkingConfig(thinking_level="low", include_thoughts=False)
        )
    )

with open("C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\output_testing\\response1.txt", "w") as file:
    file.write(response4.text)

"""
Worked with large output. Data had 100 lines, run time was 20 seconds
"""

