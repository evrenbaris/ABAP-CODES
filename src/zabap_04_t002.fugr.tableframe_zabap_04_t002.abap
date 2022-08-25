*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZABAP_04_T002
*   generation date: 08/11/2022 at 14:25:24
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZABAP_04_T002      .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
