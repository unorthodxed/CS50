#include <cmath>
#include <cstdio>
#include <vector>
#include <iostream>
#include <algorithm>

/*Problem: https://www.hackerrank.com/challenges/cpp-lower-bound/problem*/

using namespace std;

int main() {
int element, elements;
cin >> elements;
vector<int> arr;
for (int i = 0;i<elements;i++)
{
    cin >> element;
    arr.push_back(element);
}

int q, query;
cin >> q;
for (int i = 0; i<q;i++)
{
cin >> query;
vector<int>::iterator temp = lower_bound(arr.begin(),arr.end(),query);
if (*temp!=query)
{
    cout << "No " << (temp - arr.begin() + 1) << endl;
}
else 
{
    cout << "Yes " << (temp - arr.begin() + 1) << endl;
}
}
return 0;
}
