#include <iostream>
#include <algorithm>
#include <vector>
using namespace std;

int main()
{

 ios_base::sync_with_stdio(0);
 int i,j,k;
 vector <int> arr;

 while(cin>>k) arr.push_back(k);
 sort(arr.begin(), arr.end());

 for(j=0;j<arr.size();j++) cout << arr[j] << endl;
}
