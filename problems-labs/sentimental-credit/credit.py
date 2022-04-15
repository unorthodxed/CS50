# TODO
# Problem: https://cs50.harvard.edu/x/2022/psets/6/credit/
import re
from cs50 import get_string


def main():
    # define acceptable card prefixes
    # MASTERCARD
    patternm = "(51|52|53|54|55)"
    # AMEX
    patterna = "(34|37)"
    # VISA
    patternv = "4"

    number = get_string("Number: ")
    cardnum = int(number)

    # adder = 0
    # bigsum = 0
    # smallsum = 0

    # check if number matches a regular expression
    if (re.search(patternm, number) and len(number) == 16):
        type = "MASTERCARD"
    elif (re.search(patterna, number) and len(number) == 15):
        type = "AMEX"
    elif (re.search(patternv, number) and (len(number) == 13 or len(number) == 16)):
        type = "VISA"
    else:
        type = "INVALID"

    divisor = 1

    # compute sums for Luhn's algorithm
    checksum = sum1(cardnum) + sum2(cardnum)

    # if managed to pass regex check but invalidated by Luhn's algorithm
    if (checksum % 10 != 0):
        type = "INVALID"

    print(type)


def sum1(cardnum):
    divisor = 10
    bigsum = 0
    while (cardnum / divisor > 0):
        cardnum = int(cardnum / divisor)
        adder = ((cardnum % 10) * 2)
        if int(adder / 10) != 0:
            adder = (adder % 10) + (int(adder / 10))
        bigsum += adder
        divisor = 100
    return bigsum


def sum2(cardnum):
    divisor = 1
    smallsum = 0
    while int(cardnum / divisor) > 0:
        cardnum = int(cardnum / divisor)
        adder = cardnum % 10
        smallsum += adder
        divisor = 100
    return smallsum


main()
