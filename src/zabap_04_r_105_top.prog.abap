*&---------------------------------------------------------------------*
*& Include          ZABAP_04_R_105_TOP
*&---------------------------------------------------------------------*
TABLES sflight.
* FOR kullandığında TABLE eklemeyi unutma !

DATA lt_sflight TYPE  TABLE OF sflight.

PARAMETERS : p_carrid TYPE sflight-carrid,
             p_connid TYPE sflight-connid.

SELECT-OPTIONS : s_fdate FOR sflight-fldate.
