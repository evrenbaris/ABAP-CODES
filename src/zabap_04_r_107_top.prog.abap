*&---------------------------------------------------------------------*
*& Include          ZABAP_04_R_107_TOP
*&---------------------------------------------------------------------*
TABLES: sflight.
*Select optionsta FOR kısmında sorun yaşamamak için tables'ı tanımladık
CLASS lcl_main DEFINITION DEFERRED.
*deferred sayesinde implementationdan bağımsız şekilde class tanımlayabildik
*local class tanımladık
*The variant with the DEFERRED addition makes a class known provisionally in the program.

 "This variant of the statement CLASS is used to make the class class known, regardless of the location of the actual definition of the class in the program.
 "It does not introduce a declaration part and must not be ended using ENDCLASS.


DATA : go_main TYPE REF TO lcl_main.
*obje yaratmak için kullanılan data ref to ile kullanılmalı !
"The addition REF TO declares a reference variable ref.
"The static type of the reference variable is specified after REF TO
DATA : lt_sflight TYPE TABLE OF sflight.
"local sflight alanı olusturduk

DATA: gv_fldate TYPE sflight-fldate.
"global fldate oluşturdul


PARAMETERS : p_carrid TYPE sflight-carrid,
             p_connid TYPE sflight-connid,
             p_curren TYPE sflight-currency,
             p_price TYPE sflight-price.
"Kullanacağımız parametreler
SELECT-OPTIONS : s_fdate FOR sflight-fldate.
"Select options kullanımı flight date için
