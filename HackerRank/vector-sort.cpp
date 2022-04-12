#include <cmath>
#include <cstdio>
#include <vector>
#include <iostream>
#include <algorithm>

/*Problem: https://www.hackerrank.com/challenges/vector-sort/problem*/

using namespace std;


int main() {
    int elements;
    int element;
    cin >> elements;
    vector<int>arr;
    for (int i = 0;i<elements;i++)
    {
        cin >> element;
        arr.push_back(element);
    }
    sort(arr.begin(),arr.end());
    for (int i = 0;i<elements;i++)
    {
        cout << arr[i] << " ";
    }
    return 0;
}
