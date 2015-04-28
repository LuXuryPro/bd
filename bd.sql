ALTER SESSION SET nls_date_format = 'DD-MM-YYYY';


ALTER TABLE TWORZENIE_GRY DROP CONSTRAINT TWORZENIE_GRY_fk1;
ALTER TABLE TWORZENIE_GRY DROP CONSTRAINT TWORZENIE_GRY_fk2;
ALTER TABLE TWORZENIE_GRY DROP CONSTRAINT TWORZENIE_GRY_fk3;

ALTER TABLE KOMENTARZ_DO_RECENZJI DROP CONSTRAINT KOMENTARZ_DO_RECENZJI_fk1;
ALTER TABLE KOMENTARZ_DO_RECENZJI DROP CONSTRAINT KOMENTARZ_DO_RECENZJI_fk2;

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

drop table TWORZENIE_GRY;
drop table KOMENTARZ_DO_RECENZJI;
drop table RECENZJA;
drop table PORADNIK_DO_GRY;
drop table KOMENTARZ_DO_GRY;
drop table WYDANIE_GRY;
drop table GRA;
drop table GATUNEK;
drop table STUDIO_DEWELOPERSKIE;
drop table PLATFORMA;
drop table ZNAJOMOSC;
drop table UZYTKOWNIK;
drop table WYDAWCA;

DROP SEQUENCE WYDAWCA_seq;

create table WYDAWCA(
  wydawca_id NUMBER,
  nazwa VARCHAR2(200),
  CONSTRAINT WYDAWCA_pk PRIMARY KEY (wydawca_id)
);

CREATE SEQUENCE WYDAWCA_seq;
CREATE OR REPLACE TRIGGER WYDAWCA_seq_trg
BEFORE INSERT ON WYDAWCA
FOR EACH ROW
BEGIN
  :NEW.wydawca_id := WYDAWCA_seq.NEXTVAL;
END;
/

create table UZYTKOWNIK (
  uzytkownik_id NUMBER,
  nazwa VARCHAR2(200),
  CONSTRAINT UZYTKOWNIK_pk PRIMARY KEY (uzytkownik_id)
);
create table ZNAJOMOSC (
  id_a NUMBER,
  id_b NUMBER,
  CONSTRAINT ZNAJOMOSC_pk PRIMARY KEY (id_a,id_b),
  CONSTRAINT ZNAJOMOSC_fk1 FOREIGN KEY (id_a)
  REFERENCES UZYTKOWNIK(uzytkownik_id),
  CONSTRAINT ZNAJOMOSC_fk2 FOREIGN KEY (id_b)
  REFERENCES UZYTKOWNIK(uzytkownik_id)
);
create table GATUNEK (
  id NUMBER,
  nazwa VARCHAR2(200),
  CONSTRAINT gatunek_pk PRIMARY KEY (id)
);

create table STUDIO_DEWELOPERSKIE (
  id NUMBER,
  nazwa VARCHAR2(200),
  CONSTRAINT STUDIO_DEWELOPERSKIE_pk PRIMARY KEY (id)
);

create table PLATFORMA (
  id NUMBER,
  nazwa VARCHAR2(200),
  CONSTRAINT PLATFORMA_pk PRIMARY KEY (id)
);

create table GRA (
  id NUMBER,
  nazwa VARCHAR2(200),
  id_gatunek NUMBER,
  tagi VARCHAR2(200),
  CONSTRAINT gra_pk PRIMARY KEY (id),
  CONSTRAINT gra_fk FOREIGN KEY (id_gatunek)
  REFERENCES GATUNEK(id)
);

create table WYDANIE_GRY (
  id_gra NUMBER,
  id_wydawca NUMBER,
  id_platforma NUMBER,
  data DATE,
  CONSTRAINT WYDANIE_GRY_pk PRIMARY KEY (id_gra, id_wydawca, id_platforma),
  CONSTRAINT  WYDANIE_GRY_fk1 FOREIGN KEY (id_gra)
  REFERENCES GRA(id),
  CONSTRAINT  WYDANIE_GRY_fk2 FOREIGN KEY (id_wydawca)
  REFERENCES WYDAWCA(wydawca_id),
  CONSTRAINT  WYDANIE_GRY_fk3 FOREIGN KEY (id_platforma)
  REFERENCES PLATFORMA(id)
);

create table KOMENTARZ_DO_GRY (
  id NUMBER,
  id_gra NUMBER,
  id_uzytkownik NUMBER,
  data DATE,
  tekst VARCHAR2(200),
  CONSTRAINT KOMENTARZ_DO_GRY_pk PRIMARY KEY (id),
  CONSTRAINT  KOMENTARZ_DO_GRY_fk1 FOREIGN KEY (id_gra)
  REFERENCES GRA(id),
  CONSTRAINT  KOMENTARZ_DO_GRY_fk2 FOREIGN KEY (id_uzytkownik)
  REFERENCES UZYTKOWNIK(uzytkownik_id)
);

