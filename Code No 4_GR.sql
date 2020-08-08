author: gabrielrdw20 (github)

------------------  Z1 -------------------------------------------------------------

USE ABDUczelnia
SELECT S.Nazwisko, S.Imie, S.Pesel
FROM [Oceny] O JOIN [Studenci] S ON O.IdStudenta = S.IdStudenta
GROUP BY S.Nazwisko, S.Imie, O.Ocena, S.Pesel, O.IdStudenta HAVING COUNT(O.IdStudenta) >= 15 AND AVG(Ocena) > 4.0
ORDER BY S.Nazwisko ASC

------------------  Z2 -------------------------------------------------------------

USE ABDPrzychodnia
SELECT P.Imie, P.Nazwisko, P.Pesel
FROM [Pacjenci] P JOIN [Wizyty] W ON P.IdPacjenta = W.IdPacjenta JOIN [Lekarze] L ON L.IdLekarza = W.IdLekarza JOIN [Specjalizacje] S ON S.idspecjalizacji = L.Idspecjalizacji
WHERE W.DataWizyty = '2014-05-15' AND (S.idspecjalizacji = 5 OR S.idspecjalizacji = 6)
GROUP BY P.Imie, P.Nazwisko, P.Pesel, W.DataWizyty, W.IdLekarza,W.IdPacjenta,S.idspecjalizacji

EXCEPT 
(
SELECT P.Imie, P.Nazwisko, P.Pesel
FROM [Pacjenci] P JOIN [Wizyty] W ON P.IdPacjenta = W.IdPacjenta JOIN [Lekarze] L ON L.IdLekarza = W.IdLekarza JOIN [Specjalizacje] S ON S.idspecjalizacji = L.Idspecjalizacji
WHERE (W.DataWizyty BETWEEN '2014-01-01' AND '2014-12-31') AND S.Idspecjalizacji = 1
)
ORDER BY P.Nazwisko

------------------  Z3 -------------------------------------------------------------

USE ABDUczelnia;
WITH ABC AS
(
SELECT DISTINCT S.Imie as ImieStudenta, S.Nazwisko as NazwiskoStudenta, W.Imie as ImieWykladowcy, W.Nazwisko as NazwiskoWykladowcy, max(ile) as ileOcen
FROM
	(SELECT O.IdStudenta, S.Imie, S.Nazwisko, count(O.Ocena) as ile
	FROM [Oceny]O JOIN [Studenci]S ON S.IdStudenta = O.IdStudenta
	WHERE O.Ocena = 2.00 AND O.DataOceny BETWEEN '2013-01-01' AND '2013-12-31'
	GROUP BY O.IdStudenta, O.Ocena, S.Imie, S.Nazwisko
	HAVING count(O.Ocena) > 3 ) AS AAA 
JOIN [Studenci]S ON AAA.IdStudenta = S.IdStudenta JOIN [Oceny]O ON O.IdStudenta = S.IdStudenta JOIN [Wykladowcy]W ON W.IdWykladowcy = O.IdWykladowcy
WHERE AAA.IdStudenta NOT IN
	(
	SELECT O.IdStudenta
	FROM [Oceny]O 
	WHERE 5.00 in (O.Ocena) AND O.DataOceny BETWEEN '2013-01-01' AND '2013-12-31'
	GROUP BY O.IdStudenta
	) 
GROUP BY S.Imie, S.Nazwisko, W.Imie, W.Nazwisko
)

SELECT DISTINCT NN.ImieStudenta, NN.NazwiskoStudenta, NN.ImieWykladowcy, NN.NazwiskoWykladowcy
FROM 
(
	SELECT ABC.ImieStudenta, ABC.NazwiskoStudenta, ABC.ImieWykladowcy, ABC.NazwiskoWykladowcy, dense_rank() over(partition BY ABC.NazwiskoWykladowcy order by ABC.NazwiskoStudenta DESC) AS my_rank
	FROM ABC
	GROUP BY ABC.ImieStudenta, ABC.NazwiskoStudenta, ABC.ImieWykladowcy, ABC.NazwiskoWykladowcy
) AS NN JOIN ABC ON NN.NazwiskoStudenta = ABC.NazwiskoStudenta
WHERE my_rank = 1
ORDER BY NN.NazwiskoWykladowcy DESC

------------------  Z4 -------------------------------------------------------------

USE ABDPrzychodnia;
-- wyliczam kwoty miesiêczne dla danego roku
WITH AAA AS
(
SELECT datename(mm,W.DataWizyty) as month_M , year(W.DataWizyty) as rok_M, sum(W.Oplata) as total_sum_M
FROM [Wizyty] W
WHERE W.DataWizyty BETWEEN '2013-01-01' AND '2019-12-31'
GROUP BY datename(mm,W.DataWizyty), year(W.DataWizyty), datepart(month,DataWizyty)
),
-- wyliczam œrednie kwoty miesiêczne dla danego roku
BBB AS 
(
SELECT DISTINCT year(W.DataWizyty) as rok_, month(W.DataWizyty) as miesiac_, sum(W.Oplata) as total_sum_Y
FROM [Wizyty] W
GROUP BY year(W.DataWizyty), month(W.DataWizyty)
--order by year(W.DataWizyty), month(W.DataWizyty)
)

SELECT DISTINCT month_M , rok_M, total_sum_M
FROM AAA, BBB
GROUP BY month_M, rok_M, total_sum_M, total_sum_Y HAVING total_sum_M <avg(total_sum_Y/12)
ORDER BY total_sum_M
--ORDER BY rok_M,month_M