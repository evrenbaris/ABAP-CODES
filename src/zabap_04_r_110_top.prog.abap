*&---------------------------------------------------------------------*
*& Include          ZABAP_04_R_110_TOP
*&---------------------------------------------------------------------*



TABLES: zabap_04_t002.


TYPES BEGIN OF st_data.
INCLUDE TYPE zabap_04_t002.
TYPES celltab TYPE lvc_t_styl.
TYPES END OF st_data.

CLASS lcl_ziyaretci DEFINITION DEFERRED.

DATA: obj_ziyaretci TYPE REF TO lcl_ziyaretci.

DATA: go_alv  TYPE REF TO cl_gui_alv_grid, "cl_gui_alv_grid classı için obje oluşturduk
      go_cont TYPE REF TO cl_gui_custom_container,
      go_gui1 TYPE REF TO cl_gui_container.

DATA lt_ziyaretci    TYPE TABLE OF zabap_04_t002.


DATA ls_celltab TYPE lvc_s_styl.

DATA:gt_ziyaretci TYPE TABLE OF st_data, "scarr datalarını çekeceğiz
     gs_ziyaretci TYPE zabap_04_t002,
     gt_fcat      TYPE lvc_t_fcat, "field catalog 1.tablo için
     gs_fcat      TYPE lvc_s_fcat, "Structure field cat için
     gs_layout    TYPE lvc_s_layo. " layout structureı



SELECT-OPTIONS : s_id      FOR zabap_04_t002-z_id  ,
                 s_name    FOR zabap_04_t002-z_name  ,
                 s_srname  FOR zabap_04_t002-z_surname  ,
                 s_mail    FOR zabap_04_t002-z_mail   ,
                 s_tel     FOR zabap_04_t002-z_tel    ,
                 s_job     FOR zabap_04_t002-z_job  ,
                 s_comp    FOR zabap_04_t002-z_company .


FIELD-SYMBOLS: <gfs_fcat>   TYPE lvc_s_fcat, "referansını tablodan değil structuredan almış !!!
               <gfs_zabap>  TYPE zabap_04_t002,
               <gfs_zabap2> TYPE zabap_04_t002.
