#include <bits/stdc++.h>

using namespace std;

string ltrim(const string &);
string rtrim(const string &);
vector<string> split(const string &);

/*
 * Complete the 'minimumBribes' function below.
 * Problem: https://www.hackerrank.com/challenges/one-week-preparation-kit-new-year-chaos/problem
 * The function accepts INTEGER_ARRAY q as parameter.
 */

void minimumBribes(vector<int> q) {
int bribes = 0;
int length = q.size();
    for (int i = length; i>=0; --i)
    {
    if (i != q[i-1])
    {if  ((q[i-2] >= 0) && (i == q[i-2]))
        {
            q[i-2] = q[i-1];
            q[i-1] = i;
            bribes++;}
    else if ((q[i-3] >=0) && (i != q[i-2]) && (i == q[i-3]))
        {
            q[i-3] = q[i-2];
            q[i-2] = q[i-1];
            q[i-1] = i;
            bribes += 2;}
    else
        {cout << "Too chaotic" << endl;
         return;
        }
    }
    }
    cout << bribes << endl;
}

int main()
{
    string t_temp;
    getline(cin, t_temp);

    int t = stoi(ltrim(rtrim(t_temp)));

    for (int t_itr = 0; t_itr < t; t_itr++) {
        string n_temp;
        getline(cin, n_temp);

        int n = stoi(ltrim(rtrim(n_temp)));

        string q_temp_temp;
        getline(cin, q_temp_temp);

        vector<string> q_temp = split(rtrim(q_temp_temp));

        vector<int> q(n);

        for (int i = 0; i < n; i++) {
            int q_item = stoi(q_temp[i]);

            q[i] = q_item;
        }

        minimumBribes(q);
    }

    return 0;
}

string ltrim(const string &str) {
    string s(str);

    s.erase(
        s.begin(),
        find_if(s.begin(), s.end(), not1(ptr_fun<int, int>(isspace)))
    );

    return s;
}

string rtrim(const string &str) {
    string s(str);

    s.erase(
        find_if(s.rbegin(), s.rend(), not1(ptr_fun<int, int>(isspace))).base(),
        s.end()
    );

    return s;
}

vector<string> split(const string &str) {
    vector<string> tokens;

    string::size_type start = 0;
    string::size_type end = 0;

    while ((end = str.find(" ", start)) != string::npos) {
        tokens.push_back(str.substr(start, end - start));

        start = end + 1;
    }

    tokens.push_back(str.substr(start));

    return tokens;
}
