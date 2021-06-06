Create database test;
use test;

-- Stworzenie tabel znormalizowanych

Create table GeoEon (
	id_eon int Primary Key Not Null, 
	nazwa_eon varchar(50)
);

Create table GeoEra (
	id_era int Primary Key Not Null, 
	id_eon int Foreign Key References GeoEon(id_eon),
	nazwa_era varchar(50)
);

Create table GeoOkres (
	id_okres int Primary Key Not Null, 
	id_era int Foreign Key References GeoEra(id_era),
	nazwa_okres varchar(50)
);

Create table GeoEpoka (
	id_epoka int Primary Key Not Null, 
	id_okres int Foreign Key References GeoOkres(id_okres),
	nazwa_epoka varchar(50)
);

Create table GeoPietro (
	id_pietro int Primary Key Not Null, 
	id_epoka int Foreign Key References GeoEpoka(id_epoka),
	nazwa_pietro varchar(50)
);

Insert into GeoEon values(1,'Fanerozoik');

Insert into GeoEra values(1, 1,'Paleozoik');
Insert into GeoEra values(2, 1,'Mezozoik');
Insert into GeoEra values(3, 1,'Kenozoik');

Insert into GeoOkres values(1, 1,'Dewon');
Insert into GeoOkres values(2, 1,'Karbon');
Insert into GeoOkres values(3, 1,'Perm');
Insert into GeoOkres values(4, 2,'Trias');
Insert into GeoOkres values(5, 2,'Jura');
Insert into GeoOkres values(6, 2,'Kreda');
Insert into GeoOkres values(7, 3,'Paleogen');
Insert into GeoOkres values(8, 3,'Neogen');
Insert into GeoOkres values(9, 3,'Czwartorz¹d');

Insert into GeoEpoka values(1, 1,'Dolny');
Insert into GeoEpoka values(2, 1,'Œrodkowy');
Insert into GeoEpoka values(3, 1,'Górny');
Insert into GeoEpoka values(4, 2,'Dolny');
Insert into GeoEpoka values(5, 2,'Górny');
Insert into GeoEpoka values(6, 3,'Dolny');
Insert into GeoEpoka values(7, 3,'Górny');
Insert into GeoEpoka values(8, 4,'Dolna');
Insert into GeoEpoka values(9, 4,'Œrodkowa');
Insert into GeoEpoka values(10, 4,'Górna');
Insert into GeoEpoka values(11, 5,'Dolna');
Insert into GeoEpoka values(12, 5,'Œrodkowa');
Insert into GeoEpoka values(13, 5,'Górna');
Insert into GeoEpoka values(14, 6,'Dolna');
Insert into GeoEpoka values(15, 6,'Górna');
Insert into GeoEpoka values(16, 7,'Paleocen');
Insert into GeoEpoka values(17, 7,'Eocen');
Insert into GeoEpoka values(18, 7,'Oligocen');
Insert into GeoEpoka values(19, 8,'Miocen');
Insert into GeoEpoka values(20, 8,'Pliocen');
Insert into GeoEpoka values(21, 9,'Plejstocen');
Insert into GeoEpoka values(22, 9,'Halocen');

