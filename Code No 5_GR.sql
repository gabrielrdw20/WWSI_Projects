author: gbrielrdw20 (github)

----------ZADANIE 1 --------------

USE ABDUczelnia
SELECT DISTINCT S.Imie, S.Nazwisko, S.Pesel
FROM  [Studenci]S JOIN [Oceny]O ON S.IdStudenta = O.IdStudenta
WHERE S.CzyKobieta = 1 AND O.Ocena = 2.00 AND O.DataOceny BETWEEN '2013-05-01' AND '2013-05-31'
GROUP BY S.Imie, S.Nazwisko, S.Pesel HAVING count(O.Ocena) >= 1
ORDER BY S.Nazwisko ASC

----------ZADANIE 2 --------------

USE ABDUczelnia
SELECT DISTINCT S.Imie, S.Nazwisko, S.Pesel, avg(O.Ocena) as SredniaOcena
FROM  [Studenci]S JOIN [Oceny]O ON S.IdStudenta = O.IdStudenta
WHERE O.DataOceny BETWEEN '2014-01-01' AND '2014-12-31' AND O.Ocena NOT IN 
(
SELECT O.Ocena 
WHERE O.Ocena = 2.00
)
GROUP BY S.Imie, S.Nazwisko, S.Pesel HAVING count(O.Ocena) >= 10 AND avg(O.Ocena) > 4.25
ORDER BY S.Nazwisko ASC

----------ZADANIE 3 --------------

USE ABDPrzychodnia;

WITH AAA AS
(
SELECT DISTINCT TOP(30) W.IdPacjenta, count(W.DataWizyty) as IleRazy, L.NrEwid
FROM [Wizyty]W JOIN [Lekarze]L ON W.IdLekarza = L.IdLekarza
WHERE W.DataWizyty BETWEEN '2013-01-01' AND '2013-12-31'
GROUP BY W.IdPacjenta, L.NrEwid
ORDER BY IleRazy DESC
)

SELECT DISTINCT L.Imie, L.Nazwisko, L.NrEwid, sum(W.Oplata) as Oplaty
FROM AAA JOIN [Wizyty]W ON AAA.IdPacjenta = W.IdPacjenta JOIN [Lekarze]L ON L.NrEwid = AAA.NrEwid
WHERE W.DataWizyty BETWEEN '2014-01-01' AND '2014-12-31'
GROUP BY L.Imie, L.Nazwisko, L.NrEwid

----------ZADANIE 4 --------------

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

