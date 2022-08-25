*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 08/02/2022 at 15:06:24
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZABAP_04_T001...................................*
DATA:  BEGIN OF STATUS_ZABAP_04_T001                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZABAP_04_T001                 .
CONTROLS: TCTRL_ZABAP_04_T001
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZABAP_04_T001                 .
TABLES: ZABAP_04_T001                  .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
