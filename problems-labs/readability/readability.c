#include <cs50.h>
#include <stdio.h>
#include <string.h>
//Problem: https://cs50.harvard.edu/x/2022/psets/2/readability/
int count_letters(string text);
int count_words(string text);
int count_sentences(string text);

int main(void)
{
    string text = get_string("Text: ");
    float index = 0;
    float average_letters = 0, average_sentences = 0;
    average_letters = (count_letters(text) / (count_words(text) * 100.00)) * 10000;
    average_sentences = (count_sentences(text) / (count_words(text) * 100.00)) * 10000;
    index = (0.0588 * average_letters) - (0.296 * average_sentences) - 15.8;
    if (index < 1)
    {
        printf("Before Grade 1");
    }
    else if (index > 16)
    {
        printf("Grade 16+");
    }
    else
    {
        if (index)
        {
            printf("Grade %.0f", index);
        }
    }
    printf("\n");
}

int count_letters(string text)
{
    int letters = 0;
    for (int i = 0; i < strlen(text); i++)
    {
        if ((text[i] >= 65 && text[i] <= 90) || (text[i] >= 97 && text[i] <= 122))
        {
            letters++;
        }
    }
    return letters;
}

int count_words(string text)
{
    int words = 0;
    for (int i = 0; i < strlen(text); i++)
    {
        if (text[i] == 32)
        {
            words++;
        }
    }
    words++;
    return words;
}

int count_sentences(string text)
{
    int sentences = 0;
    for (int i = 0; i < strlen(text); i++)
    {
        if (text[i] == 33 || text[i] == 46 || text[i] == 63)
        {
            sentences++;
        }
    }
    return sentences;
}
