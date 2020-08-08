author: gabrielrdw20 (github)

Zadanie 1 ----------------------------------------------

USE ABDPrzychodnia
SELECT Imie, COUNT(W.DataWizyty) AS WI FROM [Wizyty] W
JOIN [Pacjenci] P ON P.IdPacjenta = W.IdPacjenta
WHERE DataWizyty BETWEEN '20130701' AND '20131231'
GROUP BY Imie HAVING COUNT(W.DataWizyty)>=3
ORDER BY WI DESC;


Zadanie 2 ----------------------------------------------

USE ABDUczelnia
SELECT P.Nazwa, COUNT(Ocena) AS LiczbaOcen5
FROM [Studenci] S 
JOIN [Oceny] O ON S.Idstudenta = O.IdStudenta
JOIN [Przedmioty] P ON P.IdPrzedmiotu = O.IdPrzedmiotu
WHERE S.Płeć = 'Kobieta' AND  (O.DataOceny BETWEEN '2013.01.01' AND '20131231') AND O.Ocena >= 5
GROUP BY P.Nazwa
ORDER BY LiczbaOcen5 DESC;

