namespace siddhant.common;
 using { sap, Currency , temporal , managed } from '@sap/cds/common';
 type Gender : String(1) enum{
     male = 'M';
     female = 'F';
     noBinary = 'N';
     noDisclosure = 'D';
     selfDescribe = 'S';
 };

 type AmountT : Decimal(15,2)@(
    Semantics.amount.currencyCode:'CURRENCY_CODE',
    sap.unit: 'CURRENCY_CODE'
 );

type Amount {
     CURRENCY_CODE : String(4);
            GROSS_AMOUNT: AmountT;
            NET_AMOUNT: AmountT;
            TAX_AMOUNT: AmountT;
 }