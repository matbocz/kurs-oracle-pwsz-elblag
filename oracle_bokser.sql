-- 18560 Mateusz Boczarski

-- Ponizej wklej poprawiony skrypt SQL dla systemu Oracle generujacy strukture bazy danych "bokser":
CREATE TABLE bokser (
    id         INTEGER NOT NULL,
    imie       VARCHAR2(20) NOT NULL,
    nazwisko   VARCHAR2(20) NOT NULL,
    data_ur    DATE NOT NULL,
    waga       INTEGER NOT NULL,
    wzrost     INTEGER NOT NULL,
    klub_id    INTEGER NOT NULL
);

ALTER TABLE bokser
    ADD CONSTRAINT bokser_ck_1 CHECK ( length(imie) > 2 );

ALTER TABLE bokser
    ADD CONSTRAINT bokser_ck_2 CHECK ( length(nazwisko) > 2 );

ALTER TABLE bokser ADD CONSTRAINT bokser_ck_3 CHECK ( waga > 0 );

ALTER TABLE bokser ADD CONSTRAINT bokser_ck_4 CHECK ( wzrost > 0 );

ALTER TABLE bokser ADD CONSTRAINT bokser_pk PRIMARY KEY ( id );

CREATE TABLE kat_wagowa (
    id                 INTEGER NOT NULL,
    min_waga           SMALLINT NOT NULL,
    max_waga           SMALLINT NOT NULL,
    nazwa_kat_wagowa   VARCHAR2(20) NOT NULL
);

ALTER TABLE kat_wagowa ADD CONSTRAINT kat_wagowa_ck_1 CHECK ( min_waga > 0 );

ALTER TABLE kat_wagowa ADD CONSTRAINT kat_wagowa_ck_2 CHECK ( max_waga > 0 );

ALTER TABLE kat_wagowa
    ADD CONSTRAINT kat_wagowa_ck_3 CHECK ( length(nazwa_kat_wagowa) > 2 );

ALTER TABLE kat_wagowa ADD CONSTRAINT kat_wagowa_pk PRIMARY KEY ( id );

ALTER TABLE kat_wagowa ADD CONSTRAINT kat_wagowa__un UNIQUE ( nazwa_kat_wagowa );

CREATE TABLE klub (
    id           INTEGER NOT NULL,
    nazwa_klub   VARCHAR2(50) NOT NULL,
    ranking      INTEGER NOT NULL
);

ALTER TABLE klub
    ADD CONSTRAINT klub_ck_1 CHECK ( length(nazwa_klub) > 2 );

ALTER TABLE klub ADD CONSTRAINT klub_pk PRIMARY KEY ( id );

ALTER TABLE klub ADD CONSTRAINT klub__un UNIQUE ( nazwa_klub );

CREATE TABLE walka (
    id              INTEGER NOT NULL,
    bokser1_id      INTEGER NOT NULL,
    bokser2_id      INTEGER NOT NULL,
    zwyciezca       SMALLINT NOT NULL,
    kat_wagowa_id   INTEGER NOT NULL,
    data_walka      DATE NOT NULL
);

ALTER TABLE walka ADD CONSTRAINT walka_pk PRIMARY KEY ( id );

ALTER TABLE bokser
    ADD CONSTRAINT bokser_klub_fk FOREIGN KEY ( klub_id )
        REFERENCES klub ( id );

ALTER TABLE walka
    ADD CONSTRAINT walka_bokser_fk1 FOREIGN KEY ( bokser1_id )
        REFERENCES bokser ( id );

ALTER TABLE walka
    ADD CONSTRAINT walka_bokser_fk2 FOREIGN KEY ( bokser2_id )
        REFERENCES bokser ( id );

ALTER TABLE walka
    ADD CONSTRAINT walka_kat_wagowa_fk FOREIGN KEY ( kat_wagowa_id )
        REFERENCES kat_wagowa ( id );

CREATE SEQUENCE bokser_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER bokser_id_trg BEFORE
    INSERT ON bokser
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := bokser_id_seq.nextval;
END;
/

