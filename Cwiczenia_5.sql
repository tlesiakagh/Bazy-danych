-- 1. Zmiana nazwy schematu z rozliczenia na ksiegowosc

alter schema rozliczenia rename to ksiegowosc;

-- 2. Stworzenie tabeli wynagrodzenie

CREATE TABLE ksiegowosc.wynagrodzenie(
	id_wynagrodzenia	varchar(50) PRIMARY KEY,
	"data"				date NOT NULL,
	id_pracownika		varchar(50) references ksiegowosc.pracownicy on delete cascade,
    id_godziny			varchar(50) references ksiegowosc.godziny on delete cascade,
    id_pensji			varchar(50) references ksiegowosc.pensje on delete cascade,
    id_premii			varchar(50) references ksiegowosc.premie on delete cascade
);

-- 3. Dodanie komentarzy do tabel

Comment on table ksiegowosc.godziny is 'Tabela zawieraj¹ca informacje o godzinach przepracowanych przez pracowników w danym dat¹ miesi¹cu.';
Comment on table ksiegowosc.pracownicy is 'Tabela zawieraj¹ca informacje o pracownikach.';
Comment on table ksiegowosc.pensje is 'Tabela zawieraj¹ca informacje o pensjach poszczególnych stanowisk.';
Comment on table ksiegowosc.premie is 'Tabela zawieraj¹ca informacje o przyznanych premiach.';
Comment on table ksiegowosc.wynagrodzenie is 'Tabela ³¹cz¹ca poprzednie tabele relacjami.';

-- 4. Wype³nienie tabeli wynagrodzenia

INSERT INTO ksiegowosc.wynagrodzenie VALUES 
('WYNA1', '2017-02-04', 'PRAC1', 'GODZ1', 'PENS1', 'PREM1'),
('WYNA2', '2017-02-07', 'PRAC2', 'GODZ2', 'PENS2', 'PREM2'),
('WYNA3', '2017-02-06', 'PRAC3', 'GODZ3', 'PENS3', 'PREM3'),
('WYNA4', '2017-02-03', 'PRAC4', 'GODZ4', 'PENS4', 'PREM4'),
('WYNA5', '2017-02-03', 'PRAC5', 'GODZ5', 'PENS5', 'PREM5'),
('WYNA6', '2017-02-03', 'PRAC6', 'GODZ6', 'PENS6', 'PREM6'),
('WYNA7', '2017-02-02', 'PRAC7', 'GODZ7', 'PENS7', 'PREM7'),
('WYNA8', '2017-02-04', 'PRAC8', 'GODZ8', 'PENS8', 'PREM8'),
('WYNA9', '2017-02-02', 'PRAC9', 'GODZ9', 'PENS9', 'PREM9'),
('WYNA10', '2017-02-04', 'PRAC10', 'GODZ10', 'PENS10', 'PREM10');

-- 5. Zapytania:

-- a)

select prac.id_pracownika, prac.nazwisko as nazwisko_pracownika 
from ksiegowosc.pracownicy prac;

-- b)

select wyna.id_pracownika 
from ksiegowosc.pensje pens join ksiegowosc.wynagrodzenie wyna on pens.id_pensji = wyna.id_pensji 
where pens.kwota_netto > 1000;

-- c)

select wyna.id_pracownika 
from ksiegowosc.wynagrodzenie wyna, ksiegowosc.pensje pens, ksiegowosc.premie prem 
where pens.id_pensji = wyna.id_pensji and prem.id_premii = wyna.id_premii 
and pens.kwota_netto > 2000 and prem.kwota = 0;


-- d)

select prac.imie as imie_pracownika, prac.nazwisko as nazwisko_pracownika 
from ksiegowosc.pracownicy prac 
where prac.imie like 'J%';

-- e)

select prac.imie as imie_pracownika, prac.nazwisko as nazwisko_pracownika 
from ksiegowosc.pracownicy prac 
where prac.imie like '%a' and prac.nazwisko like '%n%';

-- f)

