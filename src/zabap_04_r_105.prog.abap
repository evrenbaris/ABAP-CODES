*&---------------------------------------------------------------------*
*& Report ZABAP_04_R_105
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_04_r_105.

INCLUDE zabap_04_r_105_top.
INCLUDE zabap_04_r_105_f01.

INITIALIZATION.

  p_carrid = 'AA'.
  p_connid = '0017'.
  s_fdate-low = '20210101'.
  s_fdate-high = '20211231'.

  APPEND s_fdate.

AT SELECTION-SCREEN.

START-OF-SELECTION.

  PERFORM  selectflight.
