ALTER SESSION SET nls_date_format = 'DD-MM-YYYY';
BEGIN
DBMS_RANDOM.seed('random_seed');
END;
/
set serveroutput on;

ALTER TABLE TWORZENIE_GRY DROP CONSTRAINT TWORZENIE_GRY_fk1;
ALTER TABLE TWORZENIE_GRY DROP CONSTRAINT TWORZENIE_GRY_fk2;
ALTER TABLE TWORZENIE_GRY DROP CONSTRAINT TWORZENIE_GRY_fk3;
ALTER TABLE KOMENTARZ_DO_RECENZJI DROP CONSTRAINT KOMENTARZ_DO_RECENZJI_fk1;
ALTER TABLE KOMENTARZ_DO_RECENZJI DROP CONSTRAINT KOMENTARZ_DO_RECENZJI_fk2;
ALTER TABLE KOMENTARZ_DO_RECENZJI DROP CONSTRAINT KOMENTARZ_DO_RECENZJI_fk3;
ALTER TABLE RECENZJA DROP CONSTRAINT recenzja_fk1;
ALTER TABLE RECENZJA DROP CONSTRAINT recenzja_fk2;
ALTER TABLE RECENZJA DROP CONSTRAINT recenzja_fk3;
ALTER TABLE PORADNIK_DO_GRY DROP CONSTRAINT PORADNIK_DO_GRY_fk1;
ALTER TABLE PORADNIK_DO_GRY DROP CONSTRAINT PORADNIK_DO_GRY_fk2;
ALTER TABLE PORADNIK_DO_GRY DROP CONSTRAINT PORADNIK_DO_GRY_fk3;
ALTER TABLE KOMENTARZ_DO_GRY DROP CONSTRAINT KOMENTARZ_DO_GRY_fk1;
ALTER TABLE KOMENTARZ_DO_GRY DROP CONSTRAINT KOMENTARZ_DO_GRY_fk2;
ALTER TABLE WYDANIE_GRY DROP CONSTRAINT WYDANIE_GRY_fk1;
ALTER TABLE WYDANIE_GRY DROP CONSTRAINT WYDANIE_GRY_fk2;
ALTER TABLE WYDANIE_GRY DROP CONSTRAINT WYDANIE_GRY_fk3;

DROP TRIGGER KOMENTARZ_DO_RECENZJI_seq_trg;
DROP TABLE KOMENTARZ_DO_RECENZJI;
DROP SEQUENCE KOMENTARZ_DO_RECENZJI_seq;

DROP TRIGGER RECENZJA_seq_trg;
DROP TABLE RECENZJA;
DROP SEQUENCE RECENZJA_seq;

drop table TWORZENIE_GRY;

DROP TRIGGER PORADNIK_DO_GRY_seq_trg;
DROP TABLE PORADNIK_DO_GRY;
DROP SEQUENCE PORADNIK_DO_GRY_seq;

DROP TRIGGER KOMENTARZ_DO_GRY_seq_trg;
DROP TABLE KOMENTARZ_DO_GRY;
DROP SEQUENCE KOMENTARZ_DO_GRY_seq;

drop table WYDANIE_GRY;

DROP TRIGGER GRA_seq_trg;
DROP TABLE GRA;
DROP SEQUENCE GRA_seq;

DROP TRIGGER PLATFORMA_seq_trg;
DROP TABLE PLATFORMA;
DROP SEQUENCE PLATFORMA_seq;

DROP TRIGGER STUDIO_DEWELOPERSKIE_seq_trg;
DROP TABLE STUDIO_DEWELOPERSKIE;
DROP SEQUENCE STUDIO_DEWELOPERSKIE_seq;

DROP TRIGGER GATUNEK_seq_trg;
DROP TABLE GATUNEK;
DROP SEQUENCE GATUNEK_seq;


DROP TRIGGER WYDAWCA_seq_trg;
DROP TABLE WYDAWCA;
DROP SEQUENCE WYDAWCA_seq;


DROP TABLE UZYTKOWNIK;
DROP SEQUENCE UZYTKOWNIK_seq;
DROP TRIGGER UZYTKOWNIK_seq_trg;
--------------------------------------------------------------------------------

