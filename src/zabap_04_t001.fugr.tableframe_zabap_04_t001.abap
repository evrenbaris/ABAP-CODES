*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZABAP_04_T001
*   generation date: 08/02/2022 at 15:06:23
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZABAP_04_T001      .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
