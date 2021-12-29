namespace siddhant.db;

using { siddhant.db.master , siddhant.db.transaction } from './datamodel.cds';

context CDSViews{
    define view![POWorklist] as
    select from transaction.purchaseorder{
          key PO_ID as![PurchaseOrderID],
          PARTNER_GUID.BP_ID as![PartnerId],
          PARTNER_GUID.COMPANY_NAME as![CompanyName],
          LIFECYCLE_STATUS as![LifetimeStatus],
          OVERALL_STATUS as![OverallStatus],
          key Items.PO_ITEM_POS as![ItemPosition],
          Items.PRODUCT_GUID.PRODUCT_ID as![ProductId],
          Items.PRODUCT_GUID.DESCRIPTION as![Description],
          PARTNER_GUID.ADDRESS_GUID.CITY as![City],
          PARTNER_GUID.ADDRESS_GUID.COUNTRY as![Country],
          Items.GROSS_AMOUNT as![GrossAmount],
          Items.TAX_AMOUNT as![TaxAmount],
          Items.NET_AMOUNT as![NetAmount],
          Items.CURRENCY_CODE as![CurrencyCode],
   };
    define view ProductValueHelp as
    select from master.product{
        @EndUserText.label:[
            {
                language : 'en',
                text : 'Product Id'
            },{
                language : 'de',
                text : 'ProdktID'
            }
        ]
        PRODUCT_ID as ![ProductID],
        @EndUserText.lable:[
            {
                language : 'en',
                text : 'Description'
            },{
                language : 'de',
                text : 'Discripsen'
            }
        ]
        DESCRIPTION as ![Description],
    };
    define view![ItemView] as
    select from transaction.poitems{
            PARENT_KEY.PARTNER_GUID.NODE_KEY as![Partner],
            PRODUCT_GUID.NODE_KEY as![ProductId],
            GROSS_AMOUNT as![GrossAmount],
            CURRENCY_CODE as![CurrencyCode],
            TAX_AMOUNT as![taxAmount],
            NET_AMOUNT as![netAmount],
            PARENT_KEY.OVERALL_STATUS as![OverallStatus],
    };
    // Aggregation of Data
    define view![ProductViewSub] as
    select from master.product as prod{
        PRODUCT_ID as![ProductId],
        texts.DESCRIPTION as![Description],
        (
            select from transaction.poitems as a{
                // Aggregation function
                SUM(a.GROSS_AMOUNT) as SUM
            }
            where a.PRODUCT_GUID.NODE_KEY = prod.NODE_KEY
        )as PO_SUM: Decimal(10,2)
    };

    // exposed Association
    define view ProductView as
    select from master.product
    mixin{
        PO_ORDERS: Association[*] to ItemView on
        PO_ORDERS.ProductId = $projection.ProductId
    }
    into{
        NODE_KEY as ![ProductId],
        DESCRIPTION,
        CATEGORY as ![Category],
        TYPE_CODE as ![TypeCode],
        PRICE as ![Price],
        SUPPLIER_GUID.ADDRESS_GUID.CITY as ![City],
        SUPPLIER_GUID.ADDRESS_GUID.COUNTRY as ![Country],
        SUPPLIER_GUID.BP_ID as ![BpId],
        SUPPLIER_GUID.COMPANY_NAME as ![CompanyName],
        // Exposed Aggregation which means data wont wont read by some on default
        // util unless someone consume the association
        PO_ORDERS
    };
    define view CProductValuesView as
    select from ProductView{
        ProductId,
        Country,
        PO_ORDERS.CurrencyCode as![CurrencyCode],
        sum(PO_ORDERS.GrossAmount) as![POGrossamount]: Decimal(10, 2),
    }
    group by ProductId,Country,PO_ORDERS.CurrencyCode;
}
