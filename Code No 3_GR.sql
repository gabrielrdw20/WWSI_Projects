--------- Z1 ---------------------------------------------------------------

USE ABDPrzychodnia
SELECT P.Nazwisko, P.Imie, P.Pesel, COUNT (W.IdPacjenta) as liczba_wizyt
FROM [Wizyty] W JOIN [Pacjenci] P ON P.IdPacjenta = W.IdPacjenta
WHERE W.DataWizyty BETWEEN '2013-01-01'AND '2013-07-01'
GROUP BY  P.Nazwisko, P.Imie, P.Pesel HAVING COUNT(W.IdPacjenta) <= 3
ORDER BY liczba_wizyt, P.Nazwisko ASC


--------- Z2 ---------------------------------------------------------------

USE ABDUczelnia
SELECT S.Nazwisko, S.Pesel, AVG(Ocena) as OC, COUNT(Ocena) as OCC
FROM [Studenci] S JOIN [Oceny] O ON S.IdStudenta = O.IdStudenta
WHERE S.DataUrodzenia > '1996'
GROUP BY S.Nazwisko, S.Pesel, O.Ocena HAVING COUNT(Ocena) > 20
ORDER BY OC DESC




--------- Z3 ---------------------------------------------------------------

USE ABDPrzychodnia
SELECT P.Imie, P.Nazwisko, P.Pesel
FROM [Pacjenci] P JOIN [Wizyty] W ON P.IdPacjenta = W.IdPacjenta JOIN [Lekarze] L ON L.IdLekarza = W.IdLekarza JOIN [Specjalizacje] S on S.Idspecjalizacji = L.Idspecjalizacji
WHERE  P.DataUrodzenia > '1965-12-31' AND P.CzyKobieta = 1 AND S.NazwaSpecjalizacji='Lekarz rodzinny' AND W.DataWizyty between '2013-01-01' and '2013-12-31'
GROUP BY  P.Imie, P.Nazwisko, P.Pesel HAVING count(*) > 3
INTERSECT SELECT P.Imie, P.Nazwisko, P.Pesel
FROM [Pacjenci] P JOIN [Wizyty] W on P.IdPacjenta = W.IdPacjenta JOIN [Lekarze] L ON L.IdLekarza=W.IdLekarza JOIN [Specjalizacje] S ON S.idspecjalizacji=L.Idspecjalizacji
WHERE P.CzyKobieta=1 AND P.DataUrodzenia>'1965-12-31' AND S.NazwaSpecjalizacji!='Lekarz Rodzinny' AND  W.DataWizyty BETWEEN '2013-01-01' AND '2013-12-31' 
GROUP BY P.Imie, P.Nazwisko, P.Pesel HAVING COUNT (*) > 3

