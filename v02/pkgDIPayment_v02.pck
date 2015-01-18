CREATE OR REPLACE PACKAGE pkgDIPayment_v02 
IS
/*******************************************************************************
   NAME:       pkgDIPayment_v02
   PURPOSE:    Demo for PL/SQL Dependency Injection

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  -------------------------------------
   1.0        2015/1/16       JASPERLAI          1. Created this package.    
*******************************************************************************/ 

/*******************************************************************************
   NAME:       fcGetTradeTax
   PURPOSE:    ���o����|
   PARAMATER(S):
   Mode           Name           Description
   ---------      ------------   -----------------------------------------------
   IN             pi_TradeAmt    ����
   RETURN         --             ����|
*******************************************************************************/
   FUNCTION fcGetTradeTax(
      pi_TradeAmt    IN          NUMBER          --����
      )
   RETURN NUMBER;

/*******************************************************************************
   NAME:       fcGetCommFee
   PURPOSE:    ���o����O
   PARAMATER(S):
   Mode           Name           Description
   ---------      ------------   -----------------------------------------------
   IN             pi_ChannelKind �q������ ('1': �{��, '2':�q�l)
   IN             pi_TradeAmt    ����
   RETURN         --             ����O
*******************************************************************************/
   FUNCTION fcGetCommeFee(
      pi_ChannelKind IN          VARCHAR2,       --�q������ ('1': �{��, '2':�q�l)
      pi_TradeAmt    IN          NUMBER          --����
      )
   RETURN NUMBER;

END pkgDIPayment_v02;
/
CREATE OR REPLACE PACKAGE BODY pkgDIPayment_v02 
IS

/*******************************************************************************
   NAME:       fcGetTradeTax
   PURPOSE:    ���o����|
   PARAMATER(S):
   Mode           Name           Description
   ---------      ------------   -----------------------------------------------
   IN             pi_TradeAmt    ����
   RETURN         --             ����|
*******************************************************************************/
   FUNCTION fcGetTradeTax(
      pi_TradeAmt    IN          NUMBER          --����
      )
   RETURN NUMBER
   IS
      lv_Result   NUMBER(16,2);
   BEGIN
      lv_Result := pi_TradeAmt * 3 / 1000;      
      RETURN lv_Result;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         NULL;
      WHEN OTHERS THEN
         RAISE; 
   END fcGetTradeTax;
   

/*******************************************************************************
   NAME:       fcGetCommFee
   PURPOSE:    ���o����O
   PARAMATER(S):
   Mode           Name           Description
   ---------      ------------   -----------------------------------------------
   IN             pi_ChannelKind �q������ ('1': �{��, '2':�q�l)
   IN             pi_TradeAmt    ����
   RETURN         --             ����O
*******************************************************************************/
   FUNCTION fcGetCommeFee(
      pi_ChannelKind IN          VARCHAR2,       --�q������ ('1': �{��, '2':�q�l)
      pi_TradeAmt    IN          NUMBER          --����
      )
   RETURN NUMBER
   IS
      lv_Result   NUMBER(16,2);
   BEGIN
      lv_Result := 0;
      IF pi_ChannelKind = '1' THEN
         lv_Result := pi_TradeAmt * pkgCommon_v02.gv_CommFeeRate_NonEC;      
      ELSE
         lv_Result := pi_TradeAmt * pkgCommon_v02.gv_CommFeeRate_EC;     
      END IF;
      RETURN lv_Result;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         NULL;
      WHEN OTHERS THEN
         RAISE; 
   END fcGetCommeFee;
   



BEGIN
   -- Initialization
   NULL;
END pkgDIPayment_v02;
/
