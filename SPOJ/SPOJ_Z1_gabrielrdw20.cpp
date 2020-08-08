#include <iostream>
#include <vector>
using namespace std;
int algorytm(vector<int>liczba, int dl)
{
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
    
    return liczba[dl-1];
}

int main()
{
  int n;
  vector<int> liczba;
do
{
  cin >> n;
  liczba.push_back(n);
 } while(n!=0) ;
  int dl = liczba.size();
  cout << " " << endl;
  cout << algorytm(liczba, dl);
  return 0;
}
