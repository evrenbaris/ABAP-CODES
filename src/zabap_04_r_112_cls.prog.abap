*&---------------------------------------------------------------------*
*& Include          ZABAP_04_R_112_CLS
*&---------------------------------------------------------------------*


CLASS lcl_main DEFINITION.

  PUBLIC SECTION.

    CLASS-DATA: gt_bkpf TYPE TABLE OF  bkpf,
                gt_bseg TYPE TABLE OF  bseg,
                lt_bseg TYPE TABLE OF bseg.
    METHODS: get_data,container1,container2,set_fcat,set_fcat2,start_of_selection,
      handle_hotspot_click FOR EVENT hotspot_click OF cl_gui_alv_grid
        IMPORTING e_row_id
                  e_column_id.


ENDCLASS.


CLASS lcl_main IMPLEMENTATION.
  METHOD start_of_selection.
    go_main->get_data( ).
    go_main->set_fcat( ).
    go_main->container1( ).
    CALL SCREEN 0100.
  ENDMETHOD.
  METHOD container1.
    CREATE OBJECT go_cont
      EXPORTING
        container_name = 'CC_ALV'.

    CREATE OBJECT go_alv
      EXPORTING
        i_parent = go_cont.


    CALL METHOD go_alv->set_table_for_first_display
*      EXPORTING
*        i_structure_name = 'ZBKPF_STR_04'
      CHANGING
        it_fieldcatalog = gt_fcat
        it_outtab       = gt_musterı.



  ENDMETHOD.
  METHOD container2.


    CREATE OBJECT go_cont2
      EXPORTING
        container_name = 'CC_ALV2'.

    CREATE OBJECT go_alv2
      EXPORTING
        i_parent = go_cont2.


    CALL METHOD go_alv2->set_table_for_first_display
