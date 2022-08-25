*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 08/11/2022 at 14:25:27
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZABAP_04_T002...................................*
DATA:  BEGIN OF STATUS_ZABAP_04_T002                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZABAP_04_T002                 .
CONTROLS: TCTRL_ZABAP_04_T002
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZABAP_04_T002                 .
TABLES: ZABAP_04_T002                  .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
