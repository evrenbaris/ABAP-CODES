*&---------------------------------------------------------------------*
*& Include          ZABAP_04_R_113_TOP
*&---------------------------------------------------------------------*


TABLES: bseg,bkpf.
TYPE-POOLS : SLIS.
CLASS lcl_main DEFINITION DEFERRED.
DATA: go_main TYPE REF TO lcl_main.
*DATA: go_alv TYPE REF TO cl_gui_alv_grid.

CLASS cl_gui_alv_grid DEFINITION LOAD.


DATA : gt_fieldcatalog TYPE SLIS_T_FIELDCAT_ALV,
       gs_fieldcatalog TYPE SLIS_FIELDCAT_ALV.

DATA : gt_fieldcatalog2 TYPE SLIS_T_FIELDCAT_ALV,
       gs_fieldcatalog2 TYPE SLIS_FIELDCAT_ALV.

DATA: gt_musterı TYPE TABLE OF ZBKPF_STR_04.
DATA: gs_musterı TYPE ZBKPF_STR_04.
DATA  : gt_bakiye TYPE TABLE OF zbkpf_str_04_01.
DATA:
     gt_fcat    TYPE lvc_t_fcat, "field catalog 1.tablo için
     gs_fcat    TYPE lvc_s_fcat, "Structure field cat için
     gt_fcat2   TYPE lvc_t_fcat,
     gs_layout  TYPE lvc_s_layo. " layout structureı
  DATA  gt_bseg TYPE TABLE OF  bseg.
*FIELD-SYMBOLS: <gfs_fcat> TYPE lvc_s_fcat.

*  FIELD-SYMBOLS: <gs_fieldcatalog> TYPE SLIS_FIELDCAT_ALV.
*   FIELD-SYMBOLS: <gs_fieldcatalog2> TYPE SLIS_FIELDCAT_ALV.

SELECT-OPTIONS : s_bukrs FOR bkpf-bukrs,
                 s_gjahr FOR bkpf-gjahr,
                 s_kunnr FOR bseg-kunnr,
                 s_budat FOR bkpf-budat.
