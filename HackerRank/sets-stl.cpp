#include <cmath>
#include <cstdio>
#include <vector>
#include <iostream>
#include <set>
#include <algorithm>

/*Problem: https://www.hackerrank.com/challenges/cpp-sets/problem*/
using namespace std;


int main() {
int q, element, query;
set<int>x;

cin >> q;
for (int i = 0;i<q;i++)
{
    cin >> query;
    cin >> element;
    if (query == 1)
        x.insert(element); 
    else if (query == 2)
        x.erase(element);
    else if (query == 3)
    {         
        set<int>::iterator itr=x.find(element);
    if (itr != x.end())
        cout << "Yes" << endl;
        else 
        cout << "No" << endl;
    }
}
    return 0;
}
