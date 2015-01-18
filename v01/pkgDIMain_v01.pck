CREATE OR REPLACE PACKAGE pkgDIMain_v01 
IS
/*******************************************************************************
   NAME:       pkgDIMain_v01
   PURPOSE:    Demo for DI with PL/SQL version 1.0

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  -------------------------------------
   1.0        2015/1/16       JASPERLAI          1. Created this package.    
*******************************************************************************/ 

  
/*******************************************************************************
   NAME:       plCalcSettleAmtForCashSell
   PURPOSE:    進行現股賣出交易的應付金額計算 (以券商角度而言, 是要支付金額給客戶)
   PARAMATER(S):
   現股賣出的交易可以分為3段
   (1) 價金(TradeAmt) = 成交價格 * 成交股數
   (2) 交易稅(TradeTax) = 價金 * 千分之 3         //這個是要給政府的
   (3) 手續費(CommFee) = 價金 * 千分之 1.425      //這個是券商的收入, 是券商可操控的部份, 
                                                  //可能會依一些條件, 而有不同的費率
                                                  //本例只依現場單或電子單, 而有不同的費率
                                                  //現場單: 千分之1.425 (CommFeeRate_NonEC)
                                                  //電子單: 千分之1.325 (CommFeeRate_EC)
   (4) 交割金額(SettleAmt) = 價金 - 交易稅 - 手續費          //這個才是真正進入客戶帳戶的錢
   Mode           Name           Description
   ---------      ------------   -----------------------------------------------
   IN             pi_TradePrz    成交價格
   IN             pi_TradeQty    成交股數
   OUT   NOCOPY   po_ReturnMsg   交割金額
*******************************************************************************/
   PROCEDURE plCalcSettleAmtForCashSell   (  
      pi_ChannelKind IN          VARCHAR2,       --通路種類 ('1': 現場, '2':電子)
      pi_TradePrz    IN          NUMBER,     --成交價格
      pi_TradeQty    IN          NUMBER,     --成交股數
      po_SettleAmt   OUT NOCOPY  NUMBER      --交割金額
      );
      
END pkgDIMain_v01;
/
CREATE OR REPLACE PACKAGE BODY pkgDIMain_v01 
IS

/*******************************************************************************
   NAME:       plCalcSettleAmtForCashSell
   PURPOSE:    進行現股賣出交易的應付金額計算 (以券商角度而言, 是要支付金額給客戶)
   PARAMATER(S):
   現股賣出的交易可以分為3段
   (1) 價金(TradeAmt) = 成交價格 * 成交股數
   (2) 交易稅(TradeTax) = 價金 * 千分之 3         //這個是要給政府的
   (3) 手續費(CommFee) = 價金 * 千分之 1.425      //這個是券商的收入, 是券商可操控的部份, 
                                                  //可能會依一些條件, 而有不同的費率
                                                  //本例只依現場單或電子單, 而有不同的費率
                                                  //現場單: 千分之1.425 (CommFeeRate_NonEC)
                                                  //電子單: 千分之1.325 (CommFeeRate_EC)
   (4) 交割金額(SettleAmt) = 價金 - 交易稅 - 手續費          //這個才是真正進入客戶帳戶的錢
   Mode           Name           Description
   ---------      ------------   -----------------------------------------------
   IN             pi_TradePrz    成交價格
   IN             pi_TradeQty    成交股數
   OUT   NOCOPY   po_ReturnMsg   交割金額
*******************************************************************************/
   PROCEDURE plCalcSettleAmtForCashSell(
      pi_ChannelKind IN          VARCHAR2,       --通路種類 ('1': 現場, '2':電子)
      pi_TradePrz    IN          NUMBER,     --成交價格
      pi_TradeQty    IN          NUMBER,     --成交股數
      po_SettleAmt   OUT NOCOPY  NUMBER      --交割金額
      )
   IS
      lv_TradeAmt    NUMBER(16,2);     --價金
      lv_TradeTax    NUMBER(16,2);     --交易稅
      lv_CommFee     NUMBER(16,2);     --手續費
   BEGIN
      lv_TradeAmt := pi_TradeQty * pi_TradePrz;
      lv_TradeTax := pkgDIPayment_v01.fcGetTradeTax(lv_TradeAmt);
      lv_CommFee  := pkgDIPayment_v01.fcGetCommeFee(pi_ChannelKind, lv_TradeAmt);
      po_SettleAmt := lv_TradeAmt - lv_TradeTax - lv_CommFee;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         NULL;
      WHEN OTHERS THEN
         RAISE;
   END plCalcSettleAmtForCashSell;  

BEGIN
   -- Initialization
   NULL;
END pkgDIMain_v01;
/