CREATE SEQUENCE kat_wagowa_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER kat_wagowa_id_trg BEFORE
    INSERT ON kat_wagowa
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := kat_wagowa_id_seq.nextval;
END;
/

CREATE SEQUENCE klub_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER klub_id_trg BEFORE
    INSERT ON klub
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := klub_id_seq.nextval;
END;
/

CREATE SEQUENCE walka_id_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER walka_id_trg BEFORE
    INSERT ON walka
    FOR EACH ROW
    WHEN ( new.id IS NULL )
BEGIN
    :new.id := walka_id_seq.nextval;
END;
/

-- Dopisz przykladowe rekordy z walkami (dodaj co najmniej 20 walk):
INSERT INTO klub(nazwa_klub, ranking)
VALUES ('Tygryski','100');
INSERT INTO klub(nazwa_klub, ranking)
VALUES ('Kangurki','30');
INSERT INTO klub(nazwa_klub, ranking)
VALUES ('Kogutki','80');
INSERT INTO klub(nazwa_klub, ranking)
VALUES ('Wilczki','70');
SELECT * FROM klub;

INSERT INTO kat_wagowa(min_waga, max_waga, nazwa_kat_wagowa)
VALUES ('1','48','papierowa');
INSERT INTO kat_wagowa(min_waga, max_waga, nazwa_kat_wagowa)
VALUES ('48','51','musza');
INSERT INTO kat_wagowa(min_waga, max_waga, nazwa_kat_wagowa)
VALUES ('51','54','kogucia');
INSERT INTO kat_wagowa(min_waga, max_waga, nazwa_kat_wagowa)
VALUES ('54','57','piorkowa');
INSERT INTO kat_wagowa(min_waga, max_waga, nazwa_kat_wagowa)
VALUES ('57','60','lekka');
INSERT INTO kat_wagowa(min_waga, max_waga, nazwa_kat_wagowa)
VALUES ('60','63','lekkopolsrednia');
INSERT INTO kat_wagowa(min_waga, max_waga, nazwa_kat_wagowa)
VALUES ('63','67','polsrednia');
INSERT INTO kat_wagowa(min_waga, max_waga, nazwa_kat_wagowa)
VALUES ('67','71','lekkosrednia');
INSERT INTO kat_wagowa(min_waga, max_waga, nazwa_kat_wagowa)
VALUES ('71','75','srednia');
INSERT INTO kat_wagowa(min_waga, max_waga, nazwa_kat_wagowa)
VALUES ('75','81','polciezka');
INSERT INTO kat_wagowa(min_waga, max_waga, nazwa_kat_wagowa)
VALUES ('80','200','ciezka');
SELECT * FROM kat_wagowa;

INSERT INTO bokser(imie, nazwisko, data_ur, waga, wzrost, klub_id)
VALUES ('Jan','Nowak','1993-12-23','60','167','1');
INSERT INTO bokser(imie, nazwisko, data_ur, waga, wzrost, klub_id)
VALUES ('Adam','Kowal','1994-10-01','54','161','1');
INSERT INTO bokser(imie, nazwisko, data_ur, waga, wzrost, klub_id)
VALUES ('Jerzy','Kurek','1980-03-17','59','171','1');
INSERT INTO bokser(imie, nazwisko, data_ur, waga, wzrost, klub_id)
VALUES ('Kamil','Kwota','1991-09-11','71','173','2');
INSERT INTO bokser(imie, nazwisko, data_ur, waga, wzrost, klub_id)
VALUES ('Marek','Dorek','1995-11-19','68','165','2');
INSERT INTO bokser(imie, nazwisko, data_ur, waga, wzrost, klub_id)
VALUES ('Jacek','Burczak','1992-02-28','60','175','2');
INSERT INTO bokser(imie, nazwisko, data_ur, waga, wzrost, klub_id)
VALUES ('Jacek','Burczak','1992-02-28','60','175','2');
INSERT INTO bokser(imie, nazwisko, data_ur, waga, wzrost, klub_id)
VALUES ('Marcin','Korczak','1994-06-13','61','169','3');
INSERT INTO bokser(imie, nazwisko, data_ur, waga, wzrost, klub_id)
VALUES ('Marcin','Korczak','1994-06-13','61','169','3');
INSERT INTO bokser(imie, nazwisko, data_ur, waga, wzrost, klub_id)
VALUES ('Krzysztof','Domczyk','1992-06-01','71','174','1');
SELECT * FROM bokser;

