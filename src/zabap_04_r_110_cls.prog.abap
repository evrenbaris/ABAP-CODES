*&---------------------------------------------------------------------*
*& Include          ZABAP_04_R_110_CLS
*&---------------------------------------------------------------------*

CLASS lcl_ziyaretci DEFINITION.
  PUBLIC SECTION.


    CLASS-DATA :ls_ziyaretci  TYPE zabap_04_t002,
                lt_ziyaretci2 TYPE TABLE OF zabap_04_t002,
                mt_sel_rows2  TYPE lvc_t_roid,
                mt_sel_rows   TYPE lvc_t_row.



    METHODS :
      pbo,
      pai,
      start_of_selection.

  PRIVATE SECTION.

    METHODS :get_data,
      table_display,
      set_fcat,
      container,
      set_layout,
      add_row,
      delete_row,
      save_row,

      handle_toolbar FOR EVENT toolbar OF cl_gui_alv_grid  IMPORTING
                                                             e_object
                                                             e_interactive,
      handle_user_command FOR EVENT user_command OF cl_gui_alv_grid
        IMPORTING
          e_ucomm sender.

ENDCLASS.

CLASS lcl_ziyaretci IMPLEMENTATION.

  METHOD get_data.

    SELECT * FROM zabap_04_t002
     INTO CORRESPONDING FIELDS OF TABLE gt_ziyaretci
          WHERE z_id       IN s_id
          AND   z_name     IN s_name
          AND   z_surname  IN s_srname
          AND   z_mail     IN s_mail
          AND   z_tel      IN s_tel
          AND   z_job      IN s_job
          AND   z_company  IN s_comp.



    LOOP AT gt_ziyaretci ASSIGNING FIELD-SYMBOL(<fs_item>).
      DATA ls_celltab TYPE lvc_s_styl.
      CLEAR <fs_item>-celltab[].
      IF <fs_item>-z_name IS NOT INITIAL AND <fs_item>-z_surname IS NOT INITIAL.
        ls_celltab-fieldname = 'Z_NAME'.
        ls_celltab-style     = cl_gui_alv_grid=>mc_style_disabled.
        APPEND ls_celltab TO <fs_item>-celltab.

        ls_celltab-fieldname = 'Z_SURNAME'.
        ls_celltab-style     = cl_gui_alv_grid=>mc_style_disabled.
        APPEND ls_celltab TO <fs_item>-celltab.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD add_row.

    DATA :ls_ziyaretci  LIKE LINE OF gt_ziyaretci, "TYPE zabap_04_t002,
          lt_ziyaretci2 TYPE TABLE OF zabap_04_t002.
    DATA: lv_zid    TYPE numc10.
    CLEAR lv_zid.

    CALL FUNCTION 'NUMBER_GET_NEXT'
      EXPORTING
        nr_range_nr             = '01'
        object                  = 'ZZ_04_001'
      IMPORTING
        number                  = lv_zid
      EXCEPTIONS
        interval_not_found      = 1
        number_range_not_intern = 2
        object_not_found        = 3
        quantity_is_0           = 4
        quantity_is_not_1       = 5
        interval_overflow       = 6
        buffer_overflow         = 7
        OTHERS                  = 8.
    SHIFT lv_zid LEFT DELETING LEADING '0'.

    ls_ziyaretci-z_id    = lv_zid.
    APPEND ls_ziyaretci             TO gt_ziyaretci.
    MOVE-CORRESPONDING gt_ziyaretci TO lt_ziyaretci2.
    MODIFY zabap_04_t002            FROM TABLE lt_ziyaretci2.



  ENDMETHOD.

  METHOD delete_row.

    DATA: ls_row TYPE lvc_s_row,
          ans    TYPE char1.

    CALL FUNCTION 'POPUP_TO_CONFIRM'
      EXPORTING
        titlebar              = 'UYARI!'
*       DIAGNOSE_OBJECT       = ' '
        text_question         = 'Silinsin Mi?'
        text_button_1         = 'EVET'(001)
        icon_button_1         = 'ICON_CHECKED '
        text_button_2         = 'HAYIR'(002)
        icon_button_2         = 'ICON_CANCEL '
*       DEFAULT_BUTTON        = '1'
        display_cancel_button = ''
*       USERDEFINED_F1_HELP   = ' '
*       START_COLUMN          = 25
*       START_ROW             = 6
        popup_type            = 'ICON_MESSAGE_ERROR'