create table WYDAWCA(
  wydawca_id NUMBER,
  nazwa VARCHAR2(200)

);

CREATE SEQUENCE WYDAWCA_seq;
CREATE OR REPLACE TRIGGER WYDAWCA_seq_trg
BEFORE INSERT ON WYDAWCA
FOR EACH ROW
BEGIN
  :NEW.wydawca_id := WYDAWCA_seq.NEXTVAL;
END;
/
--------------------------------------------------------------------------------

create table UZYTKOWNIK (
  uzytkownik_id NUMBER,
  nazwa VARCHAR2(200)
);

CREATE SEQUENCE UZYTKOWNIK_seq;
CREATE OR REPLACE TRIGGER UZYTKOWNIK_seq_trg
BEFORE INSERT ON UZYTKOWNIK
FOR EACH ROW
BEGIN
  :NEW.uzytkownik_id := UZYTKOWNIK_seq.NEXTVAL;
END;
/
--------------------------------------------------------------------------------
create table GATUNEK (
  gatunek_id NUMBER,
  nazwa VARCHAR2(200)
);

CREATE SEQUENCE GATUNEK_seq;
CREATE OR REPLACE TRIGGER GATUNEK_seq_trg
BEFORE INSERT ON GATUNEK
FOR EACH ROW
BEGIN
  :NEW.gatunek_id := GATUNEK_seq.NEXTVAL;
END;
/
--------------------------------------------------------------------------------

create table STUDIO_DEWELOPERSKIE (
  studio_deweloperskie_id NUMBER,
  nazwa VARCHAR2(200)
);

CREATE SEQUENCE STUDIO_DEWELOPERSKIE_seq;
CREATE OR REPLACE TRIGGER STUDIO_DEWELOPERSKIE_seq_trg
BEFORE INSERT ON STUDIO_DEWELOPERSKIE
FOR EACH ROW
BEGIN
  :NEW.studio_deweloperskie_id := STUDIO_DEWELOPERSKIE_seq.NEXTVAL;
END;
/
--------------------------------------------------------------------------------

create table PLATFORMA (
  platforma_id NUMBER,
  nazwa VARCHAR2(200)
);

CREATE SEQUENCE PLATFORMA_seq;
CREATE OR REPLACE TRIGGER PLATFORMA_seq_trg
BEFORE INSERT ON PLATFORMA
FOR EACH ROW
BEGIN
  :NEW.platforma_id := PLATFORMA_seq.NEXTVAL;
END;
/
--------------------------------------------------------------------------------
create table GRA (
  gra_id NUMBER,
  nazwa VARCHAR2(200),
  gatunek_id NUMBER,
  tagi VARCHAR2(200)
);

CREATE SEQUENCE GRA_seq;
CREATE OR REPLACE TRIGGER GRA_seq_trg
BEFORE INSERT ON GRA
FOR EACH ROW
BEGIN
  :NEW.gra_id := GRA_seq.NEXTVAL;
END;
/
--------------------------------------------------------------------------------

create table WYDANIE_GRY (
  gra_id NUMBER,
  wydawca_id NUMBER,
  platforma_id NUMBER,
  data DATE
);

--------------------------------------------------------------------------------

create table KOMENTARZ_DO_GRY (
  komentarz_do_gry_id NUMBER,
  gra_id NUMBER,
  uzytkownik_id NUMBER,
  data DATE,
  tekst VARCHAR2(200)
);


CREATE SEQUENCE KOMENTARZ_DO_GRY_seq;
CREATE OR REPLACE TRIGGER KOMENTARZ_DO_GRY_seq_trg
BEFORE INSERT ON KOMENTARZ_DO_GRY
FOR EACH ROW
BEGIN
  :NEW.komentarz_do_gry_id := KOMENTARZ_DO_GRY_seq.NEXTVAL;
END;
/

--------------------------------------------------------------------------------
create table PORADNIK_DO_GRY (
  poradnik_do_gry_id NUMBER,
  uzytkownik_id NUMBER,
  gra_id NUMBER,
  platforma_id NUMBER,
  tekst VARCHAR2(200),
  tagi VARCHAR2(200)
);
CREATE SEQUENCE PORADNIK_DO_GRY_seq;
CREATE OR REPLACE TRIGGER PORADNIK_DO_GRY_seq_trg
BEFORE INSERT ON PORADNIK_DO_GRY
FOR EACH ROW
BEGIN
  :NEW.poradnik_do_gry_id := PORADNIK_DO_GRY_seq.NEXTVAL;
