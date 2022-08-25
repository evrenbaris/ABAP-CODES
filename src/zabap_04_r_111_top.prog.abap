*&---------------------------------------------------------------------*
*& Include          ZABAP_04_R_111_TOP
*&---------------------------------------------------------------------*

TABLES: bkpf,bseg.
DATA: go_alv   TYPE REF TO cl_gui_alv_grid,
      go_alv2  TYPE REF TO cl_gui_alv_grid,
      go_cont  TYPE REF TO cl_gui_custom_container,
      go_cont1 TYPE REF TO cl_gui_custom_container,
      go_gui1  TYPE REF TO cl_gui_container,
*      go_grid1 TYPE REF TO cl_gui_alv_grid,
      go_gui2  TYPE REF TO cl_gui_container.
*      go_grid2 TYPE REF TO cl_gui_alv_grid.
*      go_cont1 TYPE REF TO cl_gui_custom_container.

DATA:gt_musterı TYPE TABLE OF bkpf,
     gs_musterı TYPE bkpf,
     gt_bakiye TYPE TABLE OF bseg,
     gt_fcat    TYPE lvc_t_fcat,
     gs_fcat    TYPE lvc_s_fcat,
     gt_fcat2   TYPE lvc_t_fcat,
     gs_layout  TYPE lvc_s_layo.

CLASS lcl_main DEFINITION DEFERRED.

DATA: go_main TYPE REF TO lcl_main.

DATA: gt_bkpf TYPE TABLE OF bkpf,
      gt_bseg TYPE TABLE OF bseg.


FIELD-SYMBOLS: <gfs_fcat> TYPE lvc_s_fcat.

SELECT-OPTIONS : s_bukrs FOR bkpf-bukrs,
                 s_gjahr FOR bkpf-gjahr,
                 s_kunnr FOR bseg-kunnr,
                 s_budat FOR bkpf-budat.
