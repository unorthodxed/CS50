#include <ctype.h>
#include <cs50.h>
#include <stdio.h>
#include <string.h>
//Problem: https://cs50.harvard.edu/x/2022/labs/2/
// Points assigned to each letter of the alphabet
int POINTS[] = {1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10};
string alphabet = "abcdefghijklmnopqrstuvwxyz";
int compute_score(string word);

int main(void)
{
    // Get input words from both players
    string word1 = get_string("Player 1: ");
    string word2 = get_string("Player 2: ");

    // Score both words
    int score1 = compute_score(word1);
    int score2 = compute_score(word2);

    if (score1 > score2)  //determine whether a victory or tie has occurred
    {
        printf("Player 1 wins!");
    }
    else if (score1 == score2)
    {
        printf("Tie!");
    }
    else
    {
        printf("Player 2 wins!");
    }
    printf("\n");
}

int compute_score(string word)
{
    int score = 0;
    for (int i = 0; i < strlen(word); i++)
    {
        for (int j = 0; j < 26; j++)
        {
            if (tolower(word[i]) == alphabet[j])  //make all entries lowercase for simplicity
            {
                score += POINTS[j];  //add points according to the index of POINTS array
            }
        }
    }
    return score;
}
