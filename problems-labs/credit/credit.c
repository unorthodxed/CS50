#include <cs50.h>
#include <stdio.h>

int main(void)
{
    long cardnum = get_long("Number: ");
    long divisor = 10, adder = 0, bigsum = 0, smallsum = 0;
    const long cardnumcopy = cardnum;
    int digits = 0;
    string cardtype;
//Get number of digits in card number
    while (cardnum / divisor > 0)
    {
        cardnum /= divisor;
        digits++;
    }
    digits++;
//Determine card type
    if (digits == 15)
    {
        if (cardnumcopy / 10000000000000 == 34 || cardnumcopy / 10000000000000 == 37)
        {
            cardtype = "AMEX\n";
        }
        else
        {
            cardtype = "INVALID\n";
        }
    }
    else if (digits == 16)
    {
        if (cardnumcopy / 100000000000000 == 51 || cardnumcopy / 100000000000000 == 52 || cardnumcopy / 100000000000000 == 53
            || cardnumcopy / 100000000000000 == 54 || cardnumcopy / 100000000000000 == 55)
        {
            cardtype = "MASTERCARD\n";
        }
        else if (cardnum == 4)
        {
            cardtype = "VISA\n";
        }
            else
        {
            cardtype = "INVALID\n";
        }
    }
    else if (digits == 13)
    {
        if (cardnum == 4)
        {
            cardtype = "VISA\n";
        }
    }
    else
    {
        cardtype = "INVALID\n";
    }

    cardnum = cardnumcopy;  // gets original card number

    while (cardnum / divisor > 0)
    {
        cardnum /= divisor;
        adder = ((cardnum % 10) * 2);
        if (adder / 10 != 0)
        {
            adder = ((adder % 10) + (adder / 10));
        }
        bigsum += adder;
        divisor = 100;
    }
    divisor = 1;
    cardnum = cardnumcopy;

    while (cardnum / divisor > 0)
    {
        cardnum /= divisor;
        adder = (cardnum % 10);
        smallsum += adder;
        divisor = 100;
    }

    int checksum = bigsum + smallsum;
    if (checksum % 10 == 0)
    {

    }
    else
    {
        cardtype = "INVALID\n";
    }
    printf("%s", cardtype);
}