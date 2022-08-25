*&---------------------------------------------------------------------*
*& Report ZABAP_04_R_113
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZABAP_04_R_113.
INCLUDE zabap_04_r_113_top.
INCLUDE zabap_04_r_113_cls.



INITIALIZATION.
create OBJECT go_main.
START-OF-SELECTION.

go_main->get_data( ).

CLEAR:gs_fieldcatalog.
          gs_fieldcatalog-fieldname = 'GJAHR'.
          gs_fieldcatalog-seltext_l = 'Mali yıl'.
          gs_fieldcatalog-seltext_m = 'Mali yıl'.
          gs_fieldcatalog-seltext_s = 'Mali yıl'.
*          gs_fieldcatalog-col_opt = abap_true.
          gs_fieldcatalog-col_pos = 2.
APPEND gs_fieldcatalog TO gt_fieldcatalog.


CLEAR:gs_fieldcatalog.
gs_fieldcatalog-fieldname = 'KUNNR'.
          gs_fieldcatalog-seltext_l = 'Müşteri Numarası'.
          gs_fieldcatalog-seltext_m = 'Müşteri Numarası'.
          gs_fieldcatalog-seltext_s = 'Müşteri Numarası'.
*          gs_fieldcatalog-col_opt = abap_true.
          gs_fieldcatalog-col_pos = 3.
APPEND gs_fieldcatalog TO gt_fieldcatalog.



CLEAR:gs_fieldcatalog.
          gs_fieldcatalog-fieldname = 'NAME1'.
          gs_fieldcatalog-seltext_l = 'Müşteri Ad'.
          gs_fieldcatalog-seltext_m = 'Müşteri Adı'.
          gs_fieldcatalog-seltext_s = 'Müşteri Adı'.
*          gs_fieldcatalog-col_opt = abap_true.
          gs_fieldcatalog-col_pos = 4.
APPEND gs_fieldcatalog TO gt_fieldcatalog.


CLEAR:gs_fieldcatalog.
          gs_fieldcatalog-fieldname = 'DMBTR1'.
          gs_fieldcatalog-seltext_l = 'Borç'.
          gs_fieldcatalog-seltext_m = 'Borç'.
          gs_fieldcatalog-seltext_s = 'Borç'.
*          gs_fieldcatalog-reptext = 'Borç'.
          gs_fieldcatalog-currency = 'X'.
*          gs_fieldcatalog-col_opt = abap_true.
          gs_fieldcatalog-col_pos = 5.
APPEND gs_fieldcatalog TO gt_fieldcatalog.

CLEAR:gs_fieldcatalog.
gs_fieldcatalog-fieldname = 'DMBTR'.

          gs_fieldcatalog-seltext_l = 'Alacak'.
          gs_fieldcatalog-seltext_m = 'Alacak'.
          gs_fieldcatalog-seltext_s = 'Alacak'.
*          gs_fieldcatalog-reptext = 'Alacak'.
*          gs_fieldcatalog-col_opt = abap_true.
          gs_fieldcatalog-currency = 'X'.
          gs_fieldcatalog-col_pos = 6.
APPEND gs_fieldcatalog TO gt_fieldcatalog.


CLEAR:gs_fieldcatalog.
          gs_fieldcatalog-fieldname = 'BAKIYE'.
          gs_fieldcatalog-seltext_l = 'Bakiye'.
          gs_fieldcatalog-seltext_m = 'Bakiye'.
          gs_fieldcatalog-seltext_s = 'Bakiye'.
*          gs_fieldcatalog-col_opt = abap_true.
          gs_fieldcatalog-currency = 'X'.
*          gs_fieldcatalog-reptext = 'Bakiye'.
          gs_fieldcatalog-hotspot = abap_true.
          gs_fieldcatalog-col_pos = 7.
APPEND gs_fieldcatalog TO gt_fieldcatalog.


* go_main->handle_hotspot_click( ).
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
EXPORTING
  i_callback_program = SY-REPID
  it_fieldcat = gt_fieldcatalog
  i_callback_user_command = 'USER_COMMAND'

  TABLES
    t_outtab    =  gt_musterı.

