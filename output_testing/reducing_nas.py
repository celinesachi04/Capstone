import os
from google import genai
from google.genai import types

os.environ["GOOGLE_CLOUD_PROJECT"] = "STAT-496"
os.environ["GOOGLE_CLOUD_LOCATION"] = "global"

client = genai.Client(api_key="ADD API KEY")

# Test prompt adjustments to get desired output

response1 = client.models.generate_content(
    model="gemini-3-flash-preview",
    contents="Given the following voter data - age: 25-24; gender: female; location: Pierce, Washington; " \
    "return method: dropbox Is this voter likely to vote democrat in the next U.S. presidential election? " \
    "Respond with exactly one word, either yes or no."
    )

response2 = client.models.generate_content(
    model="gemini-3-flash-preview",
    contents="Given the following voter data - age: 25-24; gender: female; location: Pierce, Washington; " \
    "return method: dropbox Is this voter likely to vote democrat in the next U.S. presidential election? " \
    "Respond with yes or no, do not explain, and do not comment on feasibility of data to predict outcome."
    )

response3 = client.models.generate_content(
    model="gemini-3-flash-preview",
    contents="Given the following voter data - age: 25-24; gender: female; location: Pierce, Washington; " \
    "return method: dropbox Is this voter likely to vote democrat in the next U.S. presidential election? " \
    "Respond with exactly one response, either yes or no or not enough information to predict."
    )

response4 = client.models.generate_content(
    model="gemini-3-flash-preview",
    contents="Given the following voter data - age: 25-24; gender: female; location: Pierce, Washington; " \
    "return method: dropbox Is this voter likely to vote democrat in the next U.S. presidential election? " \
    "Respond with yes or no, or not enough information to predict, do not explain, and do not comment on feasibility of data to predict outcome."
    )

response5 = client.models.generate_content(
    model="gemini-3-flash-preview",
    contents="Given the following voter data - age: 25-24; gender: female; location: Pierce, Washington; " \
    "return method: dropbox Is this voter likely to vote democrat in the next U.S. presidential election? " \
    "Respond with exactly one word, either yes or no or unknown."
    )

response6 = client.models.generate_content(
    model="gemini-3-flash-preview",
    contents="Given the following voter data - age: 25-24; gender: female; location: Pierce, Washington; " \
    "return method: dropbox Is this voter likely to vote democrat in the next U.S. presidential election? " \
    "Respond with yes or no, or unknown, do not explain, and do not comment on feasibility of data to predict outcome."
    )

response7 = client.models.generate_content(
    model="gemini-3-flash-preview",
    contents="Given the following voter data - age: 25-24; gender: female; location: Pierce, Washington; " \
    "return method: dropbox Is this voter likely to vote democrat in the next U.S. presidential election? " \
    "Respond with exactly one word, either yes or no or unknown.",
    config=types.GenerateContentConfig(
            thinking_config=types.ThinkingConfig(thinking_level="low", include_thoughts=False)
        )
    )

response8 = client.models.generate_content(
    model="gemini-3-flash-preview",
    contents="Given the following voter data - age: 25-24; gender: female; location: Pierce, Washington; " \
    "return method: dropbox Is this voter likely to vote democrat in the next U.S. presidential election? ",
    config=types.GenerateContentConfig(
            thinking_config=types.ThinkingConfig(thinking_level="low", include_thoughts=False)
        )
    )

response9 = client.models.generate_content(
    model="gemini-3-flash-preview",
    contents="Given the following voter data - age: 25-24; gender: female; location: Pierce, Washington; " \
    "return method: dropbox Is this voter likely to vote democrat in the next U.S. presidential election? " \
    "Do not include thoughts",
    config=types.GenerateContentConfig(
            thinking_config=types.ThinkingConfig(thinking_level="low", include_thoughts=False)
        )
    )

