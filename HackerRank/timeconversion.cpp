#include <bits/stdc++.h>

/*Given a time in -hour AM/PM format, convert it to military (24-hour) time.*/

using namespace std;

string timeConversion(string s) {
string prehour = s.substr(0,2);
size_t pos = s.find("AM");
int pre = stoi(prehour);
if (pos != string::npos)
{
    if (pre == 12)
    {
        prehour = "00";
        s.replace(0,2,prehour);
    }    
}
else 
{
    if (pre != 12)
    prehour = to_string(pre + 12);
    s.replace(0,2,prehour);
}
s.erase(8,2);
return s;
}

int main()
{
    ofstream fout(getenv("OUTPUT_PATH"));

    string s;
    getline(cin, s);

    string result = timeConversion(s);

    fout << result << "\n";

    fout.close();

    return 0;
}
