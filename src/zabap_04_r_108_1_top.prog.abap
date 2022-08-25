*&---------------------------------------------------------------------*
*& Include          ZABAP_04_R_108_1_TOP
*&---------------------------------------------------------------------*
TABLES: zabap_04_t001.


DATA: go_alv      TYPE REF TO cl_gui_alv_grid. "cl_gui_alv_grid classı için obje oluşturduk

CLASS lcl_araclar DEFINITION DEFERRED.

DATA: obj_araclar TYPE REF TO lcl_araclar.

DATA :lt_araclar  TYPE TABLE OF zabap_04_t001. "internal table olusturduk



DATA: go_docu TYPE REF TO cl_dd_document.


SELECT-OPTIONS : s_sase   FOR zabap_04_t001-zsase OBLIGATORY  NO INTERVALS NO-EXTENSION ,
                 s_marka  FOR zabap_04_t001-zmarka  NO INTERVALS NO-EXTENSION,
                 s_model  FOR zabap_04_t001-zmodel  NO INTERVALS NO-EXTENSION,
                 s_renk   FOR zabap_04_t001-zrenk   NO INTERVALS NO-EXTENSION,
                 s_yas    FOR zabap_04_t001-zyas    NO INTERVALS NO-EXTENSION,
                 s_fiyat  FOR zabap_04_t001-zfiyat  NO INTERVALS NO-EXTENSION,
                 s_pbırım FOR zabap_04_t001-zpbirim NO INTERVALS NO-EXTENSION.

SELECTION-SCREEN:
"Buton Tanımı
PUSHBUTTON  /1(10) button1 USER-COMMAND but1,
PUSHBUTTON  20(10) button2 USER-COMMAND but2,
PUSHBUTTON  40(10) button3 USER-COMMAND but3.
