-- 1. Stworzenie bazy danych

CREATE DATABASE firma;

-- 2. Stworzenie schematu

CREATE SCHEMA rozliczenia;

-- 3. Stworzenie tabel w uprzedenio utworzonym schemacie

CREATE TABLE rozliczenia.pracownicy(
    id_pracownika	integer PRIMARY KEY,
	imie			varchar(50) NOT NULL,
    nazwisko		varchar(50) NOT NULL,
    adres			varchar(50),
    telefon			char(9) NOT NULL
);

CREATE TABLE rozliczenia.godziny(
    id_godziny		integer PRIMARY KEY,
	data			date NOT NULL,
    liczba_godzin	numeric(4,2) NOT NULL,
    id_pracownika	integer
);

CREATE TABLE rozliczenia.pensje(
    id_pensji		integer PRIMARY KEY,
	stanowisko		varchar(50),
    kwota			money NOT NULL,
    id_premii		integer
);

CREATE TABLE rozliczenia.premie(
    id_premii		integer PRIMARY KEY,
	rodzaj			varchar(50),
    kwota			money NOT NULL
);

-- 4. Dodanie kluczy obcych do odpowiednich tabel za pomoc¹ ALTER TABLE

ALTER TABLE rozliczenia.godziny 
ADD FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy (id_pracownika);

ALTER TABLE rozliczenia.pensje 
ADD FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie (id_premii);

-- 5. Wype³nienie tabel rekordami

INSERT INTO rozliczenia.pracownicy VALUES 
(1, 'Tadeusz', 'Krzesiak', 'Badacza 4/23', 216732112),
(2, 'Janusz', 'Brda',NULL, 316732112),
(3, 'Sylwia', 'Mityla', 'Lotników 5/45', 312368124),
(4, 'Leokadia', 'Bary³a', NULL, 546564192),
(5, 'Micha³', 'Opala', 'Kopalniana 20', 674239489),
(6, 'Karol', 'Grzesiak', 'Hutników 7/88', 674854155),
(7, 'Oytlia', 'Wartak', 'Olimpijska 8/25', 542136974),
(8, 'Hubert', 'Kurczak', NULL, 785294365),
(9, 'Irena', 'Poduszka', 'Oksymoroñska 49', 446528891),
(10, 'Nikola', 'Fikacz', 'Prosta 4/45', 153942786);

INSERT INTO rozliczenia.godziny VALUES 
(1, '2017-02-08', 8, 1),
(2, '2017-02-15', 9, 2),
(3, '2017-02-21', 8, 3),
(4, '2017-02-09', 10, 4),
(5, '2017-02-13', 7, 5),
(6, '2017-02-13', 6, 6),
(7, '2017-02-01', 8, 7),
(8, '2017-02-24', 8, 8),
(9, '2017-02-22', 9, 9),
(10, '2017-02-14', 8, 10);

INSERT INTO rozliczenia.premie VALUES 
(1, '', 1000),
(2, 'Regulaminowa', 1320),
(3, 'Uznaniowa', 4500),
(4, '', 6000),
(5, '', 4200),
(6, 'Regulaminowa', 1100),
(7, 'Regulaminowa', 2200),
(8, 'Uznaniowa', 3700),
(9, 'Uznaniowa', 5850),
(10, 'Uznaniowa', 6100);

INSERT INTO rozliczenia.pensje VALUES 
(1, 'Menad¿er', 5000, 1),
(2, 'Menad¿er', 4000, 2),
(3, '', 6000, 3),
(4, '', 10000, 4),
(5, 'Zarz¹dca bazy danych', 7000, 5),
(6, 'Programista', 8000, 6),
(7, 'Programista', 11000, 7),
(8, 'Zarz¹dca sieci', 8000, 8),
(9, '', 9000, 9),
(10, '', 9000, 10);

-- 6. Wypisanie nazwisk i adresów pracowników

SELECT nazwisko,adres FROM rozliczenia.pracownicy;

-- 7. Wypisanie dnia tygodnia i miesi¹ca na podstawie daty z tabeli godziny

SELECT DATE_PART('month',"data") AS miesi¹c, DATE_PART('dow',"data") AS dzieñ_tygodnia FROM rozliczenia.godziny;

-- 8. W tabeli pensje: zmiana atrybutu kwota na kwota_brutto, dodanie atrybutu kwota_netto, wyliczenie atrybutu kwota_netto

ALTER TABLE rozliczenia.pensje RENAME COLUMN kwota TO kwota_brutto;
ALTER TABLE rozliczenia.pensje ADD COLUMN kwota_netto money;
UPDATE rozliczenia.pensje SET kwota_netto = kwota_brutto * 1.19;