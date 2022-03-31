/*
IDS PROJECT - 2nd Part
Authors: Evgenii Shiliaev
         Simon Brazda
*/

/* Set the needed date format */
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YY';

/* Drop all tabels for easier script running */
DROP TABLE Zakaznik CASCADE CONSTRAINTS;
DROP TABLE Zamestnanec CASCADE CONSTRAINTS;
DROP TABLE Rezervace CASCADE CONSTRAINTS;
DROP TABLE Vypujcka CASCADE CONSTRAINTS;
DROP TABLE Nahravka CASCADE CONSTRAINTS;
DROP TABLE Kazeta CASCADE CONSTRAINTS;
DROP TABLE Zanr CASCADE CONSTRAINTS;
DROP TABLE Jazyk CASCADE CONSTRAINTS;
DROP TABLE Zneni CASCADE CONSTRAINTS;
DROP TABLE Titulky CASCADE CONSTRAINTS;
DROP TABLE Nahravka_Zanru CASCADE CONSTRAINTS;

/* Create tables */
CREATE TABLE Zakaznik(
    id_zakaznika NUMBER GENERATED ALWAYS as IDENTITY(START with 10000 INCREMENT by 1) PRIMARY KEY,
    jmeno VARCHAR(10) NOT NULL,
    prijmeni VARCHAR(10) NOT NULL,
    datum_narozeni DATE, /*TRIGGER TODO*/
    telefonni_cislo CHAR(12) UNIQUE CHECK(regexp_like(telefonni_cislo,'^[[:digit:]]{12}$')),
    email VARCHAR(50) UNIQUE CHECK (REGEXP_LIKE (email,'^[a-zA-Z0-9.!#$%&''*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-]{2,4}$')),
    ulice VARCHAR(20),
    mesto VARCHAR(20),
    psc CHAR(5) CHECK(regexp_like(psc,'^[[:digit:]]{5}$')));

CREATE TABLE Zamestnanec(
    id_zamestnance NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1) PRIMARY KEY,
    jmeno VARCHAR(10) NOT NULL,
    prijmeni VARCHAR(10) NOT NULL,
    datum_narozeni DATE, /*TRIGGER TODO*/
    telefonni_cislo CHAR(12) UNIQUE CHECK(regexp_like(telefonni_cislo,'^[[:digit:]]{12}$')),
    email VARCHAR(50) UNIQUE CHECK (REGEXP_LIKE (email,'^[a-zA-Z0-9.!#$%&''*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-]{2,4}$')),
    ulice VARCHAR(20),
    mesto VARCHAR(20),
    psc CHAR(5) CHECK(regexp_like(psc,'^[[:digit:]]{5}$')),
    bankovni_ucet CHAR(26), /*CHECK (  ), TODO*/
    opravneni VARCHAR(20),
    datum_nastupu DATE NOT NULL,
    datum_ukonceni_PP DATE);


CREATE TABLE Jazyk(
    jazyk VARCHAR(15) PRIMARY KEY);

CREATE TABLE Zneni(
    jazyk_zneni VARCHAR(15) PRIMARY KEY);
ALTER TABLE Zneni ADD CONSTRAINT FK_zneni_jazyk FOREIGN KEY (jazyk_zneni) REFERENCES Jazyk;

CREATE TABLE Titulky(
    jazyk_titulek VARCHAR(15) PRIMARY KEY);
ALTER TABLE Titulky ADD CONSTRAINT FK_titulky_jazyk FOREIGN KEY (jazyk_titulek) REFERENCES Jazyk;

CREATE TABLE Zanr(
    zanr VARCHAR(15) PRIMARY KEY);

CREATE TABLE Nahravka(
    id_nahravky NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1) PRIMARY KEY,
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

