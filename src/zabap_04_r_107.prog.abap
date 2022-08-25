*&---------------------------------------------------------------------*
*& Report ZABAP_04_R_107

REPORT ZABAP_04_R_107.

INCLUDE zabap_04_r_107_top.
INCLUDE zabap_04_r_107_cls.

INITIALIZATION.
p_curren = 'USD'.

AT SELECTION-SCREEN.

START-OF-SELECTION.

  CREATE OBJECT go_main .
  "main ekranda main adında global bi obje yarattık
  go_main->main_parameters(
*  EXPORTING
*  "export ile classtaki verileri çekiyoruz ve daha önce tanımladığımız select options, parametreleri
*  "oluşturduğumuz denkliklerine atıyoruzz
  cls_carrid = p_carrid
  cls_connid = p_connid
  cls_price = p_price
  "Ödev 6 ya ekstra olarak price ve currency ekledik
  cls_curren = p_curren
  cls_fldate = s_fdate[] ).
*
*  "The TABLES part of a function interface creates internal tables with header line at runtime.
*  "So in order to pass the entire table, instead of just one work area,
*  "you should pass s_fdate[] instead of s_fdate to the method we're calling.

  go_main->update_sflight( cls_price = p_price ).
  " değerleri update ederiz
  go_main->display_message( ).
  "update edilmiş değerlerle tekrar ekrana bastırırız.
