#include "helpers.h"
#include <math.h>
//Problem: https://cs50.harvard.edu/x/2022/psets/4/filter/less/
// Convert image to grayscale
void grayscale(int height, int width, RGBTRIPLE image[height][width])
{
    DWORD sum = 0;
    DWORD avg[height][width]; //array to store average rgb values
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++) //calculates average for each pixel
        {
            sum = image[i][j].rgbtBlue + image[i][j].rgbtGreen + image[i][j].rgbtRed;
            avg[i][j] = round(sum / 3.0);
        }
    }
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++) //assigns average rgb value to each pixel
        {
            image[i][j].rgbtBlue = avg[i][j];
            image[i][j].rgbtGreen = avg[i][j];
            image[i][j].rgbtRed = avg[i][j];
        }
    }
    return;
}

// Convert image to sepia
void sepia(int height, int width, RGBTRIPLE image[height][width])
{
    const BYTE max = 255; //maximum rgb value in case the sum exceeds 255
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            const DWORD sepiaRed = round((.393 * image[i][j].rgbtRed) + (.769 * image[i][j].rgbtGreen) + (.189 * image[i][j].rgbtBlue));
            const DWORD sepiaGreen = round((.349 * image[i][j].rgbtRed) + (.686 * image[i][j].rgbtGreen) + (.168 * image[i][j].rgbtBlue));
            const DWORD sepiaBlue = round((.272 * image[i][j].rgbtRed) + (.534 * image[i][j].rgbtGreen) + (.131 * image[i][j].rgbtBlue));
            if (sepiaRed > 255)
            {
                image[i][j].rgbtRed = max;
            }
            else
            {
                image[i][j].rgbtRed = sepiaRed;
            }
            if (sepiaGreen > 255)
            {
                image[i][j].rgbtGreen = max;
            }
            else
            {
                image[i][j].rgbtGreen = sepiaGreen;
            }
            if (sepiaBlue > 255)
            {
                image[i][j].rgbtBlue = max;
            }
            else
            {
                image[i][j].rgbtBlue = sepiaBlue;
            }
        }
    }
    return;
}

// Reflect image horizontally
void reflect(int height, int width, RGBTRIPLE image[height][width])
{
    RGBTRIPLE temp[height][width]; //placeholder for flipped image pixels
    for (int i = 0; i < height; i++)
    {
        for (int j = 0, x = width - 1; j < width && x >= 0; j++, x--) //indeces flow from opposite ends
        {
            temp[i][j].rgbtRed = image[i][x].rgbtRed;
            temp[i][j].rgbtGreen = image[i][x].rgbtGreen;
            temp[i][j].rgbtBlue = image[i][x].rgbtBlue;
        }
    }
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            image[i][j].rgbtRed = temp[i][j].rgbtRed;
            image[i][j].rgbtGreen = temp[i][j].rgbtGreen;
            image[i][j].rgbtBlue = temp[i][j].rgbtBlue;
        }
    }
    return;
}

