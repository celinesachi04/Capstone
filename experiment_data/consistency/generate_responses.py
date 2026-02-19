import os
import time
from pathlib import Path
from google import genai

os.environ["GOOGLE_CLOUD_PROJECT"] = "STAT-496"
os.environ["GOOGLE_CLOUD_LOCATION"] = "global"

client = genai.Client(api_key="")

base = Path(__file__).parent

covariates = ["all_covariates", "family_covariates", "demo_covariates", "ses_covariates"]

questions = ["what_party", "vote_democrat", "vote_republican", "vote_third_party", "easy_to_predict",
             "gov_services", "corporation_profit", "candidates_view", "religion_government", "president_vote",
             "wa_senator", "energy_initiative", "taxes_initiative", "carbon_tax_initiative", "insurance_initiative",
             "supreme_court", "governor", "state_treasurer", "attorney_general"]

# Configurations
MODEL_NAME = "models/gemma-3-27b-it"
QUESTION_REPEAT = 5
WAIT_TIME = 60
MAX_RETRIES = 3

def generate_with_retry(prompt):
    """Generate content with retry logic for rate limits and server errors."""
    for attempt in range(MAX_RETRIES):
        try:
            response = client.models.generate_content(
                model=MODEL_NAME,
                contents=prompt
            )
            return response
        except Exception as e:
            if attempt < MAX_RETRIES - 1:
                print(f"  Error: {str(e)[:100]}... Retrying in {WAIT_TIME} seconds... (attempt {attempt + 1}/{MAX_RETRIES})")
                time.sleep(WAIT_TIME)
            else:
                print(f"  Failed after {MAX_RETRIES} attempts")
                raise

for covariate in covariates:
    print(f"Covariate: {covariate}")
    for i in range(QUESTION_REPEAT):
        print(f"   Loop: {i}")
        for question in questions:
            print(f"      Question: {question}")
            # Retrieve prompt and response file paths using specified covariate
            prompt_file_path = base / "prompts" / covariate / (question + ".txt")
            response_file_path = base / "responses" / covariate / (question + "_" + str(i) + ".txt")
            
            # Create response directory if it doesn't exist
            response_file_path.parent.mkdir(parents=True, exist_ok=True)
            
            # Input prompt file
            with open(prompt_file_path) as file:
                prompt = file.read()

            # Generate response with retry
            response = generate_with_retry(prompt)

            # Save response to txt file
            with open(response_file_path, "w") as file:
                file.write(response.text)