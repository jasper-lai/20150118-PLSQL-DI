CREATE OR REPLACE PACKAGE pkgDI_Injector
IS
   /*******************************************************************************
   NAME:       plInject
   PURPOSE:    弄砞﹚把计, 猔闽家舱
   PARAMATER(S):
   Mode           Name           Description
   ---------      ------------   -----------------------------------------------
*******************************************************************************/
   PROCEDURE plInject;

END pkgDI_Injector;
/
CREATE OR REPLACE PACKAGE BODY pkgDI_Injector
IS

   /*******************************************************************************
   NAME:       plInject
   PURPOSE:    弄砞﹚把计, 猔闽家舱
   PARAMATER(S):
   Mode           Name           Description
   ---------      ------------   -----------------------------------------------
   *******************************************************************************/
   PROCEDURE plInject
   IS
      lv_Sql   VARCHAR2(512);
   BEGIN
      -- loop over all properties that are configured in table CONFIGURATION_VALUES
      FOR r IN (SELECT cve.package_name
                 ,      cve.property
                 ,      cve.value
                 FROM   CONFIGURATION_VALUES cve
                 )
      LOOP
         -- for each property
         lv_Sql := 'begin '||r.package_name||'.plSet_'||r.property||'(:1); end;' ;
         DBMS_OUTPUT.PUT_LINE(lv_Sql);
         EXECUTE IMMEDIATE lv_Sql USING r.value;
      END LOOP;
   END plInject;

end pkgDI_Injector;
/