END;
/

--------------------------------------------------------------------------------
create table TWORZENIE_GRY (
  gra_id NUMBER,
  platforma_id NUMBER,
  studio_deweloperskie_id NUMBER,
  czas_powstawania NUMBER(*,1),
  budzet NUMBER(*,1)
);
--------------------------------------------------------------------------------

create table RECENZJA (
  recenzja_id NUMBER,
  gra_id NUMBER,
  platforma_id NUMBER,
  autor_id NUMBER,
  tytul VARCHAR2(200),
  tekst VARCHAR2(200),
  tagi VARCHAR2(200)
);


CREATE SEQUENCE RECENZJA_seq;
CREATE OR REPLACE TRIGGER RECENZJA_seq_trg
BEFORE INSERT ON RECENZJA
FOR EACH ROW
BEGIN
  :NEW.recenzja_id := RECENZJA_seq.NEXTVAL;
END;
/
--------------------------------------------------------------------------------

create table KOMENTARZ_DO_RECENZJI (
  komentarz_do_recenzji_id NUMBER,
  gra_id NUMBER,
  recenzja_id NUMBER,
  uzytkownik_id NUMBER,
  data DATE,
  tekst VARCHAR2(200)
);

CREATE SEQUENCE KOMENTARZ_DO_RECENZJI_seq;
CREATE OR REPLACE TRIGGER KOMENTARZ_DO_RECENZJI_seq_trg
BEFORE INSERT ON KOMENTARZ_DO_RECENZJI
FOR EACH ROW
BEGIN
  :NEW.komentarz_do_recenzji_id := KOMENTARZ_DO_RECENZJI_seq.NEXTVAL;
