*&---------------------------------------------------------------------*
*& Report ZABAP_04_R_103
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_04_r_103 NO STANDARD PAGE HEADING.

INCLUDE zabap_04_r_103_top.
INCLUDE zabap_04_r_103_f01.

INITIALIZATION.
  PERFORM listbox.

AT SELECTION-SCREEN.
  PERFORM kontrol.
  PERFORM ahy_renk.
  PERFORM tel_sıfır.


START-OF-SELECTION.


  CREATE OBJECT go_regex
    EXPORTING
      pattern     = '\w+(\.\w+)*@(\w+\.)+(\w{2,4})'
      ignore_case = abap_true.
  go_matcher = go_regex->create_matcher( text = p_email ).
  IF  p_email = ''.
    p_email = '---------------------'.
  ELSEIF go_matcher->match( ) IS INITIAL .
    MESSAGE 'Email Adresinizi Kontrol Ediniz!' TYPE 'I' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.


  PERFORM tablobaslık.
  PERFORM bosluk_sil.
  PERFORM alt_tablo.
