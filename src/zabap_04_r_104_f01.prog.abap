*&---------------------------------------------------------------------*
*& Include          ZABAP_04_R_104_F01
*&---------------------------------------------------------------------*


*FORM listbox .
*
*  opr = 'p_islem'.
*
*  CLEAR list.
*  CLEAR value.
*
*  value-key = '+'.
*  value-text = '+'.
*  APPEND value TO list.
*
*  CLEAR value.
*
*  value-key = '-'.
*  value-text = '-'.
*  APPEND value TO list.
*
*  CLEAR value.
*
*
*  value-key = '*'.
*  value-text = '*'.
*  APPEND value TO list.
*
*
*  CALL FUNCTION 'VRM_SET_VALUES'
*    EXPORTING
*      id     = opr
*      values = list.
*&---------------------------------------------------------------------*
*& Form islemler
*&---------------------------------------------------------------------*

*FORM islemler .
*
*IF p_islem = '+' OR
*   p_islem = '-' OR
*   p_islem = '*' OR
*   p_islem = '/' AND p_sayı1 <> 0.
*ENDIF.
*ENDFORM.
