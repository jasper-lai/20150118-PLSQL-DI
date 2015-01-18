DECLARE 
   lv_SettleAmt   NUMBER(16,2);
BEGIN
   pkgDIMain_v01.plCalcSettleAmtForCashSell(
   '1', 
   10, 
   2000,
   lv_SettleAmt
   );
   
   DBMS_OUTPUT.PUT_LINE('交割金額=' || lv_SettleAmt);  
   
-- OUTPUT:
-- 交割金額=19911.5
END;
