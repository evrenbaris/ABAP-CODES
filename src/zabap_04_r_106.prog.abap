*&---------------------------------------------------------------------*
*& Report ZABAP_04_R_106
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_04_r_106.
INCLUDE zabap_04_r_106_top.
INCLUDE zabap_04_r_106_cls.

INITIALIZATION.


AT SELECTION-SCREEN.

START-OF-SELECTION.

  CREATE OBJECT go_main .
  "main ekranda main adında global bi obje yarattık
*  go_main->main_parameters(
*  EXPORTING
*  "export ile classtaki verileri çekiyoruz ve daha önce tanımladığımız select options, parametreleri
*  "oluşturduğumuz denkliklerine atıyoruzz
*  cls_carrid = p_carrid
*  cls_connid = p_connid
*  cls_fldate = s_fdate[] ).
*
*  "The TABLES part of a function interface creates internal tables with header line at runtime.
*  "So in order to pass the entire table, instead of just one work area,
*  "you should pass s_fdate[] instead of s_fdate to the method we're calling.

  go_main->main_parametes2( ).
