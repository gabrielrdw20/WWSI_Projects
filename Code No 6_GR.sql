author: gbrielrdw20 (github)

--- ZADANIE 1 --------------

USE ABDPrzychodnia
SELECT P.Imie, P.Nazwisko, L.Imie, L.Nazwisko, S.NazwaSpecjalizacji, W.DataWizyty, W.Oplata
FROM [Wizyty]W JOIN [Pacjenci]P ON W.IdPacjenta = W.IdPacjenta JOIN [Lekarze]L ON L.IdLekarza = W.IdLekarza JOIN [Specjalizacje]S ON S.idspecjalizacji = L.Idspecjalizacji
WHERE W.DataWizyty BETWEEN '2013-03-01' AND '2013-03-31' AND year(L.DataUrodzenia) > '1975' AND year(P.DataUrodzenia) > '1950'
GROUP BY P.Imie, P.Nazwisko, L.Imie,L.Nazwisko, S.NazwaSpecjalizacji, W.DataWizyty, W.Oplata


--- ZADANIE 2 --------------

USE ABDUczelnia
SELECT W.Imie, W.Nazwisko, W.Nip, count(O.Ocena) as IleOcen
FROM [Wykladowcy]W JOIN [Oceny]O ON W.IdWykladowcy = O.IdWykladowcy JOIN [Studenci]S ON O.IdStudenta = S.IdStudenta
WHERE  S.P³eæ = 'Kobieta' AND O.Ocena = 2.00  AND O.DataOceny BETWEEN '2013-01-01' AND '2013-07-01'
GROUP BY W.Imie, W.Nazwisko, W.Nip HAVING count(O.Ocena) > 21
ORDER BY IleOcen DESC

--- ZADANIE 3 --------------

USE ABDUczelnia;
WITH AAA AS
(
SELECT DISTINCT W.Imie, W.Nazwisko, W.Nip, cast(count(O.Ocena) as decimal (10,2)) as IleOcenLacznie
FROM [Oceny]O JOIN [Wykladowcy]W ON O.IdWykladowcy = W.IdWykladowcy
GROUP BY W.Nip, W.Imie, W.Nazwisko
),
BBB AS
(
SELECT DISTINCT W.Imie, W.Nazwisko, W.Nip, cast(count(O.Ocena) as decimal(10,2)) as IleOcen5
FROM [Oceny]O JOIN [Wykladowcy]W ON O.IdWykladowcy = W.IdWykladowcy
WHERE O.Ocena = 5.00
GROUP BY W.Nip, W.Imie, W.Nazwisko
)
SELECT TOP 5 W.Imie, W.Nazwisko, W.Nip, cast((BBB.IleOcen5 * 100 / AAA.IleOcenLacznie ) as decimal(10,2)) as Procent
FROM AAA JOIN BBB ON AAA.Nip = BBB.Nip JOIN [Wykladowcy]W ON AAA.Nip = W.Nip
GROUP BY W.Imie,W.Nazwisko, W.Nip,AAA.IleOcenLacznie,BBB.IleOcen5
ORDER BY Procent DESC

--- ZADANIE 4 --------------

USE ABDUczelnia;
WITH AAA AS
(
SELECT Idstudenta, count(Ocena) as IleOcen
FROM Oceny
WHERE Ocena < 4.00  AND (DataOceny BETWEEN '2013-01-01' AND '2013-12-31')
GROUP BY IdStudenta
)
SELECT AAA.IleOcen, count(AAA.IdStudenta) as IluStudentow
FROM AAA
WHERE AAA.IleOcen BETWEEN 1 AND 20
GROUP BY AAA.IleOcen
ORDER BY AAA.IleOcen DESC


