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
   PURPOSE:    �i��{�ѽ�X��������I���B�p�� (�H��Ө��צӨ�, �O�n��I���B���Ȥ�)
   PARAMATER(S):
   �{�ѽ�X������i�H����3�q
   (1) ����(TradeAmt) = ������� * ����Ѽ�
   (2) ����|(TradeTax) = ���� * �d���� 3         //�o�ӬO�n���F����
   (3) ����O(CommFee) = ���� * �d���� 1.425      //�o�ӬO��Ӫ����J, �O��ӥi�ޱ�������, 
                                                  //�i��|�̤@�Ǳ���, �Ӧ����P���O�v
                                                  //���ҥu�̲{����ιq�l��, �Ӧ����P���O�v
                                                  //�{����: �d����1.425 (CommFeeRate_NonEC)
                                                  //�q�l��: �d����1.325 (CommFeeRate_EC)
   (4) ��Ϊ��B(SettleAmt) = ���� - ����| - ����O          //�o�Ӥ~�O�u���i�J�Ȥ�b�᪺��
   Mode           Name           Description
   ---------      ------------   -----------------------------------------------
   IN             pi_TradePrz    �������
   IN             pi_TradeQty    ����Ѽ�
   OUT   NOCOPY   po_ReturnMsg   ��Ϊ��B
*******************************************************************************/
   PROCEDURE plCalcSettleAmtForCashSell   (  
      pi_ChannelKind IN          VARCHAR2,       --�q������ ('1': �{��, '2':�q�l)
      pi_TradePrz    IN          NUMBER,     --�������
      pi_TradeQty    IN          NUMBER,     --����Ѽ�
      po_SettleAmt   OUT NOCOPY  NUMBER      --��Ϊ��B
      );
      
END pkgDIMain_v01;
/
CREATE OR REPLACE PACKAGE BODY pkgDIMain_v01 
IS

/*******************************************************************************
   NAME:       plCalcSettleAmtForCashSell
   PURPOSE:    �i��{�ѽ�X��������I���B�p�� (�H��Ө��צӨ�, �O�n��I���B���Ȥ�)
   PARAMATER(S):
   �{�ѽ�X������i�H����3�q
   (1) ����(TradeAmt) = ������� * ����Ѽ�
   (2) ����|(TradeTax) = ���� * �d���� 3         //�o�ӬO�n���F����
   (3) ����O(CommFee) = ���� * �d���� 1.425      //�o�ӬO��Ӫ����J, �O��ӥi�ޱ�������, 
                                                  //�i��|�̤@�Ǳ���, �Ӧ����P���O�v
                                                  //���ҥu�̲{����ιq�l��, �Ӧ����P���O�v
                                                  //�{����: �d����1.425 (CommFeeRate_NonEC)
                                                  //�q�l��: �d����1.325 (CommFeeRate_EC)
   (4) ��Ϊ��B(SettleAmt) = ���� - ����| - ����O          //�o�Ӥ~�O�u���i�J�Ȥ�b�᪺��
   Mode           Name           Description
   ---------      ------------   -----------------------------------------------
   IN             pi_TradePrz    �������
   IN             pi_TradeQty    ����Ѽ�
   OUT   NOCOPY   po_ReturnMsg   ��Ϊ��B
*******************************************************************************/
   PROCEDURE plCalcSettleAmtForCashSell(
      pi_ChannelKind IN          VARCHAR2,       --�q������ ('1': �{��, '2':�q�l)
      pi_TradePrz    IN          NUMBER,     --�������
      pi_TradeQty    IN          NUMBER,     --����Ѽ�
      po_SettleAmt   OUT NOCOPY  NUMBER      --��Ϊ��B
      )
   IS
      lv_TradeAmt    NUMBER(16,2);     --����
      lv_TradeTax    NUMBER(16,2);     --����|
      lv_CommFee     NUMBER(16,2);     --����O
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
