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

--Wyświetl wszystkie gry wydane pomiedzy 2000 a 2015 rokiem
--podaj ich nazwę, nazwę wydawcy, nazwę platformy i datę wydania
--posortuj wg daty wydania
select GRA.NAZWA,WYDAWCA.NAZWA as NAZWA_WYDAWCY,PLATFORMA.NAZWA as NAZWA_PLATFORMY,WYDANIE_GRY.DATA as DATA_WYDANIA from GRA
join WYDANIE_GRY on GRA.gra_id = WYDANIE_GRY.gra_id
join WYDAWCA on WYDANIE_GRY.wydawca_id = WYDAWCA.WYDAWCA_ID
join PLATFORMA on WYDANIE_GRY.platforma_id = PLATFORMA.platforma_id
where WYDANIE_GRY.DATA BETWEEN to_date('1-1-2000') and to_date('31-12-2015') order by WYDANIE_GRY.DATA;

--Wyświetl ile jest gier danego gatunku
select GATUNEK.NAZWA, count(*) as ILOSC from GATUNEK
join GRA on GATUNEK.GATUNEK_ID = GRA.GATUNEK_ID
group by GATUNEK.GATUNEK_ID, GATUNEK.NAZWA
order by ILOSC DESC;

--wyświetl najnowszą grę (Wydaną najpóźniej)
select NAZWA_GRY,NAZWA_WYDAWCY,NAZWA_PLATFORMY,DATA_WYDANIA from
(select GRA.NAZWA as NAZWA_GRY,WYDAWCA.NAZWA as NAZWA_WYDAWCY,PLATFORMA.NAZWA as NAZWA_PLATFORMY,WYDANIE_GRY.DATA as DATA_WYDANIA from GRA
join WYDANIE_GRY on GRA.gra_id = WYDANIE_GRY.gra_id
join WYDAWCA on WYDANIE_GRY.wydawca_id = WYDAWCA.WYDAWCA_ID
join PLATFORMA on WYDANIE_GRY.platforma_id = PLATFORMA.platforma_id
order by WYDANIE_GRY.DATA DESC) where rownum = 1;

--wyświetl najstarsz grę (Wydaną najwcześniej)
select NAZWA_GRY,NAZWA_WYDAWCY,NAZWA_PLATFORMY,DATA_WYDANIA from
(select GRA.NAZWA as NAZWA_GRY,WYDAWCA.NAZWA as NAZWA_WYDAWCY,PLATFORMA.NAZWA as NAZWA_PLATFORMY,WYDANIE_GRY.DATA as DATA_WYDANIA from GRA
join WYDANIE_GRY on GRA.gra_id = WYDANIE_GRY.gra_id
join WYDAWCA on WYDANIE_GRY.wydawca_id = WYDAWCA.WYDAWCA_ID
join PLATFORMA on WYDANIE_GRY.platforma_id = PLATFORMA.platforma_id
order by WYDANIE_GRY.DATA ASC) where rownum = 1;

--wyswietl użytkowników którzy napisali najwięcej poradników
--posortuj po ilości poradników
select UZYTKOWNIK.NAZWA as NAZWA_UZYTKOWNIKA, count (*) as ILOSC_PORADNIKOW
from UZYTKOWNIK
join PORADNIK_DO_GRY on UZYTKOWNIK.UZYTKOWNIK_ID = PORADNIK_DO_GRY.UZYTKOWNIK_ID
group by UZYTKOWNIK.UZYTKOWNIK_ID, UZYTKOWNIK.NAZWA
order by ILOSC_PORADNIKOW DESC;

--Wyswietle ile dany wydawca wydał gier na daną platforme
select WYDAWCA.NAZWA as NAZWA_W, PLATFORMA.NAZWA as NAZWA_P, count(*) as ILOSC from WYDAWCA
join WYDANIE_GRY on WYDANIE_GRY.WYDAWCA_ID  = WYDAWCA.WYDAWCA_ID
join PLATFORMA on PLATFORMA.PLATFORMA_ID = WYDANIE_GRY.PLATFORMA_ID
group by WYDAWCA.NAZWA, PLATFORMA.NAZWA
order by ILOSC DESC;
