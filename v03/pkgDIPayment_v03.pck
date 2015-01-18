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
   PURPOSE:    取得交易稅
   PARAMATER(S):
   Mode           Name           Description
   ---------      ------------   -----------------------------------------------
   IN             pi_TradeAmt    價金
   RETURN         --             交易稅
*******************************************************************************/
   FUNCTION fcGetTradeTax(
      pi_TradeAmt    IN          NUMBER          --價金
      )
   RETURN NUMBER;

/*******************************************************************************
   NAME:       fcGetCommFee
   PURPOSE:    取得手續費
   PARAMATER(S):
   Mode           Name           Description
   ---------      ------------   -----------------------------------------------
   IN             pi_ChannelKind 通路種類 ('1': 現場, '2':電子)
   IN             pi_TradeAmt    價金
   RETURN         --             手續費
*******************************************************************************/
   FUNCTION fcGetCommeFee(
      pi_ChannelKind IN          VARCHAR2,       --通路種類 ('1': 現場, '2':電子)
      pi_TradeAmt    IN          NUMBER          --價金
      )
   RETURN NUMBER;
   
/*******************************************************************************
   NAME:       plSet_CommFeeRate_NonEC
   PURPOSE:    設定現場交易的手續費率
   PARAMATER(S):
   Mode           Name           Description
   ---------      ------------   -----------------------------------------------
   IN             pi_CommFeeRate_NonEC 現場交易的手續費率
*******************************************************************************/
   PROCEDURE plSet_CommFeeRate_NonEC(
      pi_CommFeeRate_NonEC    IN    NUMBER       --現場交易的手續費率
      ); 
   
/*******************************************************************************
   NAME:       plSet_CommFeeRate_EC
   PURPOSE:    設定電子交易的手續費率
   PARAMATER(S):
   Mode           Name           Description
   ---------      ------------   -----------------------------------------------
   IN             pi_CommFeeRate_EC 電子交易的手續費率
*******************************************************************************/
   PROCEDURE plSet_CommFeeRate_EC(
      pi_CommFeeRate_EC    IN    NUMBER       --電子交易的手續費率
      );  

END pkgDIPayment_v03;
/
CREATE OR REPLACE PACKAGE BODY pkgDIPayment_v03 
IS

   gv_CommFeeRate_NonEC    NUMBER;  --現場手續費率 (Private Field)
   gv_CommFeeRate_EC       NUMBER;  --電子手續費率 (Private Field)

/*******************************************************************************
   NAME:       fcGetTradeTax
   PURPOSE:    取得交易稅
   PARAMATER(S):
   Mode           Name           Description
   ---------      ------------   -----------------------------------------------
   IN             pi_TradeAmt    價金
   RETURN         --             交易稅
*******************************************************************************/
   FUNCTION fcGetTradeTax(
      pi_TradeAmt    IN          NUMBER          --價金
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
   PURPOSE:    取得手續費
   PARAMATER(S):
   Mode           Name           Description
   ---------      ------------   -----------------------------------------------
   IN             pi_ChannelKind 通路種類 ('1': 現場, '2':電子)
   IN             pi_TradeAmt    價金
   RETURN         --             手續費
*******************************************************************************/
   FUNCTION fcGetCommeFee(
      pi_ChannelKind IN          VARCHAR2,       --通路種類 ('1': 現場, '2':電子)
      pi_TradeAmt    IN          NUMBER          --價金
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
   PURPOSE:    設定現場交易的手續費率
   PARAMATER(S):
   Mode           Name           Description
   ---------      ------------   -----------------------------------------------
   IN             pi_CommFeeRate_NonEC 現場交易的手續費率
*******************************************************************************/
   PROCEDURE plSet_CommFeeRate_NonEC(
      pi_CommFeeRate_NonEC    IN    NUMBER       --現場交易的手續費率
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
   PURPOSE:    設定電子交易的手續費率
   PARAMATER(S):
   Mode           Name           Description
   ---------      ------------   -----------------------------------------------
   IN             pi_CommFeeRate_EC 電子交易的手續費率
*******************************************************************************/
   PROCEDURE plSet_CommFeeRate_EC(
      pi_CommFeeRate_EC    IN    NUMBER       --電子交易的手續費率
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