create table PORADNIK_DO_GRY (
  id NUMBER,
  id_uzytkownik NUMBER,
  id_gra NUMBER,
  id_platforma NUMBER,
  tekst VARCHAR2(200),
  tagi VARCHAR2(200),
  CONSTRAINT PORADNIK_DO_GRY_pk PRIMARY KEY (id),
  CONSTRAINT PORADNIK_DO_GRY_fk1 FOREIGN KEY (id_gra)         REFERENCES GRA(id),
  CONSTRAINT PORADNIK_DO_GRY_fk2 FOREIGN KEY (id_uzytkownik)  REFERENCES UZYTKOWNIK(uzytkownik_id),
  CONSTRAINT PORADNIK_DO_GRY_fk3 FOREIGN KEY (id_platforma)   REFERENCES PLATFORMA(id)
);

create table TWORZENIE_GRY (
  id_gra NUMBER,
  id_platforma NUMBER,
  id_studio_deweloperskie NUMBER,
  czas_powstawania NUMBER,
  budzet NUMBER,
  CONSTRAINT TWORZENIE_GRY_pk PRIMARY KEY (id_gra,id_platforma),
  CONSTRAINT TWORZENIE_GRY_fk1 FOREIGN KEY (id_gra)
  REFERENCES GRA(id),
  CONSTRAINT TWORZENIE_GRY_fk2 FOREIGN KEY (id_platforma)
  REFERENCES PLATFORMA(id),
  CONSTRAINT TWORZENIE_GRY_fk3 FOREIGN KEY (id_studio_deweloperskie)
  REFERENCES STUDIO_DEWELOPERSKIE(id)
);

create table RECENZJA (
  id NUMBER,
  id_gra NUMBER,
  id_platforma NUMBER,
  id_autor NUMBER,
  tytul VARCHAR2(200),
  tekst VARCHAR2(200),
  tagi VARCHAR2(200),
  CONSTRAINT recenzja_pk PRIMARY KEY (id),
  CONSTRAINT recenzja_fk1 FOREIGN KEY (id_gra)
  REFERENCES GRA(id),
  CONSTRAINT recenzja_fk2 FOREIGN KEY (id_platforma)
  REFERENCES PLATFORMA(id),
  CONSTRAINT recenzja_fk3 FOREIGN KEY (id_autor)
  REFERENCES UZYTKOWNIK(uzytkownik_id)
);

create table KOMENTARZ_DO_RECENZJI (
  id NUMBER,
  id_gra NUMBER,
  id_recenzja NUMBER,
  data DATE,
  tekst VARCHAR2(200),
  CONSTRAINT KOMENTARZ_DO_RECENZJI_pk PRIMARY KEY (id),
  CONSTRAINT  KOMENTARZ_DO_RECENZJI_fk1 FOREIGN KEY (id_gra)
  REFERENCES GRA(id),
  CONSTRAINT  KOMENTARZ_DO_RECENZJI_fk2 FOREIGN KEY (id_recenzja)
  REFERENCES RECENZJA(id)
);

INSERT INTO UZYTKOWNIK (uzytkownik_id,nazwa) VALUES (1,'Tom');
INSERT INTO UZYTKOWNIK (uzytkownik_id,nazwa) VALUES (2,'John');
INSERT INTO UZYTKOWNIK (uzytkownik_id,nazwa) VALUES (3,'Tim');
INSERT INTO UZYTKOWNIK (uzytkownik_id,nazwa) VALUES (4,'Fred');
INSERT INTO UZYTKOWNIK (uzytkownik_id,nazwa) VALUES (5,'Garry');

INSERT INTO ZNAJOMOSC (id_a,id_b) VALUES (1,2);
INSERT INTO ZNAJOMOSC (id_a,id_b) VALUES (2,3);
INSERT INTO ZNAJOMOSC (id_a,id_b) VALUES (3,5);
INSERT INTO ZNAJOMOSC (id_a,id_b) VALUES (4,5);
INSERT INTO ZNAJOMOSC (id_a,id_b) VALUES (5,1);

INSERT INTO GATUNEK (id,nazwa) VALUES (1,'FPS');
INSERT INTO GATUNEK (id,nazwa) VALUES (2,'RTS');
INSERT INTO GATUNEK (id,nazwa) VALUES (3,'Platformowa');
INSERT INTO GATUNEK (id,nazwa) VALUES (4,'Przygodowa');
INSERT INTO GATUNEK (id,nazwa) VALUES (5,'Symulator');
INSERT INTO GATUNEK (id,nazwa) VALUES (6,'Sportowa');
INSERT INTO GATUNEK (id,nazwa) VALUES (7,'God Game');
INSERT INTO GATUNEK (id,nazwa) VALUES (8,'Multiplayer Online Battle Arena');
INSERT INTO GATUNEK (id,nazwa) VALUES (9,'Car Racing');
INSERT INTO GATUNEK (id,nazwa) VALUES (10,'TPP');

INSERT INTO PLATFORMA (id,nazwa) VALUES (1,'PC');
INSERT INTO PLATFORMA (id,nazwa) VALUES (2,'PS4');
INSERT INTO PLATFORMA (id,nazwa) VALUES (3,'XBox');
INSERT INTO PLATFORMA (id,nazwa) VALUES (4,'PS3');
INSERT INTO PLATFORMA (id,nazwa) VALUES (5,'Pegasus');
INSERT INTO PLATFORMA (id,nazwa) VALUES (6,'Gameboy');

