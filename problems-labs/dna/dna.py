import csv
import sys
import re


def main():

    # TODO: Check for command-line usage
    if len(sys.argv) != 3:
        sys.exit("Usage Error: expected dna.py file.csv file.txt")
    # TODO: Read database file into a variable
    file1 = sys.argv[1]
    with open(file1, 'r') as data:
        reader = csv.DictReader(data)
        database = list(reader)
        for i in range(len(database)):
            try:
                database[i]["AGATC"] = int(database[i]["AGATC"])
                database[i]["TTTTTTCT"] = int(database[i]["TTTTTTCT"])
                database[i]["AATG"] = int(database[i]["AATG"])
                database[i]["TCTAG"] = int(database[i]["TCTAG"])
                database[i]["GATA"] = int(database[i]["GATA"])
                database[i]["TATC"] = int(database[i]["TATC"])
                database[i]["GAAA"] = int(database[i]["GAAA"])
                database[i]["TCTG"] = int(database[i]["TCTG"])
            except:
                database[i]["AGATC"] = int(database[i]["AGATC"])
                database[i]["AATG"] = int(database[i]["AATG"])
                database[i]["TATC"] = int(database[i]["TATC"])

    # TODO: Read DNA sequence file into a variable
    file2 = sys.argv[2]
    f = open(file2, 'r')
    text = f.read()

    # TODO: Find longest match of each STR in DNA sequence
    str1 = longest_match(text, "AGATC")
    str2 = longest_match(text, "TTTTTTCT")
    str3 = longest_match(text, "AATG")
    str4 = longest_match(text, "TCTAG")
    str5 = longest_match(text, "GATA")
    str6 = longest_match(text, "TATC")
    str7 = longest_match(text, "GAAA")
    str8 = longest_match(text, "TCTG")

    # TODO: Check database for matching profiles
    for i in range(len(database)):
        try:
            if str1 == database[i]["AGATC"] and str2 == database[i]["TTTTTTCT"] and str3 == database[i]["AATG"]:
                if str4 == database[i]["TCTAG"] and str5 == database[i]["GATA"] and str6 == database[i]["TATC"]:
                    if str7 == database[i]["GAAA"] and str8 == database[i]["TCTG"]:
                        print(database[i]["name"])
                        f.close()
                        return
        except:
            if str1 == database[i]["AGATC"] and str3 == database[i]["AATG"] and str6 == database[i]["TATC"]:
                print(database[i]["name"])
                f.close()
                return
    print("No match")


def longest_match(sequence, subsequence):
    """Returns length of longest run of subsequence in sequence."""

    # Initialize variables
    longest_run = 0
    subsequence_length = len(subsequence)
    sequence_length = len(sequence)

    # Check each character in sequence for most consecutive runs of subsequence
    for i in range(sequence_length):

        # Initialize count of consecutive runs
        count = 0

        # Check for a subsequence match in a "substring" (a subset of characters) within sequence
        # If a match, move substring to next potential match in sequence
        # Continue moving substring and checking for matches until out of consecutive matches
        while True:

            # Adjust substring start and end
            start = i + count * subsequence_length
            end = start + subsequence_length

            # If there is a match in the substring
            if sequence[start:end] == subsequence:
                count += 1

            # If there is no match in the substring
            else:
                break

        # Update most consecutive matches found
        longest_run = max(longest_run, count)

    # After checking for runs at each character in seqeuence, return longest run found
    return longest_run


main()
