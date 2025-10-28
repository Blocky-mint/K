# Goal

Label an openscad dataset

# Procedure

Download ThomasTheMaker/Synthetic-Object-v0 dataset

The 'code' column contains openscad code.

Render said code in openscad, and tell a VLM (running locally on Ollama) to name the closet object it can relate this to, under 5 words

(pick a vlm and install it first)

Create a json file dataset with:

- the code in the 'code' column
- the previous 'name' column becomes 'previous_name' column
- the label are in the 'name' column

