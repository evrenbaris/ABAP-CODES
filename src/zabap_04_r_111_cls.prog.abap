*&---------------------------------------------------------------------*
*& Include          ZABAP_04_R_111_CLS
*&---------------------------------------------------------------------*

CLASS lcl_main DEFINITION.
  PUBLIC SECTION.
    CLASS-DATA : gv_ucom   TYPE sy-ucomm,
                 gt_bseg   TYPE TABLE OF  bseg,
                 gt_bakiye TYPE TABLE OF  bseg,
                 gt_bkpf   TYPE TABLE OF  bkpf.



    METHODS       : start_of_selection,
      pbo1,
      pbo.

  PRIVATE SECTION.


    METHODS       : get_data    RETURNING VALUE(rv_subrc)         TYPE sy-subrc,
      table_display,
      set_fcat,
      set_fcat2,
      fcat_combine,
*      create_fcat       IMPORTING iv_st_name     TYPE dd02l-tabname
*                        RETURNING VALUE(rt_fcat) TYPE lvc_t_fcat,
**      create_alv1,
*      create_alv2,
      set_layout,
*
*      set_table1        IMPORTING iv_tabname TYPE dd02l-tabname
*                                  iv_strname TYPE dd02l-tabname
*                                  io_grid    TYPE REF TO cl_gui_alv_grid,
*
*      set_table2        IMPORTING iv_tabname TYPE dd02l-tabname
*                                  iv_strname TYPE dd02l-tabname
*                                  io_grid    TYPE REF TO cl_gui_alv_grid,

      set_hotspot   IMPORTING it_fcat        TYPE lvc_t_fcat
                              iv_field       TYPE lvc_fname
                    RETURNING VALUE(rt_fcat) TYPE lvc_t_fcat,


      hotspot_click    FOR EVENT       hotspot_click     OF cl_gui_alv_grid
        IMPORTING e_row_id,
*      container1,
      container.



ENDCLASS.


CLASS lcl_main IMPLEMENTATION.
  METHOD get_data.

    SELECT * FROM bkpf INTO CORRESPONDING FIELDS OF TABLE gt_musterı
             WHERE bukrs IN s_bukrs
             AND gjahr IN s_gjahr
             AND budat IN s_budat.

    SELECT * FROM bseg INTO CORRESPONDING FIELDS OF TABLE gt_bseg
             FOR ALL ENTRIES IN gt_musterı
             WHERE bukrs EQ gt_musterı-bukrs
             AND   belnr EQ gt_musterı-belnr
             AND   gjahr EQ gt_musterı-gjahr
             AND   kunnr IN s_kunnr
             AND   koart EQ 'D'.



  ENDMETHOD.
  METHOD start_of_selection.
    go_main->get_data( ).
    go_main->fcat_combine( ).
    go_main->set_layout( ).
    CALL SCREEN 0100.

  ENDMETHOD.

  METHOD fcat_combine.
    go_main->set_fcat( ).
    go_main->set_fcat2( ).


    ENDMETHOD.
  METHOD pbo.

    go_main->container( ).
    SET HANDLER go_main->hotspot_click FOR go_alv.
    go_main->table_display( ).
  ENDMETHOD.
  METHOD pbo1.
  go_main->container( ).
*    go_main->container1( ).

  go_main->table_display( ).
  ENDMETHOD.

  METHOD container.

    CREATE OBJECT go_cont
      EXPORTING
        container_name = 'CC_ALV'.
    CREATE OBJECT go_alv
      EXPORTING
        i_parent = go_gui1.

*    go_main->create_alv1( ).

     CREATE OBJECT go_alv2
      EXPORTING
        i_parent = go_gui2.

*  go_main->create_alv2( ).
  ENDMETHOD.


*  METHOD container1.
*
*    CREATE OBJECT go_cont1
*      EXPORTING
*        container_name = 'CC_ALV'.
*    CREATE OBJECT go_alv
*      EXPORTING
*        i_parent = go_gui2.
**
**    go_main->table_display( ).
*    go_main->create_alv2( ).
*  ENDMETHOD.
  METHOD table_display.
*    SET HANDLER obj_ziyaretci->handle_on_f4        FOR go_alv.
*    SET HANDLER go_main->handle_toolbar      FOR go_alv.
*    SET HANDLER go_main->handle_user_command FOR go_alv.

    CALL METHOD go_alv->set_table_for_first_display
      EXPORTING
        is_layout       = gs_layout
      CHANGING
        it_outtab       = gt_musterı
        it_fieldcatalog = gt_fcat.

  CALL METHOD go_alv2->set_table_for_first_display
      EXPORTING
        is_layout       = gs_layout
      CHANGING
        it_outtab       = gt_bseg
        it_fieldcatalog = gt_fcat2.

*    CALL METHOD go_alv->register_edit_event
*      EXPORTING
*        i_event_id = cl_gui_alv_grid=>mc_evt_modified.


  ENDMETHOD.


  METHOD set_fcat.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name = 'BKPF'
      CHANGING
        ct_fieldcat      = gt_fcat.


       LOOP AT gt_fcat ASSIGNING <gfs_fcat>.
      IF <gfs_fcat>-fieldname EQ 'BUKRS'."istediğim satırda işlem yaptırır
        <gfs_fcat>-hotspot = abap_true.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD set_fcat2.
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name = 'BSEG'
      CHANGING
        ct_fieldcat      = gt_fcat2.


    ENDMETHOD.


  METHOD set_layout.
    gs_layout-cwidth_opt = abap_true.
    gs_layout-zebra      = abap_true.
    gs_layout-sel_mode   = abap_true.
  ENDMETHOD.

