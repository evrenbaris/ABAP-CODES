class Z_CL_EGITIM_CLASS1 definition
  public
  final
  create public .

public section.

  methods SUM_NUMBERS
    importing
      value(IV_SAYI1) type INT4 optional
      value(IV_SAYI2) type INT4 optional
    exporting
      value(SAYI1) type INT4
      value(EV_SONUC) type INT4 .
protected section.
private section.
ENDCLASS.



CLASS Z_CL_EGITIM_CLASS1 IMPLEMENTATION.


  method SUM_NUMBERS.
    ev_sonuc = iv_sayi1 + iv_sayi2.
  endmethod.
ENDCLASS.
