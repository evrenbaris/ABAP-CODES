*&---------------------------------------------------------------------*
*& Include          ZABAP_04_R_107_CLS
*&---------------------------------------------------------------------*
CLASS lcl_main DEFINITION.
  "local ana class için definition kısmı
  PUBLIC SECTION.
    "main class olduğu için public sectionda kullanıyoruz
    " bu section sadec definition partta kullanılabilir
    CLASS-DATA :lt_data TYPE TABLE OF sflight.
    "me self referance demektir

    "When you declare a variable of any type in public section of a class, you can use it in any other implementation.
    "A variable can be declared with an initial value in public section.
    " We may declare the variable again inside a method with a different value.
    " When we write the variable inside the method, the system will print the changed value.
    " To reflect the previous value of the variable, we have to use ‘ME’ operator.
    TYPES : lt_fldate TYPE RANGE OF s_date.

    METHODS  :  main_parameters IMPORTING VALUE(cls_carrid) TYPE sflight-carrid
                                          VALUE(cls_connid) TYPE sflight-connid
                                          VALUE(cls_price)  TYPE sflight-price
                                          VALUE(cls_curren) TYPE sflight-currency
                                          VALUE(cls_fldate) TYPE lt_fldate
                                RETURNING VALUE(rv_subrc)   TYPE sy-subrc.

    METHODS:
      "fiyat güncelleyen metod definition kısmı
      update_sflight IMPORTING VALUE(cls_price) TYPE sflight-price
                     RETURNING VALUE(rv_subrc)  TYPE sy-subrc,
      "ekrana mesajı yazdırma metodu definition kısmı
      display_message RETURNING VALUE(rv_subrc)  TYPE sy-subrc.
    "rv = returning value.
    " Metodlar uygulamalarda herhangi bir işlemi yapmak için kullanılan kod parçacıklarıdır.
    " sy-subrc kodda kendisinden önce gelen işlemin sonucunu sorgular. yaptığım işlem doğru mu yanlış mı,
    "veri çekebildim mi yoksa hiç veri gelmedi mi merak ediyorsam sy-subrc kontrolü koyarım.
    "sy-subrc 0'a eşitse (işlem doğru) şunu yap, 0 değilse (hata var, veri gelmedi vs)
ENDCLASS.

CLASS lcl_main IMPLEMENTATION.
  "local main implementation kısmı
  METHOD main_parameters.
    "metodumuzun adı kullandığımız ana parametrelerden geliyor.
    SELECT * FROM sflight INTO TABLE me->lt_data  "sflighttaki dataları me_dataya atıp istediğimiz değerleri çektik
         WHERE carrid EQ cls_carrid
         AND  connid  EQ cls_connid
        AND  currency  EQ cls_curren
         AND  fldate  IN cls_fldate.


    rv_subrc = sy-subrc.
    "The logical expression in the IF statement
    " is true if the internal table in the SELECT statement was filled with lines.
    IF rv_subrc EQ 0 .


      cl_demo_output=>display( me->lt_data ).

    ELSE.

      MESSAGE 'DATA GELMEDİ' TYPE 'I' DISPLAY LIKE 'E'.

    ENDIF.
    "The expression IS [NOT] INITIAL is suitable for checking the type-dependent
    "initial value regardless of its actual data type,
    " instead of comparing it with a type-compliant operand that contains the initial value.


    "me points to the instance in which the method is currently being executed.
    "me is handled like a local constant, which means that the value of me cannot be modified in an instance method.
    "The static type of me is the class in which the instance method is implemented.
    "me is used to access the instance attribute me_data of the method.


  ENDMETHOD.
  " fiyat güncelleyen metodun implementation kısmı
  METHOD update_sflight.
    "global structure
    "Structure is a data object that is made up of components
    "of any data type stored one after the other in the memory.
    LOOP AT lt_data INTO DATA(gs_sflight).
      "The statement LOOP reads lines from the internal table
      gs_sflight-price = cls_price * gs_sflight-price.
      gs_sflight-currency = 'TRY'.
      MODIFY lt_data FROM gs_sflight.
    ENDLOOP.
  ENDMETHOD.
  "ekrana bastırma implementation
  METHOD display_message.
    cl_demo_output=>display( me->lt_data ).
  ENDMETHOD.
ENDCLASS.