END;
/
--------------------------------------------------------------------------------
ALTER TABLE WYDAWCA ADD CONSTRAINT WYDAWCA_pk PRIMARY KEY (wydawca_id);
ALTER TABLE UZYTKOWNIK ADD CONSTRAINT UZYTKOWNIK_pk PRIMARY KEY (uzytkownik_id);
ALTER TABLE GATUNEK ADD CONSTRAINT GATUNEK_pk PRIMARY KEY (gatunek_id);
ALTER TABLE STUDIO_DEWELOPERSKIE ADD CONSTRAINT STUDIO_DEWELOPERSKIE_pk PRIMARY KEY (studio_deweloperskie_id);
ALTER TABLE PLATFORMA ADD  CONSTRAINT PLATFORMA_pk PRIMARY KEY (platforma_id);
ALTER TABLE GRA ADD  CONSTRAINT gra_pk PRIMARY KEY (gra_id);
ALTER TABLE GRA ADD CONSTRAINT gra_fk FOREIGN KEY (gatunek_id) REFERENCES GATUNEK(gatunek_id);
ALTER TABLE WYDANIE_GRY ADD CONSTRAINT WYDANIE_GRY_pk PRIMARY KEY (gra_id, wydawca_id, platforma_id);
ALTER TABLE WYDANIE_GRY ADD CONSTRAINT WYDANIE_GRY_fk1 FOREIGN KEY (gra_id) REFERENCES GRA(gra_id);
ALTER TABLE WYDANIE_GRY ADD CONSTRAINT WYDANIE_GRY_fk2 FOREIGN KEY (wydawca_id) REFERENCES WYDAWCA(wydawca_id);
ALTER TABLE WYDANIE_GRY ADD CONSTRAINT WYDANIE_GRY_fk3 FOREIGN KEY (platforma_id) REFERENCES PLATFORMA(platforma_id);
ALTER TABLE KOMENTARZ_DO_GRY ADD CONSTRAINT KOMENTARZ_DO_GRY_pk PRIMARY KEY (komentarz_do_gry_id);
ALTER TABLE KOMENTARZ_DO_GRY ADD CONSTRAINT KOMENTARZ_DO_GRY_fk1 FOREIGN KEY (gra_id) REFERENCES GRA(gra_id);
ALTER TABLE KOMENTARZ_DO_GRY ADD CONSTRAINT KOMENTARZ_DO_GRY_fk2 FOREIGN KEY (uzytkownik_id) REFERENCES UZYTKOWNIK(uzytkownik_id);
ALTER TABLE PORADNIK_DO_GRY ADD CONSTRAINT PORADNIK_DO_GRY_pk PRIMARY KEY (poradnik_do_gry_id);
ALTER TABLE PORADNIK_DO_GRY ADD CONSTRAINT PORADNIK_DO_GRY_fk1 FOREIGN KEY (gra_id)         REFERENCES GRA(gra_id);
ALTER TABLE PORADNIK_DO_GRY ADD CONSTRAINT PORADNIK_DO_GRY_fk2 FOREIGN KEY (uzytkownik_id)  REFERENCES UZYTKOWNIK(uzytkownik_id);
ALTER TABLE PORADNIK_DO_GRY ADD CONSTRAINT PORADNIK_DO_GRY_fk3 FOREIGN KEY (platforma_id)   REFERENCES PLATFORMA(platforma_id);
ALTER TABLE TWORZENIE_GRY ADD CONSTRAINT TWORZENIE_GRY_pk PRIMARY KEY (gra_id, platforma_id);
ALTER TABLE TWORZENIE_GRY ADD CONSTRAINT TWORZENIE_GRY_fk1 FOREIGN KEY (gra_id) REFERENCES GRA(gra_id);
ALTER TABLE TWORZENIE_GRY ADD CONSTRAINT TWORZENIE_GRY_fk2 FOREIGN KEY (platforma_id) REFERENCES PLATFORMA(platforma_id);
ALTER TABLE TWORZENIE_GRY ADD CONSTRAINT TWORZENIE_GRY_fk3 FOREIGN KEY (studio_deweloperskie_id) REFERENCES STUDIO_DEWELOPERSKIE(studio_deweloperskie_id);
ALTER TABLE RECENZJA ADD CONSTRAINT RECENZJA_pk PRIMARY KEY (recenzja_id);
ALTER TABLE RECENZJA ADD CONSTRAINT recenzja_fk1 FOREIGN KEY (gra_id) REFERENCES GRA(gra_id);
ALTER TABLE RECENZJA ADD CONSTRAINT recenzja_fk2 FOREIGN KEY (platforma_id) REFERENCES PLATFORMA(platforma_id);
ALTER TABLE RECENZJA ADD CONSTRAINT recenzja_fk3 FOREIGN KEY (autor_id) REFERENCES UZYTKOWNIK(uzytkownik_id);
ALTER TABLE KOMENTARZ_DO_RECENZJI ADD CONSTRAINT KOMENTARZ_DO_RECENZJI_pk PRIMARY KEY (komentarz_do_recenzji_id);
ALTER TABLE KOMENTARZ_DO_RECENZJI ADD CONSTRAINT  KOMENTARZ_DO_RECENZJI_fk1 FOREIGN KEY (gra_id) REFERENCES GRA(gra_id);
ALTER TABLE KOMENTARZ_DO_RECENZJI ADD CONSTRAINT  KOMENTARZ_DO_RECENZJI_fk2 FOREIGN KEY (recenzja_id) REFERENCES RECENZJA(recenzja_id);
ALTER TABLE KOMENTARZ_DO_RECENZJI ADD CONSTRAINT  KOMENTARZ_DO_RECENZJI_fk3 FOREIGN KEY (uzytkownik_id) REFERENCES UZYTKOWNIK(uzytkownik_id);

create or replace FUNCTION GENERATOR_DATY(POCZATEK_ROK in NUMBER, KONIEC_ROK IN NUMBER)
RETURN DATE IS
	y NUMBER(4);
  d NUMBER(4);
  dates VARCHAR2(10);
BEGIN
	y := dbms_random.value(POCZATEK_ROK,KONIEC_ROK);
  d := dbms_random.value(1,355);
  dates := to_char(y) || to_char(d,'999');
  return to_date(dates,'yyyyddd');
END GENERATOR_DATY;
/

