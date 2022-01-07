
using {siddhant.db.master , siddhant.db.transaction} from '../db/datamodel';
service CatalogService@(path:'/CatalogService'){
    entity EmployeeSet as projection on master.employees;
    entity AddressSet as projection on master.address;
    entity ProductSet as projection on master.product;
    // entity ProductTextSet as projection on master.prodtext;
    entity BusinessPartnerSet as projection on master.businesspartner;
    entity POs @(
        title: '{i18n>poHeader}',
        odata.draft.enabled: true
    )as projection on transaction.purchaseorder{
        *,
        round(GROSS_AMOUNT , 2) as GROSS_AMOUNT :Decimal(10,2),
        case LIFECYCLE_STATUS
        when 'N' then 'New'
        when 'B' then 'Blocked'
        when 'D' then 'Delivered'
        end as LIFECYCLE_STATUS:String(20),
        case LIFECYCLE_STATUS
        when 'N' then 2
        when 'B' then 1
        when 'D' then 3
        end as Criticality: Integer,
        Items : redirected to POItems
    }actions{
        function largestOrder() returns array of POs;
        action boost();
    }

 annotate POs with{
     GROSS_AMOUNT @title:'{i18n>Gross_amount}';
      LIFECYCLE_STATUS @title : '{i18n>Lifecyscle_Status}'
 } ;
 
    entity POItems as projection on transaction.poitems{
        *,
        PARENT_KEY : redirected to POs,
        PRODUCT_GUID: redirected to ProductSet
    }
}