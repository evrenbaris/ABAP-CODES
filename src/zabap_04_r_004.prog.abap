*&---------------------------------------------------------------------*
*& Report ZABAP_04_R_004
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZABAP_04_R_004.
class math_op DEFINITION.
  PUBLIC SECTION.
  DATA:lv_num1   TYPE I,
       lv_num2   TYPE I,
       lv_result TYPE I.
  METHODS: sum_numbers.
 ENDCLASS.


class math_op IMPLEMENTATION.
 method sum_numbers.
   lv_result = lv_num1 + lv_num2.
   ENDMETHOD.
 ENDCLASS.

 CLASS math_op_diff DEFINITION INHERITING FROM math_op. "ALT CLASS
   PUBLIC SECTION.
   METHODs numb_diff.

 ENDCLASS.


CLASS math_op_diff IMPLEMENTATION.
     METHOD numb_diff.
     lv_result = lv_num1 - lv_num2.
    ENDMETHOD.
 ENDCLASS.




 DATA : go_math_op TYPE REF TO math_op.
 DATA : go_math_op_diff TYPE REF TO math_op_diff.

START-OF-SELECTION.

 CREATE OBJECT : go_math_op.
 CREATE OBJECT : go_math_op_diff.

 go_math_op->lv_num1 = 12.
 go_math_op->lv_num2 = 23.
 go_math_op->sum_numbers( ).
 WRITE:go_math_op->lv_result.

 go_math_op_diff->lv_num1 = 12.
 go_math_op_diff->lv_num2 = 7.
 go_math_op_diff->numb_diff( ). "metodu

 WRITE:go_math_op_diff->lv_result.