*      EXPORTING
*        i_structure_name = 'ZBKPF_STR_04'
      CHANGING
        it_fieldcatalog = gt_fcat2
        it_outtab       = gt_bakiye.
    CALL METHOD go_alv2->refresh_table_display.

  ENDMETHOD.

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

      lv_total = lv_borc - lv_alacak.


      CLEAR ls_name.
      SELECT SINGLE * FROM kna1
        INTO ls_name
         WHERE kunnr EQ ls_bseg-kunnr.
      CONCATENATE ls_name-name1 ls_name-name2 INTO lv_name SEPARATED BY space.

      MOVE-CORRESPONDING ls_bseg TO gs_musteri.
      gs_musteri-dmbtr1 = lv_borc.
      gs_musteri-dmbtr = lv_alacak.
      gs_musteri-bakiye = lv_total.
      gs_musteri-name1 = lv_name.
      APPEND gs_musteri TO gt_musteri.
    ENDLOOP.

  ENDMETHOD.

  METHOD set_fcat.
    "field catalog : it provide the simple structure which has no value .
    "and the values are filled by different methods using alv, reuse_alv_Fieldcatalog etc
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name = 'ZBKPF_STR_04'
      CHANGING
        ct_fieldcat      = gt_fcat.

    LOOP AT gt_fcat ASSIGNING <gfs_fcat>.
      CASE <gfs_fcat>-fieldname.


        WHEN 'GJAHR'.
          <gfs_fcat>-scrtext_l = 'Mali yıl'.
          <gfs_fcat>-scrtext_m = 'Mali yıl'.
          <gfs_fcat>-scrtext_s = 'Mali yıl'.
          <gfs_fcat>-col_opt = abap_true.
          <gfs_fcat>-col_pos = 2.
        WHEN 'KUNNR'.

          <gfs_fcat>-scrtext_l = 'Müşteri Numarası'.
          <gfs_fcat>-scrtext_m = 'Müşteri Numarası'.
          <gfs_fcat>-scrtext_s = 'Müşteri Numarası'.
          <gfs_fcat>-col_opt = abap_true.
          <gfs_fcat>-col_pos = 3.

        WHEN 'NAME1'.

          <gfs_fcat>-scrtext_l = 'Müşteri Ad'.
          <gfs_fcat>-scrtext_m = 'Müşteri Adı'.
          <gfs_fcat>-scrtext_s = 'Müşteri Adı'.
          <gfs_fcat>-col_opt = abap_true.
          <gfs_fcat>-col_pos = 4.
        WHEN 'DMBTR1'.
          <gfs_fcat>-scrtext_l = 'Borç'.
          <gfs_fcat>-scrtext_m = 'Borç'.
          <gfs_fcat>-scrtext_s = 'Borç'.
          <gfs_fcat>-reptext = 'Borç'.
          <gfs_fcat>-currency = 'X'.
          <gfs_fcat>-col_opt = abap_true.
          <gfs_fcat>-col_pos = 5.

        WHEN 'DMBTR'.
          <gfs_fcat>-scrtext_l = 'Alacak'.
          <gfs_fcat>-scrtext_m = 'Alacak'.
          <gfs_fcat>-scrtext_s = 'Alacak'.
          <gfs_fcat>-reptext = 'Alacak'.
          <gfs_fcat>-col_opt = abap_true.
          <gfs_fcat>-currency = 'X'.
          <gfs_fcat>-col_pos = 6.

        WHEN 'BAKIYE'.
          <gfs_fcat>-scrtext_l = 'Bakiye'.
          <gfs_fcat>-scrtext_m = 'Bakiye'.
          <gfs_fcat>-scrtext_s = 'Bakiye'.
          <gfs_fcat>-col_opt = abap_true.
          <gfs_fcat>-currency = 'X'.
          <gfs_fcat>-reptext = 'Bakiye'.
          <gfs_fcat>-hotspot = abap_true.
          <gfs_fcat>-col_pos = 7.

        WHEN 'BELNR'.
          <gfs_fcat>-no_out = 'X'.
        WHEN 'KOART'.
          <gfs_fcat>-no_out = 'X'.
        WHEN 'KBLPOS'.
          <gfs_fcat>-no_out = 'X'.
        WHEN 'WAERS'.
          <gfs_fcat>-no_out = 'X'.
        WHEN 'SHKZG'.
          <gfs_fcat>-no_out = 'X'.

        WHEN OTHERS.
      ENDCASE.
      MODIFY gt_fcat FROM <gfs_fcat>.
    ENDLOOP.

  ENDMETHOD.

  METHOD set_fcat2.
    "field catalog : it provide the simple structure which has no value .
    "and the values are filled by different methods using alv, reuse_alv_Fieldcatalog etc
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name = 'ZBKPF_STR_04_01'
      CHANGING
        ct_fieldcat      = gt_fcat2.



    LOOP AT gt_fcat2 ASSIGNING <gfs_fcat2>.
      CASE <gfs_fcat2>-fieldname.


        WHEN 'BUKRS'.
          <gfs_fcat2>-scrtext_l = 'Şirket kodu'.
          <gfs_fcat2>-scrtext_m = 'Şirket kodu'.
          <gfs_fcat2>-scrtext_s = 'Şirket kodu'.
          <gfs_fcat2>-col_opt = abap_true.
          <gfs_fcat2>-col_pos = 1.
        WHEN 'GJAHR'.

          <gfs_fcat2>-scrtext_l = 'Mali yıl'.
          <gfs_fcat2>-scrtext_m = 'Mali yıl'.
          <gfs_fcat2>-scrtext_s = 'Mali yıl'.
          <gfs_fcat2>-col_opt = abap_true.
          <gfs_fcat2>-col_pos = 2.

        WHEN 'BELNR'.

          <gfs_fcat2>-scrtext_l = 'Belge Numarası'.
          <gfs_fcat2>-scrtext_m = 'Belge Numarası'.
          <gfs_fcat2>-scrtext_s = 'Belge Numarası'.
          <gfs_fcat2>-col_opt = abap_true.
          <gfs_fcat2>-col_pos = 3.
        WHEN 'BSCHL'.
          <gfs_fcat2>-scrtext_l = 'Kayıt anahtarı'.
          <gfs_fcat2>-scrtext_m = 'Kayıt anahtarı'.
          <gfs_fcat2>-scrtext_s = 'Kayıt anahtarı'.
          <gfs_fcat2>-reptext = 'Kayıt anahtarı'.
          <gfs_fcat2>-currency = 'X'.
          <gfs_fcat2>-col_opt = abap_true.
          <gfs_fcat2>-col_pos = 4.

        WHEN 'SHKZG'.
          <gfs_fcat2>-scrtext_l = 'Borç/alacak göstergesi'.
          <gfs_fcat2>-scrtext_m = 'Borç/alacak göstergesi'.
          <gfs_fcat2>-scrtext_s = 'Borç/alacak göstergesi'.
          <gfs_fcat2>-reptext = 'Borç/alacak göstergesi'.
          <gfs_fcat2>-col_opt = abap_true.
          <gfs_fcat2>-currency = 'X'.
          <gfs_fcat2>-col_pos = 5.

        WHEN 'KOART'.
          <gfs_fcat2>-scrtext_l = 'Hesap türü'.
          <gfs_fcat2>-scrtext_m = 'Hesap türü'.
          <gfs_fcat2>-scrtext_s = 'Hesap türü'.
          <gfs_fcat2>-col_opt = abap_true.
          <gfs_fcat2>-currency = 'X'.
          <gfs_fcat2>-reptext = 'Bakiye'.
          <gfs_fcat2>-hotspot = abap_true.
          <gfs_fcat2>-col_pos = 6.

        WHEN 'BELNR'.
          <gfs_fcat2>-no_out = 'X'.
        WHEN 'KOART'.
          <gfs_fcat2>-no_out = 'X'.
        WHEN 'KBLPOS'.
          <gfs_fcat2>-scrtext_l = 'Belge kalemi'.
          <gfs_fcat2>-scrtext_m = 'Belge kalemi'.
          <gfs_fcat2>-scrtext_s = 'Belge kalemi'.
          <gfs_fcat2>-col_opt = abap_true.
