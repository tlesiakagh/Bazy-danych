-- 1. Stworzenie bazy danych

CREATE DATABASE firma1;

-- 2. Stworzenie schematu

CREATE SCHEMA rozliczenia;

-- 3. Stworzenie tabel w uprzedenio utworzonym schemacie

CREATE TABLE rozliczenia.pracownicy(
    id_pracownika	varchar(10) PRIMARY KEY,
	imie			varchar(50) NOT NULL,
    nazwisko		varchar(50) NOT NULL,
    adres			varchar(70),
    telefon			char(9) NOT NULL
);

CREATE TABLE rozliczenia.godziny(
    id_godziny		varchar(10) PRIMARY KEY,
	"data"			date NOT NULL,
    liczba_godzin	integer NOT NULL,
    id_pracownika	varchar(10)
);

CREATE TABLE rozliczenia.pensje(
    id_pensji		varchar(10) PRIMARY KEY,
	stanowisko		varchar(50) NOT NULL,
    kwota			numeric(7,2) NOT NULL,
    id_premii		varchar(10)
);

CREATE TABLE rozliczenia.premie(
    id_premii		varchar(10) PRIMARY KEY,
	rodzaj			varchar(50),
    kwota			numeric(7,2)
);

-- 4. Dodanie kluczy obcych do odpowiednich tabel za pomocą ALTER TABLE

ALTER TABLE rozliczenia.godziny 
ADD FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy (id_pracownika) on delete cascade;

ALTER TABLE rozliczenia.pensje 
ADD FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie (id_premii) on delete cascade;

-- 5. Wypełnienie tabel rekordami

INSERT INTO rozliczenia.pracownicy VALUES 
('PRAC1', 'Tadeusz', 'Krzesiak', 'Badacza 4/23', 216732112),
('PRAC2', 'Janusz', 'Brda',NULL, 316732112),
('PRAC3', 'Sylwia', 'Mityla', 'Lotników 5/45', 312368124),
('PRAC4', 'Leokadia', 'Baryła', NULL, 546564192),
('PRAC5', 'Michał', 'Opala', 'Kopalniana 20', 674239489),
('PRAC6', 'Karol', 'Grzesiak', 'Hutników 7/88', 674854155),
('PRAC7', 'Oytlia', 'Wartak', 'Olimpijska 8/25', 542136974),
('PRAC8', 'Hubert', 'Kurczak', NULL, 785294365),
('PRAC9', 'Irena', 'Poduszka', 'Oksymorońska 49', 446528891),
('PRAC10', 'Nikola', 'Fikacz', 'Prosta 4/45', 153942786);

INSERT INTO rozliczenia.godziny VALUES 
('GODZ1', '2017-01-31', 168, 'PRAC1'),
('GODZ2', '2017-01-31', 159, 'PRAC2'),
('GODZ3', '2017-01-31', 158, 'PRAC3'),
('GODZ4', '2017-01-31', 160, 'PRAC4'),
('GODZ5', '2017-01-31', 167, 'PRAC5'),
('GODZ6', '2017-01-31', 166, 'PRAC6'),
('GODZ7', '2017-01-31', 158, 'PRAC7'),
('GODZ8', '2017-01-31', 168, 'PRAC8'),
('GODZ9', '2017-01-31', 159, 'PRAC9'),
('GODZ10', '2017-01-31', 158, 'PRAC10');

INSERT INTO rozliczenia.premie VALUES 
('PREM1', NULL, 0),
('PREM2', 'Regulaminowa', 1320),
('PREM3', 'Uznaniowa', 1500),
('PREM4', NULL, 0),
('PREM5', NULL, 0),
('PREM6', 'Regulaminowa', 1100),
('PREM7', 'Regulaminowa', 1200),
('PREM8', 'Uznaniowa', 1700),
('PREM9', 'Uznaniowa', 1850),
('PREM10', 'Uznaniowa', 2275);

INSERT INTO rozliczenia.pensje VALUES 
('PENS1', 'Menadżer', 7000, 'PREM1'),
('PENS2', 'Menadżer', 8000, 'PREM2'),
('PENS3', 'Menadżer', 6000, 'PREM3'),
('PENS4', 'Menadżer', 10000, 'PREM4'),
('PENS5', 'Programista', 8000, 'PREM5'),
('PENS6', 'Programista', 9000, 'PREM6'),
('PENS7', 'Programista', 10000, 'PREM7'),
('PENS8', 'Zarządca bazy danych', 8000, 'PREM8'),
('PENS9', 'Zarządca sieci', 6000, 'PREM9'),
('PENS10', 'Zarządca sieci', 5000, 'PREM10');

-- 6. Wypisanie nazwisk i adresów pracowników

SELECT nazwisko,adres FROM rozliczenia.pracownicy;

-- 7. Wypisanie dnia tygodnia i miesiąca na podstawie daty z tabeli godziny

SELECT DATE_PART('month',"data") AS miesiąc, DATE_PART('dow',"data") AS dzień_tygodnia FROM rozliczenia.godziny;

-- 8. W tabeli pensje: zmiana atrybutu kwota na kwota_brutto, dodanie atrybutu kwota_netto, wyliczenie atrybutu kwota_netto

ALTER TABLE rozliczenia.pensje RENAME COLUMN kwota TO kwota_brutto;
ALTER TABLE rozliczenia.pensje ADD COLUMN kwota_netto numeric(7,2);
UPDATE rozliczenia.pensje SET kwota_netto = kwota_brutto * 0.81;		