create or replace PROCEDURE GENERATOR_UZYTKOWNIK(ILOSC in NUMBER) IS
BEGIN
	FOR i IN 1..ILOSC LOOP
		INSERT INTO UZYTKOWNIK VALUES (NULL, dbms_random.string('A', DBMS_RANDOM.VALUE(3,10)));
	END LOOP;
END GENERATOR_UZYTKOWNIK;
/

EXECUTE GENERATOR_UZYTKOWNIK(100);

create or replace PROCEDURE GENERATOR_GATUNEK(ILOSC in NUMBER) IS
BEGIN
	FOR i IN 1..ILOSC LOOP
    INSERT INTO GATUNEK VALUES (NULL, dbms_random.string('A', DBMS_RANDOM.VALUE(3,10)));
	END LOOP;
END GENERATOR_GATUNEK;
/
EXECUTE GENERATOR_GATUNEK(20);

create or replace PROCEDURE GENERATOR_PLATFORMA(ILOSC in NUMBER) IS
BEGIN
	FOR i IN 1..ILOSC LOOP
    INSERT INTO PLATFORMA VALUES (NULL, dbms_random.string('A', DBMS_RANDOM.VALUE(3,10)));
	END LOOP;
END GENERATOR_PLATFORMA;
/
EXECUTE GENERATOR_PLATFORMA(10);
create or replace PROCEDURE GENERATOR_WYDAWCA(ILOSC in NUMBER) IS
BEGIN
	FOR i IN 1..ILOSC LOOP
    INSERT INTO WYDAWCA VALUES (NULL, dbms_random.string('A', DBMS_RANDOM.VALUE(3,10)));
	END LOOP;
END GENERATOR_WYDAWCA;
/
EXECUTE GENERATOR_WYDAWCA(30);

create or replace PROCEDURE GENERATOR_STUDIO_DEWELOPERSKIE(ILOSC in NUMBER) IS
BEGIN
	FOR i IN 1..ILOSC LOOP
    INSERT INTO STUDIO_DEWELOPERSKIE VALUES (NULL, dbms_random.string('A', DBMS_RANDOM.VALUE(3,10)));
	END LOOP;
END GENERATOR_STUDIO_DEWELOPERSKIE;
/
EXECUTE GENERATOR_STUDIO_DEWELOPERSKIE(70);


create or replace PROCEDURE GENERATOR_GRA(ILOSC in NUMBER) IS
TYPE TABSTR IS TABLE OF VARCHAR2(250);
tags TABSTR;
BEGIN
  tags := TABSTR('nowosc','hit','legendarna produkcja','tylko na pc','remake','darmowa','promocja','debiut','popularna','niezalezna produkcja','beta','alpha','gamma','early access','steam');
	FOR i IN 1..ILOSC LOOP
		INSERT INTO GRA (nazwa,gatunek_id,tagi) VALUES
    (
    dbms_random.string('A', DBMS_RANDOM.VALUE(3,10)),
    (select gatunek_id from (select gatunek_id from GATUNEK order by dbms_random.value) where rownum = 1),
    tags(1+mod(i,15)) || ',' || tags(1+mod(i+1,15)) || ',' || tags(1+mod(i+2,15))
    );
	END LOOP;
END GENERATOR_GRA;
/

EXECUTE GENERATOR_GRA(100);

create or replace PROCEDURE GENERATOR_WYDANIE_GRY(ILOSC in NUMBER) IS
BEGIN
	FOR i IN 1..ILOSC LOOP
  <<UP>>
  BEGIN
		INSERT INTO WYDANIE_GRY VALUES (
    (select gra_id from (select gra_id from GRA order by dbms_random.value) where rownum = 1),
    (select wydawca_id from (select wydawca_id from WYDAWCA order by dbms_random.value) where rownum = 1),
    (select platforma_id from (select platforma_id from PLATFORMA order by dbms_random.value) where rownum = 1),
    GENERATOR_DATY(1990,2015)
    );
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
      goto UP;
    END;
	END LOOP;
END GENERATOR_WYDANIE_GRY;
/

EXECUTE  GENERATOR_WYDANIE_GRY(100);


