*&---------------------------------------------------------------------*
*& Report ZABAP_04_R_108_1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZABAP_04_R_108_1.

INCLUDE zabap_04_r_108_1_top.
INCLUDE zabap_04_r_108_1_cls.

INITIALIZATION.
  CREATE OBJECT obj_araclar.
  obj_araclar->buton_isimleri( ).

AT SELECTION-SCREEN.
  obj_araclar->buton_islemler( ).

START-OF-SELECTION.
  obj_araclar->arac_goster( ).
