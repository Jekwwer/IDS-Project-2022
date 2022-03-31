/*
IDS PROJECT - 2nd Part
Authors: Evgenii Shiliaev
         Simon Brazda
*/

/* Set the needed date format */
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YY';

/* Drop all tabels for easier script running */
DROP TABLE Osoba CASCADE CONSTRAINTS;
DROP TABLE Zakaznik CASCADE CONSTRAINTS;
DROP TABLE Zamestnanec CASCADE CONSTRAINTS;
DROP TABLE Rezervace CASCADE CONSTRAINTS;
DROP TABLE Vypujcka CASCADE CONSTRAINTS;
DROP TABLE Nahravka CASCADE CONSTRAINTS;
DROP TABLE Zanr CASCADE CONSTRAINTS;
DROP TABLE Jazyk CASCADE CONSTRAINTS;
DROP TABLE Zneni CASCADE CONSTRAINTS;
DROP TABLE Titulky CASCADE CONSTRAINTS;
DROP TABLE Nahravka_Zanru CASCADE CONSTRAINTS;

/* Create tables */
CREATE TABLE Osoba(
    id_osoby NUMERIC(7,0) PRIMARY KEY,
    jmeno VARCHAR(10) NOT NULL,
    prijmeni VARCHAR(10) NOT NULL,
    datum_narozeni DATE,
    telefonni_cislo NUMERIC(12) UNIQUE,
    email VARCHAR(50) UNIQUE,
    adresa VARCHAR(50));

CREATE TABLE Zakaznik(
    id_zakaznika NUMERIC(7,0));

ALTER TABLE Zakaznik ADD CONSTRAINT FK_zakaznik_osoba FOREIGN KEY (id_zakaznika) REFERENCES Osoba;


CREATE TABLE Zamestnanec(
    id_zamestnance NUMERIC(7,0),
    bankovni_ucet VARCHAR(20),
    opravneni VARCHAR(20),
    datum_nastupu DATE NOT NULL,
    datum_ukonceni_PP DATE);

ALTER TABLE Zamestnanec ADD CONSTRAINT FK_zamestnanec_osoba FOREIGN KEY (id_zamestnance) REFERENCES Osoba;


CREATE TABLE Rezervace(
    id_rezervace NUMERIC(7,0) PRIMARY KEY,
    stav VARCHAR(20) DEFAULT 'Zpracovává se',
    datum DATE);

CREATE TABLE Vypujcka(
    id_vypujcky NUMERIC(7,0) PRIMARY KEY,
    datum_od DATE,
    datum_do DATE NOT NULL,
    datum_vraceni DATE,
    cena NUMERIC(5,2));

CREATE TABLE Jazyk(
    jazyk VARCHAR(15) PRIMARY KEY);

CREATE TABLE Zneni(
    jazyk_zneni VARCHAR(15) PRIMARY KEY);
ALTER TABLE Zneni ADD CONSTRAINT FK_zneni_jazyk FOREIGN KEY (jazyk_zneni) REFERENCES Jazyk;

CREATE TABLE Titulky(
    jazyk_titulek VARCHAR(15) PRIMARY KEY);
ALTER TABLE Titulky ADD CONSTRAINT FK_titulky_jazyk FOREIGN KEY (jazyk_titulek) REFERENCES Jazyk;

CREATE TABLE Nahravka(
    id_nahravky NUMERIC(7,0) PRIMARY KEY,
    nazev VARCHAR(50) NOT NULL UNIQUE,
    nazev_v_originale VARCHAR(50),
    vekova_hranice NUMERIC(2,0),
    reziser VARCHAR(20),
    delka NUMERIC(3,0),
    popis VARCHAR(150) DEFAULT '-',
    jazyk_zneni VARCHAR(15) NOT NULL,
    jazyk_titulek VARCHAR(15) DEFAULT 'není');

ALTER TABLE Nahravka ADD CONSTRAINT FK_nahravka_zneni FOREIGN KEY (jazyk_zneni) REFERENCES Zneni;
ALTER TABLE Nahravka ADD CONSTRAINT FK_nahravka_titulky FOREIGN KEY (jazyk_titulek) REFERENCES Titulky;

CREATE TABLE Zanr(
    zanr VARCHAR(15) PRIMARY KEY);

/* Create relation tables */
CREATE TABLE Nahravka_Zanru(
    id_nahravky NUMERIC(7,0),
    zanr VARCHAR(15));

ALTER TABLE Nahravka_Zanru ADD CONSTRAINT FK_nahravkaZanru_nahravka FOREIGN KEY (id_nahravky) REFERENCES Nahravka;
ALTER TABLE Nahravka_Zanru ADD CONSTRAINT FK_nahravkaZanru_zanr FOREIGN KEY (zanr) REFERENCES Zanr;


/* Add values */
INSERT INTO Jazyk
    VALUES('není');
INSERT INTO Jazyk
    VALUES('Čeština');
INSERT INTO Jazyk
    VALUES('Angličtina');

INSERT INTO Zneni
    VALUES('Angličtina');

INSERT INTO Titulky
    VALUES('není');
INSERT INTO Titulky
    VALUES('Čeština');

INSERT INTO Nahravka
    VALUES(1,'Sociální síť','The Social Network', 12, 'David Fincher',120, DEFAULT,'Angličtina', 'Čeština');
INSERT INTO Nahravka
    VALUES(2,'Forrest Gump','Forrest Gump', 12, 'Robert Zemeckis',142, DEFAULT, 'Angličtina', DEFAULT);

INSERT INTO Zanr
    VALUES('Drama');
INSERT INTO Zanr
    VALUES('Životopisný');

INSERT INTO Nahravka_Zanru
    VALUES(1, 'Drama');
INSERT INTO Nahravka_Zanru
    VALUES(1, 'Životopisný');


/* Get all tables */
SELECT * FROM Osoba;
SELECT * FROM Zakaznik;
SELECT * FROM Zamestnanec;
SELECT * FROM Rezervace;
SELECT * FROM Vypujcka;
SELECT * FROM Nahravka;
SELECT * FROM Zanr;
SELECT * FROM Jazyk;
SELECT * FROM Zneni;
SELECT * FROM Titulky;
SELECT * FROM Nahravka_Zanru;

/* Some SELECT tests */
/* Nahravky zanru drama */
SELECT nazev
    FROM Nahravka NATURAL JOIN NAHRAVKA_ZANRU
    WHERE zanr='Drama';

/* Nahravky v anglickem jazyce zneni */
SELECT nazev
    FROM Nahravka
    WHERE jazyk_zneni='Angličtina';

/* End of xshili00_xbrazd22.sql */