*       IV_QUICKINFO_BUTTON_1 = ' '
*       IV_QUICKINFO_BUTTON_2 = ' '
      IMPORTING
        answer                = ans.

    IF ans = 1.

      SORT mt_sel_rows  BY index DESCENDING.

      LOOP AT lcl_ziyaretci=>mt_sel_rows INTO ls_row.

        READ TABLE gt_ziyaretci INTO DATA(gs_ziyaretci) INDEX ls_row-index.


        DELETE FROM zabap_04_t002 WHERE z_id = gs_ziyaretci-z_id.
        DELETE gt_ziyaretci INDEX ls_row-index.

      ENDLOOP.
    ELSE.
      LEAVE SCREEN.
    ENDIF.
    go_alv->refresh_table_display( ).

  ENDMETHOD.


  METHOD start_of_selection.

    obj_ziyaretci->get_data( ).

    obj_ziyaretci->set_fcat( ).
    obj_ziyaretci->set_layout( ).

    CALL SCREEN 0100.

  ENDMETHOD.


  METHOD set_fcat.

    "field catalog : it provide the simple structure which has no value .
    "and the values are filled by different methods using alv, reuse_alv_Fieldcatalog etc
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name = 'ZABAP_04_T002'
      CHANGING
        ct_fieldcat      = gt_fcat.


    LOOP AT gt_fcat ASSIGNING FIELD-SYMBOL(<gs_fcat>).

      CASE <gs_fcat>-fieldname.
        WHEN 'Z_NAME'.

          <gs_fcat>-edit       = abap_true.

        WHEN 'Z_SURNAME'.
          <gs_fcat>-edit       = abap_true.

        WHEN 'Z_MAIL'.
          <gs_fcat>-edit       = abap_true.

        WHEN 'Z_TEL'.
          <gs_fcat>-edit       = abap_true.


        WHEN 'Z_JOB'.
          <gs_fcat>-edit       = abap_true.
          <gs_fcat>-f4availabl = 'X'.
          <gs_fcat>-ref_table  = 'ZABAP_04_T002'.
          <gs_fcat>-ref_field  = 'Z_JOB'.

*           <gs_fcat>-style = cl_gui_alv_grid->
        WHEN 'Z_COMPANY'.
          <gs_fcat>-edit       = abap_true.
          <gs_fcat>-f4availabl = 'X'.
          <gs_fcat>-ref_table  = 'ZABAP_04_T002'.
          <gs_fcat>-ref_field  = 'Z_COMPANY'.
      ENDCASE.
    ENDLOOP.

  ENDMETHOD.


  METHOD set_layout.
    gs_layout-cwidth_opt = abap_true.
    gs_layout-zebra      = abap_true.
    gs_layout-sel_mode   = abap_true.
    gs_layout-stylefname = 'CELLTAB'.
*    gs_layout-edit       = abap_true .
*    gs_layout-no_toolbar = abap_true.

  ENDMETHOD.

  METHOD container.

    CREATE OBJECT go_cont
      EXPORTING
        container_name = 'CC_ALV'.
    CREATE OBJECT go_alv
      EXPORTING
        i_parent = go_gui1.

    obj_ziyaretci->table_display( ).



  ENDMETHOD.
  METHOD handle_toolbar.

    DATA:ls_toolbar TYPE stb_button.
    CLEAR ls_toolbar.
    ls_toolbar-function = '&DEL'.
    ls_toolbar-text = 'Silme'.
    ls_toolbar-icon ='@11@'.
    ls_toolbar-quickinfo = 'Silme İşlemi'.

    APPEND ls_toolbar TO e_object->mt_toolbar.

    CLEAR ls_toolbar.
    ls_toolbar-function = '&ADD'.
    ls_toolbar-text = 'Ekleme'.
    ls_toolbar-icon ='@04@'.
    ls_toolbar-quickinfo = 'Ekleme İşlemi'.

    APPEND ls_toolbar TO e_object->mt_toolbar.


  ENDMETHOD.
  METHOD save_row.
    CALL METHOD go_alv->check_changed_data.

    LOOP AT gt_ziyaretci ASSIGNING FIELD-SYMBOL(<fs_item>).
      IF      <fs_item>-z_name     IS INITIAL
          OR  <fs_item>-z_surname  IS INITIAL.

        MESSAGE ' Lütfen AD ve SOYAD Alanlarını Doldurunuz  ' TYPE 'I' DISPLAY LIKE 'S'.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD handle_user_command.

    CALL METHOD sender->get_selected_rows
      IMPORTING
        et_index_rows = mt_sel_rows
        et_row_no     = mt_sel_rows2.
    CASE e_ucomm.

      WHEN '&DEL'.

        obj_ziyaretci->delete_row( ).

      WHEN '&ADD'.

        obj_ziyaretci->add_row( ).
*        MESSAGE 'Ekleme İşlemi' TYPE 'I'.

    ENDCASE.
    CALL METHOD go_alv->refresh_table_display.

  ENDMETHOD.
  METHOD table_display.
*    SET HANDLER obj_ziyaretci->handle_on_f4        FOR go_alv.
    SET HANDLER obj_ziyaretci->handle_toolbar      FOR go_alv.
    SET HANDLER obj_ziyaretci->handle_user_command FOR go_alv.

    CALL METHOD go_alv->set_table_for_first_display
      EXPORTING
        is_layout       = gs_layout
      CHANGING
        it_outtab       = gt_ziyaretci
        it_fieldcatalog = gt_fcat.

    CALL METHOD go_alv->register_edit_event
      EXPORTING
        i_event_id = cl_gui_alv_grid=>mc_evt_modified.

  ENDMETHOD.

  METHOD pbo.

    obj_ziyaretci->container( ).

  ENDMETHOD.

  METHOD pai.
    "Screen sonrası buton işlemleri
    CASE sy-ucomm. " sy-ucomm function codu tutar
      WHEN '&BACK'.
        SET SCREEN 0.
      WHEN '&SAVE'.
        obj_ziyaretci->save_row( ).
*        obj_ziyaretci->name_display( ).

        MOVE-CORRESPONDING gt_ziyaretci TO lt_ziyaretci2.
        MODIFY zabap_04_t002 FROM TABLE lt_ziyaretci2.


    ENDCASE.

  ENDMETHOD.
ENDCLASS.
