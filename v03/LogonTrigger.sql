CREATE OR REPLACE TRIGGER Dependency_Injection
AFTER LOGON  ON SCHEMA
BEGIN
   pkgDI_Injector.plInject;
END;