INSERT INTO walka(bokser1_id, bokser2_id, zwyciezca, kat_wagowa_id, data_walka)
VALUES ('1','6','1','6','2017-01-03');
INSERT INTO walka(bokser1_id, bokser2_id, zwyciezca, kat_wagowa_id, data_walka)
VALUES ('1','7','1','6','2017-02-10');
INSERT INTO walka(bokser1_id, bokser2_id, zwyciezca, kat_wagowa_id, data_walka)
VALUES ('1','8','1','6','2017-02-12');
INSERT INTO walka(bokser1_id, bokser2_id, zwyciezca, kat_wagowa_id, data_walka)
VALUES ('1','9','1','6','2017-03-01');
INSERT INTO walka(bokser1_id, bokser2_id, zwyciezca, kat_wagowa_id, data_walka)
VALUES ('4','10','1','9','2017-03-05');
INSERT INTO walka(bokser1_id, bokser2_id, zwyciezca, kat_wagowa_id, data_walka)
VALUES ('5','4','2','8','2017-03-12');
INSERT INTO walka(bokser1_id, bokser2_id, zwyciezca, kat_wagowa_id, data_walka)
VALUES ('5','10','1','8','2017-04-20');
INSERT INTO walka(bokser1_id, bokser2_id, zwyciezca, kat_wagowa_id, data_walka)
VALUES ('6','1','2','6','2017-04-22');
INSERT INTO walka(bokser1_id, bokser2_id, zwyciezca, kat_wagowa_id, data_walka)
VALUES ('6','7','2','6','2017-05-02');
INSERT INTO walka(bokser1_id, bokser2_id, zwyciezca, kat_wagowa_id, data_walka)
VALUES ('6','8','1','6','2017-05-10');
INSERT INTO walka(bokser1_id, bokser2_id, zwyciezca, kat_wagowa_id, data_walka)
VALUES ('6','9','2','6','2017-05-12');
INSERT INTO walka(bokser1_id, bokser2_id, zwyciezca, kat_wagowa_id, data_walka)
VALUES ('7','1','2','6','2017-05-15');
INSERT INTO walka(bokser1_id, bokser2_id, zwyciezca, kat_wagowa_id, data_walka)
VALUES ('7','6','1','6','2017-05-20');
INSERT INTO walka(bokser1_id, bokser2_id, zwyciezca, kat_wagowa_id, data_walka)
VALUES ('7','8','1','6','2017-05-22');
INSERT INTO walka(bokser1_id, bokser2_id, zwyciezca, kat_wagowa_id, data_walka)
VALUES ('7','9','1','6','2017-05-27');
INSERT INTO walka(bokser1_id, bokser2_id, zwyciezca, kat_wagowa_id, data_walka)
VALUES ('8','1','2','6','2017-06-04');
INSERT INTO walka(bokser1_id, bokser2_id, zwyciezca, kat_wagowa_id, data_walka)
VALUES ('8','6','2','6','2017-06-15');
INSERT INTO walka(bokser1_id, bokser2_id, zwyciezca, kat_wagowa_id, data_walka)
VALUES ('8','7','2','6','2017-06-17');
INSERT INTO walka(bokser1_id, bokser2_id, zwyciezca, kat_wagowa_id, data_walka)
VALUES ('8','9','1','6','2017-06-24');
INSERT INTO walka(bokser1_id, bokser2_id, zwyciezca, kat_wagowa_id, data_walka)
VALUES ('10','4','1','9','2017-07-08');
SELECT * FROM walka;