Insert into GeoPietro values(1, 1,'¯edyn');
Insert into GeoPietro values(2, 1,'Zigen');
Insert into GeoPietro values(3, 1,'Ems');
Insert into GeoPietro values(4, 2,'Eifel');
Insert into GeoPietro values(5, 2,'¯ywet');
Insert into GeoPietro values(6, 3,'Fran');
Insert into GeoPietro values(7, 3,'Famen');
Insert into GeoPietro values(8, 4,'Turnej');
Insert into GeoPietro values(9, 4,'Wizen');
Insert into GeoPietro values(10, 5,'Namur');
Insert into GeoPietro values(11, 5,'Westfal');
Insert into GeoPietro values(12, 5,'Stefan');
Insert into GeoPietro values(13, 6,'Aselsk');
Insert into GeoPietro values(14, 6,'Sakmar');
Insert into GeoPietro values(15, 6,'Artynsk');
Insert into GeoPietro values(16, 7,'Kungur');
Insert into GeoPietro values(17, 7,'Kazan');
Insert into GeoPietro values(18, 7,'Tatar');
Insert into GeoPietro values(19, 8,'Scytyk');
Insert into GeoPietro values(20, 9,'Anizyk');
Insert into GeoPietro values(21, 9,'Ladyn');
Insert into GeoPietro values(22, 10,'Karnik');
Insert into GeoPietro values(23, 10,'Noryk');
Insert into GeoPietro values(24, 10,'Retyk');
Insert into GeoPietro values(25, 11,'Hetang');
Insert into GeoPietro values(26, 11,'Synemur');
Insert into GeoPietro values(27, 11,'Pliensbach');
Insert into GeoPietro values(28, 11,'Toark');
Insert into GeoPietro values(29, 12,'Aalen');
Insert into GeoPietro values(30, 12,'Bajos');
Insert into GeoPietro values(31, 12,'Baton');
Insert into GeoPietro values(32, 12,'Kelowej');
Insert into GeoPietro values(33, 13,'Oksford');
Insert into GeoPietro values(34, 13,'Kimeryd');
Insert into GeoPietro values(35, 13,'Tyton');
Insert into GeoPietro values(36, 14,'Berias');
Insert into GeoPietro values(37, 14,'Walanzyn');
Insert into GeoPietro values(38, 14,'Hoteryw');
Insert into GeoPietro values(39, 14,'Barrem');
Insert into GeoPietro values(40, 14,'Apt');
Insert into GeoPietro values(41, 14,'Alb');
Insert into GeoPietro values(42, 15,'Cenoman');
Insert into GeoPietro values(43, 15,'Turon');
Insert into GeoPietro values(44, 15,'Koniak');
Insert into GeoPietro values(45, 15,'Santon');
Insert into GeoPietro values(46, 15,'Kampan');
Insert into GeoPietro values(47, 15,'Mastrycht');
Insert into GeoPietro values(48, 16,'Dan');
Insert into GeoPietro values(49, 16,'Tanet');
Insert into GeoPietro values(50, 17,'Yprez');
Insert into GeoPietro values(51, 17,'Lutet');
Insert into GeoPietro values(52, 17,'Barton');
Insert into GeoPietro values(53, 17,'Priabon');
Insert into GeoPietro values(54, 18,'Rupel');
Insert into GeoPietro values(55, 18,'Szat');
Insert into GeoPietro values(56, 19,'Akwitan');
Insert into GeoPietro values(57, 19,'Burdyga³');
Insert into GeoPietro values(58, 19,'Lang');
Insert into GeoPietro values(59, 19,'Serrawal');
Insert into GeoPietro values(60, 19,'Torton');
Insert into GeoPietro values(61, 19,'Messyn');
Insert into GeoPietro values(62, 20,'Zankl');
Insert into GeoPietro values(63, 20,'Piacent');
Insert into GeoPietro values(64, 21,'Gelas');
Insert into GeoPietro values(65, 21,'Kalabr');
Insert into GeoPietro values(66, 21,'Chiban');
Insert into GeoPietro values(67, 21,'PóŸny');
Insert into GeoPietro values(68, 22,'Grenland');

-- Stworzenie tabeli nieznormalizowanej

SELECT id_pietro, nazwa_pietro, GeoEpoka.id_epoka, nazwa_epoka, GeoOkres.id_okres, nazwa_okres, GeoEra.id_era, nazwa_era, GeoEon.id_eon, nazwa_eon INTO GeoTabela
	FROM GeoPietro 
		Inner Join GeoEpoka 
		Inner Join GeoOkres
		Inner Join GeoEon 
		Inner Join GeoEra
		on GeoEra.id_eon=GeoEon.id_eon 
		on GeoEra.id_era=GeoOkres.id_era 
		on GeoEpoka.id_okres=GeoOkres.id_okres 
		on GeoEpoka.id_epoka=GeoPietro.id_epoka;

