#include <cmath>
#include <cstdio>
#include <vector>
#include <iostream>
#include <algorithm>

/*Problem: https://www.hackerrank.com/challenges/vector-erase/problem*/

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
int query;
cin >> query;
query = query - 1;
arr.erase(arr.begin()+query);
int bound1, bound2;
cin >> bound1;
bound1 = bound1 - 1;
cin >> bound2;
bound2 = bound2 - 1;
arr.erase(arr.begin()+bound1,arr.begin()+bound2);
int length = arr.size();
cout << length << endl;
for (int i = 0;i<length;i++)
{
    cout << arr[i] << " ";
}
return 0;
}
