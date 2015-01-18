CREATE OR REPLACE PACKAGE pkgDIPayment_v03 
IS
/*******************************************************************************
   NAME:       pkgDIPayment_v03
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
   
/*******************************************************************************
   NAME:       plSet_CommFeeRate_NonEC
   PURPOSE:    �]�w�{�����������O�v
   PARAMATER(S):
   Mode           Name           Description
   ---------      ------------   -----------------------------------------------
   IN             pi_CommFeeRate_NonEC �{�����������O�v
*******************************************************************************/
   PROCEDURE plSet_CommFeeRate_NonEC(
      pi_CommFeeRate_NonEC    IN    NUMBER       --�{�����������O�v
      ); 
   
/*******************************************************************************
   NAME:       plSet_CommFeeRate_EC
   PURPOSE:    �]�w�q�l���������O�v
   PARAMATER(S):
   Mode           Name           Description
   ---------      ------------   -----------------------------------------------
   IN             pi_CommFeeRate_EC �q�l���������O�v
*******************************************************************************/
   PROCEDURE plSet_CommFeeRate_EC(
      pi_CommFeeRate_EC    IN    NUMBER       --�q�l���������O�v
      );  

END pkgDIPayment_v03;
/
CREATE OR REPLACE PACKAGE BODY pkgDIPayment_v03 
IS

   gv_CommFeeRate_NonEC    NUMBER;  --�{������O�v (Private Field)
   gv_CommFeeRate_EC       NUMBER;  --�q�l����O�v (Private Field)

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
         lv_Result := pi_TradeAmt * gv_CommFeeRate_NonEC;      
      ELSE
         lv_Result := pi_TradeAmt * gv_CommFeeRate_EC;     
      END IF;
      RETURN lv_Result;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         NULL;
      WHEN OTHERS THEN
         RAISE; 
   END fcGetCommeFee;
   
/*******************************************************************************
   NAME:       plSet_CommFeeRate_NonEC
   PURPOSE:    �]�w�{�����������O�v
   PARAMATER(S):
   Mode           Name           Description
   ---------      ------------   -----------------------------------------------
   IN             pi_CommFeeRate_NonEC �{�����������O�v
*******************************************************************************/
   PROCEDURE plSet_CommFeeRate_NonEC(
      pi_CommFeeRate_NonEC    IN    NUMBER       --�{�����������O�v
      )   
   IS
   BEGIN
      gv_CommFeeRate_NonEC := pi_CommFeeRate_NonEC;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         NULL;
      WHEN OTHERS THEN
         RAISE; 
   END plSet_CommFeeRate_NonEC;
   
/*******************************************************************************
   NAME:       plSet_CommFeeRate_EC
   PURPOSE:    �]�w�q�l���������O�v
   PARAMATER(S):
   Mode           Name           Description
   ---------      ------------   -----------------------------------------------
   IN             pi_CommFeeRate_EC �q�l���������O�v
*******************************************************************************/
   PROCEDURE plSet_CommFeeRate_EC(
      pi_CommFeeRate_EC    IN    NUMBER       --�q�l���������O�v
      )   
   IS
   BEGIN
      gv_CommFeeRate_EC := pi_CommFeeRate_EC;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         NULL;
      WHEN OTHERS THEN
         RAISE; 
   END plSet_CommFeeRate_EC;

BEGIN
   -- Initialization
   NULL;
END pkgDIPayment_v03;
/
