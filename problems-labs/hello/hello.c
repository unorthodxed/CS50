#include <stdio.h>
#include <cs50.h>

int main(void)
{
    string name = get_string("What is your name?: "); //Get name
    printf("hello, %s", name); //Print Name
    printf("\n"); // Print new line
}