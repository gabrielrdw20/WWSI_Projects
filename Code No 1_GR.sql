author: gabrielrdw20 (github)


Zadanie 1 ---------------------------------------------------------------------

USE ABDPrzychodnia;

SELECT P.Imie,P.Nazwisko,P.Płeć,P.Pesel
FROM Wizyty as W JOIN Lekarze as L
ON W.IdLekarza = L.IdLekarza

JOIN Specjalizacje as S
ON L.Idspecjalizacji = S.idspecjalizacji

JOIN Pacjenci as P 
ON W.IdPacjenta = P.IdPacjenta

WHERE S.NazwaSpecjalizacji = 'Diabetolog' OR S.NazwaSpecjalizacji = 'Chirurg'
AND MONTH (W.DataWizyty) < 7
AND YEAR (W.DataWizyty) = 2013


Zadanie 2 ---------------------------------------------------------------------

USE ABDPrzychodnia;
SELECT P.Imie, P.Nazwisko, W.DataWizyty, W.Oplata, L.Imie

FROM Wizyty as W 
	JOIN Lekarze as L ON W.IdLekarza=L.IdLekarza
	JOIN Specjalizacje as S ON L.Idspecjalizacji = S.idspecjalizacji
	JOIN Pacjenci as P ON W.IdPacjenta=P.IdPacjenta
WHERE L.CzyKobieta = P.CzyKobieta
AND L.DataUrodzenia < P.DataUrodzenia
AND MONTH (W.DataWizyty) = 3 
AND YEAR (W.DataWizyty) = 2013 
ORDER BY (W.DataWizyty)


Zadanie 3 ---------------------------------------------------------------------

USE ABDPrzychodnia;
SELECT P.Imie, P.Nazwisko, W.DataWizyty, W.Oplata, L.Imie

FROM Wizyty as W 
	JOIN Lekarze as L ON W.IdLekarza=L.IdLekarza
	JOIN Specjalizacje as S ON L.Idspecjalizacji = S.idspecjalizacji
	JOIN Pacjenci as P ON W.IdPacjenta=P.IdPacjenta
WHERE L.CzyKobieta =