*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZABAP_04_U003
*   generation date: 08/17/2022 at 16:35:31
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZABAP_04_U003      .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
