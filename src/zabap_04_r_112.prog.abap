*&---------------------------------------------------------------------*
*& Report ZABAP_04_R_112
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZABAP_04_R_112.
INCLUDE zabap_04_r_112_top.
INCLUDE zabap_04_r_112_cls.
INCLUDE zabap_04_r_112_pbo.
INCLUDE zabap_04_r_112_pai.


INITIALIZATION.

create OBJECT go_main.
START-OF-SELECTION.
go_main->start_of_selection( ).
