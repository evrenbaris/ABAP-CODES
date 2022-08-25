*&---------------------------------------------------------------------*
*& Include          ZABAP_04_R_113_CLS
*&---------------------------------------------------------------------*





CLASS lcl_main DEFINITION.

  PUBLIC SECTION.

    CLASS-DATA: gt_bkpf TYPE TABLE OF  bkpf,

                lt_bseg TYPE TABLE OF bseg.
    METHODS: get_data,
    handle_hotspot_click FOR EVENT hotspot_click OF cl_gui_alv_grid
        IMPORTING e_row_id
                  e_column_id.


ENDCLASS.


CLASS lcl_main IMPLEMENTATION.


  METHOD get_data.
    DATA lv_borc   TYPE dmbtr.
    DATA lv_alacak TYPE dmbtr.
    DATA lv_total  TYPE dmbtr.

*    DATA lv_borc   TYPE string.
*    DATA lv_alacak TYPE string.
*    DATA lv_total  TYPE string.


    DATA lv_name TYPE string.
    DATA ls_name TYPE kna1.

    SELECT * FROM bkpf INTO  TABLE gt_bkpf
             WHERE bukrs IN s_bukrs
             AND gjahr IN s_gjahr
             AND budat IN s_budat.


    SELECT * FROM bseg INTO  TABLE gt_bseg
           FOR ALL ENTRIES IN gt_bkpf
           WHERE bukrs EQ gt_bkpf-bukrs
           AND   belnr EQ gt_bkpf-belnr
           AND   gjahr EQ gt_bkpf-gjahr
           AND   kunnr IN s_kunnr
           AND   koart EQ 'D'.
    lt_bseg[] = gt_bseg[].

    SORT lt_bseg STABLE BY bukrs kunnr gjahr.
    DELETE ADJACENT DUPLICATES FROM lt_bseg COMPARING bukrs kunnr gjahr.

    LOOP AT lt_bseg INTO DATA(ls_bseg).
      CLEAR : lv_borc , lv_alacak, lv_total, lv_name, gs_musteri.
      LOOP AT gt_bseg INTO DATA(gs_bseg) WHERE bukrs EQ ls_bseg-bukrs
                                           AND kunnr EQ ls_bseg-kunnr
                                           AND gjahr EQ ls_bseg-gjahr.

        IF gs_bseg-shkzg EQ 'S'.
          lv_borc = lv_borc + gs_bseg-dmbtr.
        ENDIF.
        IF gs_bseg-shkzg EQ 'H'.
          lv_alacak = lv_alacak + gs_bseg-dmbtr.
        ENDIF.


      ENDLOOP.
      IF lv_borc LE 0.
        lv_borc = 0.
      ELSEIF lv_alacak LE 0.
        lv_alacak = 0.

      ENDIF.
      lv_total = lv_borc - lv_alacak.

      IF lv_total LE 0.
        lv_total = 0.
      ENDIF.
      CLEAR ls_name.
      SELECT SINGLE * FROM kna1
        INTO ls_name
         WHERE kunnr EQ ls_bseg-kunnr.
      CONCATENATE ls_name-name1 ls_name-name2 INTO lv_name SEPARATED BY space.

      MOVE-CORRESPONDING ls_bseg TO gs_musteri.
      gs_musteri-dmbtr = lv_borc.
      gs_musteri-dmbtr1 = lv_alacak.
      gs_musteri-bakiye = lv_total.
      gs_musteri-name1 = lv_name.
      APPEND gs_musteri TO gt_musteri.
    ENDLOOP.

  ENDMETHOD.

