#include <cs50.h>
#include <stdio.h>
#include <stdint.h>

typedef uint8_t BYTE;
int BLOCK_SIZE = 512;

bool jpgCheck(BYTE header[]);

int main(int argc, char *argv[])
{
    if (argc != 2)
    {
        printf("Usage: ./test IMAGE\n");
        return 1;
    }
    char *file = argv[1];
    //handle improper usage cases
    FILE *input = fopen(file, "r");
    if (input == NULL)
    {
        printf("Unable to open file: %s\n", file);
        return 1;
    }

    int counter = 0;
    BYTE buffer[BLOCK_SIZE];
    FILE *output = NULL;
    char filename[8];

    //check if we are able to read data from the memory card
    while (fread(buffer, sizeof(BYTE), BLOCK_SIZE, input))
    {
        //check if a jpg is being read
        if (jpgCheck(buffer))
        {
            if (output != NULL)
            {
                fclose(output);
            }
            //name the jpg and increment the filename
            sprintf(filename, "%03i.jpg", counter);
            output = fopen(filename, "w");
            counter++;
        }
        //if the output has an address, write to it
        if (output != NULL)
        {
            fwrite(buffer, sizeof(buffer), 1, output);
        }
    }
    //prevent memory leak by closing files
    fclose(input);
    fclose(output);
    return 0;
}
//check for jpg header bytes
bool jpgCheck(BYTE header[])
{
    return header[0] == 0xff
           && header[1] == 0xd8
           && header[2] == 0xff
           && (header[3] & 0xf0) == 0xe0;
}