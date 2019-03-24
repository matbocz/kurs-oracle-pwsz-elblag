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

ALTER TABLE bokser ADD CONSTRAINT bokser_pk PRIMARY KEY ( id );

CREATE TABLE kat_wagowa (
    id                 INTEGER NOT NULL,
    min_waga           SMALLINT NOT NULL,
    max_waga           SMALLINT NOT NULL,
    nazwa_kat_wagowa   VARCHAR2(20) NOT NULL
);

ALTER TABLE kat_wagowa ADD CONSTRAINT kat_wagowa_pk PRIMARY KEY ( id );

CREATE TABLE klub (
    id           INTEGER NOT NULL,
    nazwa_klub   VARCHAR2(50) NOT NULL,
    ranking      INTEGER NOT NULL
);

ALTER TABLE klub ADD CONSTRAINT klub_pk PRIMARY KEY ( id );

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


-- 1. Wyswietlic imie, nazwisko, wage najciezszego zawodnika 
--    oraz nazwe klubu, w ktorym trenuje.


-- 2. Wypisac pieciu zawodnikow o najwiekszych wagach. 
--    Jezeli kilku ma taka sama wage, wypisac tych o 
--    nazwiskach wczesniejszych alfabetycznie.


-- 3. Dla kazdego z klubow wypisac jego nazwe oraz 
--    nazwisko i wage najlzejszego i najciezszego zawodnika.


-- 4. Wypisac nazwiska bokserow, ktorzy nie przegrali 
--    zadnej walki.


-- 5. Wypisac nazwiska bokserow z liczba ich zwyciestw, 
--    w kazdej startowanej kategorii wagowej.


-- 6. Wypisac nazwy klubow z liczba zwyciestw ich zawodnikow.


-- 7. Dla kazdego klubu wypisac maksymalna liczbe zwyciestw 
--    jednego zawodnika tego klubu.


-- 8. Wypisac kategorie wagowe, w ktorych nie wystepowal 
--    zaden bokser.


-- 9. Wypisac nazwy klubow, w ktorych nikt nie walczy.
 

-- 10. Wypisac tych zawodnikow, dla ktorych imiona i nazwiska 
--     sa takie same, ale wartosci indentyfikatorow sa rozne.


-- 11. Wypisac nazwy klubow, ktorych zawodnicy wygrali 
--     ponad 20% wszystkich walk.