// Blur image
void blur(int height, int width, RGBTRIPLE image[height][width])
{
    RGBTRIPLE copy[height][width]; //stores blurred pixels without affecting og image
    DWORD redsum = 0, greensum = 0, bluesum = 0, redavg = 0, greenavg = 0, blueavg = 0;
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            RGBTRIPLE topleft = image[i - 1][j - 1];
            RGBTRIPLE left = image[i][j - 1];
            RGBTRIPLE bottom = image[i + 1][j];
            RGBTRIPLE bottomright = image[i + 1][j + 1];
            RGBTRIPLE center = image[i][j];
            RGBTRIPLE right = image[i][j + 1];
            RGBTRIPLE top = image[i - 1][j];
            RGBTRIPLE bottomleft = image[i + 1][j - 1];
            RGBTRIPLE topright = image[i - 1][j + 1];
            redsum = bottomleft.rgbtRed + left.rgbtRed + bottomright.rgbtRed
                     + bottom.rgbtRed + center.rgbtRed + right.rgbtRed
                     + top.rgbtRed + topleft.rgbtRed + topright.rgbtRed;

            greensum = bottomleft.rgbtGreen + left.rgbtGreen + bottomright.rgbtGreen
                       + bottom.rgbtGreen + center.rgbtGreen + right.rgbtGreen
                       + top.rgbtGreen + topleft.rgbtGreen + topright.rgbtGreen;

            bluesum = bottomleft.rgbtBlue + left.rgbtBlue + bottomright.rgbtBlue
                      + bottom.rgbtBlue + center.rgbtBlue + right.rgbtBlue
                      + top.rgbtBlue + topleft.rgbtBlue + topright.rgbtBlue;
            redavg = round(redsum / 9.0);
            greenavg = round(greensum / 9.0);
            blueavg = round(bluesum / 9.0);

            //define special cases for pixels lacking 8 neighbors
            if (i == 0 && j == 0) //top left pixel
            {
                redsum = redsum - bottomleft.rgbtRed - left.rgbtRed
                         - top.rgbtRed - topleft.rgbtRed - topright.rgbtRed;
                greensum = greensum - bottomleft.rgbtGreen - left.rgbtGreen
                           - top.rgbtGreen - topleft.rgbtGreen - topright.rgbtGreen;
                bluesum = bluesum - bottomleft.rgbtBlue - left.rgbtBlue
                          - top.rgbtBlue - topleft.rgbtBlue - topright.rgbtBlue;
                redavg = round(redsum / 4.0);
                greenavg = round(greensum / 4.0);
                blueavg = round(bluesum / 4.0);
            }
            if (i == 0 && j == width - 1) //top right pixel
            {
                redsum = redsum - topleft.rgbtRed - top.rgbtRed
                         - topright.rgbtRed - right.rgbtRed - bottomright.rgbtRed;
                greensum = greensum - topleft.rgbtGreen - top.rgbtGreen
                           - topright.rgbtGreen - right.rgbtGreen - bottomright.rgbtGreen;
                bluesum = bluesum - topleft.rgbtBlue - top.rgbtBlue
                          - topright.rgbtBlue - right.rgbtBlue - bottomright.rgbtBlue;
                redavg = round(redsum / 4.0);
                greenavg = round(greensum / 4.0);
                blueavg = round(bluesum / 4.0);
            }
            if (i == 0 && j != 0 && j != width - 1) //top row but not corner
            {
                redsum = redsum - topleft.rgbtRed - top.rgbtRed - topright.rgbtRed;
                greensum = greensum - topleft.rgbtGreen - top.rgbtGreen
                           - topright.rgbtGreen;
                bluesum = bluesum - topleft.rgbtBlue - top.rgbtBlue
                          - topright.rgbtBlue;
                redavg = round(redsum / 6.0);
                greenavg = round(greensum / 6.0);
                blueavg = round(bluesum / 6.0);
            }
            if (i == height - 1 && j == 0) //bottom left pixel
            {
                redsum = redsum - bottomleft.rgbtRed - bottomright.rgbtRed
                         - bottom.rgbtRed - left.rgbtRed - topleft.rgbtRed;
                greensum = greensum - bottomleft.rgbtGreen - bottomright.rgbtGreen
                           - bottom.rgbtGreen - left.rgbtGreen - topleft.rgbtGreen;
                bluesum = bluesum - bottomleft.rgbtBlue - bottomright.rgbtBlue
                          - bottom.rgbtBlue - left.rgbtBlue - topleft.rgbtBlue;
                redavg = round(redsum / 4.0);
                greenavg = round(greensum / 4.0);
                blueavg = round(bluesum / 4.0);
            }
            if (i == height - 1 && j != 0 && j != width - 1) //bottom row but not corner
            {
                redsum = redsum - bottomleft.rgbtRed - bottom.rgbtRed
                         - bottomright.rgbtRed;
                greensum = greensum - bottomleft.rgbtGreen - bottom.rgbtGreen
                           - bottomright.rgbtGreen;
                bluesum = bluesum - bottomleft.rgbtBlue - bottom.rgbtBlue
                          - bottomright.rgbtBlue;
                redavg = round(redsum / 6.0);
                greenavg = round(greensum / 6.0);
                blueavg = round(bluesum / 6.0);
            }
            if (i == height - 1 && j == width - 1) //bottom right pixel
            {
                redsum = redsum - bottomleft.rgbtRed - bottomright.rgbtRed
                         - bottom.rgbtRed - right.rgbtRed - topright.rgbtRed;
                greensum = greensum - bottomleft.rgbtGreen - bottomright.rgbtGreen
                           - bottom.rgbtGreen - right.rgbtGreen - topright.rgbtGreen;
                bluesum = bluesum - bottomleft.rgbtBlue - bottomright.rgbtBlue
                          - bottom.rgbtBlue - right.rgbtBlue - topright.rgbtBlue;
                redavg = round(redsum / 4.0);
                greenavg = round(greensum / 4.0);
                blueavg = round(bluesum / 4.0);
            }
            if (i != 0 && i != height - 1 && j == 0) //left column but not corner
            {
                redsum = redsum - bottomleft.rgbtRed - left.rgbtRed - topleft.rgbtRed;
                greensum = greensum - bottomleft.rgbtGreen - left.rgbtGreen
                           - topleft.rgbtGreen;
                bluesum = bluesum - bottomleft.rgbtBlue - left.rgbtBlue - topleft.rgbtBlue;
                redavg = round(redsum / 6.0);
                greenavg = round(greensum / 6.0);
                blueavg = round(bluesum / 6.0);
            }
            if (i != 0 && i != height - 1 && j == width - 1) //right column but not corner
            {
                redsum = redsum - bottomright.rgbtRed - right.rgbtRed - topright.rgbtRed;
                greensum = greensum - bottomright.rgbtGreen - right.rgbtGreen
                           - topright.rgbtGreen;
                bluesum = bluesum - bottomright.rgbtBlue - right.rgbtBlue
                          - topright.rgbtBlue;
                redavg = round(redsum / 6.0);
                greenavg = round(greensum / 6.0);
                blueavg = round(bluesum / 6.0);
            }
            copy[i][j].rgbtRed = redavg;
            copy[i][j].rgbtGreen = greenavg;
            copy[i][j].rgbtBlue = blueavg;
        }
    }
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            image[i][j] = copy[i][j];
        }
    }
    return;
}
