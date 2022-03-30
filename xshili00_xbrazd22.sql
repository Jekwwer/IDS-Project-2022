ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YY';

DROP TABLE Osoba CASCADE CONSTRAINTS;
DROP TABLE Rezervace CASCADE CONSTRAINTS;
DROP TABLE Vypujcka CASCADE CONSTRAINTS;
DROP TABLE Nahravka CASCADE CONSTRAINTS;
DROP TABLE Zanr CASCADE CONSTRAINTS;
DROP TABLE Jazyk CASCADE CONSTRAINTS;


CREATE TABLE Osoba(
    id_osoby NUMERIC(7,0) PRIMARY KEY,
    jmeno VARCHAR(10) NOT NULL,
    prijmeni VARCHAR(10) NOT NULL,
    datum_narozeni DATE,
    telefonni_cislo NUMERIC(12) UNIQUE,
    email VARCHAR(50) UNIQUE,
    adresa VARCHAR(50));

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

CREATE TABLE Nahravka(
    id_nahravky NUMERIC(7,0) PRIMARY KEY,
    nazev VARCHAR(50) NOT NULL UNIQUE,
    nazev_v_originale VARCHAR(50),
    vekova_hranice NUMERIC(2,0),
    reziser VARCHAR(20),
    delka NUMERIC(3,0),
    popis VARCHAR(150));

CREATE TABLE Zanr(
    zanr VARCHAR(15) PRIMARY KEY);

CREATE TABLE Jazyk(
    jazyk VARCHAR(15) PRIMARY KEY);

SELECT * FROM Osoba;
SELECT * FROM Rezervace;
SELECT * FROM Vypujcka;
SELECT * FROM Nahravka;
SELECT * FROM Zanr;
SELECT * FROM Jazyk;