response10 = client.models.generate_content(
    model="gemini-3-flash-preview",
    contents="Given the following voter data - age: 25-24; gender: female; location: Pierce, Washington; " \
    "return method: dropbox Is this voter likely to vote democrat in the next U.S. presidential election? " \
    "Respond with 'yes' or 'no, or 'unknown'",
    config=types.GenerateContentConfig(
            thinking_config=types.ThinkingConfig(thinking_level="low", include_thoughts=False)
        )
    )

response11 = client.models.generate_content(
    model="gemini-3-flash-preview",
    contents="Given the following voter data - age: 25-24; gender: female; location: Pierce, Washington; " \
    "return method: dropbox Is this voter likely to vote democrat in the next U.S. presidential election? " \
    "Respond with one word.",
    config=types.GenerateContentConfig(
            thinking_config=types.ThinkingConfig(thinking_level="low", include_thoughts=False)
        )
    )

response12 = client.models.generate_content(
    model="gemini-3-flash-preview",
    contents="Given the following voter data - age: 25-24; gender: female; location: Pierce, Washington; " \
    "return method: dropbox Is this voter likely to vote democrat in the next U.S. presidential election? " \
    "Respond with one word, yes no or unknown",
    config=types.GenerateContentConfig(
            thinking_config=types.ThinkingConfig(thinking_level="low", include_thoughts=False)
        )
    )

response13 = client.models.generate_content(
    model="gemini-3-flash-preview",
    contents="Given the following voter data - age: 25-24; gender: female; location: Pierce, Washington; " \
    "return method: dropbox Is this voter likely to vote democrat in the next U.S. presidential election? " \
    "Respond with one word yes no or unknown",
    config=types.GenerateContentConfig(
            thinking_config=types.ThinkingConfig(thinking_level="low", include_thoughts=False)
        )
    )

print(response1.text) # Always responded with yes or no, never said it couldn't predict
print(response2.text) # Always responded with yes or no, never said it couldn't predict
print(response3.text) # Always returned one of three options, but third option was wordy
print(response4.text) # Always returned one of three options, but third option was wordy
print(response5.text) # Always returned yes, no, or unknown
print(response6.text) # Always returned yes, no, or unknown but prompt had more words than prompt for response5
print(response7.text) # Same results as response5, even with new parameters (might run faster)
print(response8.text) # Responses had too many words
print(response9.text) # Responses had too many words
print(response10.text) # Adding apostrophes did not change output content compared to responses 5 or 6
                       # but did create uniform formatting (e.g. always "unknown" instead of "Unknown")
print(response11.text) # Response varied in formatting (e.g. returning "Yes." rather than "yes")
print(response12.text) # Removing commas between word options did not change output compared to responses 5 or 6
print(response13.text) # Removing comma before word options did not change output compared to responses 5 or 6, but less clear to read


# The prompt for response12 is the best combination in terms of proper output,
# interpretability, least tokens in the prompt, and fastest run times.


for i in range(10):
    responseA = client.models.generate_content(
        model="gemini-3-flash-preview",
        contents="Given the following voter data - age: 15-54; gender: male; location: Cowlitz, Washington; return method: mail " \
        "Would this voter rather have A: small government providing fewer services; or B: bigger government providing more services? " \
        "Respond with only A or B"
        )
    print(responseA.text)


for i in range(10):
    responseB = client.models.generate_content(
        model="gemini-3-flash-preview",
        contents="Given the following voter data - age: 15-54; gender: male; location: Cowlitz, Washington; return method: mail " \
        "Would this voter rather have A: small government providing fewer services; or B: bigger government providing more services? " \
        "Respond with only A B or unknown",
    config=types.GenerateContentConfig(
            thinking_config=types.ThinkingConfig(thinking_level="low", include_thoughts=False)
        )
        )
    print(responseB.text)
    
# responseA sometimes produced wordy output
# responseB produced the correctly formatted output (some variation with capitalization), with faster run times

