import pandas as pd

voter_data = pd.read_csv("C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\initial_results\\voter_data.csv")

sample = voter_data.loc[[0, 1, 2, 3, 4, 5]]
# print(sample)

for index, row in sample.iterrows():
    row_data = row.to_string()
    prompt = "voter information: " + row_data + "\nadd rest of prompt here \n"
    # print(prompt)

    file_name = "C:\\Users\\casey\\Desktop\\Stat 496\\Capstone\\initial_results\\prompts\\prompt" + str(index) + ".txt"
    # print(file_name)
    with open(file_name, "w") as file:
        file.write(prompt)
