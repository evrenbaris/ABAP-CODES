*&---------------------------------------------------------------------*
*& Include          ZABAP_04_R_109_CLS
*&---------------------------------------------------------------------*


CLASS lcl_main DEFINITION.

  PUBLIC SECTION.
    METHODS :
      gl_pbo,
      gl_pai,
      gl_start_of_selection.


  PRIVATE SECTION.
    METHODS :get_data,
      set_fcat,
      set_layout,
      set_fcat2,
      fcat_combine,
      handle_hotspot_click FOR EVENT hotspot_click OF cl_gui_alv_grid
        IMPORTING e_row_id
                  e_column_id,
      split_container,
      table_display.


ENDCLASS.

CLASS lcl_main IMPLEMENTATION.


  METHOD get_data.

    SELECT * FROM scarr
      INTO TABLE gt_scarr.



  ENDMETHOD.

  METHOD gl_start_of_selection.

    go_main->get_data( ).

    go_main->fcat_combine( ).
    go_main->set_layout( ).

    CALL SCREEN 0100.

  ENDMETHOD.


  METHOD set_fcat.
    "field catalog : it provide the simple structure which has no value .
    "and the values are filled by different methods using alv, reuse_alv_Fieldcatalog etc
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name = 'SCARR'
      CHANGING
        ct_fieldcat      = gt_fcat.

    LOOP AT gt_fcat ASSIGNING <gfs_fcat>.
      IF <gfs_fcat>-fieldname EQ 'CARRID'."istediğim satırda işlem yaptırır
        <gfs_fcat>-hotspot = abap_true.

      ENDIF.
    ENDLOOP.

    "CARRID kolonunu hotspot şeklinde yapmış olduk bu metod ile
  ENDMETHOD.
  METHOD set_fcat2.
    "field catalog : it provide the simple structure which has no value .
    "and the values are filled by different methods using alv, reuse_alv_Fieldcatalog etc
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name = 'sflight'
      CHANGING
        ct_fieldcat      = gt_fcat2.

  ENDMETHOD.

  METHOD fcat_combine.

    go_main->set_fcat( ).
    go_main->set_fcat2( ).

  ENDMETHOD.
  METHOD set_layout.
    "Layout oluşturduk
    CLEAR: gs_layout.
    gs_layout-cwidth_opt = abap_true.
    gs_layout-zebra      = abap_true.
    gs_layout-sel_mode   = abap_true.
*    gs_layout-no_toolbar = abap_true.

  ENDMETHOD.

  METHOD split_container.
    "PBO ile screen öncesi işlemleri yaptık
    CREATE OBJECT go_cont
      EXPORTING
        container_name = 'CC_ALV'.
    CREATE OBJECT go_splitter
      EXPORTING
        parent  = go_cont                  " hangi objeyi split edeceksem onu vermem gereken yer
        rows    = 2
        columns = 1.

    CALL METHOD go_splitter->get_container
      EXPORTING
        row       = 1               " Row
        column    = 1               " Column
      RECEIVING
        container = go_gui1.             " Container
    CALL METHOD go_splitter->get_container
      EXPORTING
        row       = 2               " Row
        column    = 1               " Column
      RECEIVING
        container = go_gui2.             " Container
    CREATE OBJECT go_alv
      EXPORTING
        i_parent = go_gui1.            "Ekrana basacağın alvnin hangi containerda olduğunu
    "belirtmen lazım           " Name of the Screen CustCtrl Name to Link Container To

    CREATE OBJECT go_alv2
      EXPORTING
        i_parent = go_gui2.            "Ekrana basacağın alvnin hangi containerda olduğunu
    "belirtmen lazım           " Name of the Screen CustCtrl Name to Link Container To
  ENDMETHOD.

  METHOD table_display.
    CALL METHOD go_alv->set_table_for_first_display
      EXPORTING
        is_layout       = gs_layout
      CHANGING
        it_outtab       = gt_scarr
        it_fieldcatalog = gt_fcat.

    CALL METHOD go_alv2->set_table_for_first_display
      EXPORTING
        is_layout       = gs_layout
      CHANGING
        it_outtab       = gt_sflight
        it_fieldcatalog = gt_fcat2.

    "Ekran açıldığında 2. containerda tüm verileri gösterir.
    "Hotspota tıkladığımda ilgili sütunun verileri gelecektir.
  ENDMETHOD.

  METHOD gl_pbo.

    go_main->split_container( ).
    SET HANDLER go_main->handle_hotspot_click FOR go_alv.
    go_main->table_display( ).



  ENDMETHOD.
  METHOD handle_hotspot_click. " TIKLAMA ICIN METOD
    DATA : lv_msg TYPE char200. "MESAJ ICIN DATA TANIM
    READ TABLE gt_scarr INTO gs_scarr INDEX e_row_id-index.
    "INDEX HANGI SATIRI TUTTUGUMUN VERİSİ

    IF sy-subrc EQ 0.
      CASE e_column_id .
        WHEN 'CARRID'.  "carrıd sutununa tıkladığımda
          CONCATENATE 'Tıklanan kolon'
                      e_column_id
                      'değeri'
                      gs_scarr-carrid
                      INTO lv_msg
                      SEPARATED BY space.
          MESSAGE lv_msg TYPE 'I'.

          SELECT * FROM sflight INTO TABLE gt_sflight
               WHERE carrid EQ gs_scarr-carrid.


          CALL METHOD go_alv2->refresh_table_display.
          "refresh edilen tabloyu display edecek.Her tıklamamda değişecek

      ENDCASE.
    ENDIF.

  ENDMETHOD.

  METHOD gl_pai.
    "Screen sonrası buton işlemleri
    CASE sy-ucomm. " sy-ucomm function codu tutar
      WHEN '&BACK'.
        SET SCREEN 0.
    ENDCASE.

  ENDMETHOD.


ENDCLASS.
