-- a) Doda�em kolumn� zawieraj�c� dane o numerze kierunkowym

alter table ksiegowosc.pracownicy add column numer_kierunkowy text;

update ksiegowosc.pracownicy set numer_kierunkowy = '(+48)';

-- b) 

alter table ksiegowosc.pracownicy add constraint check_valid_number check (telefon ~ '[0-9]{3}-[0-9]{3}-[0-9]{3}');

-- c) Wy�wietl dane pracownika, kt�rego nazwisko jest najd�u�sze, u�ywaj�c du�ych liter

select upper(imie) as imie_pracownika, upper(nazwisko) as nazwisko_pracownika, upper(adres) as adres_pracownika, concat(numer_kierunkowy, ' ', telefon) as telefon_pracownika 
from ksiegowosc.pracownicy 
order by Length(nazwisko) desc 
limit 1;

-- d) Wy�wietl dane pracownik�w i ich pensje zakodowane przy pomocy algorytmu md5

select 
	md5(prac.imie) as imie_pracownika, md5(prac.nazwisko) as nazwisko_pracownika, md5(prac.adres) as adres_pracownika, 
	md5(concat(prac.numer_kierunkowy, ' ', prac.telefon)) as telefon_pracownika, cast(pens.kwota_netto as varchar(50)) as pensja_pracownika 
from 
	ksiegowosc.pracownicy prac, ksiegowosc.wynagrodzenie wyna, ksiegowosc.pensje pens
where 
	prac.id_pracownika = wyna.id_pracownika and pens.id_pensji = wyna.id_pensji;


-- e) Wy�wietl pracownik�w, ich pensje oraz premie. Wykorzystaj z��czenie lewostronne.

select 
	prac.imie as imie_pracownika, prac.nazwisko as nazwisko_pracownika, prac.adres as adres_pracownika, 
	concat(prac.numer_kierunkowy, ' ', prac.telefon) as telefon_pracownika, pens.kwota_netto as pensja_pracownika 
from 
	ksiegowosc.pracownicy prac 
left join 
	ksiegowosc.wynagrodzenie wyna 
on 
	prac.id_pracownika = wyna.id_pracownika
left join 
	ksiegowosc.pensje pens
on 
	wyna.id_pensji = pens.id_pensji 
left join 
	ksiegowosc.premie prem
on 
	pens.id_premii = prem.id_premii
	
-- f)
	
select 
	concat('Pracownik ', prac.imie, prac.nazwisko,', w dniu ', wyna."data", ' otrzyma� pensj� ca�kowit� na kwot� ', pens.kwota_netto,
	' z�, gdzie wynagrodzenie zasadnicze wynosi�o: ',(pens.kwota_netto - prem.kwota), ' z�, premia: ', prem.kwota, ' z�, nadgodziny: ', 0, ' z�') 
from
	ksiegowosc.pracownicy prac, ksiegowosc.wynagrodzenie wyna, ksiegowosc.pensje pens, ksiegowosc.premie prem
where
	prac.id_pracownika = wyna.id_pracownika 
and
	pens.id_pensji = wyna.id_pensji 
and 
	prem.id_premii = wyna.id_premii 

	
