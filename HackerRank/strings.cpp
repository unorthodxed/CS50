#include <iostream>
#include <string>
using namespace std;
/*Problem: https://www.hackerrank.com/challenges/c-tutorial-strings/problem*/


int main() 
{
string a, b;
cin >> a;
cin >> b;
int length = a.size();
cout << length << " ";
length = b.size();
cout << length << endl;
cout << a + b << endl;
swap(a[0],b[0]);
cout << a << " " << b;      
    return 0;
}