FORM USER_COMMAND USING R_UCOMM LIKE SY-UCOMM
      RS_SELFIELD TYPE SLIS_SELFIELD.



READ TABLE  GT_BSEG INTO DATA(LS_BSEG) INDEX RS_SELFIELD-tabindex.
SELECT * FROM  bseg INTO CORRESPONDING FIELDS OF TABLE gt_bakiye
             WHERE bukrs EQ ls_bseg-bukrs
             AND   belnr EQ ls_bseg-belnr
             AND   gjahr EQ ls_bseg-gjahr.

  IF RS_SELFIELD-FIELDNAME = 'BAKIYE'.
     CLEAR:gs_fieldcatalog2.
          gs_fieldcatalog2-fieldname = 'BUKRS'.
          gs_fieldcatalog2-seltext_l = 'Şirket kodu'.
          gs_fieldcatalog2-seltext_m = 'Şirket kodu'.
          gs_fieldcatalog2-seltext_s = 'Şirket kodu'.
*          gs_fieldcatalog-col_opt = abap_true.
         gs_fieldcatalog2-col_pos = 1.
APPEND gs_fieldcatalog2 TO gt_fieldcatalog2.
 CLEAR:gs_fieldcatalog2.
          gs_fieldcatalog2-fieldname = 'GJAHR'.
          gs_fieldcatalog2-seltext_l = 'Mali yıl'.
          gs_fieldcatalog2-seltext_m = 'Mali yıl'.
          gs_fieldcatalog2-seltext_s = 'Mali yıl'.
*          gs_fieldcatalog-col_opt = abap_true.
          gs_fieldcatalog2-col_pos = 2.
APPEND gs_fieldcatalog2 TO gt_fieldcatalog2.
*          CLEAR:gs_fieldcatalog2.
*          gs_fieldcatalog2-fieldname = 'KUNNR'.
*          gs_fieldcatalog2-seltext_l = 'Müşteri Numarası'.
*          gs_fieldcatalog2-seltext_m = 'Müşteri Numarası'.
*          gs_fieldcatalog2-seltext_s = 'Müşteri Numarası'.
**          gs_fieldcatalog-col_opt = abap_true.
*         gs_fieldcatalog2-col_pos = 3.
*APPEND gs_fieldcatalog2 TO gt_fieldcatalog2.
*
*     CLEAR:gs_fieldcatalog2.
*          gs_fieldcatalog2-fieldname = 'NAME1'.
*          gs_fieldcatalog2-seltext_l = 'Müşteri Adı'.
*          gs_fieldcatalog2-seltext_m = 'Müşteri Adı'.
*          gs_fieldcatalog2-seltext_s = 'Müşteri Adı'.
**          gs_fieldcatalog-col_opt = abap_true.
*         gs_fieldcatalog2-col_pos = 4.
*APPEND gs_fieldcatalog2 TO gt_fieldcatalog2.


 CLEAR:gs_fieldcatalog2.
          gs_fieldcatalog2-fieldname = 'BELNR'.
          gs_fieldcatalog2-seltext_l = 'Belge Numarası'.
          gs_fieldcatalog2-seltext_m = 'Belge Numarası'.
          gs_fieldcatalog2-seltext_s = 'Belge Numarası'.
*          gs_fieldcatalog-col_opt = abap_true.
          gs_fieldcatalog2-col_pos = 3.
APPEND gs_fieldcatalog2 TO gt_fieldcatalog2.
 CLEAR:gs_fieldcatalog2.
          gs_fieldcatalog2-fieldname = 'BSCHL'.
          gs_fieldcatalog2-seltext_l = 'Kayıt anahtarı'.
          gs_fieldcatalog2-seltext_m = 'Kayıt anahtarı'.
          gs_fieldcatalog2-seltext_s = 'Kayıt anahtarı'.
*          gs_fieldcatalog-col_opt = abap_true.
          gs_fieldcatalog2-col_pos = 4.