*  METHOD set_fcat.
*    "field catalog : it provide the simple structure which has no value .
*    "and the values are filled by different methods using alv, reuse_alv_Fieldcatalog etc
**    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
**      EXPORTING
**        i_structure_name = 'ZBKPF_STR_04'
**      CHANGING
**        ct_fieldcat      = gt_fcat.
*
*    LOOP AT gt_fcat ASSIGNING <gfs_fcat>.
*      CASE <gfs_fcat>-fieldname.
*
*
*        WHEN 'GJAHR'.
*          <gfs_fcat>-scrtext_l = 'Mali yıl'.
*          <gfs_fcat>-scrtext_m = 'Mali yıl'.
*          <gfs_fcat>-scrtext_s = 'Mali yıl'.
*          <gfs_fcat>-col_opt = abap_true.
*          <gfs_fcat>-col_pos = 2.
*        WHEN 'KUNNR'.
*
*          <gfs_fcat>-scrtext_l = 'Müşteri Numarası'.
*          <gfs_fcat>-scrtext_m = 'Müşteri Numarası'.
*          <gfs_fcat>-scrtext_s = 'Müşteri Numarası'.
*          <gfs_fcat>-col_opt = abap_true.
*          <gfs_fcat>-col_pos = 3.
*
*        WHEN 'NAME1'.
*
*          <gfs_fcat>-scrtext_l = 'Müşteri Ad'.
*          <gfs_fcat>-scrtext_m = 'Müşteri Adı'.
*          <gfs_fcat>-scrtext_s = 'Müşteri Adı'.
*          <gfs_fcat>-col_opt = abap_true.
*          <gfs_fcat>-col_pos = 4.
*        WHEN 'DMBTR1'.
*          <gfs_fcat>-scrtext_l = 'Borç'.
*          <gfs_fcat>-scrtext_m = 'Borç'.
*          <gfs_fcat>-scrtext_s = 'Borç'.
*          <gfs_fcat>-reptext = 'Borç'.
*          <gfs_fcat>-currency = 'X'.
*          <gfs_fcat>-col_opt = abap_true.
*          <gfs_fcat>-col_pos = 5.
*
*        WHEN 'DMBTR'.
*          <gfs_fcat>-scrtext_l = 'Alacak'.
*          <gfs_fcat>-scrtext_m = 'Alacak'.
*          <gfs_fcat>-scrtext_s = 'Alacak'.
*          <gfs_fcat>-reptext = 'Alacak'.
*          <gfs_fcat>-col_opt = abap_true.
*         <gfs_fcat>-currency = 'X'.
*          <gfs_fcat>-col_pos = 6.
*
*        WHEN 'BAKIYE'.
*          <gfs_fcat>-scrtext_l = 'Bakiye'.
*          <gfs_fcat>-scrtext_m = 'Bakiye'.
*          <gfs_fcat>-scrtext_s = 'Bakiye'.
*          <gfs_fcat>-col_opt = abap_true.
*          <gfs_fcat>-currency = 'X'.
*          <gfs_fcat>-reptext = 'Bakiye'.
*          <gfs_fcat>-hotspot = abap_true.
*          <gfs_fcat>-col_pos = 7.
*
*        WHEN 'BELNR'.
*          <gfs_fcat>-no_out = 'X'.
*        WHEN 'KOART'.
*          <gfs_fcat>-no_out = 'X'.
*        WHEN 'KBLPOS'.
*          <gfs_fcat>-no_out = 'X'.
*        WHEN 'WAERS'.
*          <gfs_fcat>-no_out = 'X'.
*        WHEN 'SHKZG'.
*          <gfs_fcat>-no_out = 'X'.
*
*        WHEN OTHERS.
*      ENDCASE.
*      MODIFY gt_fcat FROM <gfs_fcat>.
*    ENDLOOP.
*
*  ENDMETHOD.

METHOD handle_hotspot_click .


