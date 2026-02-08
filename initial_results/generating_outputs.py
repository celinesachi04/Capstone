import os
from google import genai

os.environ["GOOGLE_CLOUD_PROJECT"] = "STAT-496"
os.environ["GOOGLE_CLOUD_LOCATION"] = "global"

client = genai.Client(api_key="AIzaSyDpNLYnXkYn8k7FA0CGjicDp7HUZzijWg4")


# Prompt 1
for index in range(1, 51):

    # Create prompt and response file paths
    prompt_file_path = "C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\initial_results\\prompts\\prompt1_" + str(index) + ".txt"
    response_file_path = "C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\initial_results\\responses\\response1_" + str(index) + ".txt"

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



# Prompt 2
for index in range(1, 51):

    # Create prompt and response file paths
    prompt_file_path = "C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\initial_results\\prompts\\prompt2_" + str(index) + ".txt"
    response_file_path = "C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\initial_results\\responses\\response2_" + str(index) + ".txt"

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


# Prompt 3
for index in range(1, 51):

    # Create prompt and response file paths
    prompt_file_path = "C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\initial_results\\prompts\\prompt3_" + str(index) + ".txt"
    response_file_path = "C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\initial_results\\responses\\response3_" + str(index) + ".txt"

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


# Prompt 4
for index in range(1, 51):

    # Create prompt and response file paths
    prompt_file_path = "C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\initial_results\\prompts\\prompt4_" + str(index) + ".txt"
    response_file_path = "C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\initial_results\\responses\\response4_" + str(index) + ".txt"

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


# Prompt 5
for index in range(1, 51):

    # Create prompt and response file paths
    prompt_file_path = "C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\initial_results\\prompts\\prompt5_" + str(index) + ".txt"
    response_file_path = "C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\initial_results\\responses\\response5_" + str(index) + ".txt"

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


# Prompt 6
for index in range(1, 51):

    # Create prompt and response file paths
    prompt_file_path = "C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\initial_results\\prompts\\prompt6_" + str(index) + ".txt"
    response_file_path = "C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\initial_results\\responses\\response6_" + str(index) + ".txt"

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


# Prompt 7
for index in range(1, 51):

    # Create prompt and response file paths
    prompt_file_path = "C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\initial_results\\prompts\\prompt7_" + str(index) + ".txt"
    response_file_path = "C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\initial_results\\responses\\response7_" + str(index) + ".txt"

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


# Prompt 8
for index in range(1, 51):

    # Create prompt and response file paths
    prompt_file_path = "C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\initial_results\\prompts\\prompt8_" + str(index) + ".txt"
    response_file_path = "C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\initial_results\\responses\\response8_" + str(index) + ".txt"

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