CREATE TABLE Kazeta(
    id_nahravky NUMBER,
    id_kazety NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1),
    sazba_vypujceni INTEGER,
    stav VARCHAR(20) DEFAULT 'Skladem',
    porizovaci_cena INTEGER,
    datum_zarazeni DATE NOT NULL,
    datum_vyrazeni DATE);
ALTER TABLE Kazeta ADD CONSTRAINT PK_kazeta PRIMARY KEY (id_nahravky, id_kazety);
ALTER TABLE Kazeta ADD CONSTRAINT FK_idKazety_idNahravky FOREIGN KEY (id_nahravky) REFERENCES Nahravka ON DELETE CASCADE;

CREATE TABLE Rezervace(
    id_rezervace NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1) PRIMARY KEY,
    id_zakaznika NUMERIC(7,0),
    id_nahravky NUMERIC(7,0),
    stav VARCHAR(20) DEFAULT 'Zpracovává se',
    datum DATE);
ALTER TABLE Rezervace ADD CONSTRAINT FK_rezervace_zakaznik FOREIGN KEY (id_zakaznika) REFERENCES Zakaznik;
ALTER TABLE Rezervace ADD CONSTRAINT FK_rezervace_nahravka FOREIGN KEY (id_nahravky) REFERENCES Nahravka;

CREATE TABLE Vypujcka(
    id_vypujcky NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1) PRIMARY KEY,
    datum_od DATE DEFAULT CURRENT_DATE,
    datum_do DATE NOT NULL,
    datum_vraceni DATE,
    cena NUMERIC(5,2),
    id_rezervace NUMERIC(7,0) DEFAULT NULL,
    id_nahravky NUMERIC(7,0),
    id_kazety INTEGER,
    id_zakaznika NUMERIC(7,0),
    vydano_zamestnancem NUMERIC(7,0),
    prijato_zamestnancem NUMERIC(7,0));

ALTER TABLE Vypujcka ADD CONSTRAINT FK_vypujcka_rezervace FOREIGN KEY (id_rezervace) REFERENCES Zakaznik;
ALTER TABLE Vypujcka ADD CONSTRAINT FK_vypujcka_kazeta FOREIGN KEY (id_nahravky, id_kazety) REFERENCES Kazeta;
ALTER TABLE Vypujcka ADD CONSTRAINT FK_vypujcka_zakaznik FOREIGN KEY (id_zakaznika) REFERENCES Zakaznik;
ALTER TABLE Vypujcka ADD CONSTRAINT FK_vypujcka_zamestnanec_vydal FOREIGN KEY (vydano_zamestnancem) REFERENCES Zamestnanec;
ALTER TABLE Vypujcka ADD CONSTRAINT FK_vypujcka_zamestnanec_prijal FOREIGN KEY (prijato_zamestnancem) REFERENCES Zamestnanec;

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
    VALUES(DEFAULT,'Sociální síť','The Social Network', 12, 'David Fincher',120, DEFAULT,'Angličtina', 'Čeština');
INSERT INTO Nahravka
    VALUES(DEFAULT,'Forrest Gump','Forrest Gump', 12, 'Robert Zemeckis',142, DEFAULT, 'Angličtina', DEFAULT);

INSERT INTO Zanr
    VALUES('Drama');
INSERT INTO Zanr
    VALUES('Životopisný');

INSERT INTO Nahravka_Zanru
    VALUES(1, 'Drama');
INSERT INTO Nahravka_Zanru
    VALUES(1, 'Životopisný');


INSERT INTO Zakaznik
    VALUES(DEFAULT, 'Evgenii', 'Shiliaev', TO_DATE('01.01.2001'), '420000000000', 'asdf-moje-posta@mail.com',
           'Božetěchova 1/2', 'Brno', '61200');

/* Get all tables */
SELECT * FROM Zakaznik;
SELECT * FROM Zamestnanec;
SELECT * FROM Rezervace;
SELECT * FROM Vypujcka;
SELECT * FROM Nahravka;
SELECT * FROM Kazeta;
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