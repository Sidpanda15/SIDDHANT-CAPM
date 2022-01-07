using { CatalogService } from '../../srv/CatalogService';
annotate CatalogService.POs with @(
     UI:{
SelectionFields  : [
    PO_ID,
    GROSS_AMOUNT,
    LIFECYCLE_STATUS,
    CURRENCY_CODE
],
LineItem  : [
    
    {
        $Type : 'UI.DataField',
        Value : PO_ID,
    },
    {
        $Type : 'UI.DataField',
        Value :GROSS_AMOUNT ,
    },
     {
        $Type : 'UI.DataFieldForAction',
        Label: 'Boost',
        Action : 'CatalogService.boost',
        Inline: true
    },
    {
        $Type : 'UI.DataField',
        Value : CURRENCY_CODE,
    },
    {
        $Type : 'UI.DataField',
        Value : PARTNER_GUID_NODE_KEY,
    },
    {
        $Type : 'UI.DataField',
        Value : PARTNER_GUID.COMPANY_NAME,
    },
    {
        $Type : 'UI.DataField',
        Value : TAX_AMOUNT,
    },
    {
        $Type : 'UI.DataField',
        Value : LIFECYCLE_STATUS,
        Criticality: Criticality,
        CriticalityRepresentation : #WithIcon,
    },
   

],
HeaderInfo  : {
    $Type : 'UI.HeaderInfoType',
    TypeName : '{i18n>purchaseOrder}',
    TypeNamePlural : '{i18n>purchaseorders}',
    Title:{
        Label:'{i18n>Title}',
        Value: PO_ID,
    },
    Description:{
        Label : '{i18n>DESC}',
        Value : PARTNER_GUID.COMPANY_NAME,
    },
    ImageUrl : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTy7_GCDY-yQbuXaNEf5C4x1PoB_RrK-n_xBQ&usqp=CAU',
},
Facets  : [{
    $Type : 'UI.ReferenceFacet',
    Label: '{i18n>POGeneralInfo}',
    Target: ![@UI.FieldGroup#HeaderGeneralInfo],
},
{
    $Type : 'UI.ReferenceFacet',
    Label: '{i18n>POItemsDetails}',
    Target : 'Items/@UI.LineItem'
}  
],
FieldGroup#HeaderGeneralInfo : {
    $Type : 'UI.FieldGroupType',
    Data:[
       {
        $Type : 'UI.DataField',
        Value : PO_ID,
    },
    {
        $Type : 'UI.DataField',
        Value : PARTNER_GUID_NODE_KEY,
    },
    {
        $Type : 'UI.DataField',
        Value :GROSS_AMOUNT ,
    },
      {
        $Type : 'UI.DataField',
        Value : PARTNER_GUID.COMPANY_NAME,
    },
     {
        $Type : 'UI.DataField',
        Value : TAX_AMOUNT,
    },
    {
        $Type : 'UI.DataField',
        Value : LIFECYCLE_STATUS,
        Criticality: Criticality,
        CriticalityRepresentation : #WithIcon,
    },
    ]
},

     }
) ; 

annotate CatalogService.POItems with  @(
    UI:{
        LineItem  : [
            {
                $Type : 'UI.DataField',
                Value : PO_ITEM_POS,
            },
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value :TAX_AMOUNT ,
            },
            {
                $Type : 'UI.DataField',
                Value :NET_AMOUNT ,
            },
            {
                $Type : 'UI.DataField',
                Value : CURRENCY_CODE,
            },
            {
                $Type : 'UI.DataField',
                Value : PARENT_KEY_NODE_KEY,
            },
            {
                $Type : 'UI.DataField',
                Value :PARENT_KEY.PO_ID ,
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.PRODUCT_ID,
            },
        ],
        HeaderInfo  : {
            $Type : 'UI.HeaderInfoType',
            TypeName : 'PO Item',
            TypeNamePlural : 'PO Items',
            Title:{
                $Type : 'UI.DataField',
                Value: NODE_KEY
            },
            Description:{
                $Type : 'UI.DataField',
                Value: PO_ITEM_POS,
            },
            ImageUrl : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRb3N4bhb6jALIN_7247O37Ayi0RmCLCSo0JQ&usqp=CAU',
            
        },
        Facets  : [{
                 $Type : 'UI.ReferenceFacet',
                 Label: '{i18n>PoitemsHeader}',
                 Target:![@UI.FieldGroup#PoitemsHeader]
        },
        // {
        //     $Type : 'UI.ReferenceFacet',
        //     Label:'{i18n>Product Details}',
        //     Target:'PRODUCT_GUID/@UI.FieldGroup#ProductDetails'
        // }
        ],
        FieldGroup#PoitemsHeader : {
            $Type : 'UI.FieldGroupType',
            Data:[
                {
                    $Type : 'UI.DataField',
                    Value :PO_ITEM_POS ,
                },
                {
                    $Type : 'UI.DataField',
                    Value :TAX_AMOUNT  ,
                },
                {
                    $Type : 'UI.DataField',
                    Value : PRODUCT_GUID_NODE_KEY,
                },
                {
                    $Type : 'UI.DataField',
                    Value : TAX_AMOUNT,
                },
                {
                    $Type : 'UI.DataField',
                    Value : GROSS_AMOUNT,
                },
                {
                    $Type : 'UI.DataField',
                    Value : CURRENCY_CODE,
                },
                {
                    $Type : 'UI.DataField',
                    Value : NET_AMOUNT,
                },
            ]
        },
    }
);
 annotate CatalogService.ProductSet with @(
     UI:{
          FieldGroup#ProductDetails :{
            $Type : 'UI.FieldGroupType',
            Data:[
                {
                    $Type : 'UI.DataField',
                    Value : NODE_KEY,
                },
                {
                    $Type : 'UI.DataField',
                    Value : PRODUCT_ID,
                },
                {
                    $Type : 'UI.DataField',
                    Value : CATEGORY,
                },
                {
                    $Type : 'UI.DataField',
                    Value : DESCRIPTION,
                },
                {
                    $Type : 'UI.DataField',
                    Value : TYPE_CODE,
                },
                {
                    $Type : 'UI.DataField',
                    Value : SUPPLIER_GUID.COMPANY_NAME,
                },
                {
                    $Type : 'UI.DataField',
                    Value :SUPPLIER_GUID.EMAIL_ADDRESS ,
                },
                {
                    $Type : 'UI.DataField',
                    Value : SUPPLIER_GUID.PHONE_NUMBER,
                },
                {
                    $Type : 'UI.DataField',
                    Value :SUPPLIER_GUID.WEB_ADDRESS ,
                },
            ]
          }
     }
 );
 


