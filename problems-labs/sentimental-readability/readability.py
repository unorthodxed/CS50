# TODO
# Problem: https://cs50.harvard.edu/x/2022/psets/6/readability/
import re
from cs50 import get_string

# get data and initialize variables
text = get_string("Text: ")
letters = 0
words = 0
sentences = 0
pattern = "[a-zA-Z]"

# iterate thru characters and increment variables
for c in text:
    if re.search(pattern, c):
        letters += 1
    elif c == " ":
        words += 1
    elif c == "." or c == "!" or c == "?":
        sentences += 1

# add the last word in the text and calculate Coleman-Liau index
words += 1
l = letters / words * 100
s = sentences / words * 100
index = int(round((0.0588 * l) - (0.296 * s) - 15.8))

# print grade according to condition
if index < 1:
    print("Before Grade 1")
elif index > 16:
    print("Grade 16+")
else:
    print(f"Grade {index}")
