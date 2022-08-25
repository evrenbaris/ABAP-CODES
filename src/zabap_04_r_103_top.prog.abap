*&---------------------------------------------------------------------*
*& Include          ZABAP_04_R_103_TOP
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK rad1 WITH FRAME TITLE TEXT-t01.

  PARAMETERS : p_ad       TYPE char15 OBLIGATORY,
               p_soyad    TYPE char15 OBLIGATORY,
               p_email    TYPE char40,
               p_tel      TYPE numc10,
               p_avans    TYPE p DECIMALS 2,
               p_yemek    TYPE p DECIMALS 2,
               p_yol      TYPE p DECIMALS 2,
               p_konak    TYPE p DECIMALS 2,
               p_para(10) AS LISTBOX VISIBLE LENGTH 10.

  SELECT-OPTIONS s_tarih FOR sy-datum .


SELECTION-SCREEN END OF BLOCK rad1.

*değişkenleri tanımla
DATA : p_tel_two    TYPE i.
DATA: operator      TYPE string.
DATA: tel_no_full   TYPE string.
DATA p_tel_string   TYPE string.
DATA toplam_gider   TYPE P DECIMALS 2.
DATA ahy            TYPE p DECIMALS 2.
DATA kalan_avans    TYPE P DECIMALS 2.
DATA ahy_degisken   TYPE string.
DATA col            TYPE i.
DATA uyarı          TYPE string.
DATA gv_tel_fr       type i.

DATA: money TYPE vrm_id,
      list  TYPE vrm_values,
      value LIKE LINE OF list.

DATA : gv_ad    TYPE string,
       gv_soyad TYPE string.

DATA: no_days TYPE i.

*bolukları sil kısmının dataları
DATA :lv_yemek      TYPE char10,
      lv_yol        TYPE char10,
      lv_konak      TYPE char10,
      lv_tpgıder    TYPE char10,
      lv_kalanavans TYPE char10,
      lv_ahy        TYPE char10.


DATA: go_regex   TYPE REF TO cl_abap_regex,
      go_matcher TYPE REF TO cl_abap_matcher,
      go_match   TYPE c LENGTH 1,
      gv_msg     TYPE string.
