*&---------------------------------------------------------------------*
*& Report ZABAP_04_R_001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_04_r_001.

**Temel giriş ve veri türleri
*DATA gv_degis1 TYPE p DECIMALS 2.
**akıllı kod mantığını kullandık P decimal temsil ediyor
**2 ise ilk 2 karakterden dolayı
*DATA gv_degis2 TYPE int4.
*DATA gv_degis3 TYPE n.
*DATA gv_degis4 TYPE c.
*DATA gv_degis5 TYPE string.
*
*gv_degis1 = '12.54'.
*gv_degis1 = '40.54123'.
*gv_degis2 = 123.
*gv_degis2 = 12321312.
*
*gv_degis3 = 630.
*gv_degis4 = 'A'.
*gv_degis4 = 'b'.
*gv_degis5 = 'Cümle '.
*
*DATA gv_degis6 TYPE i.
*DATA gv_degis7 TYPE n LENGTH 10.
**N KULLANIYORSAK KAC BASAMAKLI OLMASINI İSTİYOSAK UZUNLUK ONA GÖRE
**integer ifadeler başında 0 ile gelir

*IF kosul.
*
*ENDIF.

*CASE gv_degis1.
*  WHEN 1.
*    WRITE 'DEGISKEN DEGERIM 1'.
*  WHEN 2.
*    WRITE 'DEGISKEN DEGERIM 2'.
*  WHEN OTHERS.
*    WRITE 'DEGISKEN DEGERIM YOK'.
*ENDCASE.
DATA gv_degis1 TYPE i.
*gv_degis1 = 0.
*DO 10 TIMES.
*  gv_degis1 =  gv_degis1 + 1.
*  WRITE : / gv_degis1 , 'DO OGRENIYORUZ'.
*
*ENDDO.

WHILE gv_degis1 < 10.
gv_degis1 =  gv_degis1 + 1.
 WRITE : / gv_degis1 , 'DO OGRENIYORUZ'.
ENDWHILE.
