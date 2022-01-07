namespace siddhant.db;

type Guid : String(32);

using { cuid ,  managed , temporal , Currency } from '@sap/cds/common';
using { siddhant.common  } from './common';


context  master {

 entity businesspartner{
    key  NODE_KEY: Guid;
    BP_ROLE: String(2);
    EMAIL_ADDRESS: String(64);
    PHONE_NUMBER: String(14);
    FAX_NUMBER: String(14);
    WEB_ADDRESS: String(64);
    ADDRESS_GUID : Association to  address;
    BP_ID: String(16);
    COMPANY_NAME: String(80);
    }

    

   entity address {
    key  NODE_KEY: Guid;
    CITY: String(64);
    POSTAL_CODE: String(14);
    STREET: String(64);
    BUILDING: String(64);
    COUNTRY: String(64);
    VAL_START_DATE: String(64);
    VAL_END_DATE: String(64) ;
    LATITUDE: Decimal;
    LONGITUDE: Decimal;
    businesspartner: Association to one businesspartner on businesspartner.ADDRESS_GUID = $self;
    }

    // entity prodtext {
    //     key NODE_KEY : Guid;
    //     PARENT_KEY:Guid;
    //     LANGUAGE : String(2);
    //     TEXT : String(256);
    // }

    entity product {
        key NODE_KEY : Guid;
        PRODUCT_ID : String(28);
        TYPE_CODE : String(2);
        CATEGORY: String(32);
        DESCRIPTION: localized String(255);
        SUPPLIER_GUID : Association to master.businesspartner;
        TAX_TARIF_CODE: Integer;
        MEASURE_UNIT: String(2);
        WEIGHT_MEASURE: String(2);
        WEIGHT_UNIT: String(10);
        CURRENCY_CODE: String(4);
        PRICE: Decimal;
        WIDTH: Decimal;
        DEPTH: Decimal;
        HEIGHT: Decimal;
        DIM_UNIT: String(2);
    }

    annotate product with{
        DESCRIPTION @title : '{i18n>Description}';
        PRODUCT_ID  @title : '{i18n>Product_id}'
    } ;
    

    entity employees : cuid{
    nameFirst:	String(40);
    nameMiddle:	String(40);
    nameLast:	String(40);
    nameInitials:String(40);
    sex: common.Gender;
    language:String(40);
    phoneNumber: String(40);
    email:String(40);
    loginName:String(40);
    Currency: Currency ;
    salaryAmount: common.AmountT;
    accountNumber:String(40);
    bankId:	String(40);
    bankName:String(40);
    }

  annotate businesspartner with{
    NODE_KEY @title : '{i18n>bp_key}';
    BP_ROLE @title: '{i18n>bp_role}';
    EMAIL_ADDRESS @title: '{i18n>bp_address}';
    PHONE_NUMBER @title: '{i18n>bp_phone_number}';
    FAX_NUMBER @title: '{i18n>bp_fax_number}';
    WEB_ADDRESS @title: '{i18n>bp_website_address}';
    ADDRESS_GUID @title: '{i18n>bp_address_guid}';
    BP_ID @title: '{i18n>bp_id}';
    COMPANY_NAME @title: '{i18n>bp_company_name}';
    }
  }


 context transaction{
         entity purchaseorder : common.Amount{
            key NODE_KEY: Guid;
            PO_ID : String(12);
            PARTNER_GUID : Association to master.businesspartner;
            LIFECYCLE_STATUS : String(2);
            OVERALL_STATUS : String(2);
            Items: Association to many poitems on Items.PARENT_KEY = $self;
    }

    entity poitems : common.Amount{
        key NODE_KEY : Guid;
        PARENT_KEY : Association to purchaseorder;
        PO_ITEM_POS : String(5);
        PRODUCT_GUID : Association to master.product;
    }

    annotate poitems with{
        NODE_KEY @title:'{i18n>Node_key}';
        PARENT_KEY@title : '{i18n>Parent_key}';
        PO_ITEM_POS@title : '{i18n>PoitemsPo}';
        PRODUCT_GUID@title : '{i18n>Product_Guid}';
        TAX_AMOUNT @title:'{i18n>Tax_Amount}';
        NET_AMOUNT @title:'{i18n>Net_Amount}';
        GROSS_AMOUNT @title:'{i18n>Gross_amount}';
        CURRENCY_CODE @title:'{i18n>Currency_code}';
    };
    

    annotate purchaseorder with{
        NODE_KEY @title:'{i18n>Node_key}';
        PO_ID @title:'{i18n>Po_id}';
        PARTNER_GUID @title:'{i18n>Partner_Id}';
        LIFECYCLE_STATUS @title:'{i18n>Lifecyscle_Status}';
        OVERALL_STATUS @title:'{i18n>Overall_status}';
        TAX_AMOUNT @title:'{i18n>Tax_Amount}';
        NET_AMOUNT @title:'{i18n>Net_Amount}';
        GROSS_AMOUNT @title:'{i18n>Gross_amount}';
        CURRENCY_CODE @title:'{i18n>Currency_code}';
    } ;
    


 }