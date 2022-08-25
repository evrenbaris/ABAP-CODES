*&---------------------------------------------------------------------*
*& Include          ZABAP_04_R_112_TOP
*&---------------------------------------------------------------------*

TABLES: bseg,bkpf.
CLASS lcl_main DEFINITION DEFERRED.

DATA: go_alv TYPE REF TO cl_gui_alv_grid,
      go_cont TYPE REF TO cl_gui_custom_container.

DATA: go_alv2 TYPE REF TO cl_gui_alv_grid,
      go_cont2 TYPE REF TO cl_gui_custom_container.

DATA: gt_musterı TYPE TABLE OF ZBKPF_STR_04.
DATA: gs_musterı TYPE ZBKPF_STR_04.

DATA: go_main TYPE REF TO lcl_main.

DATA  : gt_bakiye TYPE TABLE OF zbkpf_str_04_01.
DATA:
     gt_fcat    TYPE lvc_t_fcat, "field catalog 1.tablo için
     gs_fcat    TYPE lvc_s_fcat, "Structure field cat için
     gt_fcat2   TYPE lvc_t_fcat,
     gs_layout  TYPE lvc_s_layo. " layout structureı



SELECT-OPTIONS : s_bukrs FOR bkpf-bukrs,
                 s_gjahr FOR bkpf-gjahr,
                 s_kunnr FOR bseg-kunnr,
                 s_budat FOR bkpf-budat.

FIELD-SYMBOLS: <gfs_fcat> TYPE lvc_s_fcat.
FIELD-SYMBOLS: <gfs_fcat2> TYPE lvc_s_fcat.
