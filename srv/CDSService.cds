using { siddhant.db.CDSViews } from '../db/CDSViews';
using { siddhant.db.master , siddhant.db.transaction } from '../db/datamodel';


service CDSService{
    entity POWorklist as projection on CDSViews.POWorklist;
   entity ProductAggregation as projection on CDSViews.CProductValuesView;
   entity ProductOrder as projection on CDSViews.ProductViewSub;

}