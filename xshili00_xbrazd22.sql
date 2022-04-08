/*
IDS PROJECT - 2nd Part (24 – Videopujcovna)
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
    datum_narozeni DATE, /*CHECK TRIGGER TODO*/
    telefonni_cislo CHAR(12) UNIQUE CHECK(REGEXP_LIKE(telefonni_cislo,'^[[:digit:]]{12}$')),
    email VARCHAR(50) UNIQUE CHECK (REGEXP_LIKE (email,'^[a-zA-Z0-9.!#$%&''*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-]{2,4}$')),
    ulice VARCHAR(20),
    mesto VARCHAR(20),
    psc CHAR(6) CHECK(REGEXP_LIKE(psc,'^[[:digit:]]{3}+[[:space:]]+[[:digit:]]{2}$')));

CREATE TABLE Zamestnanec(
    id_zamestnance NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1) PRIMARY KEY,
    jmeno VARCHAR(10) NOT NULL,
    prijmeni VARCHAR(10) NOT NULL,
    datum_narozeni DATE, /*TRIGGER TODO*/
    telefonni_cislo CHAR(12) UNIQUE CHECK(REGEXP_LIKE(telefonni_cislo,'^[[:digit:]]{12}$')),
    email VARCHAR(50) UNIQUE CHECK (REGEXP_LIKE (email,'^[a-zA-Z0-9.!#$%&''*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-]{2,4}$')),
    ulice VARCHAR(20),
    mesto VARCHAR(20),
    psc CHAR(6) CHECK(REGEXP_LIKE(psc,'^[[:digit:]]{3}+[[:space:]]+[[:digit:]]{2}$')),
    bankovni_ucet VARCHAR(26), CHECK(REGEXP_LIKE(bankovni_ucet,'^[[:digit:]]{0,6}+[-]?+[[:digit:]]{2,10}+[/]+[[:digit:]]{4}$')),
    opravneni VARCHAR(20),
    datum_nastupu DATE NOT NULL,
    datum_ukonceni_PP DATE DEFAULT NULL);

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
    datum_vyrazeni DATE DEFAULT NULL);
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
ALTER TABLE Vypujcka ADD CONSTRAINT FK_vypujcka_rezervace FOREIGN KEY (id_rezervace) REFERENCES Rezervace;
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
    VALUES('Slovenština');
INSERT INTO Jazyk
    VALUES('Angličtina');
INSERT INTO Jazyk
    VALUES('Čínština');
INSERT INTO Jazyk
    VALUES('Španělština');
INSERT INTO Jazyk
    VALUES('Arabština');
INSERT INTO Jazyk
    VALUES('Ruština');
INSERT INTO Jazyk
    VALUES('Japonština');
INSERT INTO Jazyk
    VALUES('Francouzština');
INSERT INTO Jazyk
    VALUES('Němčina');

INSERT INTO Zneni
    VALUES('Čeština');
INSERT INTO Zneni
    VALUES('Slovenština');
INSERT INTO Zneni
    VALUES('Angličtina');
INSERT INTO Zneni
    VALUES('Čínština');
INSERT INTO Zneni
    VALUES('Španělština');
INSERT INTO Zneni
    VALUES('Arabština');
INSERT INTO Zneni
    VALUES('Ruština');
INSERT INTO Zneni
    VALUES('Japonština');
INSERT INTO Zneni
    VALUES('Francouzština');
INSERT INTO Zneni
    VALUES('Němčina');

INSERT INTO Titulky
    VALUES('není');
INSERT INTO Titulky
    VALUES('Čeština');
INSERT INTO Titulky
    VALUES('Slovenština');
INSERT INTO Titulky
    VALUES('Angličtina');
INSERT INTO Titulky
    VALUES('Čínština');
INSERT INTO Titulky
    VALUES('Španělština');
INSERT INTO Titulky
    VALUES('Arabština');
INSERT INTO Titulky
    VALUES('Ruština');
INSERT INTO Titulky
    VALUES('Japonština');
INSERT INTO Titulky
    VALUES('Francouzština');
INSERT INTO Titulky
    VALUES('Němčina');

INSERT INTO Nahravka
    VALUES(DEFAULT,'Sociální síť','The Social Network', 12, 'David Fincher',120, DEFAULT,'Angličtina', 'Čeština');
INSERT INTO Nahravka
    VALUES(DEFAULT,'Forrest Gump','Forrest Gump', 12, 'Robert Zemeckis',142, DEFAULT, 'Angličtina', DEFAULT);
INSERT INTO Nahravka
    VALUES (DEFAULT, 'Jexi: Láska z mobilu', 'Jexi', 12, 'Jon Lucas', 84, DEFAULT, 'Čeština', DEFAULT);

INSERT INTO Kazeta (id_nahravky, sazba_vypujceni, porizovaci_cena, datum_zarazeni)
    SELECT id_nahravky, 100, 180, TO_DATE('1.2.2010')
    FROM Nahravka
    WHERE nazev = 'Forrest Gump';