select prac.imie as imie_pracownika, prac.nazwisko as nazwisko_pracownika, (godz.liczba_godzin - 160) as liczba_nadgodzin 
from ksiegowosc.pracownicy prac join ksiegowosc.godziny godz on prac.id_pracownika = godz.id_pracownika 
where godz.liczba_godzin > 160;

-- g)

select prac.imie as imie_pracownika, prac.nazwisko as nazwisko_pracownika 
from ksiegowosc.wynagrodzenie wyna, ksiegowosc.pracownicy prac, ksiegowosc.pensje pens 
where prac.id_pracownika = wyna.id_pracownika and pens.id_pensji = wyna.id_pensji 
and pens.kwota_netto > 1500 and pens.kwota_netto < 3000;

-- h)

select prac.imie as imie_pracownika, prac.nazwisko as nazwisko_pracownika 
from ksiegowosc.pracownicy prac, ksiegowosc.godziny godz, ksiegowosc.premie prem, ksiegowosc.wynagrodzenie wyna
where prac.id_pracownika = wyna.id_pracownika and prem.id_premii = wyna.id_premii and godz.id_godziny = wyna.id_godziny 
and godz.liczba_godzin > 160 and prem.kwota = 0;

-- i)

select prac.imie as imie_pracownika, prac.nazwisko as nazwisko_pracownika, pens.kwota_netto as pensja_pracownika
from ksiegowosc.pracownicy prac, ksiegowosc.pensje pens, ksiegowosc.wynagrodzenie wyna
where prac.id_pracownika = wyna.id_pracownika and pens.id_pensji = wyna.id_pensji
order by pens.kwota_netto;

-- j) (sortuje te same kwoty netto malej¹co wed³ug premii)

select prac.imie as imie_pracownika, prac.nazwisko as nazwisko_pracownika, pens.kwota_netto as pensja_pracownika, prem.kwota as premia_pracownika
from ksiegowosc.pracownicy prac, ksiegowosc.pensje pens, ksiegowosc.premie prem, ksiegowosc.wynagrodzenie wyna
where prac.id_pracownika = wyna.id_pracownika and prem.id_premii = wyna.id_premii and pens.id_pensji = wyna.id_pensji
order by pens.kwota_netto desc, prem.kwota desc;

-- k)

select pens.stanowisko, count(pens.stanowisko) as liczba_zatrudnionych
from ksiegowosc.pensje pens 
group by pens.stanowisko;

-- l)

select pens.stanowisko, avg(pens.kwota_netto) as srednia_pensja, min(pens.kwota_netto) as minimalna_pensja, max(pens.kwota_netto) as maksymalna_pensja 
from ksiegowosc.pensje pens
group by pens.stanowisko 
having pens.stanowisko = 'Programista';

-- m)

select sum(pens.kwota_netto) as suma_p³ac_na_stanowisko
from ksiegowosc.pensje pens join ksiegowosc.wynagrodzenie wyna on pens.id_pensji = wyna.id_pensji;

-- n)

select pens.stanowisko, sum(pens.kwota_netto) as suma_p³ac
from ksiegowosc.pensje pens
group by pens.stanowisko;

-- o)

select pens.stanowisko, sum(prem.kwota) as suma_premii_na_stanowisko
from ksiegowosc.premie prem, ksiegowosc.pensje pens, ksiegowosc.wynagrodzenie wyna 
where prem.id_premii = wyna.id_premii and pens.id_pensji = wyna.id_pensji
group by pens.stanowisko 

-- p) (delete dlatego, ¿e potrzebujemy postawiæ warunek, przy truncate nie mo¿na postawiæ warunku)

delete from ksiegowosc.pracownicy prac
using ksiegowosc.pensje pens, ksiegowosc.wynagrodzenie wyna, ksiegowosc.godziny godz
where prac.id_pracownika = wyna.id_pracownika and pens.id_pensji = wyna.id_pensji and godz.id_pracownika = prac.id_pracownika
and pens.kwota_netto < 1200;

delete from ksiegowosc.premie prem
using ksiegowosc.pensje pens
where pens.id_premii = prem.id_premii 
and pens.kwota_netto < 1200;