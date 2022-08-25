*&---------------------------------------------------------------------*
*& Report ZABAP_04_R_005
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZABAP_04_R_005.

CLASS Class1 Definition.
  PUBLIC SECTION.
  "This statement can only be used in the declaration part of a class.
  "It defines the public visibility section of the class class.
  DATA : text1(45) VALUE 'ABAP Objects.'.
  METHODS:Display1.
  ENDCLASS.

 CLASS Class1 IMPLEMENTATION.
  METHOD Display1.
    WRITE: /'This is the Display method'.
 ENDMETHOD.
 ENDCLASS.

 START-OF-SELECTION.
 DATA: Class1 TYPE REF TO Class1.
 CREATE Object : Class1.
 WRITE:/ Class1->text1.
 CALL METHOD: Class1->Display1.