INSERT INTO Kazeta (id_nahravky, sazba_vypujceni, porizovaci_cena, datum_zarazeni)
    SELECT id_nahravky, 100, 180, TO_DATE('1.2.2010')
    FROM Nahravka
    WHERE nazev = 'Forrest Gump';
INSERT INTO Kazeta (id_nahravky, sazba_vypujceni, porizovaci_cena, datum_zarazeni)
    SELECT id_nahravky, 60, 150, TO_DATE('1.6.2015')
    FROM Nahravka
    WHERE nazev = 'Sociální síť';
INSERT INTO Kazeta (id_nahravky, sazba_vypujceni, porizovaci_cena, datum_zarazeni)
    SELECT id_nahravky, 60, 150, TO_DATE('1.6.2015')
    FROM Nahravka
    WHERE nazev = 'Sociální síť';
INSERT INTO Kazeta (id_nahravky, sazba_vypujceni, stav, porizovaci_cena, datum_zarazeni, datum_vyrazeni)
    SELECT id_nahravky, 60, 'Vyřazeno', 150, TO_DATE('1.6.2015'), TO_DATE('21.3.2017')
    FROM Nahravka
    WHERE nazev = 'Sociální síť';
INSERT INTO Kazeta (id_nahravky, sazba_vypujceni, porizovaci_cena, datum_zarazeni)
    SELECT id_nahravky, 110, 190, TO_DATE('1.2.2020')
    FROM Nahravka
    WHERE nazev = 'Jexi: Láska z mobilu';
INSERT INTO Kazeta (id_nahravky, sazba_vypujceni, porizovaci_cena, datum_zarazeni)
    SELECT id_nahravky, 110, 190, TO_DATE('1.2.2020')
    FROM Nahravka
    WHERE nazev = 'Jexi: Láska z mobilu';
INSERT INTO Kazeta (id_nahravky, sazba_vypujceni, porizovaci_cena, datum_zarazeni)
    SELECT id_nahravky, 110, 190, TO_DATE('1.2.2020')
    FROM Nahravka
    WHERE nazev = 'Jexi: Láska z mobilu';

INSERT INTO Zanr
    VALUES('Drama');
INSERT INTO Zanr
    VALUES('Životopisný');
INSERT INTO Zanr
    VALUES('Fantasy');
INSERT INTO Zanr
    VALUES('Dokument');
INSERT INTO Zanr
    VALUES('Komedie');
INSERT INTO Zanr
    VALUES('Horor');
INSERT INTO Zanr
    VALUES('Muzikál');
INSERT INTO Zanr
    VALUES('Animace');
INSERT INTO Zanr
    VALUES('Thriller');
INSERT INTO Zanr
    VALUES('Rodinný');
INSERT INTO Zanr
    VALUES('Romantický');

INSERT INTO Nahravka_Zanru
    VALUES(1, 'Drama');
INSERT INTO Nahravka_Zanru
    VALUES(1, 'Životopisný');
INSERT INTO Nahravka_Zanru
    VALUES(2, 'Komedie');
INSERT INTO Nahravka_Zanru
    VALUES(2, 'Romantický');
INSERT INTO Nahravka_Zanru
    VALUES(3, 'Komedie');

INSERT INTO Zakaznik
    VALUES(DEFAULT, 'Evgenii', 'Shiliaev', TO_DATE('01.01.2001'), '420000000000', 'asdf-moje-posta@mail.com',
            'Božetěchova 1/2', 'Brno', '612 00');
INSERT INTO Zakaznik
    VALUES(DEFAULT, 'Pavel', 'Novák', TO_DATE('24.12.1991'), '420123123123', 'pavel.novak@neznam.cz',
            'Krátká 432/2', 'Adamov', '679 04');
INSERT INTO Zakaznik
    VALUES(DEFAULT, 'Eva', 'Svobodová', TO_DATE('28.07.1995'), '420147258369', 'svobodova33@kmail.cz',
            'Netroufalky 770', 'Brno', '625 00');
INSERT INTO Zakaznik
    VALUES(DEFAULT, 'Jiří', 'Černý', TO_DATE('31.05.2007'), '420741258963', 'cerny.jiri05@inlook.com',
            'Lidická 1875/40', 'Brno', '605 00');
INSERT INTO Zakaznik
    VALUES(DEFAULT, 'Jan', 'Dvořák', TO_DATE('10.02.1999'), '420159753648', 'dvorak.honz4@protectedmail.com',
            'Lidická 1875/40', 'Brno', '602 00');

INSERT INTO Zamestnanec
    VALUES(DEFAULT, 'Ladislav', 'Marek', TO_DATE('16.08.1985'), '420658495327', 'lada.marek@eznam.cz',
            'Na náměstí 64', 'Tišnov', '666 01', '12-69821/0200', 'Legislativa',
            TO_DATE('25.03.2006'), NULL);
INSERT INTO Zamestnanec
    VALUES(DEFAULT, 'Jan', 'Culek', TO_DATE('23.4.1979'), '420952495427', 'jan.culk@eznam.cz', 
            'U sloupku 16', 'Tišnov', '666 01', '25-6982165/0200', 'Rezervace',
            TO_DATE('25.3.2006'), NULL);