Select * From GeoTabela;

-- Stworzenie tabeli Dziesiec

Create Table Dziesiec(cyfra int, bit int)

Insert into Dziesiec values(0, NULL);
Insert into Dziesiec values(1, NULL);
Insert into Dziesiec values(2, NULL);
Insert into Dziesiec values(3, NULL);
Insert into Dziesiec values(4, NULL);
Insert into Dziesiec values(5, NULL);
Insert into Dziesiec values(6, NULL);
Insert into Dziesiec values(7, NULL);
Insert into Dziesiec values(8, NULL);
Insert into Dziesiec values(9, NULL);

Select * From Dziesiec;

-- Stworzenie tabeli Milion na podstawie tabeli Dziesiec

CREATE TABLE Milion(liczba int,cyfra int, bit int);

INSERT INTO Milion 
SELECT 
	a1.cyfra +10* a2.cyfra +100*a3.cyfra + 1000*a4.cyfra + 10000*a5.cyfra + 10000*a6.cyfra AS liczba, 
	a1.cyfra AS cyfra, 
	a1.bit AS bit
FROM 
	Dziesiec a1, 
	Dziesiec a2, 
	Dziesiec a3, 
	Dziesiec a4, 
	Dziesiec a5, 
	Dziesiec a6;

Select * From Milion 
Order by Liczba;

-- Zapytania

-- 1 ZL 
SELECT COUNT(*) 
FROM dbo.Milion 
	JOIN GeoTabela ON Milion.liczba%68=GeoTabela.id_pietro;

-- 2 ZL
SELECT COUNT(*) 
FROM dbo.Milion 
	INNER JOIN GeoPietro ON (Milion.liczba%68)=GeoPietro.id_pietro 
	Inner Join GeoEpoka 
	Inner Join GeoOkres
	Inner Join GeoEon 
	Inner Join GeoEra
	on GeoEra.id_eon=GeoEon.id_eon 
	on GeoEra.id_era=GeoOkres.id_era 
	on GeoEpoka.id_okres=GeoOkres.id_okres 
	on GeoEpoka.id_epoka=GeoPietro.id_epoka;

-- 3 ZG
SELECT COUNT(*) 
FROM Milion 
WHERE Milion.liczba%68=(SELECT id_pietro 
						FROM GeoTabela 
						WHERE Milion.liczba%68=id_pietro);

-- 4 ZG
SELECT COUNT(*) 
FROM Milion 
WHERE Milion.liczba%68 IN (SELECT GeoPietro.id_pietro 
						FROM GeoPietro 
							Inner Join GeoEpoka 
							Inner Join GeoOkres
							Inner Join GeoEon 
							Inner Join GeoEra
							on GeoEra.id_eon=GeoEon.id_eon 
							on GeoEra.id_era=GeoOkres.id_era 
							on GeoEpoka.id_okres=GeoOkres.id_okres 
							on GeoEpoka.id_epoka=GeoPietro.id_epoka);

-- Tworzenie indeksów dla ka¿dego pola bior¹cego udzia³ w zapytaniu

Create Index indeks_liczby on dbo.Milion(liczba);
Create Index indeks_GeoEon on dbo.GeoEon(id_eon);
Create Index indeks_GeoEra on dbo.GeoEra(id_eon, id_era);
Create Index indeks_GeoOkres on dbo.GeoOkres(id_okres, id_era);
Create Index indeks_GeoEpoka on dbo.GeoEpoka(id_okres, id_epoka);
Create Index indeks_GeoPietro on dbo.GeoPietro(id_epoka, id_pietro);
Create Index indeks_GeoTabela on dbo.GeoTabela(id_pietro, id_epoka, id_okres, id_era, id_eon);