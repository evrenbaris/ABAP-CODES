*&---------------------------------------------------------------------*
*& Include          ZABAP_04_R_108_1_CLS
*&---------------------------------------------------------------------*
CLASS lcl_araclar DEFINITION.
  PUBLIC SECTION.

    CLASS-DATA :lt_araclar_data TYPE TABLE OF zabap_04_t001.

    METHODS : arac_goster ,
      buton_islemler,
      buton_isimleri.


ENDCLASS.


CLASS lcl_araclar IMPLEMENTATION.

  METHOD buton_isimleri.

    button1 = 'EKLE'.
    button2 = 'SİL'.
    button3 = 'GÜNCELLE'.

  ENDMETHOD.
  METHOD arac_goster.

    SELECT * FROM zabap_04_t001
         INTO  TABLE lt_araclar
              WHERE zsase   IN s_sase
              AND   zmarka  IN s_marka
              AND   zmodel  IN s_model
              AND   zrenk   IN s_renk
              AND   zyas    IN s_yas
              AND   zfiyat  IN s_fiyat
              AND   zpbirim IN s_pbırım.

    DATA : cc_alv          TYPE REF TO cl_salv_table,
           cc_salv_display TYPE REF TO cl_salv_display_settings.
    DATA:  it_makt          TYPE STANDARD TABLE OF zabap_04_t001.
    DATA: lo_columns TYPE REF TO cl_salv_columns_table,
          lo_column  TYPE REF TO cl_salv_column_table.
    DATA: wa_color          TYPE lvc_s_colo.



    CALL METHOD cl_salv_table=>factory
      IMPORTING
        r_salv_table = cc_alv   " Basis Class Simple ALV Tables
      CHANGING
        t_table      = lt_araclar.


    cc_salv_display = cc_alv->get_display_settings(  ).
    cc_salv_display->set_list_header( 'Araç Filosu' ).

    wa_color-col    = '6'.
    lo_columns      = cc_alv->get_columns(  ).
    lo_column      ?= lo_columns->get_column('ZRENK').
    lo_column->set_color( wa_color ).

    cc_alv->display( ).

    CASE sy-ucomm.
      WHEN '&BACK'.
        LEAVE TO SCREEN 0.
    ENDCASE.
    .
  ENDMETHOD.

  METHOD buton_islemler.
    DATA :ls_araclar TYPE zabap_04_t001,
          lt_arac_db TYPE TABLE OF zabap_04_t001.

    CASE sy-ucomm.

      WHEN 'BUT1'.

        ls_araclar-zsase   = s_sase-low .
        ls_araclar-zmarka  = s_marka-low.
        ls_araclar-zmodel  = s_model-low.
        ls_araclar-zrenk   = s_renk-low.
        ls_araclar-zyas    = s_yas-low.
        ls_araclar-zfiyat  = s_fiyat-low.
        ls_araclar-zpbırım = s_pbırım-low.

          APPEND ls_araclar TO lt_araclar.
          MOVE-CORRESPONDING lt_araclar TO lt_arac_db.
          MODIFY zabap_04_t001 FROM TABLE lt_arac_db.
          MESSAGE 'EKLEME İŞLEMİ BAŞARILI' TYPE 'I'.

      WHEN 'BUT2'.

        DELETE FROM zabap_04_t001 WHERE zsase EQ s_sase-low.
        MESSAGE 'SİLME İŞLEMİ BAŞARILI' TYPE 'I'.

      WHEN 'BUT3'.
        ls_araclar-zsase   = s_sase-low  .
        ls_araclar-zmarka  = s_marka-low.
        ls_araclar-zmodel  = s_model-low.
        ls_araclar-zrenk   = s_renk-low.
        ls_araclar-zyas    = s_yas-low.
        ls_araclar-zfiyat  = s_fiyat-low.
        ls_araclar-zpbırım = s_pbırım-low.

        APPEND ls_araclar TO lt_araclar.
        MOVE-CORRESPONDING lt_araclar TO lt_arac_db.
        UPDATE zabap_04_t001 FROM TABLE lt_arac_db.
        MESSAGE 'GÜNCELLEME BAŞARILI' TYPE 'I'.

    ENDCASE.

  ENDMETHOD.
ENDCLASS.
