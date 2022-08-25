*&---------------------------------------------------------------------*
*& Report ZABAP_04_R_102
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZABAP_04_R_102 NO STANDARD PAGE HEADING.

INCLUDE ZABAP_04_R_102_top.

ULINE AT 19(22).
WRITE  AT /19  '|' INTENSIFIED COLOR = 3.
WRITE  AT 20  'Personel Bilgi Formu' INTENSIFIED COLOR = 6.
WRITE  AT 40 '|' INTENSIFIED COLOR = 3.
ULINE AT /19(22).


ULINE AT /0(75).

WRITE:/0 '|' INTENSIFIED COLOR = 6,'   AD   ' INTENSIFIED COLOR = 6,
'   |'INTENSIFIED COLOR = 6,'   SOYAD  ' INTENSIFIED COLOR = 4,'|','  TELEFON  ' INTENSIFIED COLOR = 1,
'|','  EMAIL                       ' INTENSIFIED COLOR = 2,'|' .
ULINE AT /0(75).
WRITE:/0 '|',  p_ad,'| ',p_soyad,'    |',p_tel,'  |',p_mail,'    |'.
ULINE AT /0(75).
