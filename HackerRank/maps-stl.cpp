#include <cmath>
#include <cstdio>
#include <vector>
#include <iostream>
#include <set>
#include <map>
#include <algorithm>
/*Problem: https://www.hackerrank.com/challenges/cpp-maps/problem*/

using namespace std;


int main() {
map<string,int>m;
int q, query, mark;
string studentname;
cin >> q;
for (int i = 0; i<q;i++)
{
    cin >> query;
    if (query == 1)
    {
        cin >> studentname;
        map<string,int>::iterator itr=m.find(studentname);
        cin >> mark;
        if (itr == m.end())
        {
            m.insert(make_pair(studentname, mark));
        }
        else 
        { 
            itr->second += mark;
        }
    }
    else if (query == 2)
    {
        cin >> studentname;
        map<string,int>::iterator itr=m.find(studentname);
        if (itr != m.end()) m.erase(studentname);
    }
    else if (query == 3)
    {
        cin >> studentname;
        map<string,int>::iterator itr=m.find(studentname);
        if (itr == m.end())
        cout << 0 << endl;
        else 
        {
        cout << itr->second << endl;
        }
    } 
}
    return 0;
}