create or replace PROCEDURE GENERATOR_KOMENTARZ_DO_GRY(ILOSC in NUMBER) IS
BEGIN
	FOR i IN 1..ILOSC LOOP
		INSERT INTO KOMENTARZ_DO_GRY VALUES (NULL,
    (select gra_id from (select gra_id from GRA order by dbms_random.value) where rownum = 1),
    (select UZYTKOWNIK_ID from (select UZYTKOWNIK_ID from UZYTKOWNIK order by dbms_random.value) where rownum = 1),
    GENERATOR_DATY(1990,2015),
    dbms_random.string('A', DBMS_RANDOM.VALUE(10,200))
    );
	END LOOP;
END GENERATOR_KOMENTARZ_DO_GRY;
/

EXECUTE  GENERATOR_KOMENTARZ_DO_GRY(100);

create or replace PROCEDURE GENERATOR_PORADNIK_DO_GRY(ILOSC in NUMBER) IS
TYPE TABSTR IS TABLE OF VARCHAR2(250);
tags TABSTR;
BEGIN
  tags := TABSTR('nowosc','hit','nowy poradnik','kompletny poradnik','w trakcie tworzenia','darmowy','płatny');
	FOR i IN 1..ILOSC LOOP
		INSERT INTO PORADNIK_DO_GRY VALUES (NULL,
    (select UZYTKOWNIK_ID from (select UZYTKOWNIK_ID from UZYTKOWNIK order by dbms_random.value) where rownum = 1),
    (select gra_id from (select gra_id from GRA order by dbms_random.value) where rownum = 1),
    (select platforma_id from (select platforma_id from PLATFORMA order by dbms_random.value) where rownum = 1),
    dbms_random.string('A', DBMS_RANDOM.VALUE(10,200)),
    tags(1+mod(i,7)) || ',' || tags(1+mod(i+1,7)) || ',' || tags(1+mod(i+2,7))
    );
	END LOOP;
END GENERATOR_PORADNIK_DO_GRY;
/

EXECUTE  GENERATOR_PORADNIK_DO_GRY(100);


create or replace PROCEDURE GENERATOR_TWORZENIE_GRY(ILOSC in NUMBER) IS
BEGIN
	FOR i IN 1..ILOSC LOOP
  <<UP>>
  BEGIN
		INSERT INTO TWORZENIE_GRY VALUES (
    (select gra_id from (select gra_id from GRA order by dbms_random.value) where rownum = 1),
    (select platforma_id from (select platforma_id from PLATFORMA order by dbms_random.value) where rownum = 1),
    (select STUDIO_DEWELOPERSKIE_id from (select STUDIO_DEWELOPERSKIE_id from STUDIO_DEWELOPERSKIE order by dbms_random.value) where rownum = 1),
    DBMS_RANDOM.VALUE(1,5),
    DBMS_RANDOM.VALUE(10000,500000)
    );
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
      goto UP;
    END;
	END LOOP;
END GENERATOR_TWORZENIE_GRY;
/

EXECUTE  GENERATOR_TWORZENIE_GRY(100);

create or replace PROCEDURE GENERATOR_RECENZJA(ILOSC in NUMBER) IS
TYPE TABSTR IS TABLE OF VARCHAR2(250);
tags TABSTR;
BEGIN
  tags := TABSTR('dobra ocena','slaba ocena','autor poleca','nowa','w trakcie pisania');
	FOR i IN 1..ILOSC LOOP
		INSERT INTO RECENZJA VALUES (NULL,
    (select gra_id from (select gra_id from GRA order by dbms_random.value) where rownum = 1),
    (select platforma_id from (select platforma_id from PLATFORMA order by dbms_random.value) where rownum = 1),
    (select uzytkownik_id from (select uzytkownik_id from UZYTKOWNIK order by dbms_random.value) where rownum = 1),
    dbms_random.string('A', DBMS_RANDOM.VALUE(10,20)),
    dbms_random.string('A', DBMS_RANDOM.VALUE(10,200)),
    tags(1+mod(i,5)) || ',' || tags(1+mod(i+1,5)) || ',' || tags(1+mod(i+2,5))
    );
	END LOOP;
END GENERATOR_RECENZJA;
/

EXECUTE GENERATOR_RECENZJA(100);





