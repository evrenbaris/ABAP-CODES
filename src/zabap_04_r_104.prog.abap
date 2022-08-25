*&---------------------------------------------------------------------*
*& Report ZABAP_04_R_104
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_04_r_104  NO STANDARD PAGE HEADING.


PARAMETERS: p_sayi1 TYPE p DECIMALS 2,
            p_opr   TYPE char10 AS LISTBOX VISIBLE LENGTH 10,
            p_sayi2 TYPE p DECIMALS 2.
*            p_opr   TYPE char10 AS LISTBOX VISIBLE LENGTH 10.
*            p_opr   TYPE char10 AS LISTBOX VISIBLE LENGTH 10.

DATA: sonuc TYPE p DECIMALS 2.

TYPE-POOLS: vrm.

DATA: name  TYPE vrm_id,
      list  TYPE vrm_values,
      value LIKE LINE OF list.

AT SELECTION-SCREEN.
  IF  p_opr = '4' AND p_sayi2 = 0.
    MESSAGE 'Bölen sayı 0 olamaz!' TYPE  'E'.
  ELSEIF p_sayi1 = '' AND p_sayi2 = ''.
    MESSAGE 'İki sayı da sıfır veya boşluk.Lütfen sayı giriniz' TYPE  'E'.
  ENDIF.

AT SELECTION-SCREEN OUTPUT.

  name = 'p_opr'.
  value-key = '1'.
  value-text = '+'.
  APPEND value TO list.

  value-key = '2'.
  value-text = '-'.
  APPEND value TO list.

  value-key = '3'.
  value-text = '*'.
  APPEND value TO list.

  value-key = '4'.
  value-text = '/'.
  APPEND value TO list.

  CALL FUNCTION 'VRM_SET_VALUES' EXPORTING id = name values = list.

START-OF-SELECTION.

  IF p_opr = '1'.
    sonuc = p_sayi1 + p_sayi2.
    WRITE: 'SONUÇ : 'CENTERED, sonuc.

  ELSEIF p_opr = '2'.
    sonuc = p_sayi1 - p_sayi2.

*  replace ALL OCCURRENCES OF '-' in sonuc with ''.
    IF sonuc < 0.
      MESSAGE 'BU PROGRAMDA EKSİ İŞARETİ SAYIDAN SONRA GELİR DİKKAT!' TYPE 'I' DISPLAY LIKE 'E'.
*      SHIFT sonuc LEFT DELETING LEADING '0'.
      WRITE: 'SONUÇ : ' CENTERED,sonuc.
    ELSE.
      WRITE: 'SONUÇ : ' CENTERED,sonuc.
    ENDIF.

  ELSEIF p_opr = '3'.
    sonuc = p_sayi1 * p_sayi2.
    WRITE: 'SONUÇ : ' CENTERED,sonuc.

  ELSEIF p_opr = '4'.
    sonuc = p_sayi1 / p_sayi2.
    WRITE: 'SONUÇ : ' CENTERED, sonuc.

  ELSE.
*    WRITE: 'SADECE + - * / KULLANILIR'.
    MESSAGE 'SADECE + - * / KULLANILIR' TYPE 'I' DISPLAY LIKE 'E'.
  ENDIF.





















*PARAMETERS : p_inp1 TYPE int8, " int8 = 8 byte integer
*             p_inp2 TYPE int8.
*DATA: lv_out  TYPE int8,
*      lv_sign TYPE c,
*      flag    TYPE int1 VALUE 0.
*
**buton ekranı yaratttık
*SELECTION-SCREEN :BEGIN OF SCREEN 500 TITLE TEXT-001,
*                  PUSHBUTTON /10(10) add  USER-COMMAND create,
*                  PUSHBUTTON 25(10) sub USER-COMMAND sub,
*                  PUSHBUTTON 40(10) mul USER-COMMAND multiply,
*                  PUSHBUTTON 55(10) div USER-COMMAND divide,
*END OF SCREEN 500.
*INITIALIZATION. " yukarda yarattığımız butonlara isim veriyoruz
*  add = 'Add'.
*  sub = 'Subtract'.
*  mul = 'Multiply'.
*  div = 'Division'.
*AT SELECTION-SCREEN. "hesaplamalar
*  CASE sy-ucomm. "'sy-ucomm', tıklanan veya kullanılan herhangi bir ekran öğesinin işlev kodlarını içerecektir.
*    WHEN 'ADD'.
*      flag = 1.
*      lv_out = p_inp1 + p_inp2.
*    WHEN 'SUB'.
*      flag = 1.
*      lv_out = p_inp1 - p_inp2.
*    WHEN 'DIVIDE'.
*      IF ( p_inp2 <> 0 ).
*        flag = 1.
*        lv_out = p_inp1 / p_inp2.
*      ELSE.
*        flag = 2.
*      ENDIF.
*    WHEN 'MULTIPLY'.
*      flag = 1.
*      lv_out = p_inp1 * p_inp2.
*  ENDCASE.
*  IF lv_out < 0.
*  MESSAGE 'BU PROGRAMDA NEGATİF İŞARETİ SAYININ SONUNDADIR!' TYPE 'I'.
*  ENDIF.
*START-OF-SELECTION. " çıktı
*
*
*
*
*
*  IF p_inp1 IS NOT INITIAL OR p_inp2 IS NOT INITIAL.
*    CALL SELECTION-SCREEN '500' STARTING AT 10 10.
*    IF flag = 1.
*      WRITE: lv_out.
*    ELSEIF flag = 2.
*      MESSAGE 'BÖLEN 0 OLAMAZ!' TYPE 'I'.
**      WRITE: 'BÖLEN 0 OLMAMAZ'.
*    ELSEIF flag = 0.
*      MESSAGE 'Press any Button to perform any operation!' TYPE 'I'.
*    ENDIF.
*  ELSE.
*    MESSAGE 'Please give both Input to proceed!' TYPE 'I'.
*  ENDIF.