* CLEAR:gs_fieldcatalog2.
*          gs_fieldcatalog2-fieldname = 'GJAHR'.
*          gs_fieldcatalog2-seltext_l = 'Mali yıl'.
*          gs_fieldcatalog2-seltext_m = 'Mali yıl'.
*          gs_fieldcatalog2-seltext_s = 'Mali yıl'.
**          gs_fieldcatalog-col_opt = abap_true.
*          gs_fieldcatalog2-col_pos = 2.
*APPEND gs_fieldcatalog2 TO gt_fieldcatalog2.
*
*
*CLEAR:gs_fieldcatalog2.
*gs_fieldcatalog2-fieldname = 'KUNNR'.
*          gs_fieldcatalog2-seltext_l = 'Müşteri Numarası'.
*          gs_fieldcatalog2-seltext_m = 'Müşteri Numarası'.
*          gs_fieldcatalog2-seltext_s = 'Müşteri Numarası'.
**          gs_fieldcatalog-col_opt = abap_true.
*          gs_fieldcatalog2-col_pos = 3.
*APPEND gs_fieldcatalog2 TO gt_fieldcatalog2.
*
*
*
*CLEAR:gs_fieldcatalog2.
*          gs_fieldcatalog2-fieldname = 'NAME1'.
*          gs_fieldcatalog2-seltext_l = 'Müşteri Ad'.
*          gs_fieldcatalog2-seltext_m = 'Müşteri Adı'.
*          gs_fieldcatalog2-seltext_s = 'Müşteri Adı'.
**          gs_fieldcatalog-col_opt = abap_true.
*          gs_fieldcatalog2-col_pos = 4.
*APPEND gs_fieldcatalog2 TO gt_fieldcatalog2.
*
*
*CLEAR:gs_fieldcatalog2.
*          gs_fieldcatalog2-fieldname = 'DMBTR1'.
*          gs_fieldcatalog2-seltext_l = 'Borç'.
*          gs_fieldcatalog2-seltext_m = 'Borç'.
*          gs_fieldcatalog2-seltext_s = 'Borç'.
**          gs_fieldcatalog-reptext = 'Borç'.
*          gs_fieldcatalog2-currency = 'X'.
**          gs_fieldcatalog-col_opt = abap_true.
*          gs_fieldcatalog2-col_pos = 5.
*APPEND gs_fieldcatalog2 TO gt_fieldcatalog2.
*
*CLEAR:gs_fieldcatalog2.
*gs_fieldcatalog2-fieldname = 'DMBTR'.
*
*          gs_fieldcatalog2-seltext_l = 'Alacak'.
*          gs_fieldcatalog2-seltext_m = 'Alacak'.
*          gs_fieldcatalog2-seltext_s = 'Alacak'.
**          gs_fieldcatalog-reptext = 'Alacak'.
**          gs_fieldcatalog-col_opt = abap_true.
*          gs_fieldcatalog2-currency = 'X'.
*          gs_fieldcatalog2-col_pos = 6.
*APPEND gs_fieldcatalog2 TO gt_fieldcatalog2.
*
*
*CLEAR:gs_fieldcatalog2.
*          gs_fieldcatalog2-fieldname = 'BAKIYE'.
*          gs_fieldcatalog2-seltext_l = 'Bakiye'.
*          gs_fieldcatalog2-seltext_m = 'Bakiye'.
*          gs_fieldcatalog2-seltext_s = 'Bakiye'.
**          gs_fieldcatalog-col_opt = abap_true.
*          gs_fieldcatalog2-currency = 'X'.
**          gs_fieldcatalog-reptext = 'Bakiye'.
*          gs_fieldcatalog2-hotspot = abap_true.
*          gs_fieldcatalog-col_pos = 7.
*APPEND gs_fieldcatalog2 TO gt_fieldcatalog2.
*
*
*
*
*  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
*EXPORTING
*
*  it_fieldcat = gt_fieldcatalog2
*
*  TABLES
*    t_outtab    =  gt_bakiye.


  READ TABLE gt_bseg INTO DATA(ls_bseg) INDEX e_row_id-index.
SELECT * FROM  bseg INTO CORRESPONDING FIELDS OF TABLE gt_bakiye
             WHERE bukrs EQ ls_bseg-bukrs
             AND   belnr EQ ls_bseg-belnr
             AND   gjahr EQ ls_bseg-gjahr.
*SET HANDLER go_main->handle_hotspot_click FOR go_alv.
*  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
*EXPORTING
*
*  it_fieldcat = gt_fieldcatalog2
*
*  TABLES
*    t_outtab    =  gt_bakiye.
  ENDMETHOD.


ENDCLASS.
