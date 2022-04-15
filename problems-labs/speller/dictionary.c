// Implements a dictionary's functionality
//Problem: https://cs50.harvard.edu/x/2022/psets/5/speller/
#include <ctype.h>
#include <stdbool.h>
#include <string.h>
#include <strings.h>
#include <stdio.h>
#include <stdlib.h>

#include "dictionary.h"

// Represents a node in a hash table
typedef struct node
{
    char word[LENGTH + 1];
    struct node *next;
}
node;

const unsigned int N = 78; //three buckets for each letter in the alphabet

// Hash table
node *table[N];
node *head = NULL;
int success = 0; //verify if a successful load occurred
unsigned int counter = 0; //keep track of words loaded for size function
// Returns true if word is in dictionary, else false
bool check(const char *word)
{
    int index = hash(word);
    node *cursor = table[index];
    while (cursor != NULL)
    {
        if (strcasecmp(cursor->word, word) == 0)
        {
            return true;
        }
        cursor = cursor->next;
    }
    return false;
}

// Hashes word to a number
unsigned int hash(const char *word)
{
    int length = strlen(word), sum = 0, multiplier = 0, index;
    const int lower_threshold = 488, upper_threshold = 1096; //3 buckets each letter: small, medium, large ASCII sum
    for (int i = 0; i < length; i++)
    {
        if (isalpha(word[i])) //don't want to add apostrophes to the sum
        {
            sum += tolower(word[i]); //gives us the sum of ASCII values for word
        }
    }
    while (tolower(word[0]) > 97 + multiplier)
    {
        multiplier++;
    }
    index = (multiplier * 3); //define how many triplets were skipped
    if (sum > lower_threshold && sum < upper_threshold) //medium ASCII sum
    {
        index++;
    }
    else if (sum > upper_threshold) //large ASCII sum
    {
        index += 2;
    }
    return index;
}

// Loads dictionary into memory, returning true if successful, else false
bool load(const char *dictionary)
{
    FILE *file = fopen(dictionary, "r");
    if (file == NULL)
    {
        return false;
    }
    while (feof(file) == 0)
    {
        char word[LENGTH + 1]; // long enough for longest word + newline char. POSSIBLY INITIALIZE WORD ARRAY AS 0s
        fscanf(file, "%s", word);
        node *n = calloc(1, sizeof(node));
        if (n == NULL) //if no memory available
        {
            free(n);
            return false;
        }
        strcpy(n->word, word);
        head = table[hash(n->word)];
        if (head == NULL) //if the head of the table index returned by hash function
        {
            head = n;
            counter++;
        }
        else //reassign pointers
        {
            n->next = head->next;
            head->next = n;
            counter++;
        }
        table[hash(n->word)] = head;
    }
    fclose(file);
    counter--;
    success++;
    return true;
}

// Returns number of words in dictionary if loaded, else 0 if not yet loaded
unsigned int size(void)
{
    if (success == 1)
    {
        return counter;
    }
    else
    {
        return 0;
    }
}

// Unloads dictionary from memory, returning true if successful, else false
bool unload(void)
{
    for (int i = 0; i < N; i++)
    {
        node *tmp = table[i];
        node *cursor = table[i];
        while (cursor != NULL)
        {
            cursor = cursor->next;
            free(tmp);
            tmp = cursor;
        }
    }
    return true;
}