INSERT INTO GRA (id,nazwa,id_gatunek,tagi) VALUES (1,'Counter Strike Global Offensive',1,'');
INSERT INTO GRA (id,nazwa,id_gatunek,tagi) VALUES (2,'Empire Earth 3',2,'');
INSERT INTO GRA (id,nazwa,id_gatunek,tagi) VALUES (3,'Flight Gear',5,'');
INSERT INTO GRA (id,nazwa,id_gatunek,tagi) VALUES (4,'FIFA 15',6,'');
INSERT INTO GRA (id,nazwa,id_gatunek,tagi) VALUES (5,'The Vanishing of Ethan Carter',4,'');
INSERT INTO GRA (id,nazwa,id_gatunek,tagi) VALUES (6,'Super Mario Bros',3,'');
INSERT INTO GRA (id,nazwa,id_gatunek,tagi) VALUES (7,'Populus',7,'');
INSERT INTO GRA (id,nazwa,id_gatunek,tagi) VALUES (8,'Counter Strike 1.6',1,'');
INSERT INTO GRA (id,nazwa,id_gatunek,tagi) VALUES (9,'League of Legends',8,'');
INSERT INTO GRA (id,nazwa,id_gatunek,tagi) VALUES (10,'Dying Light',1,'');
INSERT INTO GRA (id,nazwa,id_gatunek,tagi) VALUES (11,'Half Life',1,'');
INSERT INTO GRA (id,nazwa,id_gatunek,tagi) VALUES (12,'Portal',1,'');
INSERT INTO GRA (id,nazwa,id_gatunek,tagi) VALUES (13,'Crysis',1,'');
INSERT INTO GRA (id,nazwa,id_gatunek,tagi) VALUES (14,'Need for Speed: Most Wanted',9,'');
INSERT INTO GRA (id,nazwa,id_gatunek,tagi) VALUES (15,'Grand Theft Auto V',10,'');

INSERT INTO WYDAWCA (wydawca_id,nazwa) VALUES (null,'Valve Corporation');
INSERT INTO WYDAWCA (wydawca_id,nazwa) VALUES (null,'Techland');
INSERT INTO WYDAWCA (wydawca_id,nazwa) VALUES (null,'Cenega');
INSERT INTO WYDAWCA (wydawca_id,nazwa) VALUES (null,'Electronic Arts');
INSERT INTO WYDAWCA (wydawca_id,nazwa) VALUES (null,'Activision');
INSERT INTO WYDAWCA (wydawca_id,nazwa) VALUES (null,'Riot Games');
INSERT INTO WYDAWCA (wydawca_id,nazwa) VALUES (null,'Rockstar Games');

INSERT INTO WYDANIE_GRY (id_gra,id_wydawca,id_platforma,data) VALUES (1,1,1,TO_DATE('21-08-2012'));
INSERT INTO WYDANIE_GRY (id_gra,id_wydawca,id_platforma,data) VALUES (8,1,1,TO_DATE('01-11-2000'));
INSERT INTO WYDANIE_GRY (id_gra,id_wydawca,id_platforma,data) VALUES (9,6,1,TO_DATE('07-10-2009'));
INSERT INTO WYDANIE_GRY (id_gra,id_wydawca,id_platforma,data) VALUES (10,2,1,TO_DATE('07-10-2009'));
INSERT INTO WYDANIE_GRY (id_gra,id_wydawca,id_platforma,data) VALUES (11,1,1,TO_DATE('19-11-1998'));
INSERT INTO WYDANIE_GRY (id_gra,id_wydawca,id_platforma,data) VALUES (12,1,1,TO_DATE('10-10-2007'));
INSERT INTO WYDANIE_GRY (id_gra,id_wydawca,id_platforma,data) VALUES (13,4,1,TO_DATE('16-10-2007'));
INSERT INTO WYDANIE_GRY (id_gra,id_wydawca,id_platforma,data) VALUES (14,4,1,TO_DATE('06-12-2005'));
INSERT INTO WYDANIE_GRY (id_gra,id_wydawca,id_platforma,data) VALUES (15,7,1,TO_DATE('14-04-2015'));
INSERT INTO WYDANIE_GRY (id_gra,id_wydawca,id_platforma,data) VALUES (15,7,2,TO_DATE('18-11-2014'));
INSERT INTO WYDANIE_GRY (id_gra,id_wydawca,id_platforma,data) VALUES (15,7,3,TO_DATE('17-09-2013'));
INSERT INTO WYDANIE_GRY (id_gra,id_wydawca,id_platforma,data) VALUES (15,7,4,TO_DATE('17-09-2013'));

select GRA.NAZWA,WYDAWCA.NAZWA from GRA join WYDANIE_GRY on GRA.ID = WYDANIE_GRY.id_gra join WYDAWCA on WYDANIE_GRY.ID_WYDAWCA = WYDAWCA.WYDAWCA_ID where WYDANIE_GRY.ID_PLATFORMA=1;