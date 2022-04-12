#include <cs50.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>

int main(int argc, string argv[])
{
    if (argc == 2 && strlen(argv[1]) == 26)
    {
        int duplicate = 0;
        for (int i = 0; i < 26; i++)  //check key for abnormalities regarding different input conditions
        {
            if (isalpha(argv[1][i]) == 0)
            {
                printf("Keys must be alphabetical\n");
                return 1;
            }
            for (int j = 1; j < 26; j++)
            {
                if (argv[1][i] == argv[1][j])
                {
                    duplicate++;
                }
            }
            if (duplicate > 25)
            {
                printf("Keys may not contain duplicate characters\n");
                return 1;
            }
        }
        string defaultlower = "abcdefghijklmnopqrstuvwxyz", defaultupper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        string plaintext = get_string("plaintext: ");
        for (int i = 0; i < strlen(plaintext); i++)
        {
            for (int j = 0; j < 26; j++)
            {
                if (islower(plaintext[i]))  //if the plaintext character is lowercase, we need to get an appropriate replacement
                {
                    if (plaintext[i] == defaultlower[j])
                    {
                        char lower = tolower(argv[1][j]);  //declare placeholder character to receive lowercase version of key index
                        argv[1][j] = lower;
                        plaintext[i] = argv[1][j];
                        j = 26;  //if the matching character was found, there is no need to continue iterating through defaultlower
                    }
                }
                else
                {
                    if (plaintext[i] == defaultupper[j])  //if the plaintext character is lowercase, we need to get an appropriate replacement
                    {
                        char upper = toupper(argv[1][j]);  //declare placeholder character to receive uppercase version of key index
                        argv[1][j] = upper;
                        plaintext[i] = argv[1][j];
                        j = 26;  //if the matching character was found, there is no need to continue iterating through defaultupper
                    }
                }
            }
        }
        printf("ciphertext: %s", plaintext);
        printf("\n");
    }
    else if (argc == 2 && strlen(argv[1]) != 26)  //check if key length is correct
    {
        printf("Key must be 26 characters long\n");
        return 1;
    }
    else if (argc != 2)  //check if program was executed properly
    {
        printf("Please execute ./substitution followed by a 26 character key\n");
        return 1;
    }
    return 0;
}