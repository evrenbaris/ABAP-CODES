*&---------------------------------------------------------------------*
*& Include          ZABAP_04_R_105_F01
*&---------------------------------------------------------------------*

FORM selectflight.

  SELECT * FROM sflight INTO TABLE lt_sflight
         WHERE carrid EQ p_carrid
         AND  connid  EQ p_connid
         AND  fldate  IN s_fdate.


  cl_demo_output=>display( lt_sflight ).


ENDFORM.
