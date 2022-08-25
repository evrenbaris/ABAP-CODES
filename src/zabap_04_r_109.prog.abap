*&---------------------------------------------------------------------*
*& Report ZABAP_04_R_109
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_04_r_109.
INCLUDE zabap_04_r_109_top. " Değişkenlerimi tanımlarım
INCLUDE zabap_04_r_109_cls. "Object Oriented Mantık
INCLUDE zabap_04_r_109_pbo. " Screen için modullerimi topladığım yer
INCLUDE zabap_04_r_109_pai. "Butonları yakaladığım yer

"OO ALV 'nin diğer ALVlerden farkı SCREEN üzerinde çalışmasıdır.

INITIALIZATION.

  CREATE OBJECT go_main.

START-OF-SELECTION.

  go_main->gl_start_of_selection( ).
