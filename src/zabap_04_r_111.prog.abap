*&---------------------------------------------------------------------*
*& Report ZABAP_04_R_111
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_04_r_111.
INCLUDE zabap_04_r_111_top.
INCLUDE zabap_04_r_111_cls.
INCLUDE zabap_04_r_111_pbo.
INCLUDE zabap_04_r_111_pai.


INITIALIZATION.

CREATE OBJECT go_main.

START-OF-SELECTION.
go_main->start_of_selection( ).
