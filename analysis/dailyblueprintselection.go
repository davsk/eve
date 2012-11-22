/*  DailyBlueprintSelection.go

for DASA on Nov 13, 2012 by David Skinner

Daily Process to Calculate Profitabily of Blueprints
Refresh on request when threshhold numbers changed

Static Files: invBuildMaterial invBlueprintTypes
Daily Files: eve_inv_types
Input Files: dasaMissions dasaSkills dasaBlueprints
Output Files: dasaProfitableT1 dasaBuildableT1
*/
package analysis

import (
	"database/sql"
	"fmt"
	"log"
	"math"
	"time"
)

type ISK float64

func (isk ISK) Val() float64 {
	return float64(isk)
}

func DailyBlueprintSelection(db *sql.DB) (err error) {

	var (
		// Threshold Values Found in MagicNumber Table
		minDemand       float64 = 5
		minProfitHour   float64 = 200
		minProfitMargin float64 = .20
		factoryStart    ISK     = 1000.00
		factoryHour     ISK     = 333.00
		factoryDays     int     = 14
		//  User Data found in header
		userId       int = 1002348
		userName string = "David Skinner"
		//  User Data found in skill tree
		userIndustry int = 5
		userPE       int = 5
	)

	// login
	db, err := sql.Open("postgres", "user=goeve password=goeve dbname=eve sslmode=disable")
	if err != nil {
		log.Fatal("sql.Open failed:", err)
	}
	defer db.Close()

	// title, subtitle, columns
	fmt.Println("Daily Blueprint Selection")
	fmt.Println("Prepared for " + userName)
	fmt.Println("canBuild", "itemName", "UnitCost", "PriceLow", "PriceHigh", "zScore", "Demand", "ProfitLow", "MarginLow", "ProfitHigh", "MarginHigh", "priceDate")
	

	// for each T1 Blueprint
	blueprints, err := db.Query("SELECT `blueprintTypeID` , `productTypeID` , `productionTime`, 'productivityModifier' FROM `dbo.invBlueprintTypes`WHERE `techLevel` =1")
	if err != nil {
		return err
	}

LOOP:
	for blueprints.Next() {
		var (
			// blueprints
			blueprintTypeId int
			productTypeId   int
			productionBatch int
			productionTime  int
			batch           int
			// Product Prices
			Quantity  int
			PriceHigh ISK
			PriceLow  ISK
			PriceDate time.Time
			// Cost Prices
			CostQuantity float64
			CostHigh     ISK
			CostLow      ISK
			CostDate     time.Time
			// Sums
			SumCostHigh ISK
			SumCostLow  ISK
			canBuild    bool = true
			// Results
			ActualTime  float64
			FactoryRuns int
			ProfitHigh  ISK
			ProfitLow   ISK
			MarginHigh  float64
			MarginLow   float64
			Demand      float64
			zScore      float64
			// Reference
			itemName string
		)

		err = blueprints.Scan(&blueprintTypeId, &productTypeId, &productionTime, &batch)
		if err != nil {
			// critical error
			return err
		}

		ActualTime = float64(productionTime) * (1 - (.05 * (float64(userIndustry) - 1)))
		FactoryRuns = math.Floor((FactoryDays * 24 * 60) / ActualTime)
		//  Factory Cost
		SumCostHigh = (FactoryStart + (FactoryHour * FactoryRuns * ActualTime / 60)) / FactoryRuns
		SumCostLow = SumCostHigh

		// func (db *DB) QueryRow(query string, args ...interface{}) *Row
		prices := db.QueryRow(fmt.Sprintf("SELECT `jita_qty_30`,'5pct_price_sell', '5pct_price_buy', '5pct_date' FROM 'public.eve_inv_types' WHERE 'typeId' = %v", productTypeId))
		err = prices.Scan(Quantity, PriceHigh, PriceLow, PriceDate)
		if err != nil {
			log.Println(err)
			continue
		}

		materials, err := db.Query(fmt.Sprintf("SELECT * FROM 'dbo.invTypeMaterials' WHERE 'something' = %v", productTypeId))

		for materials.Next(&CostQuantity) {
			err = materials.Scan()

			prices := db.QueryRow(fmt.Sprintf("SELECT '5pct_price_sell', '5pct_price_buy', '5pct_date' FROM 'public.eve_inv_types' WHERE 'typeId' = %v", productTypeId))
			err = prices.Scan(&CostHigh, &CostLow, &CostDate)
			if err != nil {
				log.Println(err)
				continue LOOP
			} else {
				SumCostHigh += ISK(CostQuantity * CostHigh.Val())
				SumCostLow += ISK(CostQuantity * CostLow.Val())

				// earliest date
				if CostDate.Before(PriceDate) {
					PriceDate = CostDate
				}
				//PriceDate = min(PriceDate, CostDate)
			}
		}

		// post processing per row
		UnitCost = CostHigh / batch
		ProfitHigh = float64(PriceHigh*batch) - CostLow
		ProfitLow = float64(PriceLow*batch) - CostHigh
		MarginHigh = float64(ProfitHigh / PriceHigh)
		MarginLow = float64(ProfitLow / PriceLow)
		ProfitHigh = float64(ProfitHigh * 60 / ActualTime)
		ProfitLow = float64(ProfitLow * 60 / ActualTime)
		Demand = (quantity * FactoryDays / 30) / (FactoryRuns * batch)
		zScore = math.Log(ProfitHigh.Val()/minProfitHour) * MarginHigh * math.Log(Demand)

		if Demand < minDemand {
			zScore = 0
		}
		if ProfitHigh.Val() < minProfitHour {
			zScore = 0
		}
		if MarginHigh < minProfitMargin {
			zScore = 0
		}
		if ProfitLow.Val() > minProfitHour {
			zScore *= 4
		}
		if MarginLow > minProfitMargin {
			zScore *= 8
		}
		if zScore > 0 {
			names := db.QueryRow(fmt.Sprintf("SELECT 'itemName' FROM 'dbo.eveName' WHERE 'itemId' = %v", productTypeId))
			err = names.Scan(&itemName)
			if err != nil {
				// critical error, should never happen
				panic(err)
			}

			fmt.Println(canBuild, itemName, UnitCost, PriceLow, PriceHigh, zScore, Demand, ProfitLow, MarginLow, ProfitHigh, MarginHigh, priceDate)
		}
	}

	//err = rows.Err() // get any error encountered during iteration   
	//get eve_inv_types.jita

	return nil
}

/*
 Blueprint Selection - Admin Only

This is a view of a table created each night, with related boolean Can Build filter with itemId * userId 

Form with filter amounts
    ProfitMargin
    Profit/Hour
    Volume
    Quantity/Production Time
    Z-Score
    Boolean Can Build
    Boolean Have Blueprint

List Items sorted descending Z-Score
    Item
    Z-Score
    ProfitMargin
    Profit/Hour
    Volume
    Quantity/Production Time
    Low Sell
    Average
    High Buy
    Slope
    CountBlueprints

Each line has a Show Info button and Set Market button for the blueprint.
*/