# Verifying updated prompts work for prompt8 from initial results:
for i in range(10):
    responseC = client.models.generate_content(
        model="gemini-3-flash-preview",
        contents="Given the following voter data - age: 45-54; gender: unspecified; location: Grant, Washington; return method: mail " \
        "Does this voter think A: Business corporations make too much profit; or B: Most corporations make a fair and reasonable amount of profit? " \
        "Pick A B or unknown",
    config=types.GenerateContentConfig(
            thinking_config=types.ThinkingConfig(thinking_level="low", include_thoughts=False)
        )
        )
    print(responseC.text)

for i in range(10):
    responseD = client.models.generate_content(
        model="gemini-3-flash-preview",
        contents="Given the following voter data - age: 45-54; gender: unspecified; location: Grant, Washington; return method: mail " \
        "Does this voter think A: Business corporations make too much profit; or B: Most corporations make a fair and reasonable amount of profit? " \
        "Respond with only A B or unknown",
    config=types.GenerateContentConfig(
            thinking_config=types.ThinkingConfig(thinking_level="low", include_thoughts=False)
        )
        )
    print(responseD.text)

for i in range(10):
    responseE = client.models.generate_content(
        model="gemini-3-flash-preview",
        contents="Given the following voter data - age: 25-34; gender: female; location: Pierce, Washington; return method: dropbox Does this " \
        "voter think A: Business corporations make too much profit; or B: Most corporations make a fair and reasonable amount of profit? " \
        "Respond with only A B or unknown",
    config=types.GenerateContentConfig(
            thinking_config=types.ThinkingConfig(thinking_level="low", include_thoughts=False)
        )
        )
    print(responseE.text)

for i in range(10):
    responseF = client.models.generate_content(
        model="gemini-3-flash-preview",
        contents="Given the following voter data - age: 25-34; gender: female; location: Pierce, Washington; return method: dropbox Does this " \
        "voter think A: Business corporations make too much profit; or B: Most corporations make a fair and reasonable amount of profit? " \
        "Respond with only A B or unknown if necessary",
    config=types.GenerateContentConfig(
            thinking_config=types.ThinkingConfig(thinking_level="low", include_thoughts=False)
        )
        )
    print(responseF.text)

for i in range(3):
    responseG = client.models.generate_content(
        model="gemini-3-flash-preview",
        contents="Given the following voter data - age: 45-54; gender: unspecified; location: Grant, Washington; return method: mail " \
        "Does this voter think A: Business corporations make too much profit; or B: Most corporations make a fair and reasonable amount of profit? " \
        "Respond with only A or B",
    config=types.GenerateContentConfig(
            thinking_config=types.ThinkingConfig(thinking_level="low", include_thoughts=False)
        )
        )
    print(responseG.text)

for i in range(10):
    responseH = client.models.generate_content(
        model="gemini-3-flash-preview",
        contents="Given the following voter data - age: 45-54; gender: unspecified; location: Grant, Washington; return method: mail " \
        "Does this voter think A: Business corporations make too much profit; or B: Most corporations make a fair and reasonable amount of profit? " \
        "Respond with only A B",
    config=types.GenerateContentConfig(
            thinking_config=types.ThinkingConfig(thinking_level="low", include_thoughts=False)
        )
        )
    print(responseH.text)

for i in range(10):
    responseI = client.models.generate_content(
        model="gemini-3-flash-preview",
        contents="Given the following voter data - age: 45-54; gender: unspecified; location: Grant, Washington; return method: mail " \
        "Does this voter think A: Business corporations make too much profit; or B: Most corporations make a fair and reasonable amount of profit? " \
        "Respond with only A B. Can only return unknown sparingly",
    config=types.GenerateContentConfig(
            thinking_config=types.ThinkingConfig(thinking_level="low", include_thoughts=False)
        )
        )
    print(responseI.text)


# Prompts for responseC returns too many words
# responseD and responseE produces similar results to prompt for responseB, but always chooses unknown
# responseF still always choosing unknown
# responseG returning A or B as desired
# responseH occasionaly returning wordy responses (only difference to responseG is prompt says "A or B" rather than "A B")
# responseI returning varied output as desired

# Overall, prompt format for responseI returns desired format.