-- 1. Wyswietlic imie, nazwisko, wage najciezszego zawodnika 
--    oraz nazwe klubu, w ktorym trenuje.
SELECT b.imie, b.nazwisko, b.waga, k.nazwa_klub FROM bokser b
JOIN klub k ON b.klub_id = k.id
WHERE b.waga = (SELECT MAX(waga) FROM bokser);

-- 2. Wypisac pieciu zawodnikow o najwiekszych wagach. 
--    Jezeli kilku ma taka sama wage, wypisac tych o 
--    nazwiskach wczesniejszych alfabetycznie.
SELECT imie, nazwisko, waga 
FROM (SELECT * FROM bokser ORDER BY waga DESC, nazwisko ASC)
WHERE ROWNUM <= 5;

-- 3. Dla kazdego z klubow wypisac jego nazwe oraz 
--    nazwisko i wage najlzejszego i najciezszego zawodnika.
SELECT k.nazwa_klub, MAX(b.waga) AS najciezszy_zawodnik, MIN(b.waga) AS najlzejszy_zawodnik
FROM klub k JOIN bokser b ON k.id = b.klub_id
GROUP BY k.nazwa_klub
ORDER BY najciezszy_zawodnik DESC;

-- 4. Wypisac nazwiska bokserow, ktorzy nie przegrali 
--    zadnej walki.


-- 5. Wypisac nazwiska bokserow z liczba ich zwyciestw, 
--    w kazdej startowanej kategorii wagowej.
SELECT b.imie, b.nazwisko, kt.nazwa_kat_wagowa, COUNT(w.bokser1_id) AS ilosc_wygranych
FROM klub k JOIN bokser b ON k.id = b.klub_id
JOIN walka w ON b.id = w.bokser1_id
JOIN kat_wagowa kt ON w.kat_wagowa_id = kt.id
WHERE zwyciezca = 1
GROUP BY b.imie, b.nazwisko, kt.nazwa_kat_wagowa
UNION ALL
SELECT b.imie, b.nazwisko, kt.nazwa_kat_wagowa, COUNT(w.bokser2_id) AS ilosc_wygranych
FROM klub k JOIN bokser b ON k.id = b.klub_id
JOIN walka w ON b.id = w.bokser2_id
JOIN kat_wagowa kt ON w.kat_wagowa_id = kt.id
WHERE zwyciezca = 2
GROUP BY b.imie, b.nazwisko, kt.nazwa_kat_wagowa
ORDER BY ilosc_wygranych DESC;

-- 6. Wypisac nazwy klubow z liczba zwyciestw ich zawodnikow.
SELECT k.nazwa_klub, COUNT(w.bokser1_id) AS ilosc_wygranych
FROM klub k JOIN bokser b ON k.id = b.klub_id
JOIN walka w ON b.id = w.bokser1_id
WHERE zwyciezca = 1
GROUP BY k.nazwa_klub
UNION ALL
SELECT k.nazwa_klub, COUNT(w.bokser2_id) AS ilosc_wygranych
FROM klub k JOIN bokser b ON k.id = b.klub_id
JOIN walka w ON b.id = w.bokser2_id
WHERE zwyciezca = 2
GROUP BY k.nazwa_klub
ORDER BY ilosc_wygranych DESC;

-- 7. Dla kazdego klubu wypisac maksymalna liczbe zwyciestw 
--    jednego zawodnika tego klubu.


-- 8. Wypisac kategorie wagowe, w ktorych nie wystepowal 
--    zaden bokser.


-- 9. Wypisac nazwy klubow, w ktorych nikt nie walczy.
 

-- 10. Wypisac tych zawodnikow, dla ktorych imiona i nazwiska 
--     sa takie same, ale wartosci indentyfikatorow sa rozne.


-- 11. Wypisac nazwy klubow, ktorych zawodnicy wygrali 
--     ponad 20% wszystkich walk.