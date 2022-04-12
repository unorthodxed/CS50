#include <cs50.h>
#include <stdio.h>

int main(void)
{
    int height = get_int("Height: ");
    int spaces = 1;
    int success = 0;

    while (success < 1)
    {
        if (height == 0)
        {
            height = get_int("Height: ");
        }
        if (height >= 1 && height <= 8)
        {
            for (int row = 1; row <= height; row++)
            {
                while (spaces <= (height - row))
                {
                    printf(" ");
                    spaces++;
                }
                spaces = 1;
                for (int hashes = 1; hashes <= row; hashes++)
                {
                    printf("#");
                }
                printf("  ");
                for (int hashes = 1; hashes <= row; hashes++)
                {
                    printf("#");
                }
                if (row <= height)
                {
                    printf("\n");
                }
                spaces = 1;
            }
            success++;
        }
        else
        {
            height = get_int("Height: ");
        }
    }
}