*          <gfs_fcat2>-currency = 'X'.
*          <gfs_fcat2>-reptext = 'Bakiye'.
*          <gfs_fcat2>-hotspot = abap_true.
          <gfs_fcat2>-col_pos = 7.
        WHEN 'DMBTR'.
          <gfs_fcat2>-scrtext_l = 'Tutar(tl)'.
          <gfs_fcat2>-scrtext_m = 'Tutar(tl)'.
          <gfs_fcat2>-scrtext_s = 'Tutar(tl)'.
          <gfs_fcat2>-col_opt = abap_true.
          <gfs_fcat2>-currency = 'X'.
          <gfs_fcat2>-reptext = 'Tutar(tl)'.
*          <gfs_fcat2>-hotspot = abap_true.
          <gfs_fcat2>-col_pos = 8.
        WHEN 'WAERS'.
          <gfs_fcat2>-no_out = 'X'.
        WHEN 'SHKZG'.
          <gfs_fcat2>-no_out = 'X'.

        WHEN OTHERS.
      ENDCASE.
      MODIFY gt_fcat2 FROM <gfs_fcat2>.
    ENDLOOP.

  ENDMETHOD.

  METHOD handle_hotspot_click. " TIKLAMA ICIN METOD

 refresh gt_bakiye.
    READ TABLE gt_musteri INTO DATA(ls_bseg) INDEX e_row_id-index.
    SELECT * FROM  bseg INTO CORRESPONDING FIELDS OF TABLE gt_bakiye
                 WHERE bukrs EQ ls_bseg-bukrs
                 AND   kunnr EQ ls_bseg-kunnr
                 AND   gjahr EQ ls_bseg-gjahr
       AND   koart EQ 'D'..

    CALL SCREEN 0200.
  ENDMETHOD.

ENDCLASS.
