#include <iostream>
#include <vector>
#include<algorithm>

using namespace std;
void algorytm(vector<int> liczba, int dl)
{
    vector<int>nowy = liczba;
    int temp;
    for(int j=1; j<dl; j++)
    {
        for (int k=dl-1; k>=j; k--)
        {
            if(liczba[k]<liczba[k-1])
            {
                temp=liczba[k-1];
                liczba[k-1]=liczba[k];
                liczba[k]=temp;
            }
        }
    }
    
    
    cout <<"\n" <<  liczba[0] << endl;
    
    auto get = find(nowy.rbegin(), nowy.rend(), liczba[0]);
    auto index = distance(nowy.begin(), get.base());
    cout << index;
}

int main()
{
  int n;
  vector<int> liczba;


 while(cin>>n && n!=0) liczba.push_back(n);
 
 
  int dl = liczba.size();
  algorytm(liczba, dl);
  return 0;
}
