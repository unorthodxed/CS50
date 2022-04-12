#include <cmath>
#include <cstdio>
#include <vector>
#include <iostream>
#include <algorithm>
using namespace std;

/*Problem: https://www.hackerrank.com/challenges/arrays-introduction/problem*/

int main() {

int elements;
cin >> elements;
int arr[elements];
for (int i = 0; i<elements; i++)
{
    cin >> arr[i];
}
for (int i = elements-1; i>=0;i--)
{
    cout << arr[i] << " ";
}   
    return 0;
}
