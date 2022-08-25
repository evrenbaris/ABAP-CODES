class Z_CL_EGITIM_CLASS2 definition
  public
  final
  create public .

public section.

  types NUMBER_TYP type INT4 .

  constants CV_NUMBER type NUMBER_TYP value 100 ##NO_TEXT.

  methods SUM_NUMBERS
    importing
      value(IV_SAYI1) type INT4 optional
      value(IV_SAYI2) type INT4 optional
    exporting
      !EV_SONUC type INT4 .
*  class-methods SUM_NUMBERS .
protected section.
private section.

  methods SUM_NUMBERS_PRIVATE
    importing
      value(IV_SAYI1) type INT4 optional
      value(IV_SAYI2) type INT4 optional
    exporting
      !EV_SONUC type INT4 .
ENDCLASS.



CLASS Z_CL_EGITIM_CLASS2 IMPLEMENTATION.


  method SUM_NUMBERS.
    ev_sonuc = iv_sayi1 + iv_sayi2 + cv_number.
  endmethod.


  method SUM_NUMBERS_PRIVATE.
    ev_sonuc = iv_sayi1 + iv_sayi2 + cv_number.
  endmethod.
ENDCLASS.
