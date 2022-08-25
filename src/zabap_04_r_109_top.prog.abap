*&---------------------------------------------------------------------*
*& Include          ZABAP_04_R_109_TOP
*&---------------------------------------------------------------------*

TABLES sflight .

CLASS lcl_main DEFINITION DEFERRED.

DATA: go_main  TYPE REF TO lcl_main.

*Grid classı için 2 obje oluşturduk(2 ayrı tablomuz var)
DATA: go_alv  TYPE REF TO cl_gui_alv_grid.
DATA: go_alv2 TYPE REF TO cl_gui_alv_grid.

"cl_gui_alv_grid bir class ve ona obje olusturduk.
"Container olusturduk ve bunu 2 Row'a böldük
DATA: go_cont TYPE REF TO cl_gui_custom_container,
      go_gui1 TYPE REF TO cl_gui_container,
      go_gui2 TYPE REF TO cl_gui_container.

"containera ait bir obje tanımlamış oldum.
DATA:go_splitter  TYPE REF TO cl_gui_splitter_container.

DATA:gt_scarr   TYPE TABLE OF scarr, "scarr datalarını çekeceğiz
     gs_scarr   TYPE scarr,
     gt_sflight TYPE TABLE OF sflight, " sflight datalarını çekeceğiz
     gt_fcat    TYPE lvc_t_fcat, "field catalog 1.tablo için
     gt_fcat2   TYPE lvc_t_fcat, "field catalog 2.tablo için
     gs_fcat    TYPE lvc_s_fcat, "Structure field cat için
     gs_layout  TYPE lvc_s_layo. " layout structureı

FIELD-SYMBOLS: <gfs_fcat> TYPE lvc_s_fcat. "referansını tablodan değil structuredan almış !!!
