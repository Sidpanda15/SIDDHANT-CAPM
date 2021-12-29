
using {siddhant.db.master , siddhant.db.transaction} from '../db/datamodel';
service CatalogService@(path:'/CatalogService'){
    entity EmployeeSet as projection on master.employees;
    entity AddressSet as projection on master.address;
    entity ProductSet as projection on master.product;
    // entity ProductTextSet as projection on master.prodtext;
    entity BusinessPartnerSet as projection on master.businesspartner;
    entity POs @(
        title: '{i18n>poHeader}'
    )as projection on transaction.purchaseorder{
        *,
        Items : redirected to POItems
    }
    entity POItems as projection on transaction.poitems{
        *,
        PARENT_KEY : redirected to POs,
        PRODUCT_GUID: redirected to ProductSet
    }
}