-- publicViews.sql
 -- View: "productionCost"
 -- DROP VIEW "productionCost";

CREATE OR REPLACE VIEW "productioncost" AS
SELECT invtypematerials.typeid,
       sum(eve_inv_types."5pct_price_sell" * invtypematerials.quantity) AS CostSell,
       sum(eve_inv_types."5pct_price_buy" * invtypematerials.quantity) AS CostBuy
FROM dbo.invtypematerials
LEFT JOIN eve_inv_types ON invtypematerials.materialtypeid = eve_inv_types.type_id
GROUP BY invtypematerials.typeid;

 -- View: "productionPrice"
 -- DROP VIEW "productionPrice";

CREATE OR REPLACE VIEW "productionprice" AS
SELECT invblueprinttypes.blueprinttypeid,
       invblueprinttypes.parentblueprinttypeid,
       invblueprinttypes.producttypeid,
       invblueprinttypes.productiontime,
       invblueprinttypes.techlevel,
       invblueprinttypes.productivitymodifier,
       invblueprinttypes.materialmodifier,
       invblueprinttypes.wastefactor,
       invblueprinttypes.maxproductionlimit,
       eve_inv_types.name,
       eve_inv_types.icon_name,
       real (eve_inv_types.jita_qty_30 * invblueprinttypes.productiontime /invblueprinttypes.productivitymodifier) AS Demand,
       eve_inv_types."5pct_price_sell" AS PriceSell,
       eve_inv_types."5pct_price_buy" AS PriceBuy
FROM dbo.invblueprinttypes,
     eve_inv_types
WHERE invblueprinttypes.producttypeid = eve_inv_types.type_id;

 -- View: productiontest
 -- DROP VIEW productiontest;

CREATE OR REPLACE VIEW productionprofit AS
SELECT productionprice.blueprinttypeid,
       productionprice.parentblueprinttypeid,
       productionprice.producttypeid,
       productionprice.productiontime,
       productionprice.techlevel,
       productionprice.productivitymodifier,
       productionprice.materialmodifier,
       productionprice.wastefactor,
       productionprice.maxproductionlimit,
       productionprice.name,
       productionprice.icon_name,
       productionprice.demand,
       productionprice.pricesell,
       productionprice.pricebuy,
       (productioncost.costsell / productionprice.productivitymodifier) AS costsell,
       (productioncost.costbuy / productionprice.productivitymodifier) AS costbuy
FROM productionprice
LEFT JOIN productioncost ON productionprice.producttypeid = productioncost.typeid;

grant all on productionprofit to goeve;

CREATE OR REPLACE VIEW "productiontest" AS
SELECT *
FROM public.productionPrice
LEFT JOIN public.productionCost ON productionPrice.producttypeid = productionCost.typeid;