create or replace PROCEDURE GEN_KOMENTARZ_DO_RECENZJI(ILOSC in NUMBER) IS
BEGIN
	FOR i IN 1..ILOSC LOOP
		INSERT INTO KOMENTARZ_DO_RECENZJI VALUES (NULL,
    (select gra_id from (select gra_id from GRA order by dbms_random.value) where rownum = 1),
    (select recenzja_id from (select recenzja_id from RECENZJA order by dbms_random.value) where rownum = 1),
    (select UZYTKOWNIK_ID from (select UZYTKOWNIK_ID from UZYTKOWNIK order by dbms_random.value) where rownum = 1),
    GENERATOR_DATY(1990,2015),
    dbms_random.string('A', DBMS_RANDOM.VALUE(10,200))
    );
	END LOOP;
END GEN_KOMENTARZ_DO_RECENZJI;
/

EXECUTE  GEN_KOMENTARZ_DO_RECENZJI(100);

commit;

--Wyświetl wszystkie gry
--podaj ich nazwę, nazwę wydawcy, nazwę platformy i datę wydania
--posortuj wg daty wydania
select GRA.NAZWA,WYDAWCA.NAZWA as NAZWA_WYDAWCY,PLATFORMA.NAZWA as NAZWA_PLATFORMY,WYDANIE_GRY.DATA as DATA_WYDANIA from GRA
join WYDANIE_GRY on GRA.gra_id = WYDANIE_GRY.gra_id
join WYDAWCA on WYDANIE_GRY.wydawca_id = WYDAWCA.WYDAWCA_ID
join PLATFORMA on WYDANIE_GRY.platforma_id = PLATFORMA.platforma_id
order by WYDANIE_GRY.DATA;


--Wyświetl wszystkie komentarze do gier urzytkownika o id = 1
select KOMENTARZ_DO_GRY.TEKST as TEKST_KOMENTARZA
from KOMENTARZ_DO_GRY where UZYTKOWNIK_ID = 1;

--wyświetl gry z tagiem remake
select GRA.NAZWA,WYDAWCA.NAZWA as NAZWA_WYDAWCY,PLATFORMA.NAZWA as NAZWA_PLATFORMY,WYDANIE_GRY.DATA as DATA_WYDANIA,
GRA.TAGI AS TAGI from GRA
join WYDANIE_GRY on GRA.gra_id = WYDANIE_GRY.gra_id
join WYDAWCA on WYDANIE_GRY.wydawca_id = WYDAWCA.WYDAWCA_ID
join PLATFORMA on WYDANIE_GRY.platforma_id = PLATFORMA.platforma_id where GRA.TAGI like '%remake%'
order by WYDANIE_GRY.DATA;

--wyświetl najchętniej komentowane recenzje
select RECENZJA.TYTUL as TYTUL_RECENZJI, UZYTKOWNIK.NAZWA as NAZWA_AUTORA, ILOSC_KOMENTARZY from
(select RECENZJA.RECENZJA_ID as IDR, count(*) as ILOSC_KOMENTARZY
from RECENZJA join KOMENTARZ_DO_RECENZJI on RECENZJA.RECENZJA_ID = KOMENTARZ_DO_RECENZJI.RECENZJA_ID
group by RECENZJA.RECENZJA_ID)
join RECENZJA on RECENZJA.RECENZJA_ID = IDR
join UZYTKOWNIK on UZYTKOWNIK.UZYTKOWNIK_ID = RECENZJA.AUTOR_ID
order by (ILOSC_KOMENTARZY) DESC;

--wyswietl komentarze do najchetniej komentowanej recenzji
select KOMENTARZ_DO_RECENZJI.TEKST as TEKST_KOMENTARZA
from KOMENTARZ_DO_RECENZJI where RECENZJA_ID =
(select IDR from (select RECENZJA.RECENZJA_ID as IDR, count(*) as ILOSC_KOMENTARZY
from RECENZJA join KOMENTARZ_DO_RECENZJI on RECENZJA.RECENZJA_ID = KOMENTARZ_DO_RECENZJI.RECENZJA_ID
group by RECENZJA.RECENZJA_ID
order by (ILOSC_KOMENTARZY) DESC) where rownum = 1);
