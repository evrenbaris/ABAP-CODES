*&---------------------------------------------------------------------*
*& Include          ZABAP_04_R_112_PAI
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
CASE sy-ucomm.
  WHEN '&BACK'.
    SET SCREEN 0.
ENDCASE.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.
 CASE sy-ucomm.
 	WHEN '&BACK'.
    SET SCREEN 0.
 ENDCASE.

ENDMODULE.
