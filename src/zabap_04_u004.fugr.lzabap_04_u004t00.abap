*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 08/17/2022 at 16:36:35
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZABAP_04_U004...................................*
DATA:  BEGIN OF STATUS_ZABAP_04_U004                 .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZABAP_04_U004                 .
CONTROLS: TCTRL_ZABAP_04_U004
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZABAP_04_U004                 .
TABLES: ZABAP_04_U004                  .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