APPEND gs_fieldcatalog2 TO gt_fieldcatalog2.
 CLEAR:gs_fieldcatalog2.
          gs_fieldcatalog2-fieldname = 'SHKZG'.
          gs_fieldcatalog2-seltext_l = 'Borç/alacak göstergesi'.
          gs_fieldcatalog2-seltext_m = 'Borç/alacak göstergesi'.
          gs_fieldcatalog2-seltext_s = 'Borç/alacak göstergesi'.
*          gs_fieldcatalog-col_opt = abap_true.
          gs_fieldcatalog2-col_pos = 5.


APPEND gs_fieldcatalog2 TO gt_fieldcatalog2.
CLEAR:gs_fieldcatalog2.
          gs_fieldcatalog2-fieldname = 'KOART'.
          gs_fieldcatalog2-seltext_l = 'Hesap türü'.
          gs_fieldcatalog2-seltext_m = 'Hesap türü'.
          gs_fieldcatalog2-seltext_s = 'Hesap türü'.
*          gs_fieldcatalog-col_opt = abap_true.
          gs_fieldcatalog2-col_pos = 6.


APPEND gs_fieldcatalog2 TO gt_fieldcatalog2.


CLEAR:gs_fieldcatalog2.
          gs_fieldcatalog2-fieldname = 'KBLPOS'.
          gs_fieldcatalog2-seltext_l = 'Belge kalemi'.
          gs_fieldcatalog2-seltext_m = 'Belge kalemi'.
          gs_fieldcatalog2-seltext_s = 'Belge kalemi'.
*          gs_fieldcatalog-col_opt = abap_true.
         gs_fieldcatalog2-col_pos = 7.
APPEND gs_fieldcatalog2 TO gt_fieldcatalog2.


CLEAR:gs_fieldcatalog2.
          gs_fieldcatalog2-fieldname = 'DMBTR'.
          gs_fieldcatalog2-seltext_l = 'Tutar(tl)'.
          gs_fieldcatalog2-seltext_m = 'Tutar(tl)'.
          gs_fieldcatalog2-seltext_s = 'Tutar(tl)'.
*          gs_fieldcatalog-reptext = 'Borç'.
          gs_fieldcatalog2-currency = 'X'.
*          gs_fieldcatalog-col_opt = abap_true.
          gs_fieldcatalog2-col_pos = 8.
APPEND gs_fieldcatalog2 TO gt_fieldcatalog2.

CLEAR:gs_fieldcatalog2.
gs_fieldcatalog2-fieldname = 'WAERS'.
gs_fieldcatalog2-no_out = 'X'.
          gs_fieldcatalog2-seltext_l = 'Para birimi anahtarı'.
          gs_fieldcatalog2-seltext_m = 'Para birimi anahtarı'.
          gs_fieldcatalog2-seltext_s = 'Para birimi anahtarı'.
*          gs_fieldcatalog-reptext = 'Alacak'.
*          gs_fieldcatalog-col_opt = abap_true.
*          gs_fieldcatalog2-currency = 'X'.
*          gs_fieldcatalog2-col_pos = 6.
APPEND gs_fieldcatalog2 TO gt_fieldcatalog2.




*call function 'REUSE_ALV_POPUP_TO_SELECT'
*  exporting
**   I_TITLE                       =
*   I_SELECTION                   =   space
*    i_tabname                     = 'ZBKPF_STR_04_01'
*    I_STRUCTURE_NAME              = 'ZBKPF_STR_04_01'
**   IT_FIELDCAT                   =   gt_fieldcatalog2
*    i_screen_start_column = 10
*    i_screen_start_line   = 20
*    i_screen_end_column   = 100
*    i_screen_end_line     = 40
** IMPORTING
**   ES_SELFIELD                   =
**   E_EXIT                        =
*  tables
*    t_outtab                      = gt_bakiye
* EXCEPTIONS
*   PROGRAM_ERROR                 = 1
*   OTHERS                        = 2
*          .
*if sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
*endif.
*endif.
RS_SELFIELD-REFRESH = ABAP_TRUE.
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
EXPORTING
  i_callback_program = SY-REPID
  it_fieldcat = gt_fieldcatalog2
 i_callback_user_command = 'USER_COMMAND'
  TABLES
    t_outtab    =  gt_bakiye.
  ENDIF.
ENDFORM.
