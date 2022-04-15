# TODO
# Problem: https://cs50.harvard.edu/x/2022/psets/6/mario/more/
from cs50 import get_int

# get user input and set default whitespace
height = get_int("height: ")
spaces = 1

# if invalid input, prompt again
while height > 8 or height < 1:
    height = get_int("height: ")

# for every row, print appropriate spaces and hashes
for i in range(height):
    while spaces < height - i:
        print(" ", end="")
        spaces += 1
    for hashes in range((i) + 1):
        print("#", end="")
    print("  ", end="")
    for hashes in range((i) + 1):
        print("#", end="")
    if i <= height:
        print("")
    spaces = 1
