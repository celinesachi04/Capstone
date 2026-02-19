import os
from google import genai

os.environ["GOOGLE_CLOUD_PROJECT"] = "STAT-496"
os.environ["GOOGLE_CLOUD_LOCATION"] = "global"

client = genai.Client(api_key="ADD API KEY")


questions = ["what_party", "vote_democrat", "vote_republican", "vote_third_party", "easy_to_predict",
             "gov_services", "corporation_profit", "candidates_view", "religion_government", "president_vote",
             "wa_senator", "energy_initiative", "taxes_initiative", "carbon_tax_initiative", "insurance_initiative",
             "supreme_court", "governor", "state_treasurer", "attorney_general"]

# all covariates
for i in range(5):
    for question in questions:
        print(question)
        # Create prompt and response file paths
        prompt_file_path = "C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\experiment_data\\consistency\\responses\\all_covariates\\" + question  + "_" + i + ".txt"
        response_file_path = "CC:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\experiment_data\\consistency\\responses\\all_covariates" + question  + "_" + i + ".txt"
        
        # Read in prompt file
        with open(prompt_file_path) as file:
            prompt = file.read()

        # Produce response from prompt
        response = client.models.generate_content(
            model="gemini-3-flash-preview",
            contents=prompt
            )

        # Save response to txt file
        with open(response_file_path, "w") as file:
            file.write(response.text)


# demo covariates
for i in range(5):
    for question in questions:
        print(question)
        # Create prompt and response file paths
        prompt_file_path = "C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\experiment_data\\consistency\\responses\\demo_covariates\\" + question  + "_1.txt"
        response_file_path = "CC:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\experiment_data\\consistency\\responses\\demo_covariates" + question  + "_1.txt"
        
        # Read in prompt file
        with open(prompt_file_path) as file:
            prompt = file.read()

        # Produce response from prompt
        response = client.models.generate_content(
            model="gemini-3-flash-preview",
            contents=prompt
            )

        # Save response to txt file
        with open(response_file_path, "w") as file:
            file.write(response.text)


# family covariates
for i in range(5):
    for question in questions:
        print(question)
        # Create prompt and response file paths
        prompt_file_path = "C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\experiment_data\\consistency\\responses\\family_covariates\\" + question  + "_1.txt"
        response_file_path = "CC:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\experiment_data\\consistency\\responses\\family_covariates" + question  + "_1.txt"
        
        # Read in prompt file
        with open(prompt_file_path) as file:
            prompt = file.read()

        # Produce response from prompt
        response = client.models.generate_content(
            model="gemini-3-flash-preview",
            contents=prompt
            )

        # Save response to txt file
        with open(response_file_path, "w") as file:
            file.write(response.text)


# ses covariates
for i in range(5):
    for question in questions:
        print(question)
        # Create prompt and response file paths
        prompt_file_path = "C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\experiment_data\\consistency\\responses\\ses_covariates\\" + question  + "_1.txt"
        response_file_path = "CC:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\experiment_data\\consistency\\responses\\ses_covariates" + question  + "_1.txt"
        
        # Read in prompt file
        with open(prompt_file_path) as file:
            prompt = file.read()

        # Produce response from prompt
        response = client.models.generate_content(
            model="gemini-3-flash-preview",
            contents=prompt
            )

        # Save response to txt file
        with open(response_file_path, "w") as file:
            file.write(response.text)