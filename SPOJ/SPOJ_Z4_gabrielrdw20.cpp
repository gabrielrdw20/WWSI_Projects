#include <iostream>
#include <vector>
#include <sstream>
#include <string>
#include <algorithm>

using namespace std;
void minmax(vector<int> liczba, int dl)
{
    vector<int>nowy = liczba;
    int temp, temp_1;
    
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
    
    
    
     for(int k=1; k<dl; k++)
    {
        for (int m=dl-1; m>=k; m--)
        {
            if(liczba[m]<liczba[m-1])
            {
                temp_1=liczba[m-1];
                liczba[m-1]=liczba[m];
                liczba[m]=temp_1;
            }
        }
    }
    
    
    // dobrze pokazuje wartosci min i max, źle - odwrotnie - pokazuje ich indeksy
    
    cout <<"\n" <<  liczba[0] << endl;
    auto it = find (nowy.begin(), nowy.end(), liczba[0]);
    cout << it - nowy.begin() +1 << endl;
    
    cout << liczba[dl-1] << endl;
    auto get = find(nowy.rbegin(), nowy.rend(), liczba[dl-1]);
    auto index = distance(nowy.begin(), get.base());
    cout << index << endl;
}



    


int main()
{
  int n;
  vector<int> liczba;
  string wpisz;

while (getline(cin, wpisz) && wpisz.length() > 0)
    {
        stringstream wpiszstr(wpisz);
        wpiszstr >> n;
        liczba.push_back(n);
    }
 
 
  int dl = liczba.size();
  minmax(liczba, dl);
  return 0;
}
