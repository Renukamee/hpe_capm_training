using CatalogService as service from '../../srv/CatelogueService';
annotate service.POs with @(

    //used to create fields for filter criteria
    UI.SelectionFields:[
        PO_ID,
        PARTNER_GUID.COMPANY_NAME,
        PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        GROSS_AMOUNT,
        OVERALL_STATUS
    ],
    //LineItems - to add columns to the table Ctrl+Space for code completion
    UI.LineItem: [
        {
            $Type : 'UI.DataField',
            Value : PO_ID,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.COMPANY_NAME,
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Label:'boost',
            Inline: true,
            Action : 'CatalogService.boost',
        },
        {
            $Type : 'UI.DataField',
            Value : OVERALL_STATUS,
            Criticality: IconColor

        },
        ],
    //Header Info - bring title for table and second page title and description
    UI.HeaderInfo:{
        TypeName: 'Purchase Order',
        TypeNamePlural: 'Purchase Orders',
        Title: {Value: PO_ID},
        Description: {Value: PARTNER_GUID.COMPANY_NAME},
        ImageUrl : 'https://raw.githubusercontent.com/hpe-design/logos/master/Requirements/color-logo.png',
    },

    UI.Identification:[
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
            Value : LIFECYCLE_STATUS,
        },
    ],
    UI.FieldGroup#Spiderman: {
        Label : 'Price Data',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : NET_AMOUNT,
            },
            {
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT,
            },
        ],
    },
    UI.FieldGroup#Superman:{
        Label : 'Status Data',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : CURRENCY_code,
            },
            {
                $Type : 'UI.DataField',
                Value : OVERALL_STATUS,
            },
        ],
    },
    UI.FieldGroup#Zkas:{
        Label : 'Status Data',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : PARTNER_GUID.COMPANY_NAME,
            },
            {
                $Type : 'UI.DataField',
                Value : PARTNER_GUID.ADDRESS_GUID.COUNTRY,
            },
        ],
    },
    UI.Facets :[
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Additional Info',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'More Info',
                    Target : '@UI.Identification',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Pricing',
                    Target : '@UI.FieldGroup#Spiderman',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Status',
                    Target : '@UI.FieldGroup#Superman',
                },
            ],
        },
         {
            Label : 'PO Items',
            $Type : 'UI.ReferenceFacet',
            Target : 'Items/@UI.LineItem',
        }
    ]
);


annotate service.POItems with @(
    ///create a table for PO items columns
    UI.LineItem:[
        {
            $Type : 'UI.DataField',
            Value : PO_ITEM_POS,
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID_NODE_KEY,
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code,
        }
    ],
    UI.HeaderInfo: {
        TypeName: 'PO Item',
        TypeNamePlural: 'PO Items',
        Title : {Value : PO_ITEM_POS},
        Description: {Value: PRODUCT_GUID.DESCRIPTION}
    },
    UI.Identification: [
        {
            $Type : 'UI.DataField',
            Value : PO_ITEM_POS,
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID_NODE_KEY,
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : NET_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : TAX_AMOUNT,
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code,
        },
    ],
    UI.Facets: [
        {
            $Type : 'UI.ReferenceFacet',
            Label: 'Item Info',
            Target : '@UI.Identification',
        },
    ]
);
    //purpose to enable text for GUID fields
annotate service.POs with{
    PARTNER_GUID @(
        Common.Text: PARTNER_GUID.COMPANY_NAME,

         Valuelist.entity: sevice.BusinessPartnerSet

    )
}


annotate service.POItems with {
    PRODUCT_GUID @(
        Common.Text: PRODUCT_GUID.DESCRIPTION,
         Valuelist.entity: sevice.ProductSet

    )
}

@cds.odata.valuelist
annotate service.BusinessPartnerSet with @(
    UI.Identification:[{
        $Type : 'UI.DataField',
        Value : COMPANY_NAME,
    },]
);


@cds.odata.valuelist
annotate service.ProductSet with @(
    UI.Identification:[{
        $Type : 'UI.DataField',
        Value : DESCRIPTION,
    },]
);