*  METHOD create_alv1.
*
*    CHECK go_alv IS BOUND.
*
*    go_main->set_table1(
*      EXPORTING
*        iv_tabname = 'ME->GT_BSEG'
*        iv_strname = 'BKPF'
*        io_grid    = go_alv ).
*
*  ENDMETHOD.
*
*  METHOD create_alv2.
*
*    CHECK go_alv2 IS BOUND.
*
*    me->set_table2(
*      EXPORTING
*        iv_tabname = 'GT_BAKIYE'
*        iv_strname = 'BSEG'
*        io_grid    = go_alv2 ).
*
*  ENDMETHOD.


*  METHOD set_table1.
*
*    ASSIGN (iv_tabname) TO FIELD-SYMBOL(<fs_tab>).
*
*
*    DATA(lt_fcat)    = me->create_fcat( iv_strname ).
*    DATA ls_variant TYPE disvariant .
*
*    lt_fcat = me->set_hotspot(
*                it_fcat  = lt_fcat
*                iv_field = 'BUKRS'
*              ).
*
*    ls_variant-report   = sy-repid.
*    ls_variant-username = sy-uname.
*
*    CALL METHOD io_grid->set_table_for_first_display
*      EXPORTING
*        is_variant                    = ls_variant
*        i_save                        = 'A'
*      CHANGING
*        it_outtab                     = <fs_tab>
*        it_fieldcatalog               = lt_fcat[]
*      EXCEPTIONS
*        invalid_parameter_combination = 1
*        program_error                 = 2
*        too_many_lines                = 3
*        OTHERS                        = 4.
*    IF sy-subrc <> 0.
*
*    ENDIF.
*
*    SET HANDLER me->hotspot_click FOR io_grid.
*    CALL METHOD io_grid->set_toolbar_interactive.
*
*
*  ENDMETHOD.
*
*
*  METHOD set_table2.
*
*    ASSIGN (iv_tabname) TO FIELD-SYMBOL(<fs_tab>).
*
*    DATA(lt_fcat)    = me->create_fcat( iv_strname ).
*    DATA ls_variant TYPE disvariant .
*
*    ls_variant-report   = sy-repid.
*    ls_variant-username = sy-uname.
*
*
*    CALL METHOD io_grid->set_table_for_first_display
*      EXPORTING
*        is_variant                    = ls_variant
*        i_save                        = 'D'
*      CHANGING
*        it_outtab                     = <fs_tab>
*        it_fieldcatalog               = lt_fcat[]
*      EXCEPTIONS
*        invalid_parameter_combination = 1
*        program_error                 = 2
*        too_many_lines                = 3
*        OTHERS                        = 4.
*    IF sy-subrc <> 0.
*
*    ENDIF.
*
*    SET HANDLER me->hotspot_click FOR io_grid.
*    CALL METHOD io_grid->set_toolbar_interactive.
*
*  ENDMETHOD.




*  METHOD create_fcat.
*    DATA ls_fcat TYPE lvc_s_fcat.
*    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
*      EXPORTING
*        i_structure_name       = iv_st_name
*      CHANGING
*        ct_fieldcat            = rt_fcat
*      EXCEPTIONS
*        inconsistent_interface = 1
*        program_error          = 2.
*    IF sy-subrc <> 0.
*      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
*    ENDIF.
*
*    LOOP AT rt_fcat INTO ls_fcat.
*
*      CASE ls_fcat-fieldname.
*        WHEN 'DMBTR'.
*          ls_fcat-scrtext_l = 'Alacak'.
*          ls_fcat-scrtext_m = 'Alacak'.
*          ls_fcat-scrtext_s = 'Alacak'.
*          ls_fcat-col_opt = abap_true.
*
*        WHEN 'DMBTR1'.
*          ls_fcat-scrtext_l = 'Borç'.
*          ls_fcat-scrtext_m = 'Borç'.
*          ls_fcat-scrtext_s = 'Borç'.
*          ls_fcat-col_opt = abap_true.
*        WHEN OTHERS.
*      ENDCASE.
*
*      MODIFY rt_fcat FROM ls_fcat.
*
*    ENDLOOP.
*
*  ENDMETHOD.
  METHOD set_hotspot.
    rt_fcat            = it_fcat.
    LOOP AT rt_fcat ASSIGNING FIELD-SYMBOL(<fs_fcat>).
      CASE <fs_fcat>-fieldname.
        WHEN iv_field.
          <fs_fcat>-hotspot   = abap_true.
      ENDCASE.
    ENDLOOP.

  ENDMETHOD.

  METHOD hotspot_click.

    READ TABLE gt_bseg INTO DATA(ls_bseg) INDEX e_row_id-index.

SELECT * FROM  bseg INTO CORRESPONDING FIELDS OF TABLE gt_bakiye
             WHERE bukrs EQ ls_bseg-bukrs
             AND   belnr EQ ls_bseg-belnr
             AND   gjahr EQ ls_bseg-gjahr.

    CALL SCREEN 0200.
  ENDMETHOD.

ENDCLASS.
