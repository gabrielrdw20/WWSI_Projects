#include <iostream>
using namespace std;

int main()
{
    int i, j, k, p, n, m, s=0;


   cin >> n; //liczba wierszy
   cin >> m; //liczba kolumn

   int tab[n][m], tab_T[m][n], tab_C[n][n];

for(i=0;i<m;i++) for(j=0;j<m;j++) tab_C[i][j]=0;

//zapełnianie tablicy bazowej
   for (i=0; i<n; i++)
   {
       for(j=0;j<m;j++)
       {
       cin >> tab[i][j];
       }
   }


// zapisanie macierzy transponowanej do tab_T
for (i=0; i<m; i++)
{
    for (j=0; j<n;j++)
    {
        tab_T[i][j] = tab[j][i];
    }
}


// mnożenie macierzy tab i tab_T
for(i=0; i<m;i++)
{
    for(j=0;j<m;j++)
    {
        tab_C[i][j]=0;

        for(k=0;k<n;k++)
        {
            tab_C[i][j]+= tab_T[i][k]*tab[k][j];
        }
    }
}


cout << endl;

//wypisanie wyniku
for(i=0;i<m;i++)
{
    for(j=0;j<m;j++)
    {
        cout<<tab_C[i][j] << " ";
    }

    cout << endl;
}



}