INSERT INTO Zamestnanec
    VALUES(DEFAULT, 'Marek', 'Cizí', TO_DATE('30.1.1987'), '420876925327', 'marek.ciz@gemail.cz',
            'Plotní 69', 'Brno', '601 00', '64-9516842/0288', 'Účetnictví',
            TO_DATE('5.5.2010'), TO_DATE('7.12.2013'));

INSERT INTO Rezervace (id_zakaznika, id_nahravky, datum)
    SELECT id_zakaznika, id_nahravky, TO_DATE('31.3.2022')
    FROM Zakaznik CROSS JOIN Nahravka
    WHERE jmeno = 'Evgenii' AND prijmeni = 'Shiliaev' AND nazev = 'Jexi: Láska z mobilu';
INSERT INTO Rezervace (id_zakaznika, id_nahravky, datum)
    SELECT id_zakaznika, id_nahravky, TO_DATE('1.4.2022')
    FROM Zakaznik CROSS JOIN Nahravka
    WHERE jmeno = 'Pavel' AND prijmeni = 'Novák' AND nazev = 'Forrest Gump';
INSERT INTO Rezervace (id_zakaznika, id_nahravky, datum)
    SELECT id_zakaznika, id_nahravky, TO_DATE('2.4.2022')
    FROM Zakaznik CROSS JOIN Nahravka
    WHERE jmeno = 'Eva' AND prijmeni = 'Svobodová' AND nazev = 'Sociální síť';

INSERT INTO Vypujcka (datum_do, cena, id_rezervace, id_nahravky, id_kazety, id_zakaznika, vydano_zamestnancem)
    SELECT TO_DATE('5.4.2022'), sazba_vypujceni*(TO_DATE('5.4.2022') - TO_DATE(CURRENT_DATE)), id_rezervace, Kazeta.id_nahravky, id_kazety, id_zakaznika, id_zamestnance
    FROM Rezervace CROSS JOIN Kazeta CROSS JOIN Zamestnanec
    WHERE id_rezervace = 1 AND Rezervace.id_nahravky = Kazeta.id_nahravky AND Kazeta.stav = 'Skladem' AND
        jmeno = 'Jan' AND prijmeni = 'Culek' AND ROWNUM <= 1;

UPDATE Rezervace
    SET stav = 'Vyrizeno'
    WHERE id_rezervace = 1;

UPDATE Kazeta
    SET stav = 'Vypůjčeno'
    WHERE id_kazety IN (
        SELECT id_rezervace
        FROM Vypujcka
        WHERE id_rezervace = 1);

INSERT INTO Vypujcka (datum_do, cena, id_rezervace, id_nahravky, id_kazety, id_zakaznika, vydano_zamestnancem)
    SELECT TO_DATE('5.4.2022'), sazba_vypujceni*(TO_DATE('5.4.2022') - TO_DATE(CURRENT_DATE)), id_rezervace, Kazeta.id_nahravky, id_kazety, id_zakaznika, id_zamestnance
    FROM Rezervace CROSS JOIN Kazeta CROSS JOIN Zamestnanec
    WHERE id_rezervace = 2 AND Rezervace.id_nahravky = Kazeta.id_nahravky AND Kazeta.stav = 'Skladem' AND
        jmeno = 'Jan' AND prijmeni = 'Culek' AND ROWNUM <= 1;

UPDATE Rezervace
    SET stav = 'Vyřizeno'
    WHERE id_rezervace = 2;

UPDATE Kazeta
    SET stav = 'Vypůjčeno'
    WHERE id_kazety IN (
        SELECT id_kazety
        FROM Vypujcka
        WHERE id_rezervace = 2);

INSERT INTO Vypujcka (datum_od, datum_do, cena, id_nahravky, id_kazety, id_zakaznika, vydano_zamestnancem)
    SELECT TO_DATE('2.4.2022'), TO_DATE('7.4.2022'), sazba_vypujceni*(TO_DATE('7.4.2022') - TO_DATE('2.4.2022')),
        Kazeta.id_nahravky, id_kazety, id_zakaznika, id_zamestnance
    FROM Nahravka CROSS JOIN Kazeta CROSS JOIN Zamestnanec CROSS JOIN ZAKAZNIK
    WHERE nazev = 'Jexi: Láska z mobilu' AND Kazeta.stav = 'Skladem' AND Zamestnanec.jmeno = 'Jan' AND
        Zamestnanec.prijmeni = 'Culek' AND Zakaznik.jmeno = 'Jiří' AND Zakaznik.prijmeni = 'Černý' AND ROWNUM <= 1;

UPDATE Kazeta
    SET stav = 'Vypůjčeno'
    WHERE id_kazety IN (
        SELECT id_kazety
        FROM Vypujcka NATURAL JOIN Zakaznik
        WHERE datum_do = TO_DATE('7.4.2022') AND jmeno = 'Jiří' AND prijmeni = 'Černý');

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
    WHERE zanr = 'Drama';

/* Nahravky v anglickem jazyce zneni */
SELECT nazev
    FROM Nahravka
    WHERE jazyk_zneni = 'Angličtina';

/* End of xshili00_xbrazd22.sql */