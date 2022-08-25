*&---------------------------------------------------------------------*
*& Report ZABAP_04_R_110
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZABAP_04_R_110.
INCLUDE ZABAP_04_R_110_TOP.
INCLUDE ZABAP_04_R_110_CLS.
INCLUDE ZABAP_04_R_110_PBO.
INCLUDE ZABAP_04_R_110_PAI.

INITIALIZATION.

CREATE OBJECT obj_ziyaretci.

START-OF-SELECTION.
obj_ziyaretci->start_of_selection( ).
