CREATE OR REPLACE PACKAGE pkgCommon_v02 
IS
/*******************************************************************************
   NAME:       pkgCommon_v02
   PURPOSE:    Demo for DI with PL/SQL version 2.0

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  -------------------------------------
   1.0        2015/1/16       JASPERLAI          1. Created this package.    
*******************************************************************************/ 

  
/*******************************************************************************
   共用變數區
*******************************************************************************/
   gv_CommFeeRate_NonEC CONSTANT NUMBER := 0.001425;
   gv_CommFeeRate_EC CONSTANT NUMBER := 0.001325;
     
END pkgCommon_v02;
/
