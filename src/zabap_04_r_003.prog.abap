*&---------------------------------------------------------------------*
*& Report ZABAP_04_R_003
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_04_r_003.
*class oluştururuz ve içindeki metodları işlevine göre 1 er kere yazıp
*istediğimiz her yerde kullanabiliriz
*class oluşturmak için se24 'e girmen lazım
DATA: go_egitim_class TYPE REF TO z_cl_egitim_class2.
DATA: gv_sayi1 TYPE int4.
DATA: gv_sayi2 TYPE int4.
DATA: gv_sonuc TYPE int4.

INITIALIZATION.

  CREATE OBJECT go_egitim_class.

START-OF-SELECTION.

  gv_sayi1 = 10.
  gv_sayi2 = 12.
  go_egitim_class->sum_numbers(
    EXPORTING
      iv_sayi1 =  gv_sayi1                " 4 bayt işaretli tamsayı
      iv_sayi2 =  gv_sayi2                " 4 bayt işaretli tamsayı
    IMPORTING
      ev_sonuc =   gv_sonuc               " 4 bayt işaretli tamsayı
  ).

  WRITE : gv_sonuc.
