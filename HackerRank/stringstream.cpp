#include <sstream>
#include <vector>
#include <iostream>
using namespace std;
/*Problem: https://www.hackerrank.com/challenges/c-tutorial-stringstream/problem*/


vector<int> parseInts(string str) {
    //int length = str.size();
    stringstream ss(str);
    vector<int> parsed;
    char c;
    int n;
    while (ss)
    {
    ss >> n;
    parsed.push_back(n); 
    ss >> c;
    }
    return parsed;
}

int main() {
    string str;
    cin >> str;
    vector<int> integers = parseInts(str);
    for(int i = 0; i < integers.size(); i++) {
        cout << integers[i] << "\n";
    }
    
    